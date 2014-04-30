
#include <SWTestHarnessDriver.h>
#include <stdlib.h>

void main() {
	int fd = initialize_uart("/dev/ttyUSB1", UART_BAUD);

	srand(0);

	// This is exactly the testbench test
/*	send_cmd(fd, CMD_Update, 0x38c, 0, 	0);
	send_cmd(fd, CMD_Update, 0x3f9, 0xf, 	0);
	send_cmd(fd, CMD_Update, 0x300, 0xff, 	0);
	send_cmd(fd, CMD_Read, 	 0x38c, 0, 0);
	send_cmd(fd, CMD_Read,   0x3f9, 0, 0);
	send_cmd(fd, CMD_Read,   0x300, 0, 0);
	send_start_cmd(fd);
*/

// Random accesses
// Status: fine up to L = 15
/*	int num_valid = 1 << 15;
        int i;
        int Nread = num_valid;
        for (i = 0; i < Nread; i++) {
                send_cmd(fd, CMD_Update, i, 0, 0);
        }

        int Nwrite = Nread << 0;
        for (i = 0; i < Nwrite; i++) {
		int a = rand() % Nread;
                send_cmd(fd, CMD_Read, a, i, 0);
        }
*/

// Simple stride
// Status: fine
        int i;
        int Nread = 20;
        for (i = 0; i < Nread; i++) {
                send_cmd(fd, CMD_Update, i, 0, 0);
        }

        int Nwrite = Nread;
        for (i = 0; i < Nwrite; i++) {
                send_cmd(fd, CMD_Read, i, i, 0);
        }

// Status: fine 
/*	int i;
        int Nread = 400;
	for (i = 0; i < Nread; i++) {
                send_cmd(fd, CMD_Update, i, 0, 0);
        }

        int Nwrite = 4000;//Nread;
        for (i = 0; i < Nwrite; i++) {
		int a = (i << 4) % Nread;
		send_cmd(fd, CMD_Read, a, i, 0);
        }
*/

// Simple reverse stride
// Status: fine
/*
	int i;
        int Nread = 1000;

        for (i = Nread; i >= 0; i--) {
                send_cmd(fd, CMD_Update, i, 0, 0);
        }

        int Nwrite = 1000;
        for (i = 0; i < Nwrite; i++) {
                send_cmd(fd, CMD_Read, i, i, 0);
        }
*/

// Access same place always
// Status: fine
/*
        int i;
        int Nread = 1000;

        for (i = Nread; i >= 0; i--) {
                send_cmd(fd, CMD_Update, i, 0, 0);
        }

        int Nwrite = 1000;
        for (i = 0; i < Nwrite; i++) {
                send_cmd(fd, CMD_Read, 0, i, 0);
        }
*/

	send_start_cmd(fd);
}
