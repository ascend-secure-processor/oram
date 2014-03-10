
#include <SWTestHarnessDriver.h>

void main() {
	int fd; initialize_uart("/dev/ttyUSB0", B115200);

	send_cmd(fd, CMD_Update, 	0x80000000, 0xf, 10);
	send_cmd(fd, CMD_Append, 	0x80000001, 0x1f, 2);
	send_cmd(fd, CMD_Read, 		0x80000002, 0x2f, 0);
	send_cmd(fd, CMD_ReadRmv, 	0x80000003, 0x3f, 128);
	send_start_cmd(fd);
}
