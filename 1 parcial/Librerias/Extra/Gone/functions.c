#include "functions.h"

int strlen(const char * str) {
    int len, i;
    for(i = len = 0; str[i] != '\0'; i++) len++;
    return len;
}

void printBytes(const char * str, int bytes) {
    sys_write(STDOUT, (void *)str, bytes);
}

void print(const char * str) {
    printBytes(str, strlen(str));
}

void _putchar(char c) {
    sys_write(STDOUT, (void *) &c, 1);
}

void perr(const char * str) {
    sys_write(STDERR, (void *) str, strlen(str));
}

void printLong(long num) {
    char buff[32];
    printBytes(buff, numToString(num, buff, 32));
}
void printInt(int num) {
    printLong(num);
}

int getcharfd(int fd) {
    char c;
    int read = sys_read(fd, &c, 1);
    if(read == 1) return c;
    if(read < 0) return GET_CHAR_ERR;
    return EOF;
}

int getchar() {
    return getcharfd(STDIN);
}

int getlinefd(int fd, char * buffer, unsigned long bufflen) {
    int dim = 0;
    int c;
    while(dim < (bufflen - 1) && (c = getcharfd(fd)) != '\n' && c != EOF) {
        buffer[dim++] = c;
    }
    buffer[dim] = '\0';
    return dim;
}

void newLine() {
    char c = '\n';
    sys_write(STDOUT, &c, 1);
}

long numToString(long num, char * buffer, long bufferSize) {
    if(bufferSize <= 0) return 0;

    if(num == 0) {
        buffer[0] = '0';
        buffer[1] = '\0';
        return 1;
    }
    int isNeg = 0;
    if(num < 0) {
        buffer[0] = '-';
        num = -num;
        isNeg = 1;
    }
    long aux = num;
    long digitcount = 0;
    while(aux > 0) {
        aux /= 10;
        digitcount++;
    }
    
    long startPos = digitcount + isNeg - 1;
    if(startPos + 1 > bufferSize) return 0;
    buffer[startPos+1] = '\0';
    for(int i = 0; i < digitcount; i++) {
        buffer[startPos - i] = num % 10 + '0';
        num /= 10;
    }
    return startPos + 1;
}


long getNum() {
    long num = 0;
    int c;
    for(c = getchar(); isNum(c);) {
        num *= 10;
        num += charToNum(c);
        c = getchar();
    }
    CLEAN_BUFFER
    return num;
}

long strToNum(char * str) {
    long num = 0;
    for(int i = 0; str[i] != 0; i++) {
        num *= 10;
        num += charToNum(str[i]); 
    }
    return num;
}


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

void printHour(long time){

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

void printDate(long time){

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

int sleep(long sec) {
    return nanoSleep(sec, 0);
}

int nanoSleep(long sec, long nanosec) {
    timespec sleepTime = {sec, nanosec};
    return sys_nanosleep(&sleepTime, NULL);
}

int getNumfd(int fd, int digitCount) {
    int num = 0;
    char c = getcharfd(fd);
    for(int i = 0; i < digitCount && isNum(c); i++) {
        num *= 10;
        num += c - '0';
        c = getcharfd(fd);
    }
    return num;
}

void printArray(int arr[], int dim) {
    _putchar('[');
    _putchar(' ');
    for(int i = 0; i < dim; i++) {
        printInt(arr[i]);
        _putchar(' ');
    }
    _putchar(']');
    _putchar('\n');
}

static void merge(int arr[], int l, int m, int r)
{
    int i, j, k;
    int n1 = m - l + 1;
    int n2 = r - m;

    /* create temp arrays */
    int L[n1], R[n2];

    /* Copy data to temp arrays L[] and R[] */
    for (i = 0; i < n1; i++)
        L[i] = arr[l + i];
    for (j = 0; j < n2; j++)
        R[j] = arr[m + 1 + j];

    /* Merge the temp arrays back into arr[l..r]*/
    i = 0; // Initial index of first subarray
    j = 0; // Initial index of second subarray
    k = l; // Initial index of merged subarray
    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) {
            arr[k] = L[i];
            i++;
        }
        else {
            arr[k] = R[j];
            j++;
        }
        k++;
    }

    /* Copy the remaining elements of L[], if there
    are any */
    while (i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }

    /* Copy the remaining elements of R[], if there
    are any */
    while (j < n2) {
        arr[k] = R[j];
        j++;
        k++;
    }
}

/* l is for left index and r is right index of the
sub-array of arr to be sorted */
void mergeSort(int arr[], int l, int r)
{
    if (l < r) {
        // Same as (l+r)/2, but avoids overflow for
        // large l and h
        int m = l + (r - l) / 2;

        // Sort first and second halves
        mergeSort(arr, l, m);
        mergeSort(arr, m + 1, r);

        merge(arr, l, m, r);
    }
}

static timespec startTime;
static timespec endTime;
static int endTimeFlag = 0;
static int startTimeFlag = 0;

int startClock() {
    endTimeFlag = 0;
    startTimeFlag = 1;
    return sys_clock_gettime(CLOCK_REALTIME, &startTime);
}

int endClock() {
    if(!startTimeFlag) {
        return -1;
    }
    endTimeFlag = 1;
    return sys_clock_gettime(CLOCK_REALTIME, &endTime);
}

int getClockInterval(long * sec, long * nanosec) {
    if(!endTimeFlag) {
        return -1;
    }
    double nanosecExp = 1/1000000000.0;
    double timePassed = (endTime.sec + endTime.nanosec*(nanosecExp)) - (startTime.sec + startTime.nanosec*(nanosecExp));
    (*sec) = (long) timePassed;
    (*nanosec) = (long)((timePassed - (*sec)) / nanosecExp);
    return 1;
}