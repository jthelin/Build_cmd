# Google Test Framework

# https://github.com/google/googletest/blob/master/googletest/README.md

CMAKE_MINIMUM_REQUIRED(VERSION 3.10)

set(PKG googletest)

# Download and unpack package sources at cmake-configuration time
configure_file(${CMAKE_CURRENT_LIST_DIR}/${PKG}-download.in ${CMAKE_CURRENT_BINARY_DIR}/${PKG}-build/CMakeLists.txt)
execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${PKG}-build )
if(result)
    message(FATAL_ERROR "CMake generate step for ${PKG} failed: ${result}")
endif()
execute_process(COMMAND ${CMAKE_COMMAND} --build .
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${PKG}-build )
if(result)
    message(FATAL_ERROR "Build step for ${PKG} failed: ${result}")
endif()

# Prevent overriding the parent project's compiler/linker settings on Windows
SET(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

# This defines the gtest and gtest_main targets.
# Add package artifacts directly to our build.
add_subdirectory(${CMAKE_CURRENT_BINARY_DIR}/${PKG}-src
        ${CMAKE_CURRENT_BINARY_DIR}/${PKG}-build
        EXCLUDE_FROM_ALL)

set(PKG "")
