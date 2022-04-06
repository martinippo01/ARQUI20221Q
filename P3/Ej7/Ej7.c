
char arregloGlobalNoInicializado[20];
char arregloGlobalInicializado[20] = "!!!!!!!!Hola!!!!!!!";


void a(){
    char array[20];
}
void b(){
    char array[20] = "!!Hola!!";
}
void c(){
    char array[20];
    array[10] = 'a';  
}
void d(){
    char array[20] = "!!!!!!!Hola!!!!!!!!";
    array[10] = 'e';
}


int main(){
    a();
    b();
    c();
    d();
}