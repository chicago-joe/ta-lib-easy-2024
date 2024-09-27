cmake_minimum_required(VERSION 3.25...3.30)
project(${SKBUILD_PROJECT_NAME} LANGUAGES C)
set(VCPKG_ROOT "${CMAKE_SOURCE_DIR}/vcpkg/installed/x64-windows")

find_package(
  Python
  COMPONENTS Interpreter Development.Module NumPy
  REQUIRED
)

find_package(Cython)
include(UseCython)

message(STATUS "Transpiling cython")
cython_transpile(
    "${CMAKE_CURRENT_SOURCE_DIR}/src/ta_lib_easy/_ta_lib.pyx"
    LANGUAGE C
    OUTPUT_VARIABLE _ta_lib_c
    CYTHON_ARGS -I "${VCPKG_ROOT}/include"
)

message(STATUS "Creating python library")
python_add_library(
    _ta_lib
    MODULE
    "${_ta_lib_c}"
    WITH_SOABI
)

message(STATUS "Linking python library to TALib")
target_link_libraries(
    _ta_lib
    PUBLIC
    "${VCPKG_ROOT}/lib/ta_abstract.lib"
    "${VCPKG_ROOT}/lib/ta_common.lib"
    "${VCPKG_ROOT}/lib/ta_func.lib"
    "${VCPKG_ROOT}/lib/ta_libc.lib"
)
target_include_directories(
    _ta_lib
    SYSTEM
    BEFORE
    PUBLIC
    "${VCPKG_ROOT}/include"
    ${Python_NumPy_INCLUDE_DIRS}
)

install(TARGETS _ta_lib DESTINATION ta_lib_easy/)