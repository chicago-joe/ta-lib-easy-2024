cmake_minimum_required(VERSION 3.25...3.30)
project(${SKBUILD_PROJECT_NAME} LANGUAGES C)

add_subdirectory(ta-lib)

find_package(
  Python
  COMPONENTS Interpreter Development.Module NumPy
  REQUIRED
)

find_package(Cython)
include(UseCython)

message(STATUS "Transpiling cython")
cython_transpile(
    "${CMAKE_CURRENT_SOURCE_DIR}/src/talib/_ta_lib.pyx"
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
    ta_lib_static
)
target_include_directories(
    _ta_lib
    SYSTEM
    BEFORE
    PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/ta-lib/include
    ${Python_NumPy_INCLUDE_DIRS}
)

install(TARGETS _ta_lib DESTINATION talib/)
install(FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/src/talib/__init__.py
    ${CMAKE_CURRENT_SOURCE_DIR}/src/talib/abstract.py
    ${CMAKE_CURRENT_SOURCE_DIR}/src/talib/deprecated.py
    ${CMAKE_CURRENT_SOURCE_DIR}/src/talib/stream.py
    DESTINATION talib/
)