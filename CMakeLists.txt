cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

project(AppVeyorTest)
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/CMake
  ${CMAKE_SOURCE_DIR}/CMake/common)
include(GitExternal)

set(VERSION_MAJOR "0")
set(VERSION_MINOR "1")
set(VERSION_PATCH "0")
set(VERSION_ABI 1)

set(APPVEYORTEST_DESCRIPTION "AppVeyor CI example")
set(APPVEYORTEST_MAINTAINER "Serkan Ergun <serkan.ergun@gmail.com>")
set(APPVEYORTEST_LICENSE LGPL )

include(Common)
common_package(Boost REQUIRED COMPONENTS unit_test_framework
                                         system
                                         filesystem)
common_package_post()

add_subdirectory(example)
add_subdirectory(tests)

include(CPackConfig)
include(DoxygenRule)
