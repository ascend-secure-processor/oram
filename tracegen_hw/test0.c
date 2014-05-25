
#include <SWTestHarnessDriver.h>
#include <stdlib.h>

void main() {
	int fd = initialize_uart("/dev/ttyUSB0", UART_BAUD);

	srand(0);

	// This is exactly the testbench test
/*	send_cmd(fd, CMD_Update, 0x38c, 0, 	0);
	send_cmd(fd, CMD_Update, 0x3f9, 0xf, 	0);
	send_cmd(fd, CMD_Update, 0x300, 0xff, 	0);
	send_cmd(fd, CMD_Read, 	 0x38c, 0, 0);
	send_cmd(fd, CMD_Read,   0x3f9, 0, 0);
	send_cmd(fd, CMD_Read,   0x300, 0, 0);
*/
//	send_start_cmd(fd);

//	send_cmd(fd,  TCMD_CmdRnd_AddrRnd,    1001,   10,        0);


	//		Command			Seed	# accesses	Offset
	
	//send_cmd(fd,  	TCMD_Fill,    		1000,   1 << 20,        1024);
	//send_cmd(fd, 	TCMD_CmdRnd_AddrRnd, 	1002, 	1 << 20, 	0);

	//
	// SPEC TRACES
	//
	int num_valid_blocks = 1 << 20;
	//send_cmd(fd, TCMD_Fill, 1000, num_valid_blocks, 1024);

	int MAX = 300000;
	
	FILE* file = fopen("trace_hmmer_pruned.csv", "rt"); int MAX_read = 1 << 20;
	//FILE* file = fopen("trace_libquantum.csv", "rt"); int MAX_read = 307607;
	//FILE* file = fopen("trace_gcc_2006_pruned.csv", "rt"); int MAX_read = 1 << 20;
	//FILE* file = fopen("trace_sjeng_pruned.csv", "rt"); int MAX_read = 702033;
	//FILE* file = fopen("trace_bzip2_pruned.csv", "rt"); int MAX_read = 384355;

	#define CHUNK 12
	char buf[CHUNK];
	size_t nread;

	int sent_before[num_valid_blocks];
	int * read_trace = (int*) malloc(sizeof(int) * num_valid_blocks);
	int j;
	for (j = 0; j < num_valid_blocks; j++) {
		sent_before[j] = 0;
	}

	if (file) {
		int i = 0; 
		int address; 
		char type; 
	  	int writes = 0;
		int reads = 0;
		int skipped = 0;

		while(i < MAX && fgets(buf, CHUNK, file) != NULL) {
		 	sscanf (buf, "%c %x\n", &type, &address);
		 	
			if (address > num_valid_blocks) {
				printf("WARNING: access=%d addr %x too large\n", i, address);	
				address = 0;
			}
			else if (sent_before[address] == 0) {
				printf ("sent write %x\n", address);
				send_cmd(fd, CMD_Update, address, 0, 0);
				sent_before[address] = 1;
				writes++;
			}
			read_trace[i] = address;
			//send_cmd(fd, CMD_Read, address, 0, 0);
			i++;
  		} 

		i = 0;
		while (reads < MAX_read && i < MAX) {
			int caddr = read_trace[i];
			if (caddr) {
				printf ("%d: sent read %x\n", reads, caddr);
				send_cmd(fd, CMD_Read, caddr, 0, 0);
				reads++;
			} else printf ("WARNING: skipped read %d\n", i);
			i++;
		}

		printf("Done; writes=%d, reads=%d\n", writes, reads);

   		fclose(file);
	}


// Random accesses	
	int num_valid = 1 << 17;
        int i;
        int Nread = num_valid;
        for (i = 0; i < Nread; i++) {
                send_cmd(fd, CMD_Update, i, 0, 0);
        }

        int Nwrite = Nread << 0;
        for (i = 0; i < Nwrite; i++) {
                send_cmd(fd, CMD_Read, rand() % Nread, i, 0);
        }



// Simple stride
/*
        int i;
        int Nread = 1 << 15;
        for (i = 0; i < Nread; i++) {
                send_cmd(fd, CMD_Update, i, 0, 0);
		if (i % 100000 == 0) printf("Wrote %d\n", i);
        }

        int Nwrite = Nread << 0;
        for (i = 0; i < Nwrite; i++) {
                send_cmd(fd, CMD_Read, i % Nread, i, 0);
		if (i % 100000 == 0) printf("Read %d\n", i);
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

// Note: just push the button to get the histogram back
//	send_start_cmd(fd);
}
