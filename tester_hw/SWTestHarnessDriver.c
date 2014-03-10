#include <errno.h>
#include <termios.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

int set_interface_attribs (int fd, int speed, int parity) {
	struct termios tty;
	memset (&tty, 0, sizeof tty);
        if (tcgetattr (fd, &tty) != 0) {
		printf ("error %d from tcgetattr", errno);
		return -1;
	}

	cfsetospeed (&tty, speed);
	cfsetispeed (&tty, speed);

        tty.c_cflag = (tty.c_cflag & ~CSIZE) | CS8;     // 8-bit chars
        // disable IGNBRK for mismatched speed tests; otherwise receive break
        // as \000 chars
        tty.c_iflag &= ~IGNBRK;         // ignore break signal
        tty.c_lflag = 0;                // no signaling chars, no echo,
                                        // no canonical processing
        tty.c_oflag = 0;                // no remapping, no delays
        tty.c_cc[VMIN]  = 0;            // read doesn't block
        tty.c_cc[VTIME] = 5;            // 0.5 seconds read timeout

        tty.c_iflag &= ~(IXON | IXOFF | IXANY); // shut off xon/xoff ctrl

        tty.c_cflag |= (CLOCAL | CREAD);// ignore modem controls,
                                        // enable reading
        tty.c_cflag &= ~(PARENB | PARODD);      // shut off parity
        tty.c_cflag |= parity;
        tty.c_cflag &= ~CSTOPB;
        tty.c_cflag &= ~CRTSCTS;

        if (tcsetattr (fd, TCSANOW, &tty) != 0)
        {
		printf ("error %d from tcsetattr", errno);
                return -1;
        }
        return 0;
}

void
set_blocking (int fd, int should_block)
{
        struct termios tty;
        memset (&tty, 0, sizeof tty);
        if (tcgetattr (fd, &tty) != 0)
        {
                printf ("error %d from tggetattr", errno);
                return;
        }

        tty.c_cc[VMIN]  = should_block ? 1 : 0;
        tty.c_cc[VTIME] = 5;            // 0.5 seconds read timeout

        if (tcsetattr (fd, TCSANOW, &tty) != 0)
                printf ("error %d setting term attributes", errno);
}

typedef int8_t cmd_t;
typedef int32_t paddr_t;
typedef int32_t datab_t;
typedef int32_t timed_t;

#define CMD_Update	0
#define CMD_Append	1
#define CMD_Read	2
#define CMD_ReadRmv	3
#define	CMD_Start	0xff

void write_packet(int fd, cmd_t cmd, paddr_t paddr, datab_t datab, timed_t timed) {
	write (fd, &timed, sizeof(timed_t));
	write (fd, &datab, sizeof(datab_t));
	write (fd, &paddr, sizeof(paddr_t));
	write (fd, &cmd, sizeof(cmd_t));
}

void write_packet_start(int fd) {
	write_packet(fd, CMD_Start, 0xdeadbeef, 0xba5eba11, 0);
}

void main() {
	char *portname = "/dev/ttyUSB0";

	int fd = open (portname, O_RDWR | O_NOCTTY | O_SYNC);

	if (fd < 0) {
		printf ("error %d opening %s: %s", errno, portname, strerror (errno));
		return;
	}

	set_interface_attribs (fd, B115200, 0);  // set speed to 115,200 bps, 8n1 (no parity)
	set_blocking (fd, 0);                // set no blocking

	write_packet(fd, CMD_Update, 	0x80000000, 0xf, 10);
	write_packet(fd, CMD_Append, 	0x80000001, 0x1f, 2);
        write_packet(fd, CMD_Read, 	0x80000002, 0x2f, 0);
        write_packet(fd, CMD_ReadRmv, 	0x80000003, 0x3f, 128);
	write_packet_start(fd);
}


