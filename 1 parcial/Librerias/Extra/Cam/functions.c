#define GCERR -2               // Error del getchar
#define EOF -1                 // End of file
#define STDIN  0               // FD Standard input
#define STDOUT 1               // FD Standard output
#define STDERR 2               // FD Standard error
#define MAX_BUFF 128

// flags para sys_open
#define _O_RDONLY 0x0000       // Read only
#define _O_WRONLY 0x0001       // Write only
#define _O_RDWR   0x0002       // Read & Write
#define _O_CREAT  0x0040       // Create
#define _O_TRUNC  0x0200       // ?
#define _O_APPEND 0x0400       // Append

#define IS_NUM(c)  ((c) >= '0' && (c)<='9')
#define IS_DIGIT(c) (((c) >= 'a' && (c)<='z') || ((c) >= 'A' && (c)<='Z'))

// flags de permisos sys_open
#define S_IXUSR 00100          // owner, execute permission
#define S_IWUSR 00200          // owner, write permission
#define S_IRUSR 00400          // owner, read permission
#define S_IRWX  00700          // owner, read, write, execute permission

extern int sys_open(const char *pathname, int flags, int mode);
extern int sys_write(int fd, void *buffer, int size);
extern int sys_exit(int error);
extern int sys_close(int fd);
extern int sys_read(int fd, void *buf, int count);
extern unsigned int sys_getpid();
extern int sys_fork();
extern long sys_gettime(long * tloc);

// for time
#define CLOCK_REALTIME 0
typedef struct timespec {
    long     sec;        /* seconds */
    long     nsec;       /* nanoseconds */
}timest;
extern int sys_clock_gettime(int clockid, struct timespec * tp);

int _strlen(const char * str);
int _puts(const char* str);
int _getchar(int fd);
int num_length(int resultado);
void num_to_str(char * char_num, int lg, int resultado);
void print_num(long long num, int fd);
int str_to_num(char * str, int longitud);
void print_hour(long time);
void print_date(long time);


/*************************************************** Funciones de strings ****************************/

 /***
 *  Funcion que lee de entrada estandar una linea de hasta MAX_BUFF - 1 caracteres.
 *
 *  Argumento:
 *    - char * buffer: puntero a la zona de memoria donde se almacenara el string ingresado.
 *
 *  Retorno:
 *    - Cantidad de caracteres copiados al buffer.
 ************************************ usa MAX_BUFF. STDIN, STDEER, sys_exit, sys_write, _getchar *******************************************
 *
 ***/
int _getline(char * buffer){
  int idx;
  char c;

  for(idx = 0 ; (idx< MAX_BUFF ) && (c=_getchar(STDIN))!='\n' ; idx++){
      buffer[idx] = c;
  }

  if(idx == MAX_BUFF){
    char errmsg[] = "La linea ingresada es demasiado larga \n";
    sys_write(STDERR, errmsg , _strlen(errmsg));
    sys_exit(-1);
  }

  buffer[idx] = 0;
  return idx;
}

/***
 *  Funcion que imprime en entrada estandar un string.
 *
 *  Argumento:
 *    - const char* str: string a imprimir.
 *
 *  Retorno:
 *    - mismo valor de retorno que sys_write: cantidad de caracteres leidos o un entero menor a 0 en caso de error.
 ************************************ usa sys_write STDOUT *******************************************
 *
 ***/
int _puts(const char* str) {
    return sys_write(STDOUT, (void*) str, _strlen(str));
}

/***
* Funcion que retorna la longitud de un string.

* Argumento:
* - const char * str:  puntero a la direccion de memoria donde se encuentra el string.
*
* Retorno:
* - La longitud del string.
***/
int _strlen(const char * str){
    int i=0;
    while( *(str + (i++)) );
    return i-1;
}

/***
* Funcion que lee un unico caracter de un file descriptor especifico.
*
* Argumento:
*  - int fd: file descriptor del que se quiere leer el caracter.
*
* Retorno:
*  - En caso de error al leer el caracter, devuelve -2 (GCERR).
*  - Si se termina el archivo devuelve -1 (EOF).
*  - Sino, devuelve el caracter leido.
*********** Usa sys_read y las constantes GCERR EOF *********************+
***/
int _getchar(int fd) {
		char c;
    int returnval = sys_read(fd, &c, 1);

    if ( returnval == 1)
				return c;

    if( returnval < 0 )
				return GCERR;

		return EOF;
}

/***
 * Funcion que transforma un entero a un string.
 *
 * Argumentos:
 * - char * char_num: Puntero a la zona de memoria donde se dejara el string.
 * - int digits: La cantidad de digitos del numero.
 * - int num: Entero a transformar en string.
 ***/
void num_to_str(char * char_num, int digits, int num){
    if(num < 0){
      num*=-1;
    }

    for(int i=digits-1 ; i>=0 ; --i){
      char_num[i] = num%10 + '0';
      num/=10;
    }
}

/***
* Funcion que cuenta la cantidad de apariciones del string almacenado del buffer en file descriptor
*
* Argumentos:
* - char * buffer: puntero a la direccion de memoria del buffer.
* - int longitud: longitud del buffer.
* - int fd: file descriptor
*
* Retorno:
* - la cantidad de apariciones del buffer en el file descriptor.
*
***/
int KMPsearch(char * buffer,int longitud,int fd){

    char next[longitud];
    nextComputation(buffer,next);

    int c;
    int finish = ((c =_getchar(fd)) == EOF);
    int counter = 0;
    int pbuff = 0;

    while (!finish){
          if(c == buffer[pbuff]){
              finish = ((c =_getchar(fd)) == EOF);
              pbuff++;
              if(pbuff == longitud){
                   counter++;
                   pbuff = next[pbuff-1];
              }
          }
          else if(pbuff!=0){
              pbuff = next[pbuff-1];
          }
          else{
              finish = ((c =_getchar(fd)) == EOF);
          }
      }
    return counter;
}
/***
* Funcion que preprocesa el string para ofrecer una busqueda eficiente con el algoritmo KMP
*
* Argumentos:
* - char * buffer: puntero a la direccion de memoria donde esta el string que se quiere preprocesar
* - char * next: puntero a la zona de memoria donde estara la tabla de next
*
***/

void nextComputation(char * buffer,char * next){
  next[0] = 0;
  int border = 0;
  for (int rec = 1; buffer[rec]; rec++) {
           while ((border > 0) && (buffer[border] != buffer[rec]))
               border = next[border - 1];
           if (buffer[border] == buffer[rec])
               border++;
           next[rec] = border;
       }
}

/********************************************** Funciones de enteros *********************************/

/***
 * Funcion que calcula la cantidad de digitos de un entero.
 *
 * Argumento:
 * - int num: El numero al que se le calculara la cantidad de digitos.
 *
 * Retorno:
 * - La cantidad de digitos del numero.
 ***/
int num_length(int num){

    if(num < 0){
      num*=-1;
    }

    int length = 0;
    while(num){
        length++;
        num/=10;
    }
    return length;
}

/***
 * Funcion que transforma un string a un entero.
 *
 * Argumentos:
 * - char * str: Puntero al string que se convertira en un entero.
 * - int longitud: Longitud del string.
 *
 * Retorno:
 * - Transformacion del string a un int.
 ***/

int str_to_num(char * str, int longitud){
    int neg = 0;

    if(str[0] == '-'){
      neg = 1;
    }

    int num = 0;

    for(int i=neg ; i<longitud ; i++){
      num = num*10 + str[i] - '0';
    }

    if(neg){
      num*=-1;
    }

    return num;
}

/***
* Funcion que imprime en fd, num.
*
* Argumento:
*  - long long num: entero a imprimir en el file descriptor.
*  - int fd: file descriptor a escribir.
*********** Usa sys_write, num_length, num_to_str *********************
*********** Si no usamos long long, poner int *************************
***/
void print_num(long long num, int fd){

  if(num==0){
    sys_write(fd, "0", 1);
    return;
  }

  int lg = num_length(num);

  char char_num[lg];

  num_to_str(char_num,lg,num);

  if(num<0){
    sys_write(fd, "-", 1);
  }
  sys_write(fd, char_num, lg);
}

/************************************************* Funciones de tiempo ***************************************/

/*
*                                                #define UTC -3
*                                         #define SECS_DAY (60*60*24)
*/


/***
* Funcion que chequea si un año es bisiesto.
*
* Argumento:
* - int year: numero entero que representa el año a analizar.
*
* Retorno:
* - 1 si el año recibido es bisiesto, o 0 si no.
***/

int leapYear(int year){
  if (year % 400 == 0) {
    return 1;
 }
 else if (year % 100 == 0) {
    return 0;
 }

 else if (year % 4 == 0) {
    return 1;
 }
  return 0;
}

/***
* Funcion que calcula la hora actual del sistema.
*
* Argumento:
* - long time: cantidad de segundos transcurridos desde EPOCH.
************************** Usa sys_write y STDOUT ***********************************
***/

void print_hour(long time){

    time += UTC * 3600;
    int t = time % SECS_DAY;
    char hour[] = {'0','0',':','0','0',':','0','0'};

    int seg = t % 60;
    int min = (t % 3600) / 60;
    int h = t / 3600;

    hour[0] += h / 10;
    hour[1] += h % 10;
    hour[3] += min / 10;
    hour[4] += min % 10;
    hour[6] += seg / 10;
    hour[7] += seg % 10;

    sys_write(STDOUT, "hora: ", 6);
    sys_write(STDOUT, hour, 8);
    sys_write(STDOUT, "\n", 1);
}

/***
  *  Funcion que imprime en pantalla la fecha actual.
  *
  *  Argumento:
  *  - long time: cantidad de segundos transcurridos desde EPOCH.
  ******************* Usa secs_day y stout ********************
***/

void print_date(long time){

    // Cantidad de dias de cada mes.
    // La primera fila es para no anos bisiesotos
    // y la segunda para anos bisiesotos
    int mdays[2][12] = {{31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
                        {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}};

    // String con el formato a imprimir
    char date[] = {'0','0','/','0','0','/','0','0','0','0'};

    // Cantidad de dias desde epoch
    int t = time/(SECS_DAY) + 1;;

    int year = 1970;
    int month = 1;

    while( t >= (365 + leapYear(year)) ){
        t -= 365 + leapYear(year);
        year++;
    }

    int leap = leapYear(year);
    while( t >= mdays[leap][month-1] ){
        t -= mdays[leap][month-1];
        month++;
    }

    // Completamos el string de fecha
    date[0]+= t/10;
    date[1]+= t%10;
    date[3]+= month/10;
    date[4]+= month%10;
    date[6]+= year/1000;
    date[7]+= (year%1000)/100;
    date[8]+= (year%100)/10;
    date[9]+= year%10;

    sys_write(STDOUT, "fecha: ", 7);
    sys_write(STDOUT, date, 10);
    sys_write(STDOUT, "\n", 1);
}