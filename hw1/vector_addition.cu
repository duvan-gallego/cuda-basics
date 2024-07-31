#include <stdio.h>

#define N (2048*2048)
#define THREADS_PER_BLOCK 512

__global__ void vadd(int *a, int *b, int *c) {
    int index = threadIdx.x + blockIdx.x * blockDim.x;    
    c[index] = a[index] + b[index];
}

int main() {
    int *a, *b, *c; 
    int *d_a, *d_b, *d_c;
    int size = N * sizeof(int);
    
    cudaMalloc((void **)&d_a, size);
    cudaMalloc((void **)&d_b, size);
    cudaMalloc((void **)&d_c, size);

    a = (int *)malloc(size);    
    b = (int *)malloc(size);     
    c = (int *)malloc(size);

    for (int i = 0; i < N; i++) {
        a[i] = rand()/N;
        b[i] = rand()/N;
    }

    // Copy input data from host to device
    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

    // Launch kernel
    vadd<<<N/THREADS_PER_BLOCK,THREADS_PER_BLOCK>>>(d_a, d_b, d_c);

    // Copy output data from device to host
    cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

    // Check result
    for (int i = 0; i < 10; i++) {
        printf("%d + %d = %d\n", a[i], b[i], c[i]);
    }

    // Cleanup
    free(a); free(b); free(c); 
    cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);
    
    return 0;
}