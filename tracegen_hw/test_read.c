
#include <SWTestHarnessDriver.h>

void main() {
	int fd = initialize_uart("/dev/ttyUSB0", UART_BAUD);

	char buf[4];
	int i = 0;
	int total = 0;
	while (1) {
		read(fd, buf, 4);
		unsigned int cast = *((datab_t *) buf);
		unsigned int temp;
		temp = (cast << 24) | (0x00ff0000 & (cast << 8)) | (0x0000ff00 & (cast >> 8)) | (cast >> 24);
		if (temp) printf("%d,\t%u\n", i, temp);
		total += temp;
		i++;
		if (i > 4000) break;
	}
	printf("Total accesses = %d\n", total);

}
