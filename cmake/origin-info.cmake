# record_origin_info - Gather significant build variables and write that origin info to the designated output file.
#
# Sample usage:
#
# include(origin-info)
# set(build_origin_info_file ${CMAKE_BINARY_DIR}/origin-info.txt)
# record_origin_info(${build_origin_info_file})
# install(FILES ${build_origin_info_file} DESTINATION . COMPONENT MyPkg)
#
function(record_origin_info output_file)
    cmake_host_system_information(RESULT host_name QUERY HOSTNAME)
    file(WRITE ${output_file} "HOSTNAME=${host_name}\n")

    set(variable_name_match_patterns
        "^BUILD_.*"
        "^CMAKE_BUILD_.*")

    get_cmake_property(variable_names VARIABLES)
    list(SORT variable_names)
    foreach(varname ${variable_names})
        foreach(pattern ${variable_name_match_patterns})
            if(varname MATCHES ${pattern})
                file(APPEND ${output_file} "${varname}=${${varname}}\n")
            endif()
        endforeach()
    endforeach()
endfunction()
