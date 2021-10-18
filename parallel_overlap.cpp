// #include "parallel_overlap.hpp"
// int sum_all(int *, int *, int, int *)

#include <stdio.h>
#include "omp.h"

void overlap_parallel_cpp(int *prev, int *curr, Py_ssize_t shape[2], int *output, Py_ssize_t output_cols)
{
    int i, j, prev_id, curr_id;
    int total;
#pragma omp parallel for collapse(2)
    for (i = 0; i < shape[0]; i++){
        for (j = 0; j < shape[1]; j++){
            prev_id = prev[i * shape[1] + j];
            curr_id = curr[i * shape[1] + j];
#pragma omp atomic
            output[prev_id * output_cols + curr_id] += 1;
        }
    }
}
