#include <stdio.h>

extern char* _itoa(int num, char* string);
extern void _stdio_read(char* string, int length);
extern void _print(char* string);

#define LENGTH 10


int atoi(char * string){
    int res;
    for(int i = 0; string[i] != 0; i++){
        int exponente = 1;
        for(int j = 0; j < i; j++){
            exponente *= 10;
        }
        res += string[i] * exponente;
    }
    return res;
}

void itoa(int num, char* res){
       
    for(int i = 0; num > 0; i++, num /= 10){
        res[i] = (num % 10) + '0';
    }
    
}


int main(int argc, char* argv[]){

    char a[LENGTH + 1] = {0};
    char b[LENGTH + 1] = {0};

    _print("Ingrese un numero: ");
    _stdio_read(a, LENGTH);
    
    _print("Ingrese un numero: ");
    _stdio_read(b, LENGTH);
    

    char res[LENGTH + 1] = {0};
    int avalue = atoi(a);
    int bvalue = atoi(b);
    
    printf("a = %d | b = %d", avalue, bvalue);

    itoa(avalue + bvalue, res);

    //_print(res);    

    return 0;

}