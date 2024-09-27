# cython: language_level=3, embedsignature=True
import numpy as np
cimport numpy as np

ctypedef np.float_t FLOAT_t


cdef extern from "ta_defs.h":
    ctypedef int TA_RetCode
    TA_RetCode TA_SUCCESS = 0
    TA_RetCode TA_NOT_SUPPORTED = 16


cdef int one():
    return 1

def hello():
    return TA_NOT_SUPPORTED

def numpy_sum(np.ndarray[FLOAT_t, ndim=1] arr):
    if arr.ndim != 1:
        raise ValueError("Input array must be 1-dimensional")

    cdef int n = arr.shape[0]
    cdef double result = 0

    cdef int i
    for i in range(n):
        result += arr[i]

    return result