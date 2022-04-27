#ifndef FUNCTIONS_H
#define FUNCTIONS_H

#include "syscalls32.h"
#define EOF -1
#define GET_CHAR_ERR -2

#define CLEAN_BUFFER {if(c != '\n' && c > 0) while(getchar() != '\n');}
#define isNum(a) ((a) >= '0' && (a) <= '9')
#define isMinus(c) ((c) >= 'a' && (c) <= 'z')
#define isMayus(c) ((c) >= 'A' && (c) <= 'Z')
#define charToNum(a) ((a) - '0')
#define UTC -3
#define SECS_DAY (60*60*24)

int strlen(const char * str);
void printBytes(const char * str, int bytes);
void print(const char * str);
void _putchar(char c);
void perror(const char * str);
void newLine();
void printLong(long num);
void printInt(int num);
int getchar();
int getcharfd(int fd);
int getlinefd(int fd, char * buffer, unsigned long bufferlen);
long numToString(long number, char * buffer, long bufferSize);
int startClock();
int endClock();
int getClockInterval(long * sec, long * nanosec);
long getNum();
long strToNum(char * str);
void printDate(long secSinceEpoch);
void printHour(long secSinceEpoch);
int sleep(long sec);
int nanoSleep(long sec, long nanosec);
int getNumfd(int fd, int digitCount);
void mergeSort(int arr[], int l, int r);
void printArray(int arr[], int dim);
#endif