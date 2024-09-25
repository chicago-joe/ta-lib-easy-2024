# cython: language_level=3, embedsignature=True

cdef extern from "ta_defs.h":
    ctypedef int TA_RetCode
    TA_RetCode TA_SUCCESS = 0
    TA_RetCode TA_LIB_NOT_INITIALIZE = 1
    TA_RetCode TA_BAD_PARAM = 2
    TA_RetCode TA_ALLOC_ERR = 3
    TA_RetCode TA_GROUP_NOT_FOUND = 4
    TA_RetCode TA_FUNC_NOT_FOUND = 5
    TA_RetCode TA_INVALID_HANDLE = 6
    TA_RetCode TA_INVALID_PARAM_HOLDER = 7
    TA_RetCode TA_INVALID_PARAM_HOLDER_TYPE = 8
    TA_RetCode TA_INVALID_PARAM_FUNCTION = 9
    TA_RetCode TA_INPUT_NOT_ALL_INITIALIZE = 10
    TA_RetCode TA_OUTPUT_NOT_ALL_INITIALIZE = 11
    TA_RetCode TA_OUT_OF_RANGE_START_INDEX = 12
    TA_RetCode TA_OUT_OF_RANGE_END_INDEX = 13
    TA_RetCode TA_INVALID_LIST_TYPE = 14
    TA_RetCode TA_BAD_OBJECT = 15
    TA_RetCode TA_NOT_SUPPORTED = 16
    TA_RetCode TA_INTERNAL_ERROR = 5000
    TA_RetCode TA_UNKNOWN_ERR = 0xffff

cdef int one():
    return 1
