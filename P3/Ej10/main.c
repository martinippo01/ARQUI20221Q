#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern char* cpuidGetter();

int main(int argc, char * argv[]){
    char* cpuidToken = cpuidGetter();
    int isAMD = strcmp(cpuidToken, "GenuineIntel");
    puts((!isAMD)?"Intel": "AMD");
    puts(cpuidToken);
    return 0;
}