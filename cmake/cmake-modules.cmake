# CMake Modules
# https://github.com/bilke/cmake-modules

CMAKE_MINIMUM_REQUIRED(VERSION 3.10)

set(PKG cmake-modules)

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

LIST(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_BINARY_DIR}/cmake-modules)

message(STATUS "CMAKE_MODULE_PATH = ${CMAKE_MODULE_PATH}")

set(PKG "")
