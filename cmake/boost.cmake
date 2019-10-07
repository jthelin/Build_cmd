# Download and install local copy of boost libraries.
# https://www.boost.org/users/download/
#
# Based on: https://stackoverflow.com/a/40000061/282326
#
# Usage:
#   include( cmake/boost.cmake )
#   include_directories( ${boost_INCLUDE_DIR} )
#   ...
#   add_dependencies( MyProject boost )
#   target_link_libraries( MyProject ${Boost_LIBRARIES} )

set( boost_URL "https://dl.bintray.com/boostorg/release/1.69.0/source/boost_1_69_0.tar.bz2" )
set( boost_SHA256 "8f32d4617390d1c2d16f26a27ab60d97807b35440d45891fa340fc2648b04406" )
set( boost_INSTALL ${CMAKE_CURRENT_BINARY_DIR}/third_party/boost )
set( boost_INCLUDE_DIR ${boost_INSTALL}/include )
set( boost_LIB_DIR ${boost_INSTALL}/lib )

include( ExternalProject )

ExternalProject_Add( boost
    PREFIX boost
    URL ${boost_URL}
    URL_HASH SHA256=${boost_SHA256}
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND
    ./bootstrap.sh
    --prefix=/opt
    --with-libraries=filesystem
    --with-libraries=system
    --with-libraries=date_time
    BUILD_COMMAND
    ./b2 install link=static variant=release threading=multi runtime-link=static
    INSTALL_COMMAND ""
    INSTALL_DIR ${boost_INSTALL} )

set( Boost_LIBRARIES
    ${boost_LIB_DIR}/libboost_filesystem.a
    ${boost_LIB_DIR}/libboost_system.a
    ${boost_LIB_DIR}/libboost_date_time.a )

message( STATUS "Boost static libs: " ${Boost_LIBRARIES} )
