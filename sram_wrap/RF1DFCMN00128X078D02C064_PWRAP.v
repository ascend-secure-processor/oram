// 03/10/2014 14:51:52
// This file is auto-generated
// Author: Tri Nguyen
`timescale 1ns/100ps
`include "define.vh"
module RF1DFCMN00128X078D02C064_PWRAP
(
input wire MEMCLK,
input wire RESET_N,
input wire CE,
input wire [6:0] A,
input wire RDWEN,
input wire [77:0] BW,
input wire [77:0] DIN,
output wire [77:0] DOUT,
input wire [6:0] TA,
input wire TRDWEN,
input wire TESTEN,
input wire [77:0] TBW,
input wire [77:0] TDIN,
output wire [77:0] TDOUT,
input wire [`BIST_FUSE_WIDTH-1:0] FUSE
);
`ifndef NO_USE_IBM_SRAMS
reg TESTEN_muxed;
reg [6:0] TA_muxed;
reg TRDWEN_muxed;
reg [77:0] TDIN_muxed;
reg [77:0] TBW_muxed;
wire [0:0] AB;
wire [0:0] AC;
wire [4:0] AW;
wire [0:0] TAB;
wire [0:0] TAC;
wire [4:0] TAW;
assign {AW, AB, AC} = A;
assign {TAW, TAB, TAC} = TA_muxed;
wire [9:0] CR0;
wire CRE0;
wire [9:0] CR1;
wire CRE1;
wire [9:0] RR0;
wire RRE0;
wire [9:0] RR1;
wire RRE1;
wire [9:0] RR2;
wire RRE2;
wire [9:0] RR3;
wire RRE3;
wire MICLKMODE;
wire MIFLOOD;
wire MILSMODE;
wire MIPIPEMODE;
wire MISTM;
wire MITESTM3;
wire MIWASSD;
wire MIWRTM;
wire MISASSD;
wire [2:0] MIEMASASS;
wire [1:0] MIEMAM;
wire [2:0] MIEMAT;
wire [1:0] MIEMAW;
wire [1:0] MIEMAWASS;
wire PGDISABLE;
wire TPGDISABLE;
assign {PGDISABLE, TPGDISABLE, MICLKMODE, MIFLOOD, MILSMODE, MIPIPEMODE, MISTM,         MITESTM3, MIWASSD, MIWRTM, MISASSD, MIEMASASS, MIEMAM, MIEMAT, MIEMAW, MIEMAWASS} = FUSE[22:0];
assign CRE0 = FUSE[18 + 5];
assign CRE1 = FUSE[19 + 5];
assign RRE0 = FUSE[20 + 5];
assign RRE1 = FUSE[21 + 5];
assign RRE2 = FUSE[22 + 5];
assign RRE3 = FUSE[23 + 5];
assign CR0 = FUSE[38:29];
assign CR1 = FUSE[48:39];
assign RR0 = FUSE[58:49];
assign RR1 = FUSE[68:59];
assign RR2 = FUSE[78:69];
assign RR3 = FUSE[88:79];
RF1DFCMN00128X078D02C064 ibmsram (
.ARWY(),
.AB0(AB[0]),
.AC0(AC[0]),
.AW0(AW[0]),
.AW1(AW[1]),
.AW2(AW[2]),
.AW3(AW[3]),
.AW4(AW[4]),
.TAB0(TAB[0]),
.TAC0(TAC[0]),
.TAW0(TAW[0]),
.TAW1(TAW[1]),
.TAW2(TAW[2]),
.TAW3(TAW[3]),
.TAW4(TAW[4]),
.D0(DIN[0]),
.D1(DIN[1]),
.D2(DIN[2]),
.D3(DIN[3]),
.D4(DIN[4]),
.D5(DIN[5]),
.D6(DIN[6]),
.D7(DIN[7]),
.D8(DIN[8]),
.D9(DIN[9]),
.D10(DIN[10]),
.D11(DIN[11]),
.D12(DIN[12]),
.D13(DIN[13]),
.D14(DIN[14]),
.D15(DIN[15]),
.D16(DIN[16]),
.D17(DIN[17]),
.D18(DIN[18]),
.D19(DIN[19]),
.D20(DIN[20]),
.D21(DIN[21]),
.D22(DIN[22]),
.D23(DIN[23]),
.D24(DIN[24]),
.D25(DIN[25]),
.D26(DIN[26]),
.D27(DIN[27]),
.D28(DIN[28]),
.D29(DIN[29]),
.D30(DIN[30]),
.D31(DIN[31]),
.D32(DIN[32]),
.D33(DIN[33]),
.D34(DIN[34]),
.D35(DIN[35]),
.D36(DIN[36]),
.D37(DIN[37]),
.D38(DIN[38]),
.D39(DIN[39]),
.D40(DIN[40]),
.D41(DIN[41]),
.D42(DIN[42]),
.D43(DIN[43]),
.D44(DIN[44]),
.D45(DIN[45]),
.D46(DIN[46]),
.D47(DIN[47]),
.D48(DIN[48]),
.D49(DIN[49]),
.D50(DIN[50]),
.D51(DIN[51]),
.D52(DIN[52]),
.D53(DIN[53]),
.D54(DIN[54]),
.D55(DIN[55]),
.D56(DIN[56]),
.D57(DIN[57]),
.D58(DIN[58]),
.D59(DIN[59]),
.D60(DIN[60]),
.D61(DIN[61]),
.D62(DIN[62]),
.D63(DIN[63]),
.D64(DIN[64]),
.D65(DIN[65]),
.D66(DIN[66]),
.D67(DIN[67]),
.D68(DIN[68]),
.D69(DIN[69]),
.D70(DIN[70]),
.D71(DIN[71]),
.D72(DIN[72]),
.D73(DIN[73]),
.D74(DIN[74]),
.D75(DIN[75]),
.D76(DIN[76]),
.D77(DIN[77]),
.TD0(TDIN_muxed[0]),
.TD1(TDIN_muxed[1]),
.TD2(TDIN_muxed[2]),
.TD3(TDIN_muxed[3]),
.TD4(TDIN_muxed[4]),
.TD5(TDIN_muxed[5]),
.TD6(TDIN_muxed[6]),
.TD7(TDIN_muxed[7]),
.TD8(TDIN_muxed[8]),
.TD9(TDIN_muxed[9]),
.TD10(TDIN_muxed[10]),
.TD11(TDIN_muxed[11]),
.TD12(TDIN_muxed[12]),
.TD13(TDIN_muxed[13]),
.TD14(TDIN_muxed[14]),
.TD15(TDIN_muxed[15]),
.TD16(TDIN_muxed[16]),
.TD17(TDIN_muxed[17]),
.TD18(TDIN_muxed[18]),
.TD19(TDIN_muxed[19]),
.TD20(TDIN_muxed[20]),
.TD21(TDIN_muxed[21]),
.TD22(TDIN_muxed[22]),
.TD23(TDIN_muxed[23]),
.TD24(TDIN_muxed[24]),
.TD25(TDIN_muxed[25]),
.TD26(TDIN_muxed[26]),
.TD27(TDIN_muxed[27]),
.TD28(TDIN_muxed[28]),
.TD29(TDIN_muxed[29]),
.TD30(TDIN_muxed[30]),
.TD31(TDIN_muxed[31]),
.TD32(TDIN_muxed[32]),
.TD33(TDIN_muxed[33]),
.TD34(TDIN_muxed[34]),
.TD35(TDIN_muxed[35]),
.TD36(TDIN_muxed[36]),
.TD37(TDIN_muxed[37]),
.TD38(TDIN_muxed[38]),
.TD39(TDIN_muxed[39]),
.TD40(TDIN_muxed[40]),
.TD41(TDIN_muxed[41]),
.TD42(TDIN_muxed[42]),
.TD43(TDIN_muxed[43]),
.TD44(TDIN_muxed[44]),
.TD45(TDIN_muxed[45]),
.TD46(TDIN_muxed[46]),
.TD47(TDIN_muxed[47]),
.TD48(TDIN_muxed[48]),
.TD49(TDIN_muxed[49]),
.TD50(TDIN_muxed[50]),
.TD51(TDIN_muxed[51]),
.TD52(TDIN_muxed[52]),
.TD53(TDIN_muxed[53]),
.TD54(TDIN_muxed[54]),
.TD55(TDIN_muxed[55]),
.TD56(TDIN_muxed[56]),
.TD57(TDIN_muxed[57]),
.TD58(TDIN_muxed[58]),
.TD59(TDIN_muxed[59]),
.TD60(TDIN_muxed[60]),
.TD61(TDIN_muxed[61]),
.TD62(TDIN_muxed[62]),
.TD63(TDIN_muxed[63]),
.TD64(TDIN_muxed[64]),
.TD65(TDIN_muxed[65]),
.TD66(TDIN_muxed[66]),
.TD67(TDIN_muxed[67]),
.TD68(TDIN_muxed[68]),
.TD69(TDIN_muxed[69]),
.TD70(TDIN_muxed[70]),
.TD71(TDIN_muxed[71]),
.TD72(TDIN_muxed[72]),
.TD73(TDIN_muxed[73]),
.TD74(TDIN_muxed[74]),
.TD75(TDIN_muxed[75]),
.TD76(TDIN_muxed[76]),
.TD77(TDIN_muxed[77]),
.Q0(DOUT[0]),
.Q1(DOUT[1]),
.Q2(DOUT[2]),
.Q3(DOUT[3]),
.Q4(DOUT[4]),
.Q5(DOUT[5]),
.Q6(DOUT[6]),
.Q7(DOUT[7]),
.Q8(DOUT[8]),
.Q9(DOUT[9]),
.Q10(DOUT[10]),
.Q11(DOUT[11]),
.Q12(DOUT[12]),
.Q13(DOUT[13]),
.Q14(DOUT[14]),
.Q15(DOUT[15]),
.Q16(DOUT[16]),
.Q17(DOUT[17]),
.Q18(DOUT[18]),
.Q19(DOUT[19]),
.Q20(DOUT[20]),
.Q21(DOUT[21]),
.Q22(DOUT[22]),
.Q23(DOUT[23]),
.Q24(DOUT[24]),
.Q25(DOUT[25]),
.Q26(DOUT[26]),
.Q27(DOUT[27]),
.Q28(DOUT[28]),
.Q29(DOUT[29]),
.Q30(DOUT[30]),
.Q31(DOUT[31]),
.Q32(DOUT[32]),
.Q33(DOUT[33]),
.Q34(DOUT[34]),
.Q35(DOUT[35]),
.Q36(DOUT[36]),
.Q37(DOUT[37]),
.Q38(DOUT[38]),
.Q39(DOUT[39]),
.Q40(DOUT[40]),
.Q41(DOUT[41]),
.Q42(DOUT[42]),
.Q43(DOUT[43]),
.Q44(DOUT[44]),
.Q45(DOUT[45]),
.Q46(DOUT[46]),
.Q47(DOUT[47]),
.Q48(DOUT[48]),
.Q49(DOUT[49]),
.Q50(DOUT[50]),
.Q51(DOUT[51]),
.Q52(DOUT[52]),
.Q53(DOUT[53]),
.Q54(DOUT[54]),
.Q55(DOUT[55]),
.Q56(DOUT[56]),
.Q57(DOUT[57]),
.Q58(DOUT[58]),
.Q59(DOUT[59]),
.Q60(DOUT[60]),
.Q61(DOUT[61]),
.Q62(DOUT[62]),
.Q63(DOUT[63]),
.Q64(DOUT[64]),
.Q65(DOUT[65]),
.Q66(DOUT[66]),
.Q67(DOUT[67]),
.Q68(DOUT[68]),
.Q69(DOUT[69]),
.Q70(DOUT[70]),
.Q71(DOUT[71]),
.Q72(DOUT[72]),
.Q73(DOUT[73]),
.Q74(DOUT[74]),
.Q75(DOUT[75]),
.Q76(DOUT[76]),
.Q77(DOUT[77]),
.TQ0(TDOUT[0]),
.TQ1(TDOUT[1]),
.TQ2(TDOUT[2]),
.TQ3(TDOUT[3]),
.TQ4(TDOUT[4]),
.TQ5(TDOUT[5]),
.TQ6(TDOUT[6]),
.TQ7(TDOUT[7]),
.TQ8(TDOUT[8]),
.TQ9(TDOUT[9]),
.TQ10(TDOUT[10]),
.TQ11(TDOUT[11]),
.TQ12(TDOUT[12]),
.TQ13(TDOUT[13]),
.TQ14(TDOUT[14]),
.TQ15(TDOUT[15]),
.TQ16(TDOUT[16]),
.TQ17(TDOUT[17]),
.TQ18(TDOUT[18]),
.TQ19(TDOUT[19]),
.TQ20(TDOUT[20]),
.TQ21(TDOUT[21]),
.TQ22(TDOUT[22]),
.TQ23(TDOUT[23]),
.TQ24(TDOUT[24]),
.TQ25(TDOUT[25]),
.TQ26(TDOUT[26]),
.TQ27(TDOUT[27]),
.TQ28(TDOUT[28]),
.TQ29(TDOUT[29]),
.TQ30(TDOUT[30]),
.TQ31(TDOUT[31]),
.TQ32(TDOUT[32]),
.TQ33(TDOUT[33]),
.TQ34(TDOUT[34]),
.TQ35(TDOUT[35]),
.TQ36(TDOUT[36]),
.TQ37(TDOUT[37]),
.TQ38(TDOUT[38]),
.TQ39(TDOUT[39]),
.TQ40(TDOUT[40]),
.TQ41(TDOUT[41]),
.TQ42(TDOUT[42]),
.TQ43(TDOUT[43]),
.TQ44(TDOUT[44]),
.TQ45(TDOUT[45]),
.TQ46(TDOUT[46]),
.TQ47(TDOUT[47]),
.TQ48(TDOUT[48]),
.TQ49(TDOUT[49]),
.TQ50(TDOUT[50]),
.TQ51(TDOUT[51]),
.TQ52(TDOUT[52]),
.TQ53(TDOUT[53]),
.TQ54(TDOUT[54]),
.TQ55(TDOUT[55]),
.TQ56(TDOUT[56]),
.TQ57(TDOUT[57]),
.TQ58(TDOUT[58]),
.TQ59(TDOUT[59]),
.TQ60(TDOUT[60]),
.TQ61(TDOUT[61]),
.TQ62(TDOUT[62]),
.TQ63(TDOUT[63]),
.TQ64(TDOUT[64]),
.TQ65(TDOUT[65]),
.TQ66(TDOUT[66]),
.TQ67(TDOUT[67]),
.TQ68(TDOUT[68]),
.TQ69(TDOUT[69]),
.TQ70(TDOUT[70]),
.TQ71(TDOUT[71]),
.TQ72(TDOUT[72]),
.TQ73(TDOUT[73]),
.TQ74(TDOUT[74]),
.TQ75(TDOUT[75]),
.TQ76(TDOUT[76]),
.TQ77(TDOUT[77]),
.BW0(BW[0]),
.BW1(BW[1]),
.BW2(BW[2]),
.BW3(BW[3]),
.BW4(BW[4]),
.BW5(BW[5]),
.BW6(BW[6]),
.BW7(BW[7]),
.BW8(BW[8]),
.BW9(BW[9]),
.BW10(BW[10]),
.BW11(BW[11]),
.BW12(BW[12]),
.BW13(BW[13]),
.BW14(BW[14]),
.BW15(BW[15]),
.BW16(BW[16]),
.BW17(BW[17]),
.BW18(BW[18]),
.BW19(BW[19]),
.BW20(BW[20]),
.BW21(BW[21]),
.BW22(BW[22]),
.BW23(BW[23]),
.BW24(BW[24]),
.BW25(BW[25]),
.BW26(BW[26]),
.BW27(BW[27]),
.BW28(BW[28]),
.BW29(BW[29]),
.BW30(BW[30]),
.BW31(BW[31]),
.BW32(BW[32]),
.BW33(BW[33]),
.BW34(BW[34]),
.BW35(BW[35]),
.BW36(BW[36]),
.BW37(BW[37]),
.BW38(BW[38]),
.BW39(BW[39]),
.BW40(BW[40]),
.BW41(BW[41]),
.BW42(BW[42]),
.BW43(BW[43]),
.BW44(BW[44]),
.BW45(BW[45]),
.BW46(BW[46]),
.BW47(BW[47]),
.BW48(BW[48]),
.BW49(BW[49]),
.BW50(BW[50]),
.BW51(BW[51]),
.BW52(BW[52]),
.BW53(BW[53]),
.BW54(BW[54]),
.BW55(BW[55]),
.BW56(BW[56]),
.BW57(BW[57]),
.BW58(BW[58]),
.BW59(BW[59]),
.BW60(BW[60]),
.BW61(BW[61]),
.BW62(BW[62]),
.BW63(BW[63]),
.BW64(BW[64]),
.BW65(BW[65]),
.BW66(BW[66]),
.BW67(BW[67]),
.BW68(BW[68]),
.BW69(BW[69]),
.BW70(BW[70]),
.BW71(BW[71]),
.BW72(BW[72]),
.BW73(BW[73]),
.BW74(BW[74]),
.BW75(BW[75]),
.BW76(BW[76]),
.BW77(BW[77]),
.TBW0(TBW_muxed[0]),
.TBW1(TBW_muxed[1]),
.TBW2(TBW_muxed[2]),
.TBW3(TBW_muxed[3]),
.TBW4(TBW_muxed[4]),
.TBW5(TBW_muxed[5]),
.TBW6(TBW_muxed[6]),
.TBW7(TBW_muxed[7]),
.TBW8(TBW_muxed[8]),
.TBW9(TBW_muxed[9]),
.TBW10(TBW_muxed[10]),
.TBW11(TBW_muxed[11]),
.TBW12(TBW_muxed[12]),
.TBW13(TBW_muxed[13]),
.TBW14(TBW_muxed[14]),
.TBW15(TBW_muxed[15]),
.TBW16(TBW_muxed[16]),
.TBW17(TBW_muxed[17]),
.TBW18(TBW_muxed[18]),
.TBW19(TBW_muxed[19]),
.TBW20(TBW_muxed[20]),
.TBW21(TBW_muxed[21]),
.TBW22(TBW_muxed[22]),
.TBW23(TBW_muxed[23]),
.TBW24(TBW_muxed[24]),
.TBW25(TBW_muxed[25]),
.TBW26(TBW_muxed[26]),
.TBW27(TBW_muxed[27]),
.TBW28(TBW_muxed[28]),
.TBW29(TBW_muxed[29]),
.TBW30(TBW_muxed[30]),
.TBW31(TBW_muxed[31]),
.TBW32(TBW_muxed[32]),
.TBW33(TBW_muxed[33]),
.TBW34(TBW_muxed[34]),
.TBW35(TBW_muxed[35]),
.TBW36(TBW_muxed[36]),
.TBW37(TBW_muxed[37]),
.TBW38(TBW_muxed[38]),
.TBW39(TBW_muxed[39]),
.TBW40(TBW_muxed[40]),
.TBW41(TBW_muxed[41]),
.TBW42(TBW_muxed[42]),
.TBW43(TBW_muxed[43]),
.TBW44(TBW_muxed[44]),
.TBW45(TBW_muxed[45]),
.TBW46(TBW_muxed[46]),
.TBW47(TBW_muxed[47]),
.TBW48(TBW_muxed[48]),
.TBW49(TBW_muxed[49]),
.TBW50(TBW_muxed[50]),
.TBW51(TBW_muxed[51]),
.TBW52(TBW_muxed[52]),
.TBW53(TBW_muxed[53]),
.TBW54(TBW_muxed[54]),
.TBW55(TBW_muxed[55]),
.TBW56(TBW_muxed[56]),
.TBW57(TBW_muxed[57]),
.TBW58(TBW_muxed[58]),
.TBW59(TBW_muxed[59]),
.TBW60(TBW_muxed[60]),
.TBW61(TBW_muxed[61]),
.TBW62(TBW_muxed[62]),
.TBW63(TBW_muxed[63]),
.TBW64(TBW_muxed[64]),
.TBW65(TBW_muxed[65]),
.TBW66(TBW_muxed[66]),
.TBW67(TBW_muxed[67]),
.TBW68(TBW_muxed[68]),
.TBW69(TBW_muxed[69]),
.TBW70(TBW_muxed[70]),
.TBW71(TBW_muxed[71]),
.TBW72(TBW_muxed[72]),
.TBW73(TBW_muxed[73]),
.TBW74(TBW_muxed[74]),
.TBW75(TBW_muxed[75]),
.TBW76(TBW_muxed[76]),
.TBW77(TBW_muxed[77]),
.DBWY0(),
.DBWY1(),
.DBWY2(),
.DBWY3(),
.DBWY4(),
.DBWY5(),
.DBWY6(),
.DBWY7(),
.DBWY8(),
.DBWY9(),
.DBWY10(),
.DBWY11(),
.DBWY12(),
.DBWY13(),
.DBWY14(),
.DBWY15(),
.DBWY16(),
.DBWY17(),
.DBWY18(),
.DBWY19(),
.DBWY20(),
.DBWY21(),
.DBWY22(),
.DBWY23(),
.DBWY24(),
.DBWY25(),
.DBWY26(),
.DBWY27(),
.DBWY28(),
.DBWY29(),
.DBWY30(),
.DBWY31(),
.DBWY32(),
.DBWY33(),
.DBWY34(),
.DBWY35(),
.DBWY36(),
.DBWY37(),
.DBWY38(),
.DBWY39(),
.DBWY40(),
.DBWY41(),
.DBWY42(),
.DBWY43(),
.DBWY44(),
.DBWY45(),
.DBWY46(),
.DBWY47(),
.DBWY48(),
.DBWY49(),
.DBWY50(),
.DBWY51(),
.DBWY52(),
.DBWY53(),
.DBWY54(),
.DBWY55(),
.DBWY56(),
.DBWY57(),
.DBWY58(),
.DBWY59(),
.DBWY60(),
.DBWY61(),
.DBWY62(),
.DBWY63(),
.DBWY64(),
.DBWY65(),
.DBWY66(),
.DBWY67(),
.DBWY68(),
.DBWY69(),
.DBWY70(),
.DBWY71(),
.DBWY72(),
.DBWY73(),
.DBWY74(),
.DBWY75(),
.DBWY76(),
.DBWY77(),
.QRED0(),
.QRED1(),
.CLK(MEMCLK),
.CE(CE),
.RDWEN(RDWEN),
.TCE(1'b1),
.TRDWEN(TRDWEN_muxed),
.CR00(CR0[0]),
.CR01(CR0[1]),
.CR02(CR0[2]),
.CR03(CR0[3]),
.CR04(CR0[4]),
.CR05(CR0[5]),
.CRE0(CRE0),
.MICLKMODE(MICLKMODE),
.MIFLOOD(MIFLOOD),
.MILSMODE(MILSMODE),
.MIPIPEMODE(MIPIPEMODE),
.MISASSD(MISASSD),
.MISTM(MISTM),
.MITESTM1(TESTEN_muxed),
.MITESTM3(MITESTM3),
.MIWASSD(MIWASSD),
.MIWRTM(MIWRTM),
.MIEMASASS0(MIEMASASS[0]),
.MIEMASASS1(MIEMASASS[1]),
.MIEMASASS2(MIEMASASS[2]),
.MIEMAT0(MIEMAT[0]),
.MIEMAT1(MIEMAT[1]),
.MIEMAW0(MIEMAW[0]),
.MIEMAW1(MIEMAW[1]),
.MIEMAWASS0(MIEMAWASS[0]),
.MIEMAWASS1(MIEMAWASS[1]),
.DEEPSLEEP(1'b0),
.TDEEPSLEEP(1'b0)
);


localparam INIT_STATE = 1'd0;
localparam DONE_STATE  = 1'd1;

localparam INDEX_WIDTH = 7;
localparam DATA_WIDTH = 78;

reg [0:0] bist_state;
reg [0:0] bist_state_next;
reg [INDEX_WIDTH-1:0] bist_index;
reg [INDEX_WIDTH-1:0] bist_index_next;
reg init_done;
reg init_done_next;

always @ (posedge MEMCLK)
begin
   if (!RESET_N)
   begin
      bist_index <= 0;
      init_done <= 1; // CF: disable initialization
      bist_state <= INIT_STATE;
   end
   else
   begin
      if (bist_state != DONE_STATE)
      begin
         bist_index <= bist_index_next;
         init_done <= init_done_next;
         bist_state <= bist_state_next;
      end
   end
end

always @ *
begin
   bist_index_next = init_done ? bist_index : bist_index + 1;
   init_done_next = ((|(~bist_index)) == 0) | init_done;
   case (bist_state)
      INIT_STATE:
      begin
         if (init_done)
            bist_state_next = DONE_STATE;
         else
            bist_state_next = INIT_STATE;
      end
      DONE_STATE:
         bist_state_next = DONE_STATE;
   endcase
end

// MUX
always @ *
begin
   if (bist_state == INIT_STATE)
   begin
      TESTEN_muxed = 1'b1;
      TA_muxed = bist_index;
      TRDWEN_muxed = 1'b0; // write only
      TDIN_muxed = {DATA_WIDTH{1'b0}};
      TBW_muxed = {DATA_WIDTH{1'b1}};
   end
   else
   begin
      TESTEN_muxed = TESTEN;
      TA_muxed = TA;
      TRDWEN_muxed = TRDWEN;
      TDIN_muxed = TDIN;
      TBW_muxed = TBW;
   end
end

`else
reg [77:0] cache [127:0];

integer i;
initial
begin
   for (i = 0; i < 128; i = i + 1)
   begin
      cache[i] = 0;
   end
end



   reg [77:0] dout_f;

   assign DOUT = dout_f;

   always @ (posedge MEMCLK)
   begin
      if (CE)
      begin
         if (RDWEN == 1'b0)
            cache[A] <= (DIN & BW) | (cache[A] & ~BW);
         else
            dout_f <= cache[A];
      end
   end

`endif
endmodule
