#!/bin/bash

# Auto create a tracking bug for a failed Azure DevOps build.
# Based on:
# https://docs.microsoft.com/en-us/azure/devops/pipelines/customize-pipeline?view=azure-devops#create-work-item-on-failure
#
# Sample usage in Azure DevOps .yaml build definition:
#
# - job: ReportBuildFailure
#   condition: failed()
#   steps:
#   - bash: script/create_build_fail_bug.sh
#     env:
#       AZURE_DEVOPS_EXT_PAT: $(System.AccessToken)

# Get the directory path of this script.
CMD_HOME=$( dirname "$(realpath -s "$0")" )
REPO_ROOT=${CMD_HOME}/..

cd "${REPO_ROOT}" || exit

env | sort

# Metadata for this failed build
BUILD_ID=${BUILD_BUILDID:-"000"}
FAILED_BUILD=${BUILD_BUILDNUMBER:-"BUILD_UNKNOWN"}
FAILED_PIPELINE=${BUILD_DEFINITIONNAME:-"DEFINITION_UNKNOWN"}
FAILED_BRANCH=${BUILD_SOURCEBRANCH:-"BRANCH_UNKNOWN"}
FAILED_BRANCH_NAME=${BUILD_SOURCEBRANCHNAME:-"BRANCH_NAME_UNKNOWN"}
FAILED_COMMIT_ID=${BUILD_SOURCEVERSION:-"COMMIT_ID_UNKNOWN"}
FAILED_COMMIT_MSG=${BUILD_SOURCEVERSIONMESSAGE:-"COMMIT_MSG_UNKNOWN"}

ADO_ORG=${SYSTEM_TEAMFOUNDATIONCOLLECTIONURI:-"https://swtech.visualstudio.com/"}
ADO_PROJECT=${SYSTEM_TEAMPROJECT:-"Projects"}

if [[ "${FAILED_BRANCH}" == "refs/heads/main" || "${FAILED_BRANCH}" == "refs/heads/master" ]]; then
  IS_MAIN_BRANCH=1
else
  IS_MAIN_BRANCH=0
  if [[ "${FORCE_CREATE_BUILD_FAIL_BUG}" != "True" ]]; then
    echo "##vso[task.logissue type=warning] Don't create tracking bug for failed build ${FAILED_BUILD} for non-main branch ${FAILED_BRANCH}"
    exit 0
  fi
fi

# Check that the required azure-cli tools are installed.
if [[ $(command -v az) == "" ]]; then
  echo "##vso[task.logissue type=error] WARNING: Cannot find Azure DevOps CLI -- cannot create tracking bug for failed build."
  exit 1
fi

# Metadata used to create new build-break
ADO_BUG_OWNER="${BUILD_REQUESTEDFOREMAIL:-"developer@example.com"}"
ADO_BUILD_WEB_URI="${ADO_ORG}/${ADO_PROJECT}/_build/results?buildId=${BUILD_ID}&view=results"
ADO_BUILD_WEB_LINK="<a href=\"${ADO_BUILD_WEB_URI}\">${ADO_BUILD_WEB_URI}</a>"

if [[ "${IS_MAIN_BRANCH}" == "1" ]]; then
  # Any build break of main branch is initially classified as priority 0 bug.
  ADO_BUG_PRI="0"
  ADO_BUG_TITLE_PREFIX="[P0] [Build Break]"
else
  ADO_BUG_PRI="4"
  ADO_BUG_TITLE_PREFIX="[TEST-IGNORE]"
fi

ADO_BUG_TITLE="${ADO_BUG_TITLE_PREFIX} '${FAILED_PIPELINE}' build ${FAILED_BUILD} failed for git commit ${FAILED_COMMIT_ID}"
ADO_BUG_INFO="<div>Build ${FAILED_BUILD} failed for pipeline '${FAILED_PIPELINE}' branch ${FAILED_BRANCH} <br> git commit ${FAILED_COMMIT_ID} <br> '${FAILED_COMMIT_MSG}' <br> ${ADO_BUILD_WEB_LINK}</div>"
ADO_BUG_ASSIGN_NOTE="<div>Initially assigning ${ADO_BUG_OWNER} as owner for this '${FAILED_BRANCH_NAME}' branch build break occurrence with your git commit ${FAILED_COMMIT_ID} <br> ${ADO_BUILD_WEB_LINK}</div>"
ADO_BUG_RESOLVE_NOTE="<div>If this build failure is caused by an existing known bug, then in the Related Work section please add a Duplicate-Of link to that root cause bug, and close this bug as Resolved / Duplicate</div>"

# See also https://swtech.visualstudio.com/_apis/wit/fields

echo "##vso[task.logissue type=warning] Creating tracking bug for failed build ${FAILED_BUILD} on branch ${FAILED_BRANCH_NAME}"

az boards work-item create \
   --type bug \
   --title "${ADO_BUG_TITLE}" \
   --discussion "${ADO_BUG_ASSIGN_NOTE}" \
   --assigned-to "${ADO_BUG_OWNER}" \
   --fields \
     "Microsoft.VSTS.Build.FoundIn=${FAILED_BUILD}" \
     "Microsoft.VSTS.Common.Priority=${ADO_BUG_PRI}" \
     "Microsoft.VSTS.TCM.ReproSteps=${ADO_BUG_INFO}" \
     "Microsoft.VSTS.TCM.SystemInfo=${ADO_BUG_RESOLVE_NOTE}" \
   --org "${ADO_ORG}" \
   --project "${ADO_PROJECT}"

