/*
Project: CAN Controller
Module: Top level wrapper
Engineer: Devon Stedronsky
Date: August 2020
Revision 1
*/



module can_top(

//input from microcontroller
input logic Bus2IP_Reset,
input logic [31:0] Bus2IP_Data,
input logic [5:0] Bus2IP_Addr,
input logic Bus2IP_RNW,
input logic Bus2IP_CS,
input logic SYS_CLK,
input logic CAN_CLK,

//input from CAN transceiver
input logic CAN_PHY_RX,

//output to microcontroller
output logic [31:0] IP2Bus_Data,
output logic IP2Bus_Ack,
output logic IP2Bus_IntrEvent,
output logic IP2Bus_Error,

//output to CAN transceiver
output logic CAN_PHY_TX             );
  
  
////////////////////////////////////////////////////////////  
//Internal mapping signals

//Internal reset signals
logic int_reset;
logic int_soft_reset;

//MC_IF
logic mc2reg_reg_w_bus;
logic mc2reg_rs_vector;
logic mc2reg_r_neg_w;

//Tx_Priority_Logic
logic tpl2bsp_send_data;
logic tpl2bsp_send_en;
logic tpl_hpb_r_en;
logic tpl_tx_fifo_r_en;

//Tx FIFO
logic int_tx_fifo_empty;
logic int_tx_fifo_data;
logic int_tx_underflow;
logic int_tx_overflow;
logic int_tx_fifo_full;

//Rx FIFO
logic reg2rx_rx_r_en;
logic int_rx_fifo_empty;
logic int_rx_fifo_underflow;
logic int_rx_fifo_overflow;
logic int_rx_fifo_r_data;
logic int_rx_fifo_full;

//Acceptance Filter
logic af_rx_fifo_w_en;
logic af_rx_fifo_w_data;
logic af2reg_acfbsy;

//bsp
logic int_bsp_busy_can;
logic bsp2af_can_ready;
logic bsp2af_rx_message;
logic bsp2reg_acker;
logic bsp2reg_berr;
logic bsp2reg_ster;
logic bsp2reg_fmer;
logic bsp2reg_crcer;
logic bsp2reg_lback;
logic bsp2reg_sleep;
logic bsp2reg_estat;
logic bsp2reg_errwrn;
logic bsp2reg_bbsy;
logic bsp2reg_bidle;
logic bsp2reg_normal;
logic bsp2reg_config;
logic bsp2reg_wakeup;
logic bsp2reg_bsoff;
logic bsp2reg_error;
logic bsp2reg_arblst;
logic bsp2reg_rec;
logic bsp2reg_tec;
logic bsp2btm_tx_bit;
logic bsp2reg_txok;

//btm
logic btm2bsp_rx_bit;
logic btm2bsp_samp_tick;

//Config Registers
logic reg2af_afmr1;
logic reg2af_afmr2;
logic reg2af_afmr3;
logic reg2af_afmr4;
logic reg2af_afir1;
logic reg2af_afir2;
logic reg2af_afir3;
logic reg2af_afir4;
logic reg2af_uaf1;
logic reg2af_uaf2;
logic reg2af_uaf3;
logic reg2af_uaf4;

logic reg2tx_tx_w_en;
logic reg2tx_tx_w_data;

logic reg2tpl_hpbfull;
logic reg2tpl_hpb_data;
logic reg2tpl_cen;

logic reg2mc_reg_r_data;
logic reg2mc_reg_ack;
logic reg2mc_reg_error;

logic reg2bsp_lback;
logic reg2bsp_sleep;

logic reg2btm_sjw;
logic reg2btm_ts1;
logic reg2btm_ts2;


///////////////////////////////////////////////////////   
//Microcontroller Interface  
can_mc_if 
can_mc_if	(
        //from microcontroller
       .i_sys_clk       (SYS_CLK),          
       .i_reset         (int_reset),          
       .i_bus_data      (Bus2IP_Data),     
       .i_addr          (Bus2IP_Addr),              
       .i_r_neg_w       (Bus2IP_RNW),         
       .i_cs            (Bus2IP_CS),                
        
        //to microcontroller
       .o_reg_data      (IP2Bus_Data),       
       .o_ack           (IP2Bus_Ack),             
       .o_error         (IP2Bus_Error),            
    
        //from config registers
       .i_reg_r_data    (reg2mc_reg_r_data),        
       .i_reg_ack       (reg2mc_reg_ack),           
       .i_reg_error     (reg2mc_reg_error),        
        
        //to config registers
       .o_reg_w_bus     (mc2reg_reg_w_bus),         
       .o_rs_vector     (mc2reg_rs_vector),        
       .o_r_neg_w       (mc2reg_r_neg_w)      
    ); 

/////////////////////////////////////////////////////
//Tx Priority Logic
CAN_TX_Priority_Logic 
can_tx_priority_logic	(
    //from wrapper
    .i_sys_clk      (SYS_CLK),
    .i_can_clk      (CAN_CLK),
    .i_reset        (int_reset),
    
    //from config registers
    .i_hpbfull      (reg2tpl_hpbfull),
    .i_hpb_data     (reg2tpl_hpb_data),
    .i_cen          (reg2tpl_cen),
    
    //from tx fifo
    .i_tx_empty     (int_tx_fifo_empty),
    .i_fifo_data    (int_tx_fifo_data),
    
    //from BSP
    .i_busy_can     (int_bsp_busy_can),
    
    //to bsp
    .o_send_data    (tpl2bsp_send_data),
    .o_send_en      (tpl2bsp_send_en),
    
    //to tx fifo/hpb
    .o_hpb_r_en     (tpl_hpb_r_en),
    .o_fifo_r_en    (tpl_tx_fifo_r_en)
    );

//////////////////////////////////////////////      
//Tx FIFO
can_fifo #(.MEM_DEPTH(2))
tx_fifo	(
    //from wrapper
   .i_sys_clk       (SYS_CLK),
   .i_reset         (int_reset),
   
   //from config registers
   .i_w_en          (reg2tx_tx_w_en),
   .i_fifo_w_data   (reg2tx_tx_w_data),
   
   //from priority logic
   .i_r_en          (tpl_tx_fifo_r_en),
   
   //to config registers
   .o_full          (int_tx_fifo_full),
   
   //to priority logic
   .o_empty         (int_tx_fifo_empty),
   .o_fifo_r_data   (int_tx_fifo_data),
   
   //unused
   .o_underflow     (int_tx_underflow),
   .o_overflow      (int_tx_overflow)
);

///////////////////////////////////////////////////
//Rx FIFO
can_fifo #(.MEM_DEPTH(2))
rx_fifo	(
  //from wrapper
  .i_sys_clk        (SYS_CLK),
  .i_reset          (int_reset),
  
  //from config registers
  .i_r_en           (reg2rx_rx_r_en),
  
  //from acceptance filter
  .i_w_en           (af_rx_fifo_w_en),
  .i_fifo_w_data    (af_rx_fifo_w_data),
  
  //to config registers
  .o_empty          (int_rx_fifo_empty),
  .o_underflow      (int_rx_fifo_underflow),
  .o_overflow       (int_rx_fifo_overflow),
  .o_fifo_r_data    (int_rx_fifo_r_data),
  
  //to config registers and acceptance filter
  .o_full           (int_rx_fifo_full)
);

////////////////////////////////////////////////////
//Acceptance Filter
CAN_Acceptance_Filter
#(.NUMBER_OF_ACCEPTANCE_FILTRES(0))
can_acceptance_filter	(
    //from wrapper
     .i_sys_clk         (SYS_CLK),
     .i_reset           (int_reset),
     .i_can_clk         (CAN_CLK),
     
     //from rx fifo
     .i_rx_full         (int_rx_fifo_full),
     
     //from config registers
     .i_afmr1           (reg2af_afmr1),
     .i_afmr2           (reg2af_afmr2),
     .i_afmr3           (reg2af_afmr3),
     .i_afmr4           (reg2af_afmr4),
     .i_afir1           (reg2af_afir1),
     .i_afir2           (reg2af_afir2),
     .i_afir3           (reg2af_afir3),
     .i_afir4           (reg2af_afir4),
     .i_uaf1            (reg2af_uaf1),
     .i_uaf2            (reg2af_uaf2),
     .i_uaf3            (reg2af_uaf3),
     .i_uaf4            (reg2af_uaf4),
    
    //to rx_fifo
     .o_rx_w_en         (af_rx_fifo_w_en),
     .o_rx_fifo_w_data  (af_rx_fifo_w_data),
     
     //to config registers
     .o_acfbsy          (af2reg_acfbsy),

     //from bsp
     .i_can_ready       (bsp2af_can_ready),
     .i_rx_message      (bsp2af_rx_message)
    );
    
/////////////////////////////////////////////////////////
//Config Registers   
can_config_registers 
can_config_registers (
   //from wrapper
   .i_sys_clk           (SYS_CLK),
   .i_reset             (int_reset),
   
   //to wrapper
   .o_interrupt         (IP2Bus_IntrEvent),    
   
   //Control Ports
   .i_reg_w_bus         (mc2reg_reg_w_bus),
   .i_rs_vector         (mc2reg_rs_vector),
   .i_r_neg_w           (mc2reg_r_neg_w),
   .o_reg_r_data        (reg2mc_reg_r_data),
   .o_reg_ack           (reg2mc_reg_ack),
   .o_reg_error         (reg2mc_reg_error),    
   .o_soft_reset        (int_soft_reset),
   .o_cen               (reg2tpl_cen),
   
   //FIFO ports
   .i_rx_fifo_data		(int_rx_fifo_r_data),
   .i_tx_full			(int_tx_fifo_full),
   .i_rx_empty			(int_rx_fifo_empty),
   .o_tx_fifo_data		(int_tx_fifo_data),
   .o_tx_w_en			(reg2tx_tx_w_en),
   .o_hpb_data			(reg2tpl_hpb_data),			
   .i_hpb_r_en			(tpl_hpb_r_en),
   .o_hpb_full			(reg2tpl_hpbfull),
   
   //bsp ports
   .i_acker             (bsp2reg_acker),
   .i_berr              (bsp2reg_berr),
   .i_ster              (bsp2reg_ster),
   .i_fmer              (bsp2reg_fmer),
   .i_crcer             (bsp2reg_crcer),
   .i_acfbsy            (af2reg_acfbsy),
   
   .o_lback             (reg2bsp_lback),
   .o_sleep             (reg2bsp_sleep),
   
   .i_estat             (bsp2reg_estat),
   .i_errwrn            (bsp2reg_errwrn),
   .i_bbsy              (bsp2reg_bbsy),
   .i_bidle             (bsp2reg_bidle),
   .i_normal            (bsp2reg_normal),
   .i_sleep             (bsp2reg_sleep),
   .i_lback             (bsp2reg_lback),
   .i_config            (bsp2reg_config),
   .i_wakeup            (bsp2reg_wakeup),
   .i_bsoff             (bsp2reg_bsoff),
   .i_error             (bsp2reg_error),
   .i_txok              (bsp2reg_txok),
   .i_arblst            (bsp2reg_arblst),
   .i_rxnemp            (int_rx_fifo_empty),
   .i_rxoflw            (int_rx_fifo_overflow),
   .i_rxuflw            (int_rx_fifo_underflow),
   .i_rxok              (af_rx_fifo_w_en),
   .i_rec               (bsp2reg_rec),
   .i_tec               (bsp2reg_tec),
   
   //btm ports
   .o_sjw               (reg2btm_sjw),
   .o_ts2               (reg2btm_ts2),
   .o_ts1               (reg2btm_ts1),
   
   //af ports
   .o_rx_r_en           (reg2rx_rx_r_en),
   .o_uaf1              (reg2af_uaf1),
   .o_uaf2              (reg2af_uaf2),
   .o_uaf3              (reg2af_uaf3),
   .o_uaf4              (reg2af_uaf4),
   .o_afmr1             (reg2af_afmr1),
   .o_afmr2             (reg2af_afmr2),
   .o_afmr3             (reg2af_afmr3),
   .o_afmr4             (reg2af_afmr4),
   .o_afir1             (reg2af_afir1),
   .o_afir2             (reg2af_afir2),
   .o_afir3             (reg2af_afir3),
   .o_afir4             (reg2af_afir4)
); 

//////////////////////////////////////////////////
//Bit stream processor
can_bsp 
can_bsp	(
   .i_sleep         	(reg2bsp_sleep),
   .i_lback				(reg2bsp_sleep),	
   .i_reset				(int_reset),
   .i_send_data			(tpl2bsp_send_data),
   .i_send_en			(tpl2bsp_send_en),
   .i_can_clk			(CAN_CLK),
   .i_cen				(reg2tpl_cen),
   .o_busy_can			(int_bsp_busy_can),
   .o_acker				(bsp2reg_acker),
   .o_berr				(bsp2reg_berr),
   .o_ster				(bsp2reg_ster),
   .o_fmer				(bsp2reg_fmer),
   .o_crcer				(bsp2reg_crcer),
   .o_can_ready			(bsp2af_can_ready),
   .o_rx_message		(bsp2af_rx_message),
   .o_rec				(bsp2reg_rec),
   .o_tec				(bsp2reg_tec),
   .o_errwrn			(bsp2reg_errwrn),
   .o_bbsy				(bsp2reg_bbsy),
   .o_bidle				(bsp2reg_bidle),
   .o_normal			(bsp2reg_normal),
   .o_sleep				(bsp2reg_sleep),
   .o_tx_bit			(bsp2btm_tx_bit),
   .i_samp_tick			(btm2bsp_samp_tick),
   .i_rx_bit			(btm2bsp_rx_bit),
   .o_lback          	(bsp2reg_lback),
   .o_config			(bsp2reg_config),
   .o_wakeup			(bsp2reg_wakeup),
   .o_bsoff				(bsp2reg_bsoff),
   .o_error				(bsp2reg_error),
   .o_txok				(bsp2reg_txok),
   .o_arblst			(bsp2reg_arblst),
   .o_estat				(bsp2reg_estat)
    );
    
//////////////////////////////////////////////////
//Bit Timing Module    
can_bit_timing 
can_bit_timing (
    .i_can_clk			(CAN_CLK),
    .i_reset			(int_reset),
    .i_tx_bit			(bsp2btm_tx_bit),
    .o_samp_tick		(btm2bsp_samp_tick),
    .o_rx_bit			(btm2bsp_rx_bit),
    .i_ts2				(reg2btm_ts2),
    .i_ts1				(reg2btm_ts1),
    .CAN_PHY_TX			(CAN_PHY_TX),
    .CAN_PHY_RX			(CAN_PHY_RX)
    );

//internal reset assignment
always begin
int_reset = int_soft_reset || Bus2IP_Reset;
end

endmodule
