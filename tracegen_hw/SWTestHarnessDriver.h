#include <errno.h>
#include <termios.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

typedef int8_t cmd_t;
typedef int32_t paddr_t;
typedef unsigned int datab_t;
typedef int32_t timed_t;

// Must match TestHarnessLocal.vh
#define CMD_Update	0
#define CMD_Append	1
#define CMD_Read	2
#define CMD_ReadRmv	3
#define	CMD_Start	0xff

// Must match your machine setup
//#define UART_BAUD	B9600
#define UART_BAUD     	B115200

void send_cmd(int fd, cmd_t cmd, paddr_t paddr, datab_t datab, timed_t timed);
void send_start_cmd(int fd);
