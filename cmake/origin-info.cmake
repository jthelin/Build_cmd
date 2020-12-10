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
        "^CMAKE_BUILD_.*"
        "^JETBRAINS_.*"
        )

    # cmake variables
    get_cmake_property(variable_names VARIABLES)
    list(SORT variable_names)
    foreach(varname ${variable_names})
        foreach(pattern ${variable_name_match_patterns})
            if(varname MATCHES ${pattern})
                file(APPEND ${output_file} "${varname}=${${varname}}\n")
            endif()
        endforeach()
    endforeach()

    # Runtime environment variables
    if(WIN32)
        set(CMD_STR cmd /c set)
    else()
        set(CMD_STR bash -c "env | sort")
    endif()
    execute_process(
        COMMAND ${CMD_STR}
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        OUTPUT_VARIABLE list_env_vars
        COMMAND_ECHO STDOUT
        ECHO_OUTPUT_VARIABLE
    )
    string(REPLACE ";" "[--COMMA--]" list_env_vars "${list_env_vars}")
    string(REPLACE "\n" ";" list_env_vars "${list_env_vars}")
    foreach(line IN LISTS list_env_vars)
        string(REPLACE "[--COMMA--]" ";" line "${line}")
        foreach(pattern ${variable_name_match_patterns})
            if(line MATCHES ${pattern})
                file(APPEND ${output_file} "${line}\n")
            endif()
        endforeach()
    endforeach()

    file(APPEND ${output_file} "\n")
    message(STATUS "Wrote origin-info to ${output_file}")
endfunction()
