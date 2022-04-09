#include <stddef.h>
#include <sys/types.h>
#define O_CREAT 00000100 

extern void exit(int status);
extern ssize_t read(int fd, void *buf, size_t count);
extern ssize_t write(int fd, const void *buf, size_t count);
extern int open(const char *pathname, int flags, mode_t mode);
extern int close(int fd);
extern int _print(const char *string, int size);

int main(int argc, char *argv[]){
    int size = 5;
    char buffer[size];
    int fd = open("test3.txt", 2 | O_CREAT, 0777);
    char buffer2[] = "world";
    write(fd, buffer2, size);
    close(fd);
    fd = open("test3.txt", 2, 0777);
    read(fd, buffer, size);
    _print(buffer, size);
    exit(0);
    return 0;
}