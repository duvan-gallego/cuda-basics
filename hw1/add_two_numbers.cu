#include <stdio.h>

__global__ void add(int *a, int *b, int *c) {
    *c = *a + *b;
}

int main() {
    int a, b, c;
    a = 2;
    b= 7; 
    int *d_a, *d_b, *d_c;
    int size = sizeof(int);
    
    cudaMalloc((void **)&d_a, size);
    cudaMalloc((void **)&d_b, size);
    cudaMalloc((void **)&d_c, size);

    cudaMemcpy(d_a, &a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, &b, size, cudaMemcpyHostToDevice);
    add<<<1, 1>>>(d_a, d_b, d_c);
    cudaMemcpy(&c, d_c, size, cudaMemcpyDeviceToHost);

    printf("a + b = %d\n", c);    
}