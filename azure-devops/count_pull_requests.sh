#!/bin/bash

#
# List the Azure DevOps work items and pull requests owner by a specified user.
#

ADO_USER=${BUILD_SOURCEVERSIONAUTHOR:-"jthelin@microsoft.com"}

ADO_ORG=${SYSTEM_TEAMFOUNDATIONCOLLECTIONURI:-"https://aiinfra.visualstudio.com/"}
ADO_PROJECT=${SYSTEM_TEAMPROJECT:-"MAIA"}

query_fields="[System.Id], [System.State], [System.Title]"
query_days=90
query_wiql=$(cat << EOF
SELECT ${query_fields}
FROM workitems
WHERE
    [System.AreaPath] under '${ADO_PROJECT}'
    and [System.AssignedTo] == '${ADO_USER}'
    and [System.ChangedDate] >= @today-${query_days}
EOF
)
az boards query \
    --wiql "${query_wiql}" \
    --org "${ADO_ORG}" \
    --project "${ADO_PROJECT}" \
> count_work_items.tmp.json

echo "Work Items - AssignedTo"
# Parse the relevant field from the JSON query reply
jq --compact-output ".[].fields" < count_work_items.tmp.json

az repos pr list \
    --creator "${ADO_USER}" \
    --org "${ADO_ORG}" \
    --project "${ADO_PROJECT}" \
    --status all \
> pr.created.tmp.json

echo "Pull Requests - Created"
# Parse the relevant field from the JSON query reply
jq --compact-output '.[] | { pullRequestId, title }' < pr.created.tmp.json

az repos pr list \
    --reviewer "${ADO_USER}" \
    --org "${ADO_ORG}" \
    --project "${ADO_PROJECT}" \
    --status all \
> pr.reviewed.tmp.json

echo "Pull Requests - Reviewed"
# Parse the relevant field from the JSON query reply
jq --compact-output '.[] | { pullRequestId, title }' < pr.reviewed.tmp.json
