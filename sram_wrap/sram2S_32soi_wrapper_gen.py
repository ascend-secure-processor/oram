import os, sys
from math import *

if len(sys.argv) >= 5:
	NWords, NBits, NDec, NCPBL = (int(arg) for arg in sys.argv[1:6])
else:
	print("Not enough arguments")	
	exit()

# generate SRAM name
SRAM_name = "SRAM2SFCMN" # Must use F (latency = 1). TODO: other configs less relevent
			     
SRAM_name += "%05d" % NWords + "X%03d" % NBits + "D%02d" % NDec + "C%03d" % NCPBL

print("generating wrapper for %s.v" % SRAM_name)

# generate file
f = open(SRAM_name + "_WRAP.v", 'w')

f.write("// auto generated SRAM wrapper by sram_wrap_gen.py\n\n")

# parameters and IO declaration
_AddrA = "_AddrA"
_AddrB = "_AddrB"
_DInA = "_DInA"
_DInB = "_DInB"
_DOutA = "_DOutA"
_DOutB = "_DOutB"

DWidth = NBits
AWidth = int(log(NWords, 2))

Upper_IO = ["Clock", "EnableA", "WriteA", "EnableB", "WriteB", _AddrA, _DInA, _DOutA, _AddrB, _DInB, _DOutB]
f.write("module " + SRAM_name + "_WRAP ({0});\n\n".format(", ".join(Upper_IO)))

f.write("\tinput {0};\n".format(", ".join(Upper_IO[0:5])))
f.write("\tinput [{0}-1:0] {1};\n".format(AWidth, _AddrA + ', ' + _AddrB))
f.write("\tinput [{0}-1:0] {1};\n".format(DWidth, _DInA + ', ' + _DInB))
f.write("\toutput [{0}-1:0] {1};\n\n".format(DWidth, _DOutA + ', ' + _DOutB))

# ---- SRAM paramter and ports ----
# control ports
Connection = [
	("CLKA", "Clock"),
	("CLKB", "Clock"),
	("CEA", "EnableA"),
	("CEB", "EnableB"),
	("RDWENA", "!WriteA"),
	("RDWENB", "!WriteB"),
	("DEEPSLEEP", "1'b0"),
	("PGDISABLE", "1'b1"),
]

divider = [('\n', 0)]
Connection += divider

def generatePorts(PortAndWidth):
	Ports = []
	for port in PortAndWidth:
		if len(port) == 2:
			port_name, port_width = port
			ports = [port_name] * port_width
			Ports += [ports[i] + str(i) for i in range(port_width)]
		elif len(port) == 3:
			port_name, port_width1, port_width2 = port
			ports = [port_name] * port_width1 * port_width2
			Ports += [ports[i] + str(i) + str(j) for i in range(port_width1) for j in range(port_width2)]
	return Ports

# addr ports
p = ceil(NWords/(NCPBL*NDec))
if p > 0: ABW = int(ceil(log(p, 2)))
else: ABW = 0 
ACW = 2
ADW = int(log(NDec/4, 2))
AWW = AWidth - ABW - ACW - ADW

# port1
AddrPorts = [("ABA", ABW), ("ACA", ACW), ("ADA", ADW), ("AWA", AWW)]
AddrPorts = generatePorts(AddrPorts)
Connection += [( AddrPorts[i], "{0}[{1}]".format(_AddrA, str(i))) for i in range(AWidth)]
Connection += divider
# port 2
AddrPorts = [("ABB", ABW), ("ACB", ACW), ("ADB", ADW), ("AWB", AWW)]
AddrPorts = generatePorts(AddrPorts)
Connection += [( AddrPorts[i], "{0}[{1}]".format(_AddrB, str(i))) for i in range(AWidth)]
Connection += divider

# data ports
Connection += [( 'DA' + str(i), "{0}[{1}]".format(_DInA, str(i))) for i in range(DWidth)]
Connection += [( 'QA' + str(i), "{0}[{1}]".format(_DOutA, str(i))) for i in range(DWidth)]
Connection += [( 'BWA' + str(i), "1'b1") for i in range(DWidth)]
Connection += divider
Connection += [( 'DB' + str(i), "{0}[{1}]".format(_DInB, str(i))) for i in range(DWidth)]
Connection += [( 'QB' + str(i), "{0}[{1}]".format(_DOutB, str(i))) for i in range(DWidth)]
Connection += [( 'BWB' + str(i), "1'b1") for i in range(DWidth)]
Connection += divider

# test ports
Col_redundancy = int(ceil(log(ceil(NBits * NDec / 8), 2)))
Row_redundancy = 0 if SRAM_name[7] == 'C' else 4

Connection += divider
TestPorts = [
	("TABA", ABW),
	("TACA", ACW),
	("TADA", ADW),
	("TAWA", AWW),
	("TABB", ABW),
	("TACB", ACW),
	("TADB", ADW),
	("TAWB", AWW),
	("TDA",   DWidth),
	("TQA",   DWidth),
	("TBWA",  DWidth),
	("TDB",   DWidth),
	("TQB",   DWidth),
	("TBWB",  DWidth),
	("MIEMAT",  3),
	("MIEMAW",  2),
	("MIEMASASS",  3),
	("MIEMAWASS",  2),
	("CRE", 2),
	("CR", 2, Col_redundancy),
	("RRE", Row_redundancy),
	("RR", Row_redundancy, AWW),
]

TestPorts = generatePorts(TestPorts)

TestPorts += [
	"TPGDISABLE",
	"TDEEPSLEEP",
	"MICLKMODE",
	"MIDPTEN",
	"MIEMAM",
	"MIFLOOD",
	"MILSMODE",
	"MIPIPEMODE",
	"MISASSD",
	"MISTM",
	"MITESTM1",
	"MITESTM3",
	"MITESTWT",
	"MIWASSD",
	"MIWRTM",
	"TCEA",
	"TCEB",
	"TRDWENA",
	"TRDWENB",
	"MIPORTSEL",
	"MIDPT0",
	"MIDPT1",
	"MIDPT2",
	"MIDPT3"
]

Connection += [ ( TestPorts[i], "1'b0") for i in range(len(TestPorts))]

# ---- instantiate the SRAM ----
f.write("\t" + SRAM_name + ' SRAM (\n')

for connect in Connection[0:len(Connection)-1]:
	if connect[0] == '\n':
		f.write('\n')
	else:
		f.write("\t\t.{0}(\t{1}),\n".format(connect[0], connect[1]))		
connect = Connection[-1]
f.write("\t\t.{0}(\t{1}));\n".format(connect[0], connect[1]))

f.write("endmodule\n")
f.close()
