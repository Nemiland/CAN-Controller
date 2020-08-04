`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: L&T Technology Services Ltd.
// Engineer: Andrew Newman
// 
// Create Date: 08/03/2020 02:42:22 PM
// Design Name: FIFO Testcases
// Module Name: can_fifo_testcases
// Project Name: CAN Controller
// Target Devices: Nexys A7-100T
// Tool Versions: Vivado 2019.2
// Description: Testcase testbench to perform functional verification upon the CAN_fifo module
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CAN_fifo_testcases;

  logic i_sys_clk = 1'b0;           
  logic i_reset = 1'b0;
  logic i_w_en = 1'b0;              
  logic i_r_en = 1'b0;              
  logic [127:0] i_fifo_w_data = 128'b1;
  logic o_full;
  logic o_empty;             
  logic o_underflow;         
  logic o_overflow;          
  logic [127:0] o_fifo_r_data;
  
  parameter DEPTH = 8;
  
  can_fifo #(
    .MEM_DEPTH     (DEPTH)
  )
  DUT (
    .i_sys_clk     (i_sys_clk),
    .i_reset       (i_reset),
    .i_w_en        (i_w_en),
    .i_r_en        (i_r_en),
    .i_fifo_w_data (i_fifo_w_data),
    .o_full        (o_full),
    .o_empty       (o_empty),
    .o_underflow   (o_underflow),
    .o_overflow    (o_overflow),
    .o_fifo_r_data (o_fifo_r_data)
  );
  
  //Variable Instantiation
  logic [$clog2(DEPTH) : 0] last_ptr;
  initial begin
    i_sys_clk     = 1'b0;
    i_reset       = 1'b0;
    i_w_en        = 1'b0;
    i_r_en        = 1'b0;
    i_fifo_w_data = 128'b0;
    last_ptr      = {($clog2(DEPTH) + 1) {1'b0}};
  end
  
  //Clock Generation
    always 
        #5 i_sys_clk = !i_sys_clk;
        
  //Testbench Begins
  initial begin
    #1;
    //FIFO_TC_00
    $display("[FIFO_TC_00] The fifo has a parameter 'MEM_DEPTH' that decides the depth of the fifo.");
    assert (DUT.MEM_DEPTH == DEPTH) 
        $display("\tTest PASS: MEM_DEPTH exists. Current value = %d", DUT.MEM_DEPTH);
    else
        $error("\tTest FAIL: MEM_DEPTH does not exist or is improperly initialized.");

    //FIFO_TC_01
    i_reset = 1'b1;
    $display("[FIFO_TC_01] 'o_full', 'o_overflow', 'o_underflow' are set to 0 when 'i_reset' is set to 1");
    #1 assert (o_full == 1'b0) begin
        $display("\tTest 1 PASS: o_full = %b", o_full);
        assert (o_overflow == 1'b0) begin
            $display("\tTest 2 PASS: o_overflow = %b", o_overflow);
            assert (o_underflow == 1'b0) 
                $display("\tTest 3 PASS: o_underflow = %b", o_underflow);
            else
                $error("\tTest 3 FAIL: o_underflow = %b", o_underflow);
        end
        else
            $error("\tTest 2 FAIL: o_overflow = %b", o_overflow);
    end
    else
        $error("\tTest 1 FAIL: o_full = %b", o_full);
    i_reset = 1'b0;
    @(posedge i_sys_clk);
    
    //FIFO_TC_02
    i_reset = 1'b1;
    $display("[FIFO_TC_02] 'o_empty' is set to 1 when 'i_reset' is set to 1");
    #1 assert (o_empty == 1'b1) 
        $display("\tTest PASS: o_empty = %b", o_empty);
    else
        $error("\tTest FAIL: o_empty = %b", o_empty);
    i_reset = 1'b0;
    @(posedge i_sys_clk);
    
    //FIFO_TC_03
    i_r_en = 1'b1;
    wait(o_empty == 1'b1);
    @(posedge i_sys_clk);
    $display("[FIFO_TC_03] 'o_underflow' is pulsed for one clock cycle when a read attempt happens while the fifo is empty");
    #1 assert (o_underflow == 1'b1) begin
        $display("\tTest 1 PASS: o_underflow = %b", o_underflow);
        i_r_en = 1'b0;
        @(posedge i_sys_clk);
        #1 assert (o_underflow == 1'b0) 
            $display("\tTest 2 PASS: o_underflow = %b", o_underflow);
        else
            $error("\tTest 2 FAIL: o_underflow = %b", o_underflow);
    end
    else
        $error("\tTest 1 FAIL: o_underflow = %b", o_underflow);
    i_reset = 1'b1;
    @(posedge i_sys_clk);
    i_reset = 1'b0;
    @(posedge i_sys_clk);
    
    //FIFO_TC_04
    i_r_en = 1'b1;
    wait(o_empty == 1'b1);
    i_r_en = 1'b0;
    i_w_en = 1'b1;
    wait(DUT.r_ptr[$clog2(DEPTH) - 1 : 0] == DUT.w_ptr[$clog2(DEPTH) - 1 : 0] && DUT.r_ptr[$clog2(DEPTH)] != DUT.w_ptr[$clog2(DEPTH)]);
    $display("[FIFO_TC_04] 'o_full' is set to 1 when all bits of read and write pointers are equal except the most significant bit");
    #1 assert (o_full == 1'b1) 
        $display("\tTest PASS: o_full = %b", o_full);
    else
        $error("\tTest FAIL: o_full = %b", o_full);
    i_w_en = 1'b0;
    i_reset = 1'b1;
    @(posedge i_sys_clk);
    i_reset = 1'b0;
    @(posedge i_sys_clk);
    
    //FIFO_TC_05
    i_r_en = 1'b1;
    wait(o_empty == 1'b1);
    i_r_en = 1'b0;
    i_w_en = 1'b1;
    wait(o_full == 1'b1);
    @(posedge i_sys_clk);
    $display("[FIFO_TC_05] 'o_overflow' is pulsed for one clock cycle when a write attempt happens while the fifo is full");
    #1 assert (o_overflow == 1'b1) begin
        $display("\tTest 1 PASS: o_overflow = %b", o_overflow);
        i_w_en = 1'b0;
        @(posedge i_sys_clk);
        #1 assert (o_overflow == 1'b0) 
            $display("\tTest 2 PASS: o_overflow = %b", o_overflow);
        else
            $error("\tTest 2 FAIL: o_overflow = %b", o_overflow);
    end
    else
        $error("\tTest 1 FAIL: o_overflow = %b", o_overflow);
    i_reset = 1'b1;
    @(posedge i_sys_clk);
    i_reset = 1'b0;
    @(posedge i_sys_clk);
    
    //FIFO_TC_06
    i_w_en = 1'b1;
    wait(o_full == 1'b1);
    i_r_en = 1'b1;
    i_w_en = 1'b0;
    wait(DUT.r_ptr[$clog2(DEPTH) : 0] == DUT.w_ptr[$clog2(DEPTH) : 0]);
    $display("[FIFO_TC_06] 'o_empty' is set to 1 when read and write pointers are equal");
    #1 assert (o_empty == 1'b1) 
        $display("\tTest PASS: o_empty = %b", o_empty);
    else
        $error("\tTest FAIL: o_empty = %b", o_empty);
    i_r_en = 1'b0;
    i_reset = 1'b1;
    @(posedge i_sys_clk);
    i_reset = 1'b0;
    @(posedge i_sys_clk);
    
    //FIFO_TC_07
    i_r_en = 1'b1;
    wait(o_empty == 1'b1);
    i_r_en = 1'b0;
    i_w_en = 1'b1;
    wait(o_full == 1'b0);
    #1 last_ptr = DUT.w_ptr;
    @(posedge i_sys_clk);
    $display("[FIFO_TC_07] Write pointer gets incremented on rising edge of clock if 'i_w_en' is set to 1 and fifo is not full");
    #1 assert (DUT.w_ptr == last_ptr + 1) 
        $display("\tTest PASS: w_ptr = %b, last_ptr = %b", DUT.w_ptr, last_ptr);
    else
        $error("\tTest FAIL: w_ptr = %b, last_ptr = %b", DUT.w_ptr, last_ptr);
    i_w_en = 1'b0;
    last_ptr = {($clog2(DEPTH) + 1) {1'b0}};
    i_reset = 1'b1;
    @(posedge i_sys_clk);
    i_reset = 1'b0;
    @(posedge i_sys_clk);
    
    //FIFO_TC_08
    i_fifo_w_data = 128'd0;
    i_r_en = 1'b1;
    wait(o_empty == 1'b1);
    i_r_en = 1'b0;
    i_w_en = 1'b1;
    wait(o_full == 1'b0);
    i_fifo_w_data = 128'h0123456789ABCDEF;
    last_ptr = DUT.w_ptr;
    @(posedge i_sys_clk);
    $display("[FIFO_TC_08] 'o_fifo_w_data' is saved in the fifo cell where the write pointer is pointing to at rising edge of clock if 'i_w_en' is set to 1 and fifo is not full");
    #1 assert (DUT.memory[last_ptr] == i_fifo_w_data) 
        $display("\tTest PASS: memory[last_ptr] = %h, i_fifo_w_data = %h", DUT.memory[last_ptr], i_fifo_w_data);
    else
        $error("\tTest FAIL: memory[last_ptr] = %h, i_fifo_w_data = %h", DUT.memory[last_ptr], i_fifo_w_data);
    i_w_en = 1'b0;
    i_fifo_w_data = 128'd0;
    last_ptr = {($clog2(DEPTH) + 1) {1'b0}};
    i_reset = 1'b1;
    @(posedge i_sys_clk);
    i_reset = 1'b0;
    @(posedge i_sys_clk);
    
    //FIFO_TC_09
    i_w_en = 1'b1;
    wait(o_full == 1'b1);
    i_w_en = 1'b0;
    i_r_en = 1'b1;
    wait(o_empty == 1'b0);
    last_ptr = DUT.r_ptr;
    @(posedge i_sys_clk);
    $display("[FIFO_TC_09] Read pointer gets incremented on rising edge of clock if 'i_r_en' is set to 1 and fifo is not empty");
    #1 assert (DUT.r_ptr == last_ptr + 1) 
        $display("\tTest PASS: r_ptr = %h, last_ptr = %h", DUT.r_ptr, last_ptr);
    else
        $error("\tTest FAIL: r_ptr = %h, last_ptr = %h", DUT.r_ptr, last_ptr);
    i_r_en = 1'b0;
    last_ptr = {($clog2(DEPTH) + 1) {1'b0}};
    i_reset = 1'b1;
    @(posedge i_sys_clk);
    i_reset = 1'b0;
    @(posedge i_sys_clk);
    
    //FIFO_TC_10
    i_fifo_w_data = 128'd0;
    i_r_en = 1'b1;
    wait(o_empty == 1'b1);
    i_r_en = 1'b0;
    i_w_en = 1'b1;
    i_fifo_w_data = 128'h0123456789ABCDEF;
    while(o_full == 1'b0) begin
        i_fifo_w_data += 4;
        @(posedge i_sys_clk);
    end
    //Memory is populated with different data now;
    i_r_en = 1'b1;
    i_w_en = 1'b0;
    #(10:(10*DEPTH/4):(10*DEPTH/2)); //Have a random selected cell in the upper half
    @(posedge i_sys_clk);
    #1 last_ptr = DUT.r_ptr;
    $display("[FIFO_TC_10] 'o_fifo_r_data' is set to the fifo cell content where the read pointer is pointing to");
    assert (DUT.memory[last_ptr] == o_fifo_r_data) 
        $display("\tTest PASS: memory[last_ptr] = %h, o_fifo_r_data = %h", DUT.memory[last_ptr], o_fifo_r_data);
    else
        $error("\tTest FAIL: memory[last_ptr] = %h, o_fifo_r_data = %h", DUT.memory[last_ptr], o_fifo_r_data);
    i_fifo_w_data = 128'd0;
    i_r_en = 1'b0;
    last_ptr = {($clog2(DEPTH) + 1) {1'b0}};
    i_reset = 1'b1;
    @(posedge i_sys_clk);
    i_reset = 1'b0;
    @(posedge i_sys_clk);
    
    //FIFO_TC_11
    i_fifo_w_data = 128'd0;
    i_r_en = 1'b1;
    wait(o_empty == 1'b1);
    i_r_en = 1'b0;
    i_w_en = 1'b1;
    i_fifo_w_data = 128'h0123456789ABCDEF;
    while(o_full == 1'b0) begin
        i_fifo_w_data += 4;
        @(posedge i_sys_clk);
    end
    //Memory is populated with different data now;
    i_reset = 1'b1;
    #1 $display("[FIFO_TC_11] All fifo cells are set to zeros when 'i_reset' is set to 1");
    for (int i = 0; i < DEPTH; i++) begin
        assert (DUT.memory[i] == 128'd0) 
            $display("\tTest %d PASS: memory[%h] = %h", i+1, i, DUT.memory[last_ptr]);
        else begin
            $error("\tTest %d FAIL: memory[%h] = %h", i+1, i, DUT.memory[last_ptr]);
            break;
        end
    end
    i_fifo_w_data = 128'd0;
    i_r_en = 1'b0;
    last_ptr = {($clog2(DEPTH) + 1) {1'b0}};
    i_reset = 1'b1;
    @(posedge i_sys_clk);
    i_reset = 1'b0;
    @(posedge i_sys_clk);
    
    $display("FINISHED");
    $finish;
  end
  
endmodule
