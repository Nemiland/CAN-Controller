/*-------------------------------------------
  Project: CAN Controller
  Module: can_mc_if_tb
  Author: Antonio Jimenez
  Date: 8/05/2020
  Module Description: A testbench that verifies the functionality of can_mc_if
-------------------------------------------*/

module can_mc_if_tb;

  localparam TOTAL_TEST_CASES = 59;
  
  integer failed_test_cases = 0;
  integer failed_sub_test_cases = 0;

  logic i_sys_clk = 1'b0;
  logic i_reset = 1'b0;
  logic [31:0] i_bus_data;
  logic [5:0] i_addr;
  logic i_r_neg_w;
  logic i_cs;
  logic [31:0] o_reg_data;
  logic o_ack;
  logic o_error;
  logic [31:0] i_reg_r_data;
  logic i_reg_ack;
  logic i_reg_error;
  logic [31:0] o_reg_w_bus;
  logic [30:0] o_rs_vector;
  logic o_r_neg_w;

  can_mc_if DUT (
    .i_sys_clk(i_sys_clk),
    .i_reset(i_reset),
    .i_bus_data(i_bus_data),
    .i_addr(i_addr),
    .i_r_neg_w(i_r_neg_w),
    .i_cs(i_cs),
    .o_reg_data(o_reg_data),
    .o_ack(o_ack),
    .o_error(o_error),
    .i_reg_r_data(i_reg_r_data),
    .i_reg_ack(i_reg_ack),
    .i_reg_error(i_reg_error),
    .o_reg_w_bus(o_reg_w_bus),
    .o_rs_vector(o_rs_vector),
    .o_r_neg_w(o_r_neg_w)
  );
  
  initial begin
    // Initial Start
    i_sys_clk = 1'b0;
    i_reset = 1'b0;
    i_bus_data = 32'b0;
    i_addr = 6'b0;
    i_r_neg_w = 1'b0;
    i_cs = 1'b0;
    i_reg_r_data = 32'b0;
    i_reg_ack = 1'b0;
    i_reg_error = 1'b0;
    
    // MCI_RES_TC_01
    // o_reg_data outputs 0's when i_reset is 1
    $display("-------------------- MCI_RES_TC_01 -------------------\n");
      i_reset = 1'b1;
      #5;
      $display("    Expected: o_reg_data = 32'h0000_0000\n");
      $display("    Actual:   o_reg_data = %h\n", o_reg_data);
      assert(o_reg_data == 32'h0000_0000)
        $display("    PASS\n\n");
      else begin
        $display("    FAIL\n\n");
        failed_test_cases += 1;
      end
    
    // MCI_RES_TC_02
    // o_reg_w_bus outputs 0's when i_reset is 1
    $display("-------------------- MCI_RES_TC_02 -------------------\n");
      i_reset = 1'b1;
      #5;
      $display("    Expected: o_reg_w_bus = 32'h0000_0000\n");
      $display("    Actual:   o_reg_w_bus = %h\n", o_reg_w_bus);
      assert(o_reg_w_bus == 32'h0000_0000)
        $display("    PASS\n\n");
      else begin
        $display("    FAIL\n\n");
        failed_test_cases += 1;
      end
    
    // MCI_RES_TC_03
    // o_rs_vector outputs all 0's when i_reset is 1
    $display("-------------------- MCI_RES_TC_03 -------------------\n");
      i_reset = 1'b1;
      #5;
      $display("    Expected: o_rs_vector = 31'h0000_0000\n");
      $display("    Actual:   o_rs_vector = %h\n", o_rs_vector);
      assert(o_rs_vector == 31'h0000_0000)
        $display("    PASS\n\n");
      else begin
        $display("    FAIL\n\n");
        failed_test_cases += 1;
      end
    
    // MCI_RES_TC_04
    // o_r_neg_w outputs 0 when i_reset is 1
    $display("-------------------- MCI_RES_TC_04 -------------------\n");
      i_reset = 1'b1;
      #5;
      $display("    Expected: o_r_neg_w = 1'b0\n");
      $display("    Actual:   o_r_neg_w = %b\n", o_r_neg_w);
      assert(o_r_neg_w == 1'b0)
        $display("    PASS\n\n");
      else begin
        $display("    FAIL\n\n");
        failed_test_cases += 1;
      end
    
    // MCI_RES_TC_05
    // o_ack outputs 0 when i_reset is 1
    $display("-------------------- MCI_RES_TC_05 -------------------\n");
      i_reset = 1'b1;
      #5;
      $display("    Expected: o_ack = 1'b0\n");
      $display("    Actual:   o_ack = %b\n", o_ack);
      assert(o_ack == 1'b0)
        $display("    PASS\n\n");
      else begin
        $display("    FAIL\n\n");
        failed_test_cases += 1;
      end
    
    // MCI_RES_TC_06
    $display("-------------------- MCI_RES_TC_06 -------------------\n");
      i_reset = 1'b1;
      #5;
      $display("    Expected: o_error = 1'b0\n");
      $display("    Actual:   o_error = %b\n", o_error);
      assert(o_error == 1'b0)
        $display("    PASS\n\n");
      else begin
        $display("    FAIL\n\n");
        failed_test_cases += 1;
      end
    
    // MCI_RD_TC_01
    // o_reg_data outputs i_reg_r_data when i_cs and i_r_neg_w are 1 and i_addr is a valid input
    $display("-------------------- MCI_RD_TC_01 -------------------\n");
      failed_sub_test_cases = 0;
      i_bus_data = 32'hAAAA_AAAA;
      
      // i_cs = 0, i_r_neg_w = 0, i_reg_ack = 0, & i_addr = 6'h30
      $display("    Test when i_cs=0, i_r_neg_w=0, i_reg_ack=0, & i_addr=6'h30");
      i_reset = 1'b1;
      i_cs = 1'b0;
      i_r_neg_w = 1'b0;
      i_reg_ack = 1'b0;
      i_addr = 6'h30;
      i_bus_data = 32'hAAAA_AAAA;
      tick;
      i_reset = 1'b0;
      tick;
      $display("        Expected: o_reg_data = 32'h0000_0000\n");
      $display("        Actual:   o_reg_data = %h\n", o_reg_data);
      if (o_reg_data != 32'h0000_0000) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      // i_cs = 1, i_r_neg_w = 0, i_reg_ack = 0, & i_addr = 6'h30
      $display("    Test when i_cs=1, i_r_neg_w=0, i_reg_ack=0, & i_addr=6'h30");
      i_cs = 1'b1;
      tick;
      $display("        Expected: o_reg_data = 32'h0000_0000\n");
      $display("        Actual:   o_reg_data = %h\n", o_reg_data);
      if (o_reg_data != 32'h0000_0000) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      // i_cs = 0, i_r_neg_w = 1, i_reg_ack = 0, & i_addr = 6'h30
      $display("    Test when i_cs=1, i_r_neg_w=0, i_reg_ack=0, & i_addr=6'h30");
      i_cs = 1'b0;
      i_r_neg_w = 1'b1;
      tick;
      $display("        Expected: o_reg_data = 32'h0000_0000\n");
      $display("        Actual:   o_reg_data = %h\n", o_reg_data);
      if (o_reg_data != 32'h0000_0000) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      // i_cs = 0, i_r_neg_w = 1, i_reg_ack = 0, & i_addr = 6'h00
      $display("    Test when i_cs=0, i_r_neg_w=1, i_reg_ack=0, & i_addr=6'h00");
      i_addr = 6'h00;
      tick;
      $display("        Expected: o_reg_data = 32'h0000_0000\n");
      $display("        Actual:   o_reg_data = %h\n", o_reg_data);
      if (o_reg_data != 32'h0000_0000) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      // i_cs = 0, i_r_neg_w = 1, i_reg_ack = 1, & i_addr = 6'h00
      $display("    Test when i_cs=0, i_r_neg_w=1, i_reg_ack=1, & i_addr=6'h00");
      i_reg_ack = 1'b1;
      tick;
      $display("        Expected: o_reg_data = 32'h0000_0000\n");
      $display("        Actual:   o_reg_data = %h\n", o_reg_data);
      if (o_reg_data != 32'h0000_0000) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      // i_cs = 1, i_r_neg_w = 1, i_reg_ack = 1, & i_addr = 6'h00
      $display("    Test when i_cs=1, i_r_neg_w=1, i_reg_ack=1, & i_addr=6'h00");
      i_cs = 1'b1;
      tick;
      $display("        Expected: o_reg_data = 32'hAAAA_AAAA\n");
      $display("        Actual:   o_reg_data = %h\n", o_reg_data);
      if (o_reg_data != 32'hAAAA_AAAA) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      assert(failed_sub_test_cases == 0)
        $display("    TEST CASE PASSED\n\n");
      else begin
        $display("    TEST CASE FAILED\n\n");
        failed_test_cases += 1;
      end
    
    // MCI_RD_TC_02
    // o_ack outputs the value input into i_reg_ack
    $display("-------------------- MCI_RD_TC_02 -------------------\n");
      failed_sub_test_cases = 0;
    
      // i_reg_ack = 0
      $display("    Test when i_reg_ack=0\n");
      i_reg_ack = 1'b0;
      #5;
      $display("        Expected: o_ack = 0");
      $display("        Actual:   o_ack = %b\n", o_ack);
      if (o_ack != 1'b0) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
    
      // i_reg_ack = 1
      $display("    Test when i_reg_ack=1\n");
      i_reg_ack = 1'b1;
      #5;
      $display("        Expected: o_ack = 1");
      $display("        Actual:   o_ack = %b\n", o_ack);
      if (o_ack != 1'b1) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      assert(failed_sub_test_cases == 0)
        $display("    TEST CASE PASSED\n\n");
      else begin
        $display("    TEST CASE FAILED\n\n");
        failed_test_cases += 1;
      end
    
    // MCI_RD_TC_03
    // o_reg_neg_w outputs the value input into i_r_neg_w
    $display("-------------------- MCI_RD_TC_03 -------------------\n");
      failed_sub_test_cases = 0;
      
      // i_r_neg_w = 0
      $display("    Test when i_r_neg_w=0\n");
      i_r_neg_w = 1'b0;
      #5;
      $display("        Expected: o_r_neg_w = 1'b0\n");
      $display("        Actual:   o_r_neg_w = %b\n", o_r_neg_w);
      if (o_r_neg_w != 1'b0) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      // i_r_neg_w = 1
      $display("    Test when i_r_neg_w=1\n");
      i_r_neg_w = 1'b1;
      #5;
      $display("        Expected: o_r_neg_w = 1'b1\n");
      $display("        Actual:   o_r_neg_w = %b\n", o_r_neg_w);
      if (o_r_neg_w != 1'b1) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      assert(failed_sub_test_cases == 0)
        $display("    TEST CASE PASSED\n\n");
      else begin
        $display("    TEST CASE FAILED\n\n");
        failed_test_cases += 1;
      end
    
    // MCI_RD_TC_04
    // o_rs_vector at bit position 0 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x00,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_04 -------------------\n");
      failed_sub_test_cases = 0;
      i_reset = 1'b1;
      tick;
      i_reset = 1'b0;
      
      // i_cs = 0, i_r_neg_w = 0, and i_addr = 6'h30
      $display("    Test when i_cs=0, i_r_neg_w=0, and i_addr=6'h30\n");
      i_cs = 1'b0;
      i_r_neg_w = 1'b0;
      i_addr = 6'h30;
      tick;
      $display("        Expected: o_rs_vector[0] = 1'b0\n");
      $display("        Actual:   o_rs_vector[0] = %b\n", o_rs_vector[0]);
      if (o_rs_vector[0] != 1'b0) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      // i_cs = 1, i_r_neg_w = 0, and i_addr = 6'h30
      $display("    Test when i_cs=1, i_r_neg_w=0, and i_addr=6'h30\n");
      i_cs = 1'b1;
      tick;
      $display("        Expected: o_rs_vector[0] = 1'b0\n");
      $display("        Actual:   o_rs_vector[0] = %b\n", o_rs_vector[0]);
      if (o_rs_vector[0] != 1'b0) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      // i_cs = 0, i_r_neg_w = 1, and i_addr = 6'h30
      $display("    Test when i_cs=0, i_r_neg_w=1, and i_addr=6'h30\n");
      i_cs = 1'b0;
      i_r_neg_w = 1'b1;
      tick;
      $display("        Expected: o_rs_vector[0] = 1'b0\n");
      $display("        Actual:   o_rs_vector[0] = %b\n", o_rs_vector[0]);
      if (o_rs_vector[0] != 1'b0) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      // i_cs = 1, i_r_neg_w = 1 and i_addr = 6'h00
      $display("    Test when i_cs=0, i_r_neg_w=1, and i_addr=6'h00\n");
      i_cs = 1'b1;
      i_addr = 6'h00;
      tick;
      $display("        Expected: o_rs_vector[0] = 1'b0\n");
      $display("        Actual:   o_rs_vector[0] = %b\n", o_rs_vector[0]);
      if (o_rs_vector[0] != 1'b1) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      assert(failed_sub_test_cases == 0)
        $display("    TEST CASE PASSED\n\n");
      else begin
        $display("    TEST CASE FAILED\n\n");
        failed_test_cases += 1;
      end
    
    // MCI_RD_TC_05
    // o_rs_vector at bit position 1 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x01,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_05 -------------------\n");
      o_rs_vector_test_case (6'd1, 6'h01, 1'b1);
    
    // MCI_RD_TC_06
    // o_rs_vector at bit position 2 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x02,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_06 -------------------\n");
      o_rs_vector_test_case (6'd2, 6'h02, 1'b1);
    
    // MCI_RD_TC_07
    // o_rs_vector at bit position 3 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x03,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_07 -------------------\n");
      o_rs_vector_test_case (6'd3, 6'h03, 1'b1);
    
    // MCI_RD_TC_08
    // o_rs_vector at bit position 4 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x04,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_08 -------------------\n");
      o_rs_vector_test_case (6'd4, 6'h04, 1'b1);
    
    // MCI_RD_TC_09
    // o_rs_vector at bit position 5 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x05,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_09 -------------------\n");
      o_rs_vector_test_case (6'd5, 6'h05, 1'b1);
    
    // MCI_RD_TC_10
    // o_rs_vector at bit position 6 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x06,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_10 -------------------\n");
      o_rs_vector_test_case (6'd6, 6'h06, 1'b1);
    
    // MCI_RD_TC_11
    // o_rs_vector at bit position 7 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x07,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_11 -------------------\n");
      o_rs_vector_test_case (6'd7, 6'h07, 1'b1);
    
    // MCI_RD_TC_12
    // o_rs_vector at bit position 8 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x08,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_12 -------------------\n");
      o_rs_vector_test_case (6'd8, 6'h08, 1'b1);
    
    // MCI_RD_TC_13
    // o_rs_vector at bit position 18 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x14,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_13 -------------------\n");
      o_rs_vector_test_case (6'd18, 6'h14, 1'b1);
    
    // MCI_RD_TC_14
    // o_rs_vector at bit position 19 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x15,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_14 -------------------\n");
      o_rs_vector_test_case (6'd19, 6'h15, 1'b1);
    
    // MCI_RD_TC_15
    // o_rs_vector at bit position 20 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x16,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_15 -------------------\n");
      o_rs_vector_test_case (6'd20, 6'h16, 1'b1);
    
    // MCI_RD_TC_16
    // o_rs_vector at bit position 21 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x17,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_16 -------------------\n");
      o_rs_vector_test_case (6'd21, 6'h17, 1'b1);
    
    // MCI_RD_TC_17
    // o_rs_vector at bit position 22 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x18,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_17 -------------------\n");
      o_rs_vector_test_case (6'd22, 6'h18, 1'b1);
    
    // MCI_RD_TC_18
    // o_rs_vector at bit position 23 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x19,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_18 -------------------\n");
      o_rs_vector_test_case (6'd23, 6'h19, 1'b1);
    
    // MCI_RD_TC_19
    // o_rs_vector at bit position 24 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x1A,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_19 -------------------\n");
      o_rs_vector_test_case (6'd24, 6'h1A, 1'b1);
    
    // MCI_RD_TC_20
    // o_rs_vector at bit position 25 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x1B,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_20 -------------------\n");
      o_rs_vector_test_case (6'd25, 6'h1B, 1'b1);
    
    // MCI_RD_TC_21
    // o_rs_vector at bit position 26 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x1C,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_21 -------------------\n");
      o_rs_vector_test_case (6'd26, 6'h1C, 1'b1);
    
    // MCI_RD_TC_22
    // o_rs_vector at bit position 27 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x1D,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_22 -------------------\n");
      o_rs_vector_test_case (6'd27, 6'h1D, 1'b1);
    
    // MCI_RD_TC_23
    // o_rs_vector at bit position 28 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x1E,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_23 -------------------\n");
      o_rs_vector_test_case (6'd28, 6'h1E, 1'b1);
    
    // MCI_RD_TC_24
    // o_rs_vector at bit position 29 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x1F,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_24 -------------------\n");
      o_rs_vector_test_case (6'd29, 6'h1F, 1'b1);
    
    // MCI_RD_TC_25
    // o_rs_vector at bit position 30 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs and i_r_neg_w are 1, and addr is 0x20,
    // else it is set to 0
    $display("-------------------- MCI_RD_TC_25 -------------------\n");
      o_rs_vector_test_case (6'd30, 6'h20, 1'b1);
    
    // MCI_WR_TC_01
    // o_reg_w_bus outputs data from i_bus_data when i_cs is 1, i_r_neg_w is 0,
    // and i_addr is a valid input
    $display("-------------------- MCI_WR_TC_01 -------------------\n");
      failed_sub_test_cases = 0;
      i_reg_r_data = 32'hAAAA_AAAA;
      
      // i_cs = 0, i_r_neg_w = 1, & i_addr = 6'h30
      $display("    Test when i_cs=0, i_r_neg_w=1, & i_addr=6'h30");
      i_reset = 1'b1;
      i_cs = 1'b0;
      i_r_neg_w = 1'b1;
      i_addr = 6'h30;
      i_reg_r_data = 32'hAAAA_AAAA;
      tick;
      i_reset = 1'b0;
      tick;
      $display("        Expected: o_reg_w_bus = 32'h0000_0000\n");
      $display("        Actual:   o_reg_w_bus = %h\n", o_reg_w_bus);
      if (o_reg_w_bus != 32'h0000_0000) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      // i_cs = 1, i_r_neg_w = 1, & i_addr = 6'h30
      $display("    Test when i_cs=1, i_r_neg_w=1, & i_addr=6'h30");
      i_cs = 1'b1;
      tick;
      $display("        Expected: o_reg_w_bus = 32'h0000_0000\n");
      $display("        Actual:   o_reg_w_bus = %h\n", o_reg_w_bus);
      if (o_reg_w_bus != 32'h0000_0000) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      // i_cs = 0, i_r_neg_w = 0, & i_addr = 6'h30
      $display("    Test when i_cs=1, i_r_neg_w=0, & i_addr=6'h30");
      i_cs = 1'b0;
      i_r_neg_w = 1'b0;
      tick;
      $display("        Expected: o_reg_w_bus = 32'h0000_0000\n");
      $display("        Actual:   o_reg_w_bus = %h\n", o_reg_w_bus);
      if (o_reg_w_bus != 32'h0000_0000) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      // i_cs = 0, i_r_neg_w = 0, & i_addr = 6'h00
      $display("    Test when i_cs=0, i_r_neg_w=0, & i_addr=6'h00");
      i_addr = 6'h00;
      tick;
      $display("        Expected: o_reg_w_bus = 32'h0000_0000\n");
      $display("        Actual:   o_reg_w_bus = %h\n", o_reg_w_bus);
      if (o_reg_w_bus != 32'h0000_0000) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      // i_cs = 1, i_r_neg_w = 0, & i_addr = 6'h00
      $display("    Test when i_cs=1, i_r_neg_w=0 & i_addr=6'h00");
      i_cs = 1'b1;
      tick;
      $display("        Expected: o_reg_w_bus = 32'hAAAA_AAAA\n");
      $display("        Actual:   o_reg_w_bus = %h\n", o_reg_w_bus);
      if (o_reg_w_bus != 32'hAAAA_AAAA) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      assert(failed_sub_test_cases == 0)
        $display("    TEST CASE PASSED\n\n");
      else begin
        $display("    TEST CASE FAILED\n\n");
        failed_test_cases += 1;
      end
    
    // MCI_WR_TC_02
    // o_ack outputs the value input into i_reg_ack
    $display("-------------------- MCI_WR_TC_02 -------------------\n");
      failed_sub_test_cases = 0;
    
      // i_reg_ack = 0
      $display("    Test when i_reg_ack=0\n");
      i_reg_ack = 1'b0;
      #5;
      $display("        Expected: o_ack = 0");
      $display("        Actual:   o_ack = %b\n", o_ack);
      if (o_ack != 1'b0) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
    
      // i_reg_ack = 1
      $display("    Test when i_reg_ack=1\n");
      i_reg_ack = 1'b1;
      #5;
      $display("        Expected: o_ack = 1");
      $display("        Actual:   o_ack = %b\n", o_ack);
      if (o_ack != 1'b1) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      assert(failed_sub_test_cases == 0)
        $display("    TEST CASE PASSED\n\n");
      else begin
        $display("    TEST CASE FAILED\n\n");
        failed_test_cases += 1;
      end
    
    // MCI_WR_TC_03
    // o_r_neg_w outputs the value input into i_r_neg_w
    $display("-------------------- MCI_WR_TC_03 -------------------\n");
      failed_sub_test_cases = 0;
      
      // i_r_neg_w = 0
      $display("    Test when i_r_neg_w=0\n");
      i_r_neg_w = 1'b0;
      #5;
      $display("        Expected: o_r_neg_w = 1'b0\n");
      $display("        Actual:   o_r_neg_w = %b\n", o_r_neg_w);
      if (o_r_neg_w != 1'b0) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      // i_r_neg_w = 1
      $display("    Test when i_r_neg_w=1\n");
      i_r_neg_w = 1'b1;
      #5;
      $display("        Expected: o_r_neg_w = 1'b1\n");
      $display("        Actual:   o_r_neg_w = %b\n", o_r_neg_w);
      if (o_r_neg_w != 1'b1) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      assert(failed_sub_test_cases == 0)
        $display("    TEST CASE PASSED\n\n");
      else begin
        $display("    TEST CASE FAILED\n\n");
        failed_test_cases += 1;
      end
    
    // MCI_WR_TC_04
    // o_rs_vector at bit position 0 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x00,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_04 -------------------\n");
      failed_sub_test_cases = 0;
      i_reset = 1'b1;
      tick;
      i_reset = 1'b0;
      
      // i_cs = 0, i_r_neg_w = 1, and i_addr = 6'h30
      $display("    Test when i_cs=0, i_r_neg_w=1, and i_addr=6'h30\n");
      i_cs = 1'b0;
      i_r_neg_w = 1'b1;
      i_addr = 6'h30;
      tick;
      $display("        Expected: o_rs_vector[0] = 1'b0\n");
      $display("        Actual:   o_rs_vector[0] = %b\n", o_rs_vector[0]);
      if (o_rs_vector[0] != 1'b0) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      // i_cs = 1, i_r_neg_w = 1, and i_addr = 6'h30
      $display("    Test when i_cs=1, i_r_neg_w=1, and i_addr=6'h30\n");
      i_cs = 1'b1;
      tick;
      $display("        Expected: o_rs_vector[0] = 1'b0\n");
      $display("        Actual:   o_rs_vector[0] = %b\n", o_rs_vector[0]);
      if (o_rs_vector[0] != 1'b0) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      // i_cs = 0, i_r_neg_w = 0, and i_addr = 6'h30
      $display("    Test when i_cs=0, i_r_neg_w=0, and i_addr=6'h30\n");
      i_cs = 1'b0;
      i_r_neg_w = 1'b0;
      tick;
      $display("        Expected: o_rs_vector[0] = 1'b0\n");
      $display("        Actual:   o_rs_vector[0] = %b\n", o_rs_vector[0]);
      if (o_rs_vector[0] != 1'b0) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      // i_cs = 1, i_r_neg_w = 0 and i_addr = 6'h00
      $display("    Test when i_cs=0, i_r_neg_w=0, and i_addr=6'h00\n");
      i_cs = 1'b1;
      i_addr = 6'h00;
      tick;
      $display("        Expected: o_rs_vector[0] = 1'b0\n");
      $display("        Actual:   o_rs_vector[0] = %b\n", o_rs_vector[0]);
      if (o_rs_vector[0] != 1'b1) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      assert(failed_sub_test_cases == 0)
        $display("    TEST CASE PASSED\n\n");
      else begin
        $display("    TEST CASE FAILED\n\n");
        failed_test_cases += 1;
      end
    
    // MCI_WR_TC_05
    // o_rs_vector at bit position 1 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x01,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_05 -------------------\n");
      o_rs_vector_test_case (6'd1, 6'h01, 1'b0);
    
    // MCI_WR_TC_06
    // o_rs_vector at bit position 2 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x02,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_06 -------------------\n");
      o_rs_vector_test_case (6'd2, 6'h02, 1'b0);
    
    // MCI_WR_TC_07
    // o_rs_vector at bit position 3 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x03,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_07 -------------------\n");
      o_rs_vector_test_case (6'd3, 6'h03, 1'b0);
    
    // MCI_WR_TC_08
    // o_rs_vector at bit position 5 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x05,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_08 -------------------\n");
      o_rs_vector_test_case (6'd5, 6'h05, 1'b0);
    
    // MCI_WR_TC_09
    // o_rs_vector at bit position 9 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x09,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_09 -------------------\n");
      o_rs_vector_test_case (6'd8, 6'h08, 1'b0);
    
    // MCI_WR_TC_10
    // o_rs_vector at bit position 9 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x09,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_10 -------------------\n");
      o_rs_vector_test_case (6'd9, 6'h09, 1'b0);
    
    // MCI_WR_TC_11
    // o_rs_vector at bit position 10 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x0A,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_11 -------------------\n");
      o_rs_vector_test_case (6'd10, 6'h0A, 1'b0);
    
    // MCI_WR_TC_12
    // o_rs_vector at bit position 11 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x0B,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_12 -------------------\n");
      o_rs_vector_test_case (6'd11, 6'h0B, 1'b0);
    
    // MCI_WR_TC_13
    // o_rs_vector at bit position 12 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x0C,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_13 -------------------\n");
      o_rs_vector_test_case (6'd12, 6'h0C, 1'b0);
    
    // MCI_WR_TC_14
    // o_rs_vector at bit position 13 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x0D,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_14 -------------------\n");
      o_rs_vector_test_case (6'd13, 6'h0D, 1'b0);
    
    // MCI_WR_TC_15
    // o_rs_vector at bit position 14 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x0E,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_15 -------------------\n");
      o_rs_vector_test_case (6'd14, 6'h0E, 1'b0);
    
    // MCI_WR_TC_16
    // o_rs_vector at bit position 15 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x0F,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_16 -------------------\n");
      o_rs_vector_test_case (6'd15, 6'h0F, 1'b0);
    
    // MCI_WR_TC_17
    // o_rs_vector at bit position 16 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x10,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_17 -------------------\n");
      o_rs_vector_test_case (6'd16, 6'h10, 1'b0);
    
    // MCI_WR_TC_18
    // o_rs_vector at bit position 17 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x11,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_18 -------------------\n");
      o_rs_vector_test_case (6'd17, 6'h11, 1'b0);
    
    // MCI_WR_TC_19
    // o_rs_vector at bit position 22 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x18,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_19 -------------------\n");
      o_rs_vector_test_case (6'd22, 6'h18, 1'b0);
    
    // MCI_WR_TC_20
    // o_rs_vector at bit position 23 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x19,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_20 -------------------\n");
      o_rs_vector_test_case (6'd23, 6'h19, 1'b0);
    
    // MCI_WR_TC_21
    // o_rs_vector at bit position 24 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x1A,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_21 -------------------\n");
      o_rs_vector_test_case (6'd24, 6'h1A, 1'b0);
    
    // MCI_WR_TC_22
    // o_rs_vector at bit position 25 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x1B,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_22 -------------------\n");
      o_rs_vector_test_case (6'd25, 6'h1B, 1'b0);
    
    // MCI_WR_TC_23
    // o_rs_vector at bit position 26 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x1C,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_23 -------------------\n");
      o_rs_vector_test_case (6'd26, 6'h1C, 1'b0);
    
    // MCI_WR_TC_24
    // o_rs_vector at bit position 27 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x1D,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_24 -------------------\n");
      o_rs_vector_test_case (6'd27, 6'h1D, 1'b0);
    
    // MCI_WR_TC_25
    // o_rs_vector at bit position 28 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x1E,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_25 -------------------\n");
      o_rs_vector_test_case (6'd28, 6'h1E, 1'b0);
    
    // MCI_WR_TC_26
    // o_rs_vector at bit position 29 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x1F,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_26 -------------------\n");
      o_rs_vector_test_case (6'd29, 6'h1F, 1'b0);

    // MCI_WR_TC_27
    // o_rs_vector at bit position 30 is set to 1 for one clock cycle if i_sys_clk
    // transitions from 0 to 1 when i_cs is 1, i_r_neg_w is 0, and addr is 0x20,
    // else it is set to 0
    $display("-------------------- MCI_WR_TC_27 -------------------\n");
      o_rs_vector_test_case (6'd30, 6'h20, 1'b0);
    
    // MCI_ER_TC_01
    // o_error outputs the value at i_reg_error
    $display("-------------------- MCI_ER_TC_01 -------------------\n");
      failed_sub_test_cases = 0;
      
      // i_reg_error = 0
      $display("    Test when i_reg_error=0\n");
      i_reg_error = 1'b0;
      #5;
      $display("        Expected: o_error = 1'b0\n");
      $display("        Actual:   o_error = %b\n", o_error);
      if (o_error != 1'b0) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      // i_reg_error = 1
      $display("    Test when i_reg_error=1\n");
      i_reg_error = 1'b1;
      #5;
      $display("        Expected: o_error = 1'b1\n");
      $display("        Actual:   o_error = %b\n", o_error);
      if (o_error != 1'b1) begin
        failed_sub_test_cases += 1;
        $display("        FAIL\n\n");
      end else $display("        PASS\n\n");
      
      assert(failed_sub_test_cases == 0)
        $display("    TEST CASE PASSED\n\n");
      else begin
        $display("    TEST CASE FAILED\n\n");
        failed_test_cases += 1;
      end
    
    $display("-------------------- PASS/FAIL TOTAL --------------------\n");
      $display("Total test cases passed: %d\n", (TOTAL_TEST_CASES - failed_test_cases));
      $display("Total test cases failed: %d\n", failed_test_cases);
      
    $finish;
    
  end
  
  // Executes one clock cycle when called
  task tick;
  begin
    #5; i_sys_clk = 1'b1;
    #5; i_sys_clk = 1'b0;
  end
  endtask
  
  // Generic way of testing o_rs_vector at each bit position
  task o_rs_vector_test_case (
    input bit [5:0] bit_position,
    input bit [5:0] i_addr_value,
    input bit i_r_neg_w_value
  );
  begin
    failed_sub_test_cases = 0;
    i_reset = 1'b1;
    tick;
    i_reset = 1'b0;
      
    // i_cs = 0, i_r_neg_w = ~i_r_neg_w_value, and i_addr = 6'h00
    $display("    Test when i_cs=0, i_r_neg_w=%b, and i_addr=6'h00\n", ~i_r_neg_w_value);
    i_cs = 1'b0;
    i_r_neg_w = ~i_r_neg_w_value;
    i_addr = 6'h00;
    tick;
    $display("        Expected: o_rs_vector[%d] = 1'b0\n", bit_position);
    $display("        Actual:   o_rs_vector[%d] = %b\n", bit_position, o_rs_vector[bit_position]);
    if (o_rs_vector[bit_position] != 1'b0) begin
      failed_sub_test_cases += 1;
      $display("        FAIL\n\n");
    end else $display("        PASS\n\n");
      
    // i_cs = 1, i_r_neg_w = ~i_r_neg_w_value, and i_addr = 6'h00
    $display("    Test when i_cs=1, i_r_neg_w=%b, and i_addr=6'h00\n", ~i_r_neg_w_value);
    i_cs = 1'b1;
    tick;
    $display("        Expected: o_rs_vector[%d] = 1'b0\n", bit_position);
    $display("        Actual:   o_rs_vector[%d] = %b\n", bit_position, o_rs_vector[bit_position]);
    if (o_rs_vector[bit_position] != 1'b0) begin
      failed_sub_test_cases += 1;
      $display("        FAIL\n\n");
    end else $display("        PASS\n\n");
      
    // i_cs = 0, i_r_neg_w = i_r_neg_w_value, and i_addr = 6'h00
    $display("    Test when i_cs=0, i_r_neg_w=%b, and i_addr=6'h00\n", i_r_neg_w_value);
    i_cs = 1'b0;
    i_r_neg_w = i_r_neg_w_value;
    tick;
    $display("        Expected: o_rs_vector[%d] = 1'b0\n", bit_position);
    $display("        Actual:   o_rs_vector[%d] = %b\n", bit_position, o_rs_vector[bit_position]);
    if (o_rs_vector[bit_position] != 1'b0) begin
      failed_sub_test_cases += 1;
      $display("        FAIL\n\n");
    end else $display("        PASS\n\n");
      
    // i_cs = 1, i_r_neg_w = i_r_neg_w_value, and i_addr = i_addr_value
    $display("    Test when i_cs=1, i_r_neg_w=%b, and i_addr=%h\n", i_r_neg_w_value, i_addr_value);
    i_cs = 1'b1;
    i_addr = i_addr_value;
    tick;
    $display("        Expected: o_rs_vector[%d] = 1'b1\n", bit_position);
    $display("        Actual:   o_rs_vector[%d] = %b\n", bit_position, o_rs_vector[bit_position]);
    if (o_rs_vector[bit_position] != 1'b1) begin
      failed_sub_test_cases += 1;
      $display("        FAIL\n\n");
    end else $display("        PASS\n\n");
      
    assert(failed_sub_test_cases == 0)
      $display("    TEST CASE PASSED\n\n");
    else begin
      $display("    TEST CASE FAILED\n\n");
      failed_test_cases += 1;
    end
  end
  endtask
  
endmodule
