# This function will read the nuget package version info
#  from a nuget config file (usually called packages.config)
#  and populate cmake variables named `*_ver` for each package found
#  (for example: Package "my.pkg" --> ${my_pkg_ver} )
function(read_nuget_versions nuget_config_file)

  if(NOT EXISTS ${nuget_config_file})
    message(FATAL_ERROR "Missing nuget config file ${nuget_config_file}")
  else()
    cmake_path(ABSOLUTE_PATH nuget_config_file OUTPUT_VARIABLE nuget_config_file)
    message(STATUS "Reading nuget package version info from config file ${nuget_config_file}")
  endif()

  # Find all package reference lines
  # Sample data line:
  #   <package id="My.Package" version="1.2.3" />
  file(STRINGS "${nuget_config_file}" pkg_data
    REGEX "<package[ \t\r\n]+.*/>")

  foreach(pkg_line ${pkg_data})
    message(DEBUG ${pkg_line})
    # Find package name and version fields
    string(REGEX MATCH
      "id=\"(.+)\"[ \t\r\n]*version=\"(.+)\""
      unused
      ${pkg_line})
    set(pkg_name ${CMAKE_MATCH_1})
    set(pkg_version ${CMAKE_MATCH_2})
    message(STATUS "Package ${pkg_name} version = ${pkg_version}")

    # Set output variable for this package
    # Replace dots with underscore characters
    string(REGEX REPLACE "\\." "_" pkg_var_name ${pkg_name})
    message(DEBUG ${pkg_var_name})
    set("${pkg_var_name}_ver" ${pkg_version} PARENT_SCOPE)
  endforeach()

endfunction()
