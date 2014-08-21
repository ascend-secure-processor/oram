localparam  WriteLatency    = 1;
localparam  RefillLatency   = (1 << LogLineSize);

localparam  DArrayAddrWidth = `log2f(Capacity / DataWidth);
localparam  NumLines = (Capacity / DataWidth) >> LogLineSize;
localparam  TArrayAddrWidth = `log2f(NumLines);
localparam  TagWidth = AddrWidth - LogLineSize;

