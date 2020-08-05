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
	
	//No set up necessary for this testcase
    $display("[FIFO_TC_00] The fifo has a parameter 'MEM_DEPTH' that decides the depth of the fifo.");
	//Checking for runtime error when accessing DUT.MEM_DEPTH 
    assert (DUT.MEM_DEPTH == DEPTH) 
        $display("\tTest PASS: MEM_DEPTH exists. Current value = %d", DUT.MEM_DEPTH);
    else
        $error("\tTest FAIL: MEM_DEPTH does not exist or is improperly initialized.");

    //FIFO_TC_01
    i_reset = 1'b1;															//Reset the FIFO		
	
	//Testcase conditions are now set up, begin assert sequence
    $display("[FIFO_TC_01] 'o_full', 'o_overflow', 'o_underflow' are set to 0 when 'i_reset' is set to 1");
	#1 assert (o_full == 1'b0) begin										//Check if o_full does indeed get reset
		$display("\tTest 1 PASS: o_full = %b", o_full);						//Passed first test, report and move on
		
        assert (o_overflow == 1'b0) begin									//Check if o_overflow does indeed get reset
			$display("\tTest 2 PASS: o_overflow = %b", o_overflow);			//Passed first test, report and move on
			
            assert (o_underflow == 1'b0) 									//Check if o_underflow does indeed get reset
                $display("\tTest 3 PASS: o_underflow = %b", o_underflow);	//Success! passed all the tests and ready to move on
            else 
                $error("\tTest 3 FAIL: o_underflow = %b", o_underflow);		//Did not get reset, generate error message and break
        end
        else
            $error("\tTest 2 FAIL: o_overflow = %b", o_overflow);			//Did not get reset, generate error message and break
    end
    else
        $error("\tTest 1 FAIL: o_full = %b", o_full);						//Did not get reset, generate error message and break
		
    //Revert any variable changes and pass some time to normalize
	i_reset = 1'b0;
    @(posedge i_sys_clk);
    
	
	
    //FIFO_TC_02
    i_reset = 1'b1;															//Reset the FIFO
	
	//Testcase conditions are now set up, begin assert sequence
    $display("[FIFO_TC_02] 'o_empty' is set to 1 when 'i_reset' is set to 1");
    #1 assert (o_empty == 1'b1) 											//Check if o_empty does indeed get reset
        $display("\tTest PASS: o_empty = %b", o_empty);						//Success! passed all the tests and ready to move on
    else
        $error("\tTest FAIL: o_empty = %b", o_empty);						//Did not get reset, generate error message and break
		
	//Revert any variable changes and pass some time to normalize
    i_reset = 1'b0;
    @(posedge i_sys_clk);
    
	
	
    //FIFO_TC_03
    i_r_en = 1'b1;															//Initiate the read attempt
    wait(o_empty == 1'b1);													//Keep reading until and through the FIFO being empty
    @(posedge i_sys_clk);													//Wait until the very next clock cycle after FIFO became empty
	//Testcase conditions are now set up, begin assert sequence
    $display("[FIFO_TC_03] 'o_underflow' is pulsed for one clock cycle when a read attempt happens while the fifo is empty");
    #1 assert (o_underflow == 1'b1) begin									//Verify that this setup indeed sets o_underflow to logic high 
        $display("\tTest 1 PASS: o_underflow = %b", o_underflow);			//Report partial success
        i_r_en = 1'b0;														//Stop reading from empty queue
        @(posedge i_sys_clk);												//Advance a clock cycle past underflow instance
        #1 assert (o_underflow == 1'b0) 									//Verify that this setup indeed creates a one-cycle pulse of o_underflow
            $display("\tTest 2 PASS: o_underflow = %b", o_underflow);		//Success! passed all the tests and ready to move on
        else
            $error("\tTest 2 FAIL: o_underflow = %b", o_underflow);			//Fail, report and move on.
    end
    else
        $error("\tTest 1 FAIL: o_underflow = %b", o_underflow);				//Fail, report and move on.
		
    //Reset and pass some time to normalize
    i_reset = 1'b1;
    @(posedge i_sys_clk);
    i_reset = 1'b0;
    @(posedge i_sys_clk);
    
	
	
    //FIFO_TC_04
    i_r_en = 1'b1;															//Initiate the read attempt
    wait(o_empty == 1'b1);													//Keep reading until and through the FIFO being empty
    i_r_en = 1'b0;															//Stop reading from empty queue		
    i_w_en = 1'b1;															//Initiate the write attempt into an empty queue	
    wait(DUT.r_ptr[$clog2(DEPTH) - 1 : 0] == DUT.w_ptr[$clog2(DEPTH) - 1 : 0] && DUT.r_ptr[$clog2(DEPTH)] != DUT.w_ptr[$clog2(DEPTH)]);		//Wait until we reach a point where all bits of read and write pointers are equal except the most significant bit
	
	//Testcase conditions are now set up, begin assert sequence
    $display("[FIFO_TC_04] 'o_full' is set to 1 when all bits of read and write pointers are equal except the most significant bit");
    #1 assert (o_full == 1'b1)												//Verify that this setup indeed sets o_full to logic high 
        $display("\tTest PASS: o_full = %b", o_full);						//Success! passed all the tests and ready to move on
    else
        $error("\tTest FAIL: o_full = %b", o_full);							//Fail, report and move on.
		
    //Revert any variable changes , reset and pass some time to normalize
    i_w_en = 1'b0;
    i_reset = 1'b1;
    @(posedge i_sys_clk);
    i_reset = 1'b0;
    @(posedge i_sys_clk);
    
	
	
    //FIFO_TC_05
    i_r_en = 1'b1;															//Initiate the read attempt
    wait(o_empty == 1'b1);													//Keep reading until the FIFO being empty
    i_r_en = 1'b0;															//Stop reading from empty queue		
    i_w_en = 1'b1;															//Initiate the write attempt into an empty queue	
    wait(o_full == 1'b1);													//Keep wriitng until and through the FIFO being full
    @(posedge i_sys_clk);													//Wait until the very next clock cycle after FIFO became full
	
	//Testcase conditions are now set up, begin assert sequence
    $display("[FIFO_TC_05] 'o_overflow' is pulsed for one clock cycle when a write attempt happens while the fifo is full");
    #1 assert (o_overflow == 1'b1) begin									//Verify that this setup indeed sets o_overflow to logic high 
        $display("\tTest 1 PASS: o_overflow = %b", o_overflow);				//Report partial success
        i_w_en = 1'b0;														//Stop writing into the full queue
        @(posedge i_sys_clk);												//Advance a clock cycle past overflow instance	
        #1 assert (o_overflow == 1'b0) 										//Verify that this setup indeed creates a one-cycle pulse of o_overflow 
            $display("\tTest 2 PASS: o_overflow = %b", o_overflow);			//Success! passed all the tests and ready to move on
        else
            $error("\tTest 2 FAIL: o_overflow = %b", o_overflow);			//Fail, report and move on.
    end
    else
        $error("\tTest 1 FAIL: o_overflow = %b", o_overflow);				//Fail, report and move on.
		
    //Reset and pass some time to normalize
    i_reset = 1'b1;
    @(posedge i_sys_clk);
    i_reset = 1'b0;
    @(posedge i_sys_clk);
    
	
	
    //FIFO_TC_06
    i_w_en = 1'b1;															//Initiate the write attempt
    wait(o_full == 1'b1);													//Keep writing until the FIFO being full
    i_r_en = 1'b1;															//Initiate the read attempt from the full queue
    i_w_en = 1'b0;															//Stop writing into the full queue
    wait(DUT.r_ptr[$clog2(DEPTH) : 0] == DUT.w_ptr[$clog2(DEPTH) : 0]);		//Wait until we reach a point where read and write pointers are equal
	
	//Testcase conditions are now set up, begin assert sequence
    $display("[FIFO_TC_06] 'o_empty' is set to 1 when read and write pointers are equal");
    #1 assert (o_empty == 1'b1) 											//Verify that this setup indeed sets o_empty to logic high 
        $display("\tTest PASS: o_empty = %b", o_empty);						//Success! passed all the tests and ready to move on
    else
        $error("\tTest FAIL: o_empty = %b", o_empty);						//Fail, report and move on.
		
    //Revert any variable changes , reset and pass some time to normalize
    i_r_en = 1'b0;
    i_reset = 1'b1;
    @(posedge i_sys_clk);
    i_reset = 1'b0;
    @(posedge i_sys_clk);
    
	
	
    //FIFO_TC_07
    i_r_en = 1'b1;															//Initiate the read attempt
    wait(o_empty == 1'b1);													//Keep reading until the FIFO being empty
    i_r_en = 1'b0;															//Stop reading from empty queue		
    i_w_en = 1'b1;															//Initiate the write attempt into an empty queue	
    wait(o_full == 1'b0);													//Validate we are not full; just a precaution to satisfy the testcase
    #1 last_ptr = DUT.w_ptr;												//Store a value of the write pointer
    @(posedge i_sys_clk);													//Advance another write clock cycle
	
	//Testcase conditions are now set up, begin assert sequence
    $display("[FIFO_TC_07] Write pointer gets incremented on rising edge of clock if 'i_w_en' is set to 1 and fifo is not full");
    #1 assert (DUT.w_ptr == last_ptr + 1) 									//Verify that this setup indeed sets w_ptr to its old value + 1
        $display("\tTest PASS: w_ptr = %b, last_ptr = %b", DUT.w_ptr, last_ptr);		//Success! passed all the tests and ready to move on
    else
        $error("\tTest FAIL: w_ptr = %b, last_ptr = %b", DUT.w_ptr, last_ptr);			//Fail, report and move on.
		
    //Revert any variable changes , reset and pass some time to normalize
    i_w_en = 1'b0;
    last_ptr = {($clog2(DEPTH) + 1) {1'b0}};
    i_reset = 1'b1;
    @(posedge i_sys_clk);
    i_reset = 1'b0;
    @(posedge i_sys_clk);
    
	
	
    //FIFO_TC_08
    i_fifo_w_data = 128'd0;													//Zero out the write bus just in case	
    i_r_en = 1'b1;															//Initiate the read attempt
    wait(o_empty == 1'b1);													//Keep reading until the FIFO being empty
    i_r_en = 1'b0;															//Stop reading from empty queue		
    i_w_en = 1'b1;															//Initiate the write attempt into an empty queue	
    wait(o_full == 1'b0);													//Validate we are not full; just a precaution to satisfy the testcase
    i_fifo_w_data = 128'h0123456789ABCDEF;									//Set write data to some arbitrary data to test
    last_ptr = DUT.w_ptr;													//Store write pointer value of where the value is going to get written
    @(posedge i_sys_clk);													//Advance another write clock cycle
	
	//Testcase conditions are now set up, begin assert sequence
    $display("[FIFO_TC_08] 'o_fifo_w_data' is saved in the fifo cell where the write pointer is pointing to at rising edge of clock if 'i_w_en' is set to 1 and fifo is not full");
    #1 assert (DUT.memory[last_ptr] == i_fifo_w_data) 						//Verify that this setup indeed sets writes the write data into the position in memory indicated by old value of w_ptr
        $display("\tTest PASS: memory[last_ptr] = %h, i_fifo_w_data = %h", DUT.memory[last_ptr], i_fifo_w_data);	//Success! passed all the tests and ready to move on
    else
        $error("\tTest FAIL: memory[last_ptr] = %h, i_fifo_w_data = %h", DUT.memory[last_ptr], i_fifo_w_data);		//Fail, report and move on.
		
    //Revert any variable changes , reset and pass some time to normalize
    i_w_en = 1'b0;
    i_fifo_w_data = 128'd0;
    last_ptr = {($clog2(DEPTH) + 1) {1'b0}};
    i_reset = 1'b1;
    @(posedge i_sys_clk);
    i_reset = 1'b0;
    @(posedge i_sys_clk);
    
	
	
    //FIFO_TC_09
    i_w_en = 1'b1;															//Initiate the write attempt
    wait(o_full == 1'b1);													//Keep writing until the FIFO being full
	i_r_en = 1'b1;															//Initiate the read attempt from the full queue
    i_w_en = 1'b0;															//Stop writing into the full queue
    wait(o_empty == 1'b0);													//Validate we are not empty; just a precaution to satisfy the testcase
    last_ptr = DUT.r_ptr;													//Store a value of the read pointer
    @(posedge i_sys_clk);													//Advance another read clock cycle
	
	//Testcase conditions are now set up, begin assert sequence
    $display("[FIFO_TC_09] Read pointer gets incremented on rising edge of clock if 'i_r_en' is set to 1 and fifo is not empty");
    #1 assert (DUT.r_ptr == last_ptr + 1) 									//Verify that this setup indeed sets r_ptr to its old value + 1
        $display("\tTest PASS: r_ptr = %h, last_ptr = %h", DUT.r_ptr, last_ptr);			//Success! passed all the tests and ready to move on
    else
        $error("\tTest FAIL: r_ptr = %h, last_ptr = %h", DUT.r_ptr, last_ptr);				//Fail, report and move on.
		
    //Revert any variable changes , reset and pass some time to normalize
    i_r_en = 1'b0;
    last_ptr = {($clog2(DEPTH) + 1) {1'b0}};
    i_reset = 1'b1;
    @(posedge i_sys_clk);
    i_reset = 1'b0;
    @(posedge i_sys_clk);
    
	
	
    //FIFO_TC_10
	
	//Firstly, clear out the FIFO fully
    i_fifo_w_data = 128'd0;													//Zero out the write bus just in case		
    i_r_en = 1'b1;															//Initiate the read attempt
    wait(o_empty == 1'b1);													//Keep reading until the FIFO being empty
    
	//Now we populate every place in the memory with varying data
	i_r_en = 1'b0;															//Stop reading from empty queue		
    i_w_en = 1'b1;															//Initiate the write attempt into an empty queue
    i_fifo_w_data = 128'h0123456789ABCDEF;									//Set write data to some arbitrary initial value from which we base differential data
    while(o_full == 1'b0) begin												//Keep writing until we are full							
        i_fifo_w_data += 4;													//Modify the data written into the current slot by adding 4 to it		
        @(posedge i_sys_clk);												//Advance another write clock cycle
    end
    //Memory is populated with different data now;
	
    i_r_en = 1'b1;															//Initiate the read attempt from the full queue
    i_w_en = 1'b0;															//Stop writing into the full queue
    #(10:(10*DEPTH/4):(10*DEPTH/2)); 										//Have a random selected cell in the upper half(made this way to accomodate some randomness in this test)
    @(posedge i_sys_clk);													//Go to the rising edge to line up the timing from the rendom advancement in the last line
    #1 last_ptr = DUT.r_ptr;												//Store read pointer value of where the value is going to get read from											
	
	//Testcase conditions are now set up, begin assert sequence
    $display("[FIFO_TC_10] 'o_fifo_r_data' is set to the fifo cell content where the read pointer is pointing to");
    assert (DUT.memory[last_ptr] == o_fifo_r_data) 							//Verify that the memory pointed to by r_ptr does indeed generate o_fifo_r_data
        $display("\tTest PASS: memory[last_ptr] = %h, o_fifo_r_data = %h", DUT.memory[last_ptr], o_fifo_r_data);	//Success! passed all the tests and ready to move on
    else
        $error("\tTest FAIL: memory[last_ptr] = %h, o_fifo_r_data = %h", DUT.memory[last_ptr], o_fifo_r_data);		//Fail, report and move on.
		
    //Revert any variable changes , reset and pass some time to normalize
    i_fifo_w_data = 128'd0;
    i_r_en = 1'b0;
    last_ptr = {($clog2(DEPTH) + 1) {1'b0}};
    i_reset = 1'b1;
    @(posedge i_sys_clk);
    i_reset = 1'b0;
    @(posedge i_sys_clk);
    
	
	
    //FIFO_TC_11
	
	//Firstly, clear out the FIFO fully
    i_fifo_w_data = 128'd0;													//Zero out the write bus just in case	
    i_r_en = 1'b1;															//Initiate the read attempt
    wait(o_empty == 1'b1);													//Keep reading until the FIFO being empty
	
	//Now we populate every place in the memory with varying data
    i_r_en = 1'b0;															//Stop reading from empty queue		
    i_w_en = 1'b1;															//Initiate the write attempt into an empty queue
    i_fifo_w_data = 128'h0123456789ABCDEF;									//Set write data to some arbitrary initial value from which we base differential data
    while(o_full == 1'b0) begin												//Keep writing until we are full							
        i_fifo_w_data += 4;													//Modify the data written into the current slot by adding 4 to it		
        @(posedge i_sys_clk);												//Advance another write clock cycle
    end
	
    //Memory is populated with different data now;
    i_reset = 1'b1;															//Reset the module with all cells populated
	
	//Testcase conditions are now set up, begin assert sequence
    #1 $display("[FIFO_TC_11] All fifo cells are set to zeros when 'i_reset' is set to 1");
    for (int i = 0; i < DEPTH; i++) begin									//Advance through every cell of FIFO memory, with pointer i
        assert (DUT.memory[i] == 128'd0) 									//Verify that the FIFO memory gets fully cleared for i-th cell
            $display("\tTest %d PASS: memory[%h] = %h", i+1, i, DUT.memory[last_ptr]);	//Success! passed all the tests and ready to move on
        else begin
            $error("\tTest %d FAIL: memory[%h] = %h", i+1, i, DUT.memory[last_ptr]);	//Fail, report and move on.
            break;
        end
    end
	
    //Revert any variable changes , reset and pass some time to normalize
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
