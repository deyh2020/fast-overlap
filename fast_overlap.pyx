# distutils: language=c++

import numpy as np
cimport numpy as np
cimport cython
__all__ = [
    "__version__",
    "overlap",
    "run",
]
cimport numpy as np
import numpy as np

cdef extern from "parallel_overlap.cpp":
    cdef void overlap_parallel_cpp(int *, int *, Py_ssize_t[2], int *, Py_ssize_t)

cpdef overlap_parallel(int [:,::1] prev, int[:,::1] curr, shape):
    prev = np.ascontiguousarray(prev)
    curr = np.ascontiguousarray(curr)
    # shape = (prev.max()+1, curr.max()+1)
    
    cdef np.ndarray[int, ndim=2, mode="c"] output = np.zeros(shape, dtype=np.intc)

    overlap_parallel_cpp(&prev[0,0], &curr[0,0], prev.shape, &output[0,0], shape[1])
    return output


__version__ = "0.1.0"
# @cython.boundscheck(False)
@cython.wraparound(False)
@cython.nonecheck(False)
cpdef overlap(int[:, :] prev, int[:,:] curr, shape):
    """
    Calculate the pairwise overlap the labels for two arrays.

    Parameters
    ----------
    prev, curr : 2D array-like of int
        curr will have at least as many unique labels as prev

    Returns
    -------
    arr : (N, M) array of int
        N is the number of unique labels in prev and M the number of unique in curr.
        The ijth entry in the array gives the number of pixels for which label *i* in prev
        overlaps with *j* in curr.
    """
    cdef int [:, :] arr
    arr = np.zeros(shape, dtype=np.dtype("i"))
    cdef size_t I, J, i, j
    for i in range(prev.shape[0]):
        for j in range(prev.shape[1]):
            arr[prev[i,j],curr[i,j]] += 1
    return np.asarray(arr)


