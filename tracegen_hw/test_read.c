
#include <SWTestHarnessDriver.h>

void main() {
	int fd = initialize_uart("/dev/ttyUSB0", B9600);//B115200);

	char buf[4];
	int i = 0;
	while (1) {
		read(fd, buf, 4);
		int cast = *((datab_t *) buf);
		printf("%x\n", cast);
	}

}
