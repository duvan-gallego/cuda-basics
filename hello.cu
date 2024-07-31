#include <stdio.h>

__global__ void hello() {
    printf("Hello from GPU");
    #if __CUDA_ARCH__ >= 200
        printf("Hi Cuda World");
    #endif
}

int main() {
    printf("beforeDeviceFunc\n\n");
    hello<<<1, 1>>>();
    cudaError_t cudaerr = cudaDeviceSynchronize();
    printf(cudaGetErrorString(cudaerr));
    if (cudaerr != cudaSuccess)
        printf("kernel launch failed with error \"%s\".\n",
               cudaGetErrorString(cudaerr));
    printf("after DeviceFunc\n\n"); 
    return 0; 
}
