
#include <SWTestHarnessDriver.h>

void main() {
	int fd = initialize_uart("/dev/ttyUSB0", B115200);

send_cmd(fd, CMD_Update, 0, 0, 0);
send_cmd(fd, CMD_Read, 0, 0, 0);
/*
	int i;
	int N = 200;
        for (i = 0; i < N; i++) {
                send_cmd(fd, CMD_Update, i, i, 0);
        }
	for (i = 0; i < N; i++) {
		send_cmd(fd, CMD_Read, i, i, 0);
	}

*/
	send_start_cmd(fd);
}
