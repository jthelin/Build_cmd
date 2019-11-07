# JSON for Modern C++ Library
# https://github.com/nlohmann/json

CMAKE_MINIMUM_REQUIRED(VERSION 3.10)

include(ExternalProject)
ExternalProject_Add(json
        URL         https://github.com/nlohmann/json/releases/download/v3.7.1/include.zip
        URL_HASH    SHA256=77b9f54b34e7989e6f402afb516f7ff2830df551c3a36973085e2c7a6b1045fe
        SOURCE_DIR  ${CMAKE_CURRENT_BINARY_DIR}/json-build
        CONFIGURE_COMMAND ""
        BUILD_COMMAND     ""
        INSTALL_COMMAND   ""
        TEST_COMMAND      ""
)

# Set include folders
set(json_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/json-build/single_include/nlohmann)
message(STATUS "json_INCLUDE_DIR=${json_INCLUDE_DIR}")

# Make the json header file available to our build.
include_directories( ${json_INCLUDE_DIR} )
