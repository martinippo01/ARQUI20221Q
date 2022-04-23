#include <stdio.h>
#define DIMENSION 1024

int main(int argc, char * argv[]) {

    char matriz[DIMENSION] = {'a', 'b', 'c', 'd', 'e', 'f'};

    for(int i = 0; i < DIMENSION; i++){
            matriz[i] = (i + 1);
    }

    printf("Hello World!\n");
    return 0;

}