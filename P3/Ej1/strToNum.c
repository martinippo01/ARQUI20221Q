
int strToNum(char * string){
    
    int numero = 0;
    
    for(int i = 0; string[i] != 0; i++){
        numero *= 10;
        numero += (string[i] - '0');
    }

    return numero;

}