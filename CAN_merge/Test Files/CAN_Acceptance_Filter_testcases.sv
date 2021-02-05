`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/05/2020 10:47:55 AM
// Design Name: 
// Module Name: CAN_Acceptance_Filter_testcases
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CAN_Acceptance_Filter_testcases(

    );
    //DUT Ports Declaration
    logic i_sys_clk;
    logic i_reset;
    logic i_rx_full;
    logic [31:0] i_afmr1;
    logic [31:0] i_afmr2;
    logic [31:0] i_afmr3;
    logic [31:0] i_afmr4;
    logic [31:0] i_afir1;
    logic [31:0] i_afir2;
    logic [31:0] i_afir3;
    logic [31:0] i_afir4;
    logic i_uaf1;
    logic i_uaf2;
    logic i_uaf3;
    logic i_uaf4; 
    logic o_rx_w_en;
    logic [127:0] o_rx_fifo_w_data;
    logic o_acfbsy;    
    logic i_can_clk;
    logic i_can_ready;
    logic [127:0] i_rx_message;
    logic o_rx_w_en_num0;
    logic [127:0] o_rx_fifo_w_data_num0;
    logic o_acfbsy_num0; 
    
    //DUT Module Instantiation
    CAN_Acceptance_Filter #(.NUMBER_OF_ACCEPTANCE_FILTRES(4))
        DUT (
        .i_sys_clk        (i_sys_clk       ),       
        .i_reset          (i_reset         ),       
        .i_rx_full        (i_rx_full       ),       
        .i_afmr1          (i_afmr1         ),
        .i_afmr2          (i_afmr2         ),
        .i_afmr3          (i_afmr3         ),
        .i_afmr4          (i_afmr4         ),
        .i_afir1          (i_afir1         ),
        .i_afir2          (i_afir2         ),  
        .i_afir3          (i_afir3         ),  
        .i_afir4          (i_afir4         ),  
        .i_uaf1           (i_uaf1          ),         
        .i_uaf2           (i_uaf2          ),         
        .i_uaf3           (i_uaf3          ),          
        .i_uaf4           (i_uaf4          ),          
        .o_rx_w_en        (o_rx_w_en       ),          
        .o_rx_fifo_w_data (o_rx_fifo_w_data),  
        .o_acfbsy         (o_acfbsy        ),          
        .i_can_clk        (i_can_clk       ),          
        .i_can_ready      (i_can_ready     ),          
        .i_rx_message     (i_rx_message    ) 
        );
     //Declaring an empty module for AF_TC_17 - AF_TC_19
     CAN_Acceptance_Filter #(.NUMBER_OF_ACCEPTANCE_FILTRES(0))
        DUT_empty (
        .i_sys_clk        (i_sys_clk           ),       
        .i_reset          (i_reset             ),       
        .i_rx_full        (i_rx_full           ),       
        .i_afmr1          (i_afmr1             ),
        .i_afmr2          (i_afmr2             ),
        .i_afmr3          (i_afmr3             ),
        .i_afmr4          (i_afmr4             ),
        .i_afir1          (i_afir1             ),
        .i_afir2          (i_afir2             ),  
        .i_afir3          (i_afir3             ),  
        .i_afir4          (i_afir4             ),  
        .i_uaf1           (i_uaf1              ),         
        .i_uaf2           (i_uaf2              ),         
        .i_uaf3           (i_uaf3              ),          
        .i_uaf4           (i_uaf4              ),          
        .o_rx_w_en        (o_rx_w_en_num0       ),          
        .o_rx_fifo_w_data (o_rx_fifo_w_data_num0),  
        .o_acfbsy         (o_acfbsy_num0        ),          
        .i_can_clk        (i_can_clk            ),          
        .i_can_ready      (i_can_ready          ),          
        .i_rx_message     (i_rx_message         ) 
        );   
    //Initial values for inputs
    initial begin
        i_sys_clk    = 1'b0;
        i_reset      = 1'b0; 
        i_rx_full    = 1'b0;
        i_afmr1      = 32'd0;
        i_afmr2      = 32'd0;
        i_afmr3      = 32'd0;
        i_afmr4      = 32'd0;
        i_afir1      = 32'd0;
        i_afir2      = 32'd0;
        i_afir3      = 32'd0;
        i_afir4      = 32'd0;
        i_uaf1       = 1'b0;
        i_uaf2       = 1'b0;
        i_uaf3       = 1'b0;
        i_uaf4       = 1'b0;
        i_can_clk    = 1'b0;
        i_can_ready  = 1'b0; 
        i_rx_message = 128'd0;
    end    
    typedef enum logic [2:0] {idle,compare,pass,acf_not_ex} State;
    
    //Clock Generation
    always 
        #5 i_sys_clk = !i_sys_clk;
        
    //Testbench proper
    always begin
        //Just wait to not overlap with preload variables
        #1;
        
        //AF_TC_1
        i_reset = 1'b1;
        $display("[AF_TC_1] 'o_rx_w_en' and 'o_acfbsy' shall be set to 0 when 'i_reset' is 1.");
        #1 assert (o_rx_w_en == 1'b0) begin 
            $display("\t Test 1 PASS: o_rx_w_en = %b", o_rx_w_en);
            assert (o_acfbsy == 1'b0)
                $display("\t Test 2 PASS: o_acfbsy = %b", o_acfbsy);
            else
                $error("\t Test 2 FAIL: o_acfbsy = %b", o_acfbsy);
        end
        else
            $error("\t Test 1 FAIL: o_rx_w_en = %b", o_rx_w_en);
        i_reset = 1'b0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
        //AF_TC_2
        i_reset = 1'b1;
        $display("[AF_TC_2] 'o_rx_fifo_w_data[127:0]' shall be set to all 0's when 'i_reset' is 1.");
        #1 assert (o_rx_fifo_w_data == 128'd0) 
            $display("\t Test PASS: o_rx_w_en = %b", o_rx_w_en);
        else
            $error("\t Test FAIL: o_rx_w_en = %b", o_rx_w_en);
        i_reset = 1'b0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
        //AF_TC_3
        i_can_ready = 1'd1;
        i_rx_message = 128'd64756657;
        $display("[AF_TC_3] 'i_can_ready' and 'i_rx_message[127:0]' shall be synchronized with the 'i_sys_clk'.");
        #1 assert (DUT.syn_can_ready == 1'd0) begin
            $display("\t Test 1a PASS: syn_can_ready = %b", DUT.syn_can_ready);
            assert (DUT.genblk1.AFR_CU.rx_message_temp == 128'd0)
                $display("\t Test 2a PASS: rx_message_temp = %b", DUT.genblk1.AFR_CU.rx_message_temp);
            else
                $error("\t Test 2a FAIL: rx_message_temp = %b", DUT.genblk1.AFR_CU.rx_message_temp);
        end
        else
            $error("\t Test 1a FAIL: syn_can_ready = %b", DUT.syn_can_ready);
        @(posedge i_sys_clk);
        #1 assert (DUT.syn_can_ready == 1'd1) begin
            $display("\t Test 1b PASS: syn_can_ready = %b", DUT.syn_can_ready);
            assert (DUT.genblk1.AFR_CU.rx_message_temp == 128'd64756657)
                $display("\t Test 2b PASS: rx_message_temp = %b", DUT.genblk1.AFR_CU.rx_message_temp);
            else
                $error("\t Test 2b FAIL: rx_message_temp = %b", DUT.genblk1.AFR_CU.rx_message_temp);
        end
        else
            $error("\t Test 1b FAIL: syn_can_ready = %b", DUT.syn_can_ready);
        i_can_ready = 1'd0;
        i_rx_message = 128'd0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
        //AF_TC_4
        i_uaf1 = 1'b0;
        i_can_ready = 1'b0;
        i_rx_message[127:96] = 32'hAAAAAAAA;
        i_afmr1 = 32'hFFFFFFFF;
        i_afir1 = 32'hAAAAAAAA;
        @(posedge i_sys_clk);
        #1;
        i_uaf1 = 1'b1;
        i_can_ready = 1'b1;
        @(posedge i_sys_clk);
        $display("[AF_TC_4] If 'i_uaf1' is set to 1 and the bits in 'i_rx_message[127:96]' corresponding to the set bits in AFMR of AFR1 are equal to the contents of the AFIR in AFR1, internal signal 'in_pass1' shall be set to 1.");
        #1 assert (DUT.afr_pass1 == 1'b1) 
            $display("\t Test PASS: afr_pass1 = %b", DUT.afr_pass1);
        else
            $error("\t Test FAIL: afr_pass1 = %b", DUT.afr_pass1);
        i_uaf1 = 1'b0;
        i_can_ready = 1'b0;
        i_rx_message[127:96] = 32'd0;
        i_afmr1 = 32'd0;
        i_afir1 = 32'd0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
        //AF_TC_5
        i_uaf1 = 1'b0;
        i_can_ready = 1'b0;
        i_rx_message[127:96] = 32'hF0F0F0F0;
        i_afmr1 = 32'hFFF00FFF;
        i_afir1 = 32'h0F0F0F0F;
        @(posedge i_sys_clk);
        #1;
        i_uaf1 = 1'b1;
        i_can_ready = 1'b1;
        @(posedge i_sys_clk);
        $display("[AF_TC_5] If 'i_uaf1' is set to 0 or the bits in 'i_rx_message[127:96]' corresponding to the set bits in AFMR of AFR1 aren't equal to the contents of the AFIR in AFR1, internal signal 'in_pass1' shall be set to 0.");
        #1 assert (DUT.afr_pass1 == 1'b0) 
            $display("\t Test PASS: afr_pass1 = %b", DUT.afr_pass1);
        else
            $error("\t Test FAIL: afr_pass1 = %b", DUT.afr_pass1);
        i_uaf1 = 1'b0;
        i_can_ready = 1'b0;
        i_rx_message[127:96] = 32'd0;
        i_afmr1 = 32'd0;
        i_afir1 = 32'd0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
        //AF_TC_6
        i_uaf2 = 1'b0;
        i_can_ready = 1'b0;
        i_rx_message[127:96] = 32'hAAAAAAAA;
        i_afmr2 = 32'hFFFFFFFF;
        i_afir2 = 32'hAAAAAAAA;
        @(posedge i_sys_clk);
        #1;
        i_uaf2 = 1'b1;
        i_can_ready = 1'b1;
        @(posedge i_sys_clk);
        $display("[AF_TC_6] If 'i_uaf2' is set to 1 and the bits in 'i_rx_message[127:96]' corresponding to the set bits in AFMR of AFR2 are equal to the contents of the AFIR in AFR2, internal signal 'in_pass2' shall be set to 1.");
        #1 assert (DUT.afr_pass2 == 1'b1) 
            $display("\t Test PASS: afr_pass2 = %b", DUT.afr_pass2);
        else
            $error("\t Test FAIL: afr_pass2 = %b", DUT.afr_pass2);
        i_uaf2 = 1'b0;
        i_can_ready = 1'b0;
        i_rx_message[127:96] = 32'd0;
        i_afmr2 = 32'd0;
        i_afir2 = 32'd0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
        //AF_TC_7
        i_uaf2 = 1'b0;
        i_can_ready = 1'b0;
        i_rx_message[127:96] = 32'hAAAAAAAA;
        i_afmr2 = 32'hFFFFFFFF;
        i_afir2 = 32'h0A0A0A0A;
        @(posedge i_sys_clk);
        #1;
        i_uaf2 = 1'b1;
        i_can_ready = 1'b1;
        @(posedge i_sys_clk);
        $display("[AF_TC_7] If 'i_uaf2' is set to 0 or the bits in 'i_rx_message[127:96]' corresponding to the set bits in AFMR of AFR2 aren't equal to the contents of the AFIR in AFR2, internal signal 'in_pass2' shall be set to 0.");
        #1 assert (DUT.afr_pass2 == 1'b0) 
            $display("\t Test PASS: afr_pass2 = %b", DUT.afr_pass2);
        else
            $error("\t Test FAIL: afr_pass2 = %b", DUT.afr_pass2);
        i_uaf2 = 1'b0;
        i_can_ready = 1'b0;
        i_rx_message[127:96] = 32'd0;
        i_afmr2 = 32'd0;
        i_afir2 = 32'd0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
        //AF_TC_8
        i_uaf3 = 1'b0;
        i_can_ready = 1'b0;
        i_rx_message[127:96] = 32'hAAAAAAAA;
        i_afmr3 = 32'hFFFFFFFF;
        i_afir3 = 32'hAAAAAAAA;
        @(posedge i_sys_clk);
        #1;
        i_uaf3 = 1'b1;
        i_can_ready = 1'b1;
        @(posedge i_sys_clk);
        $display("[AF_TC_8] If 'i_uaf3' is set to 1 and the bits in 'i_rx_message[127:96]' corresponding to the set bits in AFMR of AFR3 are equal to the contents of the AFIR in AFR3, internal signal 'in_pass3' shall be set to 1.");
        #1 assert (DUT.afr_pass3 == 1'b1) 
            $display("\t Test PASS: afr_pass3 = %b", DUT.afr_pass3);
        else
            $error("\t Test FAIL: afr_pass3 = %b", DUT.afr_pass3);
        i_uaf3 = 1'b0;
        i_can_ready = 1'b0;
        i_rx_message[127:96] = 32'd0;
        i_afmr3 = 32'd0;
        i_afir3 = 32'd0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
        //AF_TC_9
        i_uaf3 = 1'b0;
        i_can_ready = 1'b0;
        i_rx_message[127:96] = 32'hAAAAAAAA;
        i_afmr3 = 32'hFFFFFFFF;
        i_afir3 = 32'h0A0A0A0A;
        @(posedge i_sys_clk);
        #1;
        i_uaf3 = 1'b1;
        i_can_ready = 1'b1;
        @(posedge i_sys_clk);
        $display("[AF_TC_9] If 'i_uaf3' is set to 0 or the bits in 'i_rx_message[127:96]' corresponding to the set bits in AFMR of AFR3 aren't equal to the contents of the AFIR in AFR3, internal signal 'in_pass3' shall be set to 0.");
        #1 assert (DUT.afr_pass3 == 1'b0) 
            $display("\t Test PASS: afr_pass3 = %b", DUT.afr_pass3);
        else
            $error("\t Test FAIL: afr_pass3 = %b", DUT.afr_pass3);
        i_uaf3 = 1'b0;
        i_can_ready = 1'b0;
        i_rx_message[127:96] = 32'd0;
        i_afmr3 = 32'd0;
        i_afir3 = 32'd0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
            
        //AF_TC_10
        i_uaf4 = 1'b0;
        i_can_ready = 1'b0;
        i_rx_message[127:96] = 32'hAAAAAAAA;
        i_afmr4 = 32'hFFFFFFFF;
        i_afir4 = 32'hAAAAAAAA;
        @(posedge i_sys_clk);
        #1;
        i_uaf4 = 1'b1;
        i_can_ready = 1'b1;
        @(posedge i_sys_clk);
        $display("[AF_TC_10] If 'i_uaf4' is set to 1 and the bits in 'i_rx_message[127:96]' corresponding to the set bits in AFMR of AFR4 are equal to the contents of the AFIR in AFR4, internal signal 'in_pass4' shall be set to 1.");
        #1 assert (DUT.afr_pass4 == 1'b1) 
            $display("\t Test PASS: afr_pass4 = %b", DUT.afr_pass4);
        else
            $error("\t Test FAIL: afr_pass4 = %b", DUT.afr_pass4);
        i_uaf4 = 1'b0;
        i_can_ready = 1'b0;
        i_rx_message[127:96] = 32'd0;
        i_afmr4 = 32'd0;
        i_afir4 = 32'd0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
        //AF_TC_11
        i_uaf4 = 1'b0;
        i_can_ready = 1'b0;
        i_rx_message[127:96] = 32'hAAAAAAAA;
        i_afmr4 = 32'hFFFFFFFF;
        i_afir4 = 32'h0A0A0A0A;
        @(posedge i_sys_clk);
        #1;
        i_uaf4 = 1'b1;
        i_can_ready = 1'b1;
        @(posedge i_sys_clk);
        $display("[AF_TC_11] If 'i_uaf4' is set to 0 or the bits in 'i_rx_message[127:96]' corresponding to the set bits in AFMR of AFR4 aren't equal to the contents of the AFIR in AFR4, internal signal 'in_pass4' shall be set to 0.");
        #1 assert (DUT.afr_pass4 == 1'b0) 
            $display("\t Test PASS: afr_pass4 = %b", DUT.afr_pass4);
        else
            $error("\t Test FAIL: afr_pass4 = %b", DUT.afr_pass4);
        i_uaf4 = 1'b0;
        i_can_ready = 1'b0;
        i_rx_message[127:96] = 32'd0;
        i_afmr4 = 32'd0;
        i_afir4 = 32'd0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
        //AF_TC_12
        i_uaf1 = 1'b1;
        wait(DUT.genblk1.AFR_CU.current_state == idle);
        i_can_ready = 1'b1;
        i_rx_full = 1'b0;
        @(posedge i_sys_clk); //i_can_ready synchronized to clock.
        $display("[AF_TC_12] Internal signal 'currstate' shall enter 'compare' state from 'idle' state when 'i_can_ready' is 1 and 'i_rx_full' is set to 0;");
        #1 assert (DUT.genblk1.AFR_CU.next_state == compare) 
            $display("\t Test PASS: next_state = %b", DUT.genblk1.AFR_CU.next_state);
        else
            $error("\t Test FAIL: next_state = %b", DUT.genblk1.AFR_CU.next_state);
        i_uaf1 = 1'b0;
        i_can_ready = 1'b0;
        i_rx_full = 1'b0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
      //AF_TC_13
        i_uaf1 = 1'b0;
        i_rx_message[127:96] = 32'hAAAAAAAA;
        i_afmr1 = 32'hFFFFFFFF;
        i_afir1 = 32'hAAAAAAAA;
        @(posedge i_sys_clk);
        #1;
        i_uaf1 = 1'b1;
        wait(DUT.genblk1.AFR_CU.current_state == idle);
        i_can_ready = 1'b1;
        wait(DUT.genblk1.AFR_CU.current_state == pass);
        $display("[AF_TC_13] Module shall set 'o_rx_w_en' to 1 for one clock cycle on the rising edge of 'i_sys_clk', if internal signal 'currstate' is in 'pass' state.");
        #1 assert (o_rx_w_en == 1'b1) 
            $display("\t Test PASS: o_rx_w_en = %b", o_rx_w_en);
        else
            $error("\t Test FAIL: o_rx_w_en = %b", o_rx_w_en);
        i_uaf1 = 1'b0;
        i_can_ready = 1'b0;
        i_rx_message[127:96] = 32'd0;
        i_afmr1 = 32'd0;
        i_afir1 = 32'd0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk); 
        #1;
        
        //AF_TC_14
        i_uaf1 = 1'b1;
        wait(DUT.genblk1.AFR_CU.current_state == idle);
        i_can_ready = 1'b1;
        i_rx_full = 1'b1;
        $display("[AF_TC_14] Internal signal 'currstate' shall stay in 'idle' state, when 'i_rx_full' is set to 1.");
        #1 assert (DUT.genblk1.AFR_CU.next_state == idle) 
            $display("\t Test PASS: next_state = %b", DUT.genblk1.AFR_CU.next_state);
        else
            $error("\t Test FAIL: next_state = %b", DUT.genblk1.AFR_CU.next_state);
        i_uaf1 = 1'b0;
        i_can_ready = 1'b0;
        i_rx_full = 1'b0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
        //AF_TC_15
        i_uaf1 = 1'b0;
        i_rx_message[127:96] = 32'hAAAAAAAA;
        i_afmr1 = 32'hFFFFFFFF;
        i_afir1 = 32'hAAAAAAAA;
        @(posedge i_sys_clk);
        #1;
        i_uaf1 = 1'b1;
        wait(DUT.genblk1.AFR_CU.current_state == idle);
        i_can_ready = 1'b1;
        wait(DUT.genblk1.AFR_CU.current_state == pass);
        @(posedge i_sys_clk);
        $display("[AF_TC_15] 'o_rx_fifo_w_data[127:0]' shall be set to the corresponding bits from  'i_rx_message[127:0]' on the rising edge of 'i_sys_clk', if internal signal 'currstate' is in 'pass' state.");
        #1 assert (o_rx_fifo_w_data == i_rx_message) 
            $display("\t Test PASS: o_rx_fifo_w_data = %b", o_rx_fifo_w_data);
        else
            $error("\t Test FAIL: o_rx_fifo_w_data = %b", o_rx_fifo_w_data);
        i_uaf1 = 1'b0;
        i_can_ready = 1'b0;
        i_rx_message[127:96] = 32'd0;
        i_afmr1 = 32'd0;
        i_afir1 = 32'd0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
        //AF_TC_16
        i_uaf1 = 1'b0;
        i_rx_message[127:96] = 32'hAAAAAAAA;
        i_afmr1 = 32'hFFFFFFFF;
        i_afir1 = 32'hAAAAAAAA;
        @(posedge i_sys_clk);
        #1;
        i_uaf1 = 1'b1;
        wait(DUT.genblk1.AFR_CU.current_state == idle);
        i_can_ready = 1'b1;
        wait(DUT.genblk1.AFR_CU.current_state == pass);
        @(posedge i_sys_clk);
        wait(DUT.genblk1.AFR_CU.current_state == idle);
        i_can_ready = 1'b1;
        i_rx_full = 1'b1;
        i_rx_message[127:96] = 32'hABCDABCD;
        @(posedge i_sys_clk);
        $display("[AF_TC_16] 'o_rx_fifo_w_data[127:0]' shall retain its previous value, if internal signal 'currstate' is in 'idle' state.");
        #1 assert (o_rx_fifo_w_data == {32'hAAAAAAAA, 96'd0}) 
            $display("\t Test PASS: o_rx_fifo_w_data = %b", o_rx_fifo_w_data);
        else
            $error("\t Test FAIL: o_rx_fifo_w_data = %b", o_rx_fifo_w_data);
        i_uaf1 = 1'b0;
        i_can_ready = 1'b0;
        i_rx_full = 1'b0;
        i_rx_message[127:96] = 32'd0;
        i_afmr1 = 32'd0;
        i_afir1 = 32'd0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
        //AF_TC_17
        $display("[AF_TC_17] If all exist 'i_uaf' bits or number of acceptance filters are set to 0, 'o_rx_w_en' shall be set to 1 for one clock cycle on the rising edge of 'i_sys_clk' when 'i_can_ready' is set to 1 and 'i_rx_full' is set to 0.");
        
        //Test number 1: setting i_uaf bits to 0
        //Test number 2: Using a module with number of acceptance filters set to 0 (DUT_empty)
        i_uaf1 = 1'b0;
        i_uaf2 = 1'b0;
        i_uaf3 = 1'b0;
        i_uaf4 = 1'b0;
        wait(DUT.genblk1.AFR_CU.current_state == acf_not_ex);
        i_can_ready = 1'b1;
        i_rx_full = 1'b0;
        @(posedge i_sys_clk);
        $display("           Test 1: Setting all i_uaf bits to 0"); 
        #1 assert (o_rx_w_en == 1'b1) 
            $display("\t Test 1 PASS: o_rx_w_en = %b", o_rx_w_en);
        else
            $error("\t Test 1 FAIL: o_rx_w_en = %b", o_rx_w_en);
        $display("           Test 2: Using a module with number of acceptance filters set to 0"); 
        assert (o_rx_w_en_num0 == 1'b1) 
            $display("\t Test 2 PASS: o_rx_w_en_num0 = %b", o_rx_w_en_num0);
        else
            $error("\t Test 2 FAIL: o_rx_w_en_num0 = %b", o_rx_w_en_num0);
        i_can_ready = 1'b0;
        i_rx_message[127:96] = 32'd0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1; 
        
        //AF_TC_18
        $display("[AF_TC_18] If all exist 'i_uaf' bits or number of acceptance filters are set to 0, 'o_rx_fifo_w_data[127:0]' shall be set to the corresponding bits from 'i_rx_message[127:0]' on the rising edge of 'i_sys_clk'");
        
        //Test number 1: setting i_uaf bits to 0
        //Test number 2: Using a module with number of acceptance filters set to 0 (DUT_empty)
        i_uaf1 = 1'b0;
        i_uaf2 = 1'b0;
        i_uaf3 = 1'b0;
        i_uaf4 = 1'b0;
        wait(DUT.genblk1.AFR_CU.current_state == acf_not_ex);
        i_rx_message[127:96] = 32'hBBBBBBBB;
        i_can_ready = 1'b1;
        i_rx_full = 1'b0;
        @(posedge i_sys_clk);
        $display("           Test 1: Setting all i_uaf bits to 0"); 
        #1 assert (o_rx_fifo_w_data == {i_rx_message[127:96], 96'd0}) 
            $display("\t Test 1 PASS: o_rx_fifo_w_data = %b", o_rx_fifo_w_data);
        else
            $error("\t Test 1 FAIL: o_rx_fifo_w_data = %b", o_rx_fifo_w_data);
        $display("           Test 2: Using a module with number of acceptance filters set to 0"); 
        assert (o_rx_fifo_w_data_num0 == {i_rx_message[127:96], 96'd0}) 
            $display("\t Test 2 PASS: o_rx_fifo_w_data_num0 = %b", o_rx_fifo_w_data_num0);
        else
            $error("\t Test 2 FAIL: o_rx_fifo_w_data_num0 = %b", o_rx_fifo_w_data_num0);
        i_can_ready = 1'b0;
        i_rx_message[127:96] = 32'd0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk); 
        #1;
        
        //AF_TC_19
        $display("[AF_TC_19]If all exist 'i_uaf' bits or number of acceptance filters are set to 0,'o_acfbsy' shall be set to 0.");
        
        //Test number 1: setting i_uaf bits to 0
        //Test number 2: Using a module with number of acceptance filters set to 0 (DUT_empty)
        i_uaf1 = 1'b0;
        i_uaf2 = 1'b0;
        i_uaf3 = 1'b0;
        i_uaf4 = 1'b0;
        wait(DUT.genblk1.AFR_CU.current_state == acf_not_ex);
        $display("           Test 1: Setting all i_uaf bits to 0"); 
        #1 assert (o_acfbsy == 1'b0) 
            $display("\t Test 1 PASS: o_acfbsy = %b", o_acfbsy);
        else
            $error("\t Test 1 FAIL: o_acfbsy = %b", o_acfbsy);
        $display("           Test 2: Using a module with number of acceptance filters set to 0"); 
        assert (o_acfbsy_num0 == 1'b0) 
            $display("\t Test 2 PASS: o_acfbsy_num0 = %b", o_acfbsy_num0);
        else
            $error("\t Test 2 FAIL: o_acfbsy_num0 = %b", o_acfbsy_num0);
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk); 
        #1;
        
        //AF_TC_20
        i_uaf1 = 1'b1;
        wait(DUT.genblk1.AFR_CU.current_state == idle);
        @(posedge i_sys_clk);
        $display("[AF_TC_20] If any exist 'i_uaf' bit is set to 1, 'o_acfbsy' shall be set to 1 on the rising edge of 'i_sys_clk'.");
        #1 assert (o_acfbsy == 1'b1) 
            $display("\t Test PASS: o_acfbsy = %b", o_acfbsy);
        else
            $error("\t Test FAIL: o_acfbsy = %b", o_acfbsy);
        i_uaf1 = 1'b0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
        //AF_TC_21
        i_uaf1 = 1'b1;
        i_uaf2 = 1'b1;
        i_uaf3 = 1'b1;
        i_uaf4 = 1'b1;
        wait(DUT.genblk1.AFR_CU.current_state == idle);
        i_uaf1 = 1'b0;
        i_afir1 = 32'h11111111;
        @(posedge i_sys_clk);
        $display("[AF_TC_21] If 'i_uaf1' is set to 0, internal ID register 'AFIR[31:0]' in AFR1 shall be set to the corresponding bits from 'i_afir1[31:0]' on the rising edge of 'i_sys_clk'");
        #1 assert (DUT.genblk1.AFR1.acir == i_afir1) 
            $display("\t Test PASS: AFR1.acir = %b", DUT.genblk1.AFR1.acir);
        else
            $error("\t Test FAIL: AFR1.acir = %b", DUT.genblk1.AFR1.acir);
        i_afir1 = 32'h00000000;
        i_uaf1 = 1'b0;
        i_uaf2 = 1'b0;
        i_uaf3 = 1'b0;
        i_uaf4 = 1'b0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
        //AF_TC_22
        i_uaf1 = 1'b1;
        i_uaf2 = 1'b1;
        i_uaf3 = 1'b1;
        i_uaf4 = 1'b1;
        wait(DUT.genblk1.AFR_CU.current_state == idle);
        i_uaf2 = 1'b0;
        i_afir2 = 32'h22222222;
        @(posedge i_sys_clk);
        $display("[AF_TC_22] If 'i_uaf2' is set to 0, internal ID register 'AFIR[31:0]' in AFR2 shall be set to the corresponding bits from 'i_afir2[31:0]' on the rising edge of 'i_sys_clk'");
        #1 assert (DUT.genblk1.AFR2.acir == i_afir2) 
            $display("\t Test PASS: AFR2.acir = %b", DUT.genblk1.AFR2.acir);
        else
            $error("\t Test FAIL: AFR2.acir = %b", DUT.genblk1.AFR2.acir);
        i_afir2 = 32'h00000000;
        i_uaf1 = 1'b0;
        i_uaf2 = 1'b0;
        i_uaf3 = 1'b0;
        i_uaf4 = 1'b0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
        //AF_TC_23
        i_uaf1 = 1'b1;
        i_uaf2 = 1'b1;
        i_uaf3 = 1'b1;
        i_uaf4 = 1'b1;
        wait(DUT.genblk1.AFR_CU.current_state == idle);
        i_uaf3 = 1'b0;
        i_afir3 = 32'h33333333;
        @(posedge i_sys_clk);
        $display("[AF_TC_23] If 'i_uaf3' is set to 0, internal ID register 'AFIR[31:0]' in AFR3 shall be set to the corresponding bits from 'i_afir3[31:0]' on the rising edge of 'i_sys_clk'");
        #1 assert (DUT.genblk1.AFR3.acir == i_afir3) 
            $display("\t Test PASS: AFR3.acir = %b", DUT.genblk1.AFR3.acir);
        else
            $error("\t Test FAIL: AFR3.acir = %b", DUT.genblk1.AFR3.acir);
        i_afir3 = 32'h00000000;
        i_uaf1 = 1'b0;
        i_uaf2 = 1'b0;
        i_uaf3 = 1'b0;
        i_uaf4 = 1'b0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
        //AF_TC_24
        i_uaf1 = 1'b1;
        i_uaf2 = 1'b1;
        i_uaf3 = 1'b1;
        i_uaf4 = 1'b1;
        wait(DUT.genblk1.AFR_CU.current_state == idle);
        i_uaf4 = 1'b0;
        i_afir4 = 32'h44444444;
        @(posedge i_sys_clk);
        $display("[AF_TC_24] If 'i_uaf4' is set to 0, internal ID register 'AFIR[31:0]' in AFR4 shall be set to the corresponding bits from 'i_afir4[31:0]' on the rising edge of 'i_sys_clk'");
        #1 assert (DUT.genblk1.AFR4.acir == i_afir4) 
            $display("\t Test PASS: AFR4.acir = %b", DUT.genblk1.AFR4.acir);
        else
            $error("\t Test FAIL: AFR4.acir = %b", DUT.genblk1.AFR4.acir);
        i_afir4 = 32'h00000000;
        i_uaf1 = 1'b0;
        i_uaf2 = 1'b0;
        i_uaf3 = 1'b0;
        i_uaf4 = 1'b0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
        //AF_TC_25
        i_uaf1 = 1'b1;
        i_uaf2 = 1'b1;
        i_uaf3 = 1'b1;
        i_uaf4 = 1'b1;
        wait(DUT.genblk1.AFR_CU.current_state == idle);
        i_uaf1 = 1'b0;
        i_afmr1 = 32'h11111111;
        @(posedge i_sys_clk);
        $display("[AF_TC_25] If 'i_uaf1' is set to 0, internal mask register 'AFMR[31:0]' in AFR1 shall be set to the corresponding bits from 'i_afmr1[31:0]' on the rising edge of 'i_sys_clk'");
        #1 assert (DUT.genblk1.AFR1.acmr == i_afmr1) 
            $display("\t Test PASS: AFR1.acmr = %b", DUT.genblk1.AFR1.acmr);
        else
            $error("\t Test FAIL: AFR1.acmr = %b", DUT.genblk1.AFR1.acmr);
        i_afmr1 = 32'h00000000;
        i_uaf1 = 1'b0;
        i_uaf2 = 1'b0;
        i_uaf3 = 1'b0;
        i_uaf4 = 1'b0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
        //AF_TC_26
        i_uaf1 = 1'b1;
        i_uaf2 = 1'b1;
        i_uaf3 = 1'b1;
        i_uaf4 = 1'b1;
        wait(DUT.genblk1.AFR_CU.current_state == idle);
        i_uaf2 = 1'b0;
        i_afmr2 = 32'h22222222;
        @(posedge i_sys_clk);
        $display("[AF_TC_26] If 'i_uaf2' is set to 0, internal mask register 'AFMR[31:0]' in AFR2 shall be set to the corresponding bits from 'i_afmr2[31:0]' on the rising edge of 'i_sys_clk'");
        #1 assert (DUT.genblk1.AFR2.acmr == i_afmr2) 
            $display("\t Test PASS: AFR2.acmr = %b", DUT.genblk1.AFR2.acmr);
        else
            $error("\t Test FAIL: AFR2.acmr = %b", DUT.genblk1.AFR2.acmr);
        i_afmr2 = 32'h00000000;
        i_uaf1 = 1'b0;
        i_uaf2 = 1'b0;
        i_uaf3 = 1'b0;
        i_uaf4 = 1'b0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
        //AF_TC_27
        i_uaf1 = 1'b1;
        i_uaf2 = 1'b1;
        i_uaf3 = 1'b1;
        i_uaf4 = 1'b1;
        wait(DUT.genblk1.AFR_CU.current_state == idle);
        i_uaf3 = 1'b0;
        i_afmr3 = 32'h33333333;
        @(posedge i_sys_clk);
        $display("[AF_TC_27] If 'i_uaf3' is set to 0, internal mask register 'AFMR[31:0]' in AFR3 shall be set to the corresponding bits from 'i_afmr3[31:0]' on the rising edge of 'i_sys_clk'");
        #1 assert (DUT.genblk1.AFR3.acmr == i_afmr3) 
            $display("\t Test PASS: AFR3.acmr = %b", DUT.genblk1.AFR3.acmr);
        else
            $error("\t Test FAIL: AFR3.acmr = %b", DUT.genblk1.AFR3.acmr);
        i_afmr3 = 32'h00000000;
        i_uaf1 = 1'b0;
        i_uaf2 = 1'b0;
        i_uaf3 = 1'b0;
        i_uaf4 = 1'b0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        
        //AF_TC_28
        i_uaf1 = 1'b1;
        i_uaf2 = 1'b1;
        i_uaf3 = 1'b1;
        i_uaf4 = 1'b1;
        wait(DUT.genblk1.AFR_CU.current_state == idle);
        i_uaf4 = 1'b0;
        i_afmr4 = 32'h44444444;
        @(posedge i_sys_clk);
        $display("[AF_TC_27] If 'i_uaf4' is set to 0, internal mask register 'AFMR[31:0]' in AFR4 shall be set to the corresponding bits from 'i_afmr4[31:0]' on the rising edge of 'i_sys_clk'");
        #1 assert (DUT.genblk1.AFR4.acmr == i_afmr4) 
            $display("\t Test PASS: AFR4.acmr = %b", DUT.genblk1.AFR4.acmr);
        else
            $error("\t Test FAIL: AFR4.acmr = %b", DUT.genblk1.AFR4.acmr);
        i_afmr4 = 32'h00000000;
        i_uaf1 = 1'b0;
        i_uaf2 = 1'b0;
        i_uaf3 = 1'b0;
        i_uaf4 = 1'b0;
        for(int i = 0; i < 20; i++)
            @(posedge i_sys_clk);
        #1;
        //COMPLETE!
        $finish("Test run complete");    
    end
endmodule


