import numpy as np
cimport numpy as np
cimport cython
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
    return arr


