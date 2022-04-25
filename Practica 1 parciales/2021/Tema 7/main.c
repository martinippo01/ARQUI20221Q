extern int _read(int fd, char* string, int length);
extern int _write(int fd, char* string, int length);
extern int _open(char* fileName, int flags, int mode);
extern int _print(char* string);
extern int _print_without_len(char* string, int len);
extern int _getchar(int fd, char * buffer);

#define LEN 6
#define MAX 60



int strcmp(char * strA, char * strB){
    for(int i = 0; i < LEN; i++){
        if(strA[i] != strB[i])
            return 0;
    }
    return 1;
}

int main(int argc, char* argv[]){
    
    int fdA = _open("DatosA.txt", 0x0002, 0777);
    int fdB = _open("DatosB.txt", 0x0002, 0777);
    char legajo[LEN];
    
    char legajos [MAX][LEN];

    int pos = 0;
    while(_read(fdA, legajo, LEN) != 0){
      for(int i = 0; i < LEN - 1; i++){
        legajos[pos][i] = legajo[i];
      }
      legajos[pos][LEN - 1] = 0;  
      pos++;
    }
    legajos[pos][0] = 0;


    char letra;
    while(_getchar(fdB, &letra) != 0){
        if(letra == ' '){
            for(;;){

            }
        }
    }

    return 0;
}

