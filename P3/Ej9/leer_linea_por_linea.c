#include <stddef.h>
#include <sys/types.h>
#define O_CREAT 00000100 

extern void exit(int status);
extern ssize_t read(int fd, void *buf, size_t count);
extern ssize_t write(int fd, const void *buf, size_t count);
extern int open(const char *pathname, int flags, mode_t mode);
extern int close(int fd);
extern int _print(const char *string, int size);

int main(int argc, char* argv[]){
    int fd = open("test.txt", 2 | O_CREAT, 0777);
}