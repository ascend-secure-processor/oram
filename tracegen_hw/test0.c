
#include <SWTestHarnessDriver.h>

void main() {
	int fd = initialize_uart("/dev/ttyUSB0", UART_BAUD);

	// This is exactly the testbench test
/*	send_cmd(fd, CMD_Update, 0x38c, 0, 	0);
	send_cmd(fd, CMD_Update, 0x3f9, 0xf, 	0);
	send_cmd(fd, CMD_Update, 0x300, 0xff, 	0);
	send_cmd(fd, CMD_Read, 	 0x38c, 0, 0);
	send_cmd(fd, CMD_Read,   0x3f9, 0, 0);
	send_cmd(fd, CMD_Read,   0x300, 0, 0);
	send_start_cmd(fd);
*/

// Test a block that will be mapped to the leaf
// Status: fine
/*      int i;
        int Nread = 200;
        for (i = 0; i < Nread; i++) {
                send_cmd(fd, CMD_Update, i, 0, 0);
        }

	send_cmd(fd, CMD_Read,   102, 0, 0);
*/

// Simple stride
// Status: fine
        int i;
        int Nread = 1000;
        for (i = 0; i < Nread; i++) {
                send_cmd(fd, CMD_Update, i, 0, 0);
        }

        int Nwrite = 10000;
        for (i = 0; i < Nwrite; i++) {
                send_cmd(fd, CMD_Read, i % 999, i, 0);
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
