`timescale 1ns / 1ps
module CAN_txpl_tctb();
//---------------------PORT SIGNALS---------------------
    logic           i_sys_clk;  
    logic           i_can_clk;  
    logic           i_reset;    
    logic           i_hpbfull;  
    logic   [127:0] i_hpb_data; 
    logic           i_cen;      
    logic           i_tx_empty; 
    logic   [127:0] i_fifo_data;
    logic           i_busy_can; 
                                
    logic   [127:0] o_send_data;
    logic           o_send_en;  
    logic           o_hpb_r_en; 
    logic           o_fifo_r_en;
//-----------------INTERNAL PARAMETERS------------------
    localparam   IDLE        = 3'b000;
    localparam   PREPARE     = 3'b001;
    localparam   SEND_HPB    = 3'b011;
    localparam   SEND_FIFO   = 3'b010;
    localparam   SEND        = 3'b110;
//-----------------MODULE INSTANTIATION-----------------
    CAN_TX_Priority_Logic DUT0(
        .i_sys_clk      (i_sys_clk),
        .i_can_clk      (i_can_clk),
        .i_reset        (i_reset),
        .i_hpbfull      (i_hpbfull),
        .i_hpb_data     (i_hpb_data),
        .i_cen          (i_cen),
        .i_tx_empty     (i_tx_empty),
        .i_fifo_data    (i_fifo_data),
        .i_busy_can     (i_busy_can), 
                                    
        .o_send_data    (o_send_data),
        .o_send_en      (o_send_en),
        .o_hpb_r_en     (o_hpb_r_en),
        .o_fifo_r_en    (o_fifo_r_en)
    );
    initial begin
        i_sys_clk   = 1'b0;  
        i_can_clk   = 1'b0;  
        i_reset     = 1'b0;    
        i_hpbfull   = 1'b0;  
        i_hpb_data  = 128'b0; 
        i_cen       = 1'b0;      
        i_tx_empty  = 1'b0; 
        i_fifo_data = 128'b0;
        i_busy_can  = 1'b0; 
    end
    
    always 
        #1 i_sys_clk =  !i_sys_clk;//100MHz clock
    always
        #4 i_can_clk =  !i_can_clk;//25MHz clock
    

//---------------------TEST BEGINS----------------------
    initial begin
        //TXPL_TC_1
        $display("[TXPL_TC_1] 'o_send_data', 'o_send_en', 'o_hpb_r_en' and 'o_fifo_r_en' outputs shall be set to zeros when 'i_reset' is set to 1.");
        i_reset = #1 1'b1;
        #1 if (o_send_data == 128'b0 && o_send_en == 1'b0 && o_hpb_r_en == 1'b0 && o_fifo_r_en == 1'b0) begin
            $display("\tPASS: All outputs set to zeros.");
           end else begin
            if(o_send_data != 128'b0) begin
                $display("\tFAIL: o_send_data NOT EQUAL to zeros.");
            end
            if(o_send_en != 1'b0) begin
                $display("\tFAIL: o_send_en NOT EQUAL to zero.");
            end
            if(o_hpb_r_en != 1'b0) begin
                $display("\tFAIL: o_hpb_r_en NOT EQUAL to zero.");
            end        
            if(o_fifo_r_en != 1'b0) begin
                $display("\tFAIL: o_fifo_r_en NOT EQUAL to zero.");
            end
        end
        i_reset    = #1 1'b0;
        i_tx_empty = #1 1'b1;
        //TXPL_TC_2
        $display("[TXPL_TC_2] 'o_send_data' shall be synchronized to 'i_can_clk'.");
        $display("\tPASS/FAIL must be observed with the simulation waveform.");
        //TXPL_TC_3
        $display("[TXPL_TC_3] 'o_send_en' shall be synchronized to 'i_can_clk'.");
        $display("\tPASS/FAIL must be observed with the simulation waveform.");
        //TXPL_TC_4
        $display("[TXPL_TC_4] 'i_busy_can' shall be synchronized to 'i_sys_clk'.");
        $display("\tPASS/FAIL must be observed with the simulation waveform.");
        //TXPL_TC_5
        $display("[TXPL_TC_5] All state transitions and signal manipulation shall occur using 'i_sys_clk'.");
        $display("\tPASS/FAIL must be observed with the simulation waveform.");
        //TXPL_TC_6
        $display("[TXPL_TC_6] The implemented state machine shall have at least the following states: idle, prepare, send_hpb, send_fifo and send.");
        $display("\tPASS/FAIL must be observed with the simulation waveform.");
        //TXPL_TC_7
        $display("[TXPL_TC7] 'state' shall be initialized at idle state.");
        if(DUT0.state == IDLE) begin
            $display("\tPASS: Initial state is IDLE.");
        end else begin
            $display("\tFAIL: Initial state is not IDLE.");
        end
        //TXPL_TC_8
        i_reset = #5 1'b1;
        $display("[TXPL_TC_8] 'state' shall transition to and stay in idle state when 'i_reset' is set to 1.");
        if(DUT0.state == IDLE & DUT0.n_state == IDLE)begin
            $display("\tPASS: state is IDLE.");
        end else begin
            $display("\tFAIL: state is not IDLE.");
        end
        //TCPL_TC_9
        $display("[TXPL_TC_9] 'o_send_en' shall be set to 0 in all states except in send state.");
        if(o_send_en == 1'b0) begin
            $display("\tPASS: o_send_en is 0 outside of SEND state.");
        end else begin
            $display("\tFAIL: o_send_en is 1 in IDLE state.");
        end
        //TXPL_TC_10
        i_reset     = #1 1'b0;
        i_busy_can  = #1 1'b0;
        i_cen       = #1 1'b1;
        i_hpb_data  = #1 32'h0A0A0A0A;
        $display("[TXPL_TC_10] The state shall transition from idle to prepare when 'i_busy_can' is set to 0 and 'i_cen' is set to 1.");
        #2 if(DUT0.state == PREPARE) begin
            $display("\tPASS: state is PREPARE.");
        end else begin
            $display("\tFAIL: state is not PREPARE.");
        end
        //TXPL_TC_11
        i_hpbfull = #1 1'b1;
        $display("[TXPL_TC_11] The state shall transition from prepare to send_hpb when 'i_busy_can' is set to 0, 'i_cen' is set to 1 and 'i_hpbfull' is set to 1.");
        #2 if(DUT0.state == SEND_HPB) begin
            $display("\tPASS: state is SEND_HPB.");
        end else begin
            $display("\tFAIL: state is not SEND_HPB.");
        end
        //TXPL_TC_12
        $display("[TXPL_TC_12] 'o_hpb_r_en' shall be pulsed for one system clock cycle when the state transitions from prepare to send_hpb.");
        if(o_hpb_r_en == 1'b1) begin
            $display("\tPASS: o_hpb_r_en was set.");
        end else begin
            $display("\tFAIL: o_hpb_r_en was not set.");
        end
        //TXPL_TC_13
        $display("[TXPL_TC_13] 'i_hpb_data' shall be latched internally in 'latch_data'[127:0] when the state transitions from prepare to send_hpb.");
        if(DUT0.latch_data == i_hpb_data) begin
            $display("\tPASS: Data was latched.");
        end else begin
            $display("\tFAIL: Data was not latched.");
        end
        //TXPL_TC_14
        i_busy_can = #1 1'b1;
        $display("[TXPL_TC_14] The state shall transition from send_hpb to send after one clock cycle.");
        #2 if(DUT0.state == SEND) begin
            $display("\tPASS: state is SEND.");
        end else begin
            $display("\tFAIL: state is not SEND.");
        end
        i_reset = #1  1'b1;
        i_reset = #10 1'b0;
        //TXPL_TC_15
        i_busy_can = #1 1'b0;
        i_cen      = #1 1'b1;
        i_tx_empty = #1 1'b0;
        i_hpbfull  = #1 1'b0;
        i_fifo_data  = #1 32'h0A0A0A0A;        
        $display("[TXPL_TC_15] The state shall transition from prepare to send_fifo when 'i_busy_can' is set to 0, 'i_cen' is set to 1, 'i_hpbfull' is set to 0 and 'i_tx_empty' is set to 0.");
        #2 if(DUT0.state == SEND_FIFO) begin
            $display("\tPASS: state is SEND_FIFO.");
        end else begin
            $display("\tFAIL: state is not SEND_FIFO.");
        end
        //TXPL_TC_16
        $display("[TXPL_TC_16] 'o_fifo_r_en' shall be pulsed for one system clock cycle when the state transitions from prepare to send_fifo.");
        if(o_fifo_r_en == 1'b1) begin
            $display("\tPASS: o_fifo_r_en was set.");
        end else begin
            $display("\tFAIL: o_fifo_r_en was not set.");
        end
        //TXPL_TC_17
        $display("[TXPL_TC_17] 'i_fifo_data' shall be latched internally in 'latch_data' when the state transitions from prepare to send_hpb.");
        if(DUT0.latch_data == i_fifo_data) begin
            $display("\tPASS: Data was latched.");
        end else begin
            $display("\tFAIL: Data was not latched.");
        end
        //TXPL_TC_18
        $display("[TXPL_TC_18] The state shall transition from send_fifo to send after one clock cycle.");
        #2 if(DUT0.state == SEND) begin
            $display("\tPASS: state is SEND.");
        end else begin
            $display("\tFAIL: state is not SEND.");
        end
        //TXPL_TC_19
        $display("[TXPL_TC_19] 'o_send_en' shall be set to 1 when the state is in send.");
        if(o_send_en == 1'b1) begin
            $display("\tPASS: o_send_en was set.");
        end else begin
            $display("\tFAIL: o_send_en was not set.");
        end
        //TXPL_TC_20
        $display("[TXPL_TC_20]  'o_send_data'[127:0] shall be set to the latched data when the state is in send.");    
        if(o_send_data == DUT0.latch_data) begin
            $display("\tPASS: Latch data sent.");
        end else begin
            $display("\tFAIL: Latch data not sent.");
        end
        //TXPL_TC_21
        i_busy_can = #1 1'b1;
        $display("[TXPL_TC_21] The state shall transition from send to prepare when 'i_busy_can' is set to 1 and 'i_cen' is set to 1.");
        #2 if(DUT0.state == PREPARE) begin
            $display("\tPASS: state is PREPARE.");
        end else begin
            $display("\tFAIL: state is not PREPARE.");
        end
        i_reset = #5 1'b1;
        $finish;
    end
endmodule
