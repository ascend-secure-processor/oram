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

#define TCMD_Fill 0xaf
#define TCMD_CmdLin_AddrLin 0xbf
#define TCMD_CmdLin_AddrRnd 0xcf
#define TCMD_CmdRnd_AddrLin 0xdf
#define TCMD_CmdRnd_AddrRnd 0xef

#define	CMD_Start	0xff

// Must match your machine setup
//#define UART_BAUD	B9600
#define UART_BAUD     	B115200

// NOTE: the real size is 4096, but there is a small bug in the test harness tha causes us to stop early
// This isn't a problem for getting results
#define HISTOGRAM_SIZE	4094

void send_cmd(int fd, cmd_t cmd, paddr_t paddr, datab_t datab, timed_t timed);
void send_start_cmd(int fd);
