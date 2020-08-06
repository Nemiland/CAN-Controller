/*-------------------------------------------
  Project: CAN Controller
  Module: can_config_registers_tb
  Author: Pengfei He
  Date: 8/6/2020
  Module Description: Configuration registers self_checking test bench
-------------------------------------------*/

module can_config_reg_tb;
    logic i_sys_clk;
    logic i_reset;
    logic [31:0] i_reg_w_bus;
    logic [30:0] i_rs_vector;
    logic i_r_neg_w;
    logic [31:0] o_reg_r_data;
    logic o_reg_ack;
    logic o_reg_error;
    logic o_interrupt;
    logic o_soft_reset;
    logic o_cen;
    logic [127:0] i_rx_fifo_data;
    logic i_tx_full;
    logic i_rx_empty;
    logic [127:0] o_tx_fifo_data;
    logic o_tx_w_en;
    logic [127:0] o_hpb_data;
    logic i_hpb_r_en;
    logic o_hpb_full;
    logic i_acker;
    logic i_berr;
    logic i_ster;
    logic i_fmer;
    logic i_crcer;
    logic i_acfbsy;
    logic o_lback;
    logic o_sleep;
    logic [1:0] i_estat;
    logic i_errwrn;
    logic i_bbsy;
    logic i_bidle;
    logic i_normal;
    logic i_sleep;
    logic i_lback;
    logic i_config;
    logic i_wakeup;
    logic i_bsoff;
    logic i_error;
    logic i_txok;
    logic i_arblst;
    logic i_rxnemp;
    logic i_rxoflw;
    logic i_rxuflw;
    logic i_rxok;
    logic [1:0] o_sjw;
    logic [2:0] o_ts2;
    logic [3:0] o_ts1;
    logic [7:0] i_rec;
    logic [7:0] i_tec;
    logic o_rx_r_en;
    logic o_uaf1;
    logic o_uaf2;
    logic o_uaf3;
    logic o_uaf4;
    logic [31:0] o_afmr1;
    logic [31:0] o_afmr2;
    logic [31:0] o_afmr3;
    logic [31:0] o_afmr4;
    logic [31:0] o_afir1;
    logic [31:0] o_afir2;
    logic [31:0] o_afir3;
    logic [31:0] o_afir4;
       
       
can_config_registers DUT (
    .i_sys_clk,
    .i_reset,
    .i_reg_w_bus,
    .i_rs_vector,
    .i_r_neg_w,
    .o_reg_r_data,
    .o_reg_ack,
    .o_reg_error,
    .o_interrupt,
    .o_soft_reset,
    .o_cen,
    .i_rx_fifo_data,
    .i_tx_full,
    .i_rx_empty,
    .o_tx_fifo_data,
    .o_tx_w_en,
    .o_hpb_data,
    .i_hpb_r_en,
    .o_hpb_full,
    .i_acker,
    .i_berr,
    .i_ster,
    .i_fmer,
    .i_crcer,
    .i_acfbsy,
    .o_lback,
    .o_sleep,
    .i_estat,
    .i_errwrn,
    .i_bbsy,
    .i_bidle,
    .i_normal,
    .i_sleep,
    .i_lback,
    .i_config,
    .i_wakeup,
    .i_bsoff,
    .i_error,
    .i_txok,
    .i_arblst,
    .i_rxnemp,
    .i_rxoflw,
    .i_rxuflw,
    .i_rxok,
    .o_sjw,
    .o_ts2,
    .o_ts1,
    .i_rec,
    .i_tec,
    .o_rx_r_en,
    .o_uaf1,
    .o_uaf2,
    .o_uaf3,
    .o_uaf4,
    .o_afmr1,
    .o_afmr2,
    .o_afmr3,
    .o_afmr4,
    .o_afir1,
    .o_afir2,
    .o_afir3,
    .o_afir4);
       
       
       
       
       
always 
#5 i_sys_clk <= !i_sys_clk;


initial 
begin

/*----------------- CONFIG_REG_TC_00 Begin -----------------*/
i_sys_clk <=1'b0; 
i_reg_w_bus <=32'b0;
i_rs_vector <=31'b0;
i_r_neg_w <=1'b0;
i_rx_fifo_data <=128'b0;
i_tx_full <=1'b0;
i_rx_empty <=1'b1;
i_acfbsy <=1'b0;
i_estat <=2'b0;
i_errwrn <=1'b0;
i_bbsy <=1'b0;
i_bidle <=1'b0;
i_normal <=1'b0;
i_sleep <=1'b0;
i_acker <=1'b0;
i_berr <=1'b0;
i_ster <=1'b0;
i_fmer <=1'b0;
i_crcer <=1'b0;
i_acfbsy <=1'b0;
i_lback <=1'b0;
i_config <=1'b0;
i_wakeup <=1'b0;
i_bsoff <=1'b0;
i_error <=1'b0;
i_txok <=1'b0;
i_arblst <=1'b0;
i_rxnemp <=1'b0;
i_rxoflw <=1'b0;
i_rxuflw <=1'b0;
i_rxok <=1'b0;
i_rec <=8'b0;
i_tec <=8'b0; 

// Set afmr1 = 0x0000_0001
@(posedge i_sys_clk);
i_r_neg_w <=1'b0; 
i_reg_w_bus <=32'h0000_0001;
i_rs_vector <=31'h0800_0000
;
       
@(posedge i_sys_clk);       
i_rs_vector <=31'h0000_0000;      

// Set afmr2 = 0x0000_0001       
@(posedge i_sys_clk);
i_reg_w_bus <=32'h0000_0001;
i_rs_vector <=31'h1000_0000;      

@(posedge i_sys_clk);       
i_rs_vector <=31'h0000_0000;

// Set afmr3 = 0x0000_0001
@(posedge i_sys_clk);
i_reg_w_bus <=32'h0000_0001;
i_rs_vector <=31'h2000_0000;  

@(posedge i_sys_clk);       
i_rs_vector <=31'h0000_0000; 
        
// Set afmr4 = 0x0000_0001
@(posedge i_sys_clk)
i_reg_w_bus <=32'h0000_0001;
i_rs_vector <=31'h4000_0000;

@(posedge i_sys_clk)       
i_rs_vector <=31'h0000_0000; 

// Set afir1 = 0x0000_0001
@(posedge i_sys_clk)
i_reg_w_bus <=32'h0000_0001;
i_rs_vector <=31'h0080_0000;
 
@(posedge i_sys_clk)       
i_rs_vector <=31'h0000_0000; 

// Set afir2 = 0x0000_0001
@(posedge i_sys_clk)
i_reg_w_bus <=32'h0000_0001;
i_rs_vector <=31'h0100_0000;
 
@(posedge i_sys_clk)       
i_rs_vector <=31'h0000_0000; 

// Set afir3 = 0x0000_0001
@(posedge i_sys_clk)
i_reg_w_bus <=32'h0000_0001;
i_rs_vector <=31'h0200_0000;
 
@(posedge i_sys_clk)       
i_rs_vector <=31'h0000_0000; 

// Set afir4 = 0x0000_0001
@(posedge i_sys_clk)
i_reg_w_bus <=32'h0000_0001;
i_rs_vector <=31'h0400_0000;
 
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;    

// Set i_reset <=1'b1

@(posedge i_sys_clk)
i_reset <= 1'b1;
@(posedge i_sys_clk)
assert (o_reg_r_data ==32'h0 && o_reg_ack ==1'b0 && o_reg_error ==1'b0 && o_interrupt ==1'b0 && o_sjw == 2'b00 &&
        o_tx_fifo_data ==128'h0 && o_tx_w_en ==1'b0 && o_hpb_data ==128'h0  && o_hpb_full ==1'b0 && o_cen == 1'b0 && o_rx_r_en == 1'b0 &&
        o_sleep==1'b0 && o_lback == 1'b0 && o_afmr1 ==32'h0000_0001 && o_afmr2 ==32'h0000_0001 && o_afmr3 ==32'h0000_0001 &&
        o_afmr4 ==32'h0000_0001 && o_afir1 ==32'h0000_0001 && o_afir2 ==32'h0000_0001 && o_afir3 ==32'h0000_0001 && o_ts2 == 3'b0 &&
        o_afir4 ==32'h0000_0001 && o_uaf1 ==1'b0 && o_uaf2 ==1'b0 && o_uaf3 ==1'b0 && o_ts1 == 3'b0 && o_uaf4 ==1'b0)$display ("---- CONFIG_REG_TC_00 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_00 FAILED AT %0t !!!!! ",$time);

@(posedge i_sys_clk)
i_reset <= 1'b0;

/*----------------- CONFIG_REG_TC_00 END -----------------*/

/*----------------- CONFIG_REG_TC_01 BEGIN -----------------*/

@(posedge i_sys_clk)
i_r_neg_w <=1'b1;
i_rs_vector <=31'h0000_0001;
@(posedge i_sys_clk) 
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (o_reg_ack == 1'b1)$display ("---- CONFIG_REG_TC_01 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_01 FAILED AT %0t !!!!! ",$time);

/*----------------- CONFIG_REG_TC_01 END -----------------*/


/*----------------- CONFIG_REG_TC_02 BEGIN -----------------*/

@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h0002_0001;
i_reg_w_bus <=32'hffff_ffff;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (o_reg_error == 1'b1) $display ("---- CONFIG_REG_TC_02 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_02 FAILED AT %0t !!!!! ",$time);

/*----------------- CONFIG_REG_TC_02 END -----------------*/


/*----------------- CONFIG_REG_TC_03 BEGIN -----------------*/

@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h0000_0080;
i_reg_w_bus <=32'h0;
i_sleep <=1'b1; 
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
@(posedge i_sys_clk)    
assert (o_interrupt == 1'b0) $display ("---- CONFIG_REG_TC_03 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_03 FAILED AT %0t !!!!! ",$time);

/*----------------- CONFIG_REG_TC_03 END -----------------*/

/*----------------- CONFIG_REG_TC_04 BEGIN -----------------*/
@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h0000_0001;
i_reg_w_bus <=32'h8000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (o_soft_reset == 1'b1) $display ("---- CONFIG_REG_TC_04 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_04 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_04 END -----------------*/

/*----------------- CONFIG_REG_TC_05 BEGIN -----------------*/
@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h0000_0400;
i_reg_w_bus <=32'h0000_0001;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0800;
i_reg_w_bus <=32'h0000_0001;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_1000;
i_reg_w_bus <=32'h0000_0001;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_2000;
i_reg_w_bus <=32'h0000_0000;  
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;  
@(posedge i_sys_clk)
assert (o_tx_fifo_data == 128'h0000_0001_0000_0001_0000_0001_0000_0000) $display ("---- CONFIG_REG_TC_05 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_05 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_05 END -----------------*/

/*----------------- CONFIG_REG_TC_06 BEGIN -----------------*/
@(posedge i_sys_clk)
assert (o_tx_w_en == 1'b1) $display ("---- CONFIG_REG_TC_06 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_06 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_06 END -----------------*/

/*----------------- CONFIG_REG_TC_07 BEGIN -----------------*/
@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h0000_4000;
i_reg_w_bus <=32'h0000_0001;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_8000;
i_reg_w_bus <=32'h0000_0001;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0001_0000;
i_reg_w_bus <=32'h0000_0001;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0002_0000;
i_reg_w_bus <=32'h0000_0000;  
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;  
@(posedge i_sys_clk)
assert (o_hpb_data == 128'h0000_0001_0000_0001_0000_0001_0000_0000)  $display ("---- CONFIG_REG_TC_07 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_07 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_07 END -----------------*/

/*----------------- CONFIG_REG_TC_09 BEGIN -----------------*/
 assert (o_hpb_full == 1'b1) $display ("---- CONFIG_REG_TC_09 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_09 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_09 END -----------------*/

/*----------------- CONFIG_REG_TC_08 BEGIN -----------------*/
@(posedge i_sys_clk)
i_hpb_r_en <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (o_hpb_full == 1'b0)  $display ("---- CONFIG_REG_TC_08 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_08 FAILED AT %0t !!!!! ",$time);
 // Author uses 'i_hpb_r_en' instead of 'o_hpb_r_en' so it's differnet with test case
/*----------------- CONFIG_REG_TC_08 END -----------------*/


/*----------------- CONFIG_REG_TC_10 BEGIN -----------------*/
@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h0000_0002;
i_reg_w_bus <=32'h4000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (o_lback == 1'b1)  $display ("---- CONFIG_REG_TC_10 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_10 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_10 END -----------------*/

/*----------------- CONFIG_REG_TC_11 BEGIN -----------------*/
@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h0000_0002;
i_reg_w_bus <=32'h8000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (o_sleep == 1'b1)  $display ("---- CONFIG_REG_TC_11 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_11 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_11 END -----------------*/


/*----------------- CONFIG_REG_TC_12 BEGIN -----------------*/
@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h0000_0008;
i_reg_w_bus <=32'h0180_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (o_sjw == 2'b11)  $display ("---- CONFIG_REG_TC_12 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_12 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_12 END -----------------*/


/*----------------- CONFIG_REG_TC_13 BEGIN -----------------*/
@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h0000_0008;
i_reg_w_bus <=32'h0E00_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (o_ts2 == 3'b111)  $display ("---- CONFIG_REG_TC_13 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_13 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_13 END -----------------*/


/*----------------- CONFIG_REG_TC_14 BEGIN -----------------*/
@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h0000_0008;
i_reg_w_bus <=32'hF000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (o_ts1 == 4'b1111)  $display ("---- CONFIG_REG_TC_14 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_14 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_14 END -----------------*/


/*----------------- CONFIG_REG_TC_15 BEGIN -----------------*/
@(posedge i_sys_clk)
i_r_neg_w <=1'b1;
i_rx_empty <=1'b0;
i_rs_vector <=31'h0020_0000;
i_reg_w_bus <=32'h0000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
assert (o_rx_r_en == 1'b1)  $display ("---- CONFIG_REG_TC_15 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_15 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_15 END -----------------*/


/*----------------- CONFIG_REG_TC_16 BEGIN -----------------*/
@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h0040_0000;
i_reg_w_bus <=32'h8000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
assert (o_uaf1 == 1'b1)  $display ("---- CONFIG_REG_TC_16 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_16 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_16 END -----------------*/


/*----------------- CONFIG_REG_TC_17 BEGIN -----------------*/
@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h0040_0000;
i_reg_w_bus <=32'h4000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
assert (o_uaf2== 1'b1)  $display ("---- CONFIG_REG_TC_17 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_17 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_17 END -----------------*/



/*----------------- CONFIG_REG_TC_18 BEGIN -----------------*/
@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h0040_0000;
i_reg_w_bus <=32'h2000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
assert (o_uaf3== 1'b1)  $display ("---- CONFIG_REG_TC_18 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_18 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_18 END -----------------*/


/*----------------- CONFIG_REG_TC_19 BEGIN -----------------*/
@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h0040_0000;
i_reg_w_bus <=32'h1000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
assert (o_uaf4== 1'b1)  $display ("---- CONFIG_REG_TC_19 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_19 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_19 END -----------------*/

/*----------------- CONFIG_REG_TC_20 BEGIN -----------------*/
@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h0800_0000;
i_reg_w_bus <=32'h1000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (o_afmr1== 32'h1000_0000)  $display ("---- CONFIG_REG_TC_20 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_20 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_20 END -----------------*/



/*----------------- CONFIG_REG_TC_21 BEGIN -----------------*/
@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h1000_0000;
i_reg_w_bus <=32'h1000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (o_afmr2== 32'h1000_0000)  $display ("---- CONFIG_REG_TC_21 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_21 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_21 END -----------------*/



/*----------------- CONFIG_REG_TC_22 BEGIN -----------------*/
@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h2000_0000;
i_reg_w_bus <=32'h1000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (o_afmr3== 32'h1000_0000)  $display ("---- CONFIG_REG_TC_22 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_22 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_22 END -----------------*/


/*----------------- CONFIG_REG_TC_23 BEGIN -----------------*/
@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h4000_0000;
i_reg_w_bus <=32'h1000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (o_afmr4== 32'h1000_0000)  $display ("---- CONFIG_REG_TC_23 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_23 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_23 END -----------------*/


/*----------------- CONFIG_REG_TC_24 BEGIN -----------------*/
@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h0080_0000;
i_reg_w_bus <=32'h1000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (o_afir1== 32'h1000_0000)  $display ("---- CONFIG_REG_TC_24 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_24 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_24 END -----------------*/



/*----------------- CONFIG_REG_TC_25 BEGIN -----------------*/
@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h0100_0000;
i_reg_w_bus <=32'h1000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (o_afir2== 32'h1000_0000)  $display ("---- CONFIG_REG_TC_25 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_25 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_25 END -----------------*/


/*----------------- CONFIG_REG_TC_26 BEGIN -----------------*/
@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h0200_0000;
i_reg_w_bus <=32'h1000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (o_afir3== 32'h1000_0000)  $display ("---- CONFIG_REG_TC_26 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_26 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_26 END -----------------*/


/*----------------- CONFIG_REG_TC_27 BEGIN -----------------*/
@(posedge i_sys_clk)
i_r_neg_w <=1'b0;
i_rs_vector <=31'h0400_0000;
i_reg_w_bus <=32'h1000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (o_afir4== 32'h1000_0000)  $display ("---- CONFIG_REG_TC_27 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_27 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_27 END -----------------*/



/*----------------- CONFIG_REG_TC_28 BEGIN -----------------*/
@(posedge i_sys_clk)
i_rx_fifo_data <=128'h0000_0001_0000_0001_0000_0001_0000_0003;
@(posedge i_sys_clk)
i_r_neg_w <=1'b1;
i_rx_empty <=1'b0;
i_rs_vector <=31'h0020_0000;
i_reg_w_bus <=32'h0000_0000;
@(posedge i_sys_clk)
i_rs_vector <=31'h0000_0000;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[18] == 0000_0001)  $display ("---- CONFIG_REG_TC_28 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_28 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_28 END -----------------*/

/*----------------- CONFIG_REG_TC_29 BEGIN -----------------*/

assert (DUT.config_reg[19] == 0000_0001)  $display ("---- CONFIG_REG_TC_29 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_29 FAILED AT %0t !!!!! ",$time);

/*----------------- CONFIG_REG_TC_29 END-----------------*/


/*----------------- CONFIG_REG_TC_30 BEGIN -----------------*/

assert (DUT.config_reg[20] == 0000_0001)  $display ("---- CONFIG_REG_TC_30 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_30 FAILED AT %0t !!!!! ",$time);

/*----------------- CONFIG_REG_TC_30 END-----------------*/


/*----------------- CONFIG_REG_TC_31 BEGIN -----------------*/

assert (DUT.config_reg[21] == 0000_0003)  $display ("---- CONFIG_REG_TC_31 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_31 FAILED AT %0t !!!!! ",$time);

/*----------------- CONFIG_REG_TC_31 END-----------------*/


/*----------------- CONFIG_REG_TC_32 BEGIN -----------------*/
@(posedge i_sys_clk)
i_acker <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[5][27] == 1'b1)  $display ("---- CONFIG_REG_TC_32 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_32 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_32 END -----------------*/


/*----------------- CONFIG_REG_TC_33 BEGIN -----------------*/
@(posedge i_sys_clk)
i_berr <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[5][28] == 1'b1)  $display ("---- CONFIG_REG_TC_33 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_33 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_33 END -----------------*/


/*----------------- CONFIG_REG_TC_34 BEGIN -----------------*/
@(posedge i_sys_clk)
i_ster <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[5][29] == 1'b1)  $display ("---- CONFIG_REG_TC_34 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_34 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_34 END -----------------*/

/*----------------- CONFIG_REG_TC_35 BEGIN -----------------*/
@(posedge i_sys_clk)
i_fmer <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[5][30] == 1'b1)  $display ("---- CONFIG_REG_TC_35 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_35 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_35 END -----------------*/

/*----------------- CONFIG_REG_TC_36 BEGIN -----------------*/
@(posedge i_sys_clk)
i_crcer <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[5][31] == 1'b1)  $display ("---- CONFIG_REG_TC_36 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_36 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_36 END -----------------*/

/*----------------- CONFIG_REG_TC_37 BEGIN -----------------*/
@(posedge i_sys_clk)
i_acfbsy <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[6][20] == 1'b1)  $display ("---- CONFIG_REG_TC_37 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_37 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_37 END -----------------*/


/*----------------- CONFIG_REG_TC_38 BEGIN -----------------*/
@(posedge i_sys_clk)
i_estat <=2'b11;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[6][24:23] == 2'b11)  $display ("---- CONFIG_REG_TC_38 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_38 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_38 END -----------------*/

/*----------------- CONFIG_REG_TC_39 BEGIN -----------------*/
@(posedge i_sys_clk)
i_errwrn <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[6][25] == 1'b1)  $display ("---- CONFIG_REG_TC_39 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_39 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_39 END -----------------*/


/*----------------- CONFIG_REG_TC_40 BEGIN -----------------*/
@(posedge i_sys_clk)
i_bbsy <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[6][26] == 1'b1)  $display ("---- CONFIG_REG_TC_40 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_40 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_40 END -----------------*/

/*----------------- CONFIG_REG_TC_41 BEGIN -----------------*/
@(posedge i_sys_clk)
i_bidle <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[6][27] == 1'b1)  $display ("---- CONFIG_REG_TC_41 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_41 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_41 END -----------------*/

/*----------------- CONFIG_REG_TC_42 BEGIN -----------------*/
@(posedge i_sys_clk)
i_normal <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[6][28] == 1'b1)  $display ("---- CONFIG_REG_TC_42 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_42 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_42 END -----------------*/


/*----------------- CONFIG_REG_TC_43 BEGIN -----------------*/
@(posedge i_sys_clk)
i_sleep <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[6][29] == 1'b1)  $display ("---- CONFIG_REG_TC_43 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_43 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_43 END -----------------*/

/*----------------- CONFIG_REG_TC_44 BEGIN -----------------*/
@(posedge i_sys_clk)
i_lback <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[6][30] == 1'b1)  $display ("---- CONFIG_REG_TC_44 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_44 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_44 END -----------------*/

/*----------------- CONFIG_REG_TC_45 BEGIN -----------------*/
@(posedge i_sys_clk)
i_config <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[6][31] == 1'b1)  $display ("---- CONFIG_REG_TC_45 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_45 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_45 END -----------------*/


/*----------------- CONFIG_REG_TC_46 BEGIN -----------------*/
@(posedge i_sys_clk)
i_wakeup <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[7][20] == 1'b1)  $display ("---- CONFIG_REG_TC_46 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_46 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_46 END -----------------*/

/*----------------- CONFIG_REG_TC_47 BEGIN -----------------*/
@(posedge i_sys_clk)
i_sleep <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[7][21] == 1'b1)  $display ("---- CONFIG_REG_TC_47 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_47 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_47 END -----------------*/


/*----------------- CONFIG_REG_TC_48 BEGIN -----------------*/
@(posedge i_sys_clk)
i_bsoff <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[7][22] == 1'b1)  $display ("---- CONFIG_REG_TC_48 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_48 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_48 END -----------------*/


/*----------------- CONFIG_REG_TC_49 BEGIN -----------------*/
@(posedge i_sys_clk)
i_error <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[7][23] == 1'b1)  $display ("---- CONFIG_REG_TC_49 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_49 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_49 END -----------------*/


/*----------------- CONFIG_REG_TC_50 BEGIN -----------------*/
@(posedge i_sys_clk)
i_rxnemp <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[7][24] == 1'b1)  $display ("---- CONFIG_REG_TC_50 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_50 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_50 END -----------------*/


/*----------------- CONFIG_REG_TC_51 BEGIN -----------------*/
@(posedge i_sys_clk)
i_rxoflw <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[7][25] == 1'b1)  $display ("---- CONFIG_REG_TC_51 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_51 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_51 END -----------------*/

/*----------------- CONFIG_REG_TC_52 BEGIN -----------------*/
@(posedge i_sys_clk)
i_rxuflw <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[7][26] == 1'b1)  $display ("---- CONFIG_REG_TC_52 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_52 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_52 END -----------------*/


/*----------------- CONFIG_REG_TC_53 BEGIN -----------------*/
@(posedge i_sys_clk)
i_rxok <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[7][27] == 1'b1)  $display ("---- CONFIG_REG_TC_53 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_53 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_53 END -----------------*/
    
/*----------------- CONFIG_REG_TC_54 BEGIN -----------------*/

@(posedge i_sys_clk)
assert (DUT.config_reg[7][28] == 1'b1)  $display ("---- CONFIG_REG_TC_54 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_54 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_54 END -----------------*/    

/*----------------- CONFIG_REG_TC_55 BEGIN -----------------*/
@(posedge i_sys_clk)
i_tx_full <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[7][29] == 1'b1)  $display ("---- CONFIG_REG_TC_55 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_55 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_55 END -----------------*/


/*----------------- CONFIG_REG_TC_56 BEGIN -----------------*/
@(posedge i_sys_clk)
i_txok <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[7][30] == 1'b1)  $display ("---- CONFIG_REG_TC_56 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_56 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_56 END -----------------*/

/*----------------- CONFIG_REG_TC_57 BEGIN -----------------*/
@(posedge i_sys_clk)
i_arblst <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[7][31] == 1'b1)  $display ("---- CONFIG_REG_TC_57 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_57 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_57 END -----------------*/

/*----------------- CONFIG_REG_TC_58 BEGIN -----------------*/
@(posedge i_sys_clk)
i_rec <=8'h1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[4][23:16] == 8'h1)  $display ("---- CONFIG_REG_TC_58 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_58 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_58 END -----------------*/


/*----------------- CONFIG_REG_TC_59 BEGIN -----------------*/
@(posedge i_sys_clk)
i_tec <=8'h1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[4][31:24] == 8'h1)  $display ("---- CONFIG_REG_TC_59 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_59 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_59 END -----------------*/


/*----------------- CONFIG_REG_TC_60 BEGIN -----------------*/
@(posedge i_sys_clk)
i_tx_full <=1'b1;
@(posedge i_sys_clk)
@(posedge i_sys_clk)
assert (DUT.config_reg[6][21] == 8'h1)  $display ("---- CONFIG_REG_TC_60 PASSED AT %0t----",$time);
else $display ("!!!!! CONFIG_REG_TC_60 FAILED AT %0t !!!!! ",$time);
/*----------------- CONFIG_REG_TC_60 END -----------------*/

/*--------------------------- Finished ----------------------------------*/
$display("FINISHED!");
$finish;
end

    
       
          
  
endmodule
