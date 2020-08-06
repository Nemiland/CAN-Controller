/*--------------------------------------------------------------
  Project: CAN Controller
  Module: can_BSP
  Author: Waseem Orphali
  Date: 08/03/2020
  Module Description: A testbench for the bit stream processor
----------------------------------------------------------------*/

module can_bsp_tb;

    logic           i_sleep = 1'b0;
    logic           i_lback = 1'b0;
    logic           i_reset = 1'b1;
    logic   [0:127] i_send_data = 128'b0;
    logic           i_send_en = 1'b0;
    logic           i_can_clk = 1'b0;
    logic           i_cen = 1'b1;
    logic           o_busy_can;
    logic           o_acker;
    logic           o_berr;
    logic           o_ster;
    logic           o_fmer;
    logic           o_crcer;
    logic           o_can_ready;
    logic   [0:127] o_rx_message;
    logic   [7:0]   o_rec;
    logic   [7:0]   o_tec;
    logic           o_errwrn;
    logic           o_bbsy;
    logic           o_bidle;
    logic           o_normal;
    logic           o_sleep;
    logic           o_tx_bit;
    logic           i_samp_tick = 1'b0;
    logic           i_rx_bit = 1'b1;
    logic           o_lback;
    logic           o_config;
    logic           o_wakeup;
    logic           o_bsoff;
    logic           o_error;
    logic           o_txok;
    logic           o_arblst;
    logic   [1:0]   o_estat;
    
    logic   [1:0]   temp;
    
    can_bsp can_bsp (.*);
    
    
    always
        #2 i_can_clk = !i_can_clk;
        
    always
    begin
        #28 i_samp_tick = !i_samp_tick;
        #4 i_samp_tick = !i_samp_tick;
    end
    
    initial
    begin
    
        i_sleep = 1'b0;
        i_lback = 1'b0;
        i_reset = 1'b1;
        i_send_en = 1'b0;
        i_cen = 1'b1;
        i_rx_bit = 1'b1;
        
    //====================== BSP_INT_01_01 => BSP_INT_01_24 ===========================//
        
        assert (o_busy_can == 1'b0)                 $display ("Test Case BSP_INT_01_01 passed");
        else                                        $error ("Test Case BSP_INT_01_01 failed");
        
        assert (o_tx_bit == 1'b1)                   $display ("Test Case BSP_INT_01_02 passed");
        else                                        $error ("Test Case BSP_INT_01_02 failed");
        
        assert (o_rec == 8'h0)                      $display ("Test Case BSP_INT_01_03 passed");
        else                                        $error ("Test Case BSP_INT_01_03 failed");
        
        assert (o_tec == 8'h0)                      $display ("Test Case BSP_INT_01_04 passed");
        else                                        $error ("Test Case BSP_INT_01_04 failed");
        
        assert (o_acker == 1'b0)                    $display ("Test Case BSP_INT_01_05 passed");
        else                                        $error ("Test Case BSP_INT_01_05 failed");
        
        assert (o_berr == 1'b0)                     $display ("Test Case BSP_INT_01_06 passed");
        else                                        $error ("Test Case BSP_INT_01_06 failed");
        
        assert (o_ster == 1'b0)                     $display ("Test Case BSP_INT_01_07 passed");
        else                                        $error ("Test Case BSP_INT_01_07 failed");
        
        assert (o_fmer == 1'b0)                     $display ("Test Case BSP_INT_01_08 passed");
        else                                        $error ("Test Case BSP_INT_01_08 failed");
        
        assert (o_crcer == 1'b0)                    $display ("Test Case BSP_INT_01_09 passed");
        else                                        $error ("Test Case BSP_INT_01_09 failed");
        
        assert (o_estat == 2'b10)                   $display ("Test Case BSP_INT_01_10 passed");
        else                                        $error ("Test Case BSP_INT_01_10 failed");
        
        assert (o_bbsy == 1'b0)                     $display ("Test Case BSP_INT_01_11 passed");
        else                                        $error ("Test Case BSP_INT_01_11 failed");
        
        assert (o_bidle == 1'b0)                    $display ("Test Case BSP_INT_01_12 passed");
        else                                        $error ("Test Case BSP_INT_01_12 failed");
        
        assert (o_normal == 1'b0)                   $display ("Test Case BSP_INT_01_13 passed");
        else                                        $error ("Test Case BSP_INT_01_13 failed");
        
        assert (o_config == 1'b0)                   $display ("Test Case BSP_INT_01_14 passed");
        else                                        $error ("Test Case BSP_INT_01_14 failed");
        
        assert (o_txok == 1'b0)                     $display ("Test Case BSP_INT_01_15 passed");
        else                                        $error ("Test Case BSP_INT_01_15 failed");
        
        assert (o_arblst == 1'b0)                   $display ("Test Case BSP_INT_01_16 passed");
        else                                        $error ("Test Case BSP_INT_01_16 failed");
        
        assert (o_error == 1'b0)                    $display ("Test Case BSP_INT_01_17 passed");
        else                                        $error ("Test Case BSP_INT_01_17 failed");
        
        assert (o_bsoff == 1'b1)                    $display ("Test Case BSP_INT_01_18 passed");
        else                                        $error ("Test Case BSP_INT_01_18 failed");
        
        assert (o_sleep == 1'b1)                    $display ("Test Case BSP_INT_01_19 passed");
        else                                        $error ("Test Case BSP_INT_01_19 failed");
        
        assert (o_lback == 1'b0)                    $display ("Test Case BSP_INT_01_20 passed");
        else                                        $error ("Test Case BSP_INT_01_20 failed");
        
        assert (o_wakeup == 1'b0)                   $display ("Test Case BSP_INT_01_21 passed");
        else                                        $error ("Test Case BSP_INT_01_21 failed");
        
        assert (o_can_ready == 1'b0)                $display ("Test Case BSP_INT_01_22 passed");
        else                                        $error ("Test Case BSP_INT_01_22 failed");
        
        assert (can_bsp.int_mstate == can_bsp.MSLEEP)       $display ("Test Case BSP_INT_01_23 passed");
        else                                                $error ("Test Case BSP_INT_01_23 failed");
        
        assert (can_bsp.int_mstate_next == can_bsp.MSLEEP)  $display ("Test Case BSP_INT_01_24 passed");
        else                                                $error ("Test Case BSP_INT_01_24 failed");
        
    
    //--------------------------------------------------------------------------------//
    //====================== BSP_RST_01_01 => BSP_24_01_24 ===========================//
        
        i_reset = 1'b0;
        @(negedge i_can_clk);
        i_reset = 1'b1;
        @(posedge i_can_clk);
        
        assert (o_busy_can == 1'b0)                 $display ("Test Case BSP_RST_01_01 passed");
        else                                        $error ("Test Case BSP_RST_01_01 failed");
        
        assert (o_tx_bit == 1'b1)                   $display ("Test Case BSP_RST_01_02 passed");
        else                                        $error ("Test Case BSP_RST_01_02 failed");
        
        assert (o_rec == 8'h0)                      $display ("Test Case BSP_RST_01_03 passed");
        else                                        $error ("Test Case BSP_RST_01_03 failed");
                                                                             
        assert (o_tec == 8'h0)                      $display ("Test Case BSP_RST_01_04 passed");
        else                                        $error ("Test Case BSP_RST_01_04 failed");
                                                                             
        assert (o_acker == 1'b0)                    $display ("Test Case BSP_RST_01_05 passed");
        else                                        $error ("Test Case BSP_RST_01_05 failed");
                                                                             
        assert (o_berr == 1'b0)                     $display ("Test Case BSP_RST_01_06 passed");
        else                                        $error ("Test Case BSP_RST_01_06 failed");
                                                                             
        assert (o_ster == 1'b0)                     $display ("Test Case BSP_RST_01_07 passed");
        else                                        $error ("Test Case BSP_RST_01_07 failed");
                                                                             
        assert (o_fmer == 1'b0)                     $display ("Test Case BSP_RST_01_08 passed");
        else                                        $error ("Test Case BSP_RST_01_08 failed");
                                                                             
        assert (o_crcer == 1'b0)                    $display ("Test Case BSP_RST_01_09 passed");
        else                                        $error ("Test Case BSP_RST_01_09 failed");
                                                                             
        assert (o_estat == 2'b10)                   $display ("Test Case BSP_RST_01_10 passed");
        else                                        $error ("Test Case BSP_RST_01_10 failed");
                                                                             
        assert (o_bbsy == 1'b0)                     $display ("Test Case BSP_RST_01_11 passed");
        else                                        $error ("Test Case BSP_RST_01_11 failed");
                                                                             
        assert (o_bidle == 1'b0)                    $display ("Test Case BSP_RST_01_12 passed");
        else                                        $error ("Test Case BSP_RST_01_12 failed");
                                                                             
        assert (o_normal == 1'b0)                   $display ("Test Case BSP_RST_01_13 passed");
        else                                        $error ("Test Case BSP_RST_01_13 failed");
                                                                             
        assert (o_config == 1'b0)                   $display ("Test Case BSP_RST_01_14 passed");
        else                                        $error ("Test Case BSP_RST_01_14 failed");
                                                                             
        assert (o_txok == 1'b0)                     $display ("Test Case BSP_RST_01_15 passed");
        else                                        $error ("Test Case BSP_RST_01_15 failed");
                                                                             
        assert (o_arblst == 1'b0)                   $display ("Test Case BSP_RST_01_16 passed");
        else                                        $error ("Test Case BSP_RST_01_16 failed");
                                                                             
        assert (o_error == 1'b0)                    $display ("Test Case BSP_RST_01_17 passed");
        else                                        $error ("Test Case BSP_RST_01_17 failed");
                                                                             
        assert (o_bsoff == 1'b1)                    $display ("Test Case BSP_RST_01_18 passed");
        else                                        $error ("Test Case BSP_RST_01_18 failed");
                                                                             
        assert (o_sleep == 1'b1)                    $display ("Test Case BSP_RST_01_19 passed");
        else                                        $error ("Test Case BSP_RST_01_19 failed");
                                                                             
        assert (o_lback == 1'b0)                    $display ("Test Case BSP_RST_01_20 passed");
        else                                        $error ("Test Case BSP_RST_01_20 failed");
                                                                             
        assert (o_wakeup == 1'b0)                   $display ("Test Case BSP_RST_01_21 passed");
        else                                        $error ("Test Case BSP_RST_01_21 failed");
                                                                             
        assert (o_can_ready == 1'b0)                $display ("Test Case BSP_RST_01_22 passed");
        else                                        $error ("Test Case BSP_RST_01_22 failed");
                                                                             
        assert (can_bsp.int_mstate == can_bsp.MSLEEP)        $display ("Test Case BSP_RST_01_23 passed");
        else                                                 $error ("Test Case BSP_RST_01_23 failed");
                                                                             
        assert (can_bsp.int_mstate_next == can_bsp.MSLEEP)   $display ("Test Case BSP_RST_01_24 passed");
        else                                                 $error ("Test Case BSP_RST_01_24 failed");

    //--------------------------------------------------------------------------------//
    //============================== BSP_MFSM_01_01 ==================================//
        
        @(negedge i_can_clk);
        i_reset = 1'b0;
        @(posedge i_can_clk);
        temp = can_bsp.int_mstate_next;
        #1;
        assert (can_bsp.int_mstate == temp)
        $display ("Test Case BSP_MFSM_01_01 Passed");
        else
        $error ("Test Case BSP_MFSM_01_01 Failed");
    
    //--------------------------------------------------------------------------------//
    //============================== BSP_MFSM_02_01 ==================================//
        
        @(negedge i_can_clk);
        i_cen = 1'b0;
        @(posedge i_can_clk);
        #1;
        assert (can_bsp.int_mstate_next == can_bsp.MCONFIG)
        $display ("Test Case BSP_MFSM_02_01 Passed");
        else
        $error ("Test Case BSP_MFSM_02_01 Failed");
        
    //--------------------------------------------------------------------------------//
    //============================== BSP_MFSM_03_01 ==================================//
    
        @(negedge i_can_clk);
        i_cen = 1'b1;
        i_lback = 1'b1;
        @(posedge i_can_clk)
        #1;
        assert (can_bsp.int_mstate_next == can_bsp.MLOOPBACK)
        $display ("Test Case BSP_MFSM_03_01 Passed");
        else
        $error ("Test Case BSP_MFSM_03_01 Failed");
    
    //--------------------------------------------------------------------------------//
    //============================== BSP_MFSM_04_01 ==================================//
    
        @(negedge i_can_clk);
        i_cen = 1'b1;
        i_lback = 1'b0;
        i_sleep = 1'b1;
        @(posedge i_can_clk)
        #1;
        assert (can_bsp.int_mstate_next == can_bsp.MSLEEP)
        $display ("Test Case BSP_MFSM_04_01 Passed");
        else
        $error ("Test Case BSP_MFSM_04_01 Failed");
    
    //--------------------------------------------------------------------------------//
    //============================== BSP_MFSM_05_01 ==================================//
    
        @(negedge i_can_clk);
        i_cen = 1'b1;
        i_lback = 1'b0;
        i_sleep = 1'b0;
        @(posedge i_can_clk)
        #1;
        assert (can_bsp.int_mstate_next == can_bsp.MNORMAL)
        $display ("Test Case BSP_MFSM_05_01 Passed");
        else
        $error ("Test Case BSP_MFSM_05_01 Failed");
    
    //--------------------------------------------------------------------------------//
    //============================== BSP_TFSM_01_01 ==================================//
    
        @(negedge i_can_clk);
        @(posedge i_can_clk);
        #1;
        assert (can_bsp.int_tstate == can_bsp.int_tstate_next)
        $display ("Test Case BSP_TFSM_01_01 Passed");
        else
        $error ("Test Case BSP_TFSM_01_01 Failed");
        
    //--------------------------------------------------------------------------------//
    //============================== BSP_TFSM_02_01 ==================================//
    
        i_rx_bit = 1'b0;
        i_send_en = 1'b1;
        wait (can_bsp.int_tstate == can_bsp.BUSY);
        i_send_en = 1'b0;
        wait (can_bsp.int_txbit_history == 8'hff && i_samp_tick);
        assert (can_bsp.int_tstate_next == can_bsp.IFS)
        $display ("Test Case BSP_TFSM_02_01 Passed");
        else
        $error ("Test Case BSP_TFSM_02_01 Failed");
        
    //--------------------------------------------------------------------------------//
    //============================== BSP_TFSM_03_01 ==================================//
        
        wait (can_bsp.int_tstate == can_bsp.IFS)
        #50;
        i_send_en = 1'b1;
        wait (i_samp_tick && can_bsp.int_txbit_history[2:0] == 3'b111 && can_bsp.int_tstate == can_bsp.IFS);
        assert (can_bsp.int_tstate_next == can_bsp.BUSY)
        $display ("Test Case BSP_TFSM_03_01 Passed");
        else
        $error ("Test Case BSP_TFSM_03_01 Failed");
        wait (can_bsp.int_tstate == can_bsp.BUSY);
        i_send_en = 1'b0;
    
    //--------------------------------------------------------------------------------//
    //============================== BSP_TFSM_04_01 ==================================//
        
//        wait (
//        i_send_en = 1'b1;
//        wait (i_samp_tick && can_bsp.int_txbit_history[3:0] == 4'b1110 && can_bsp.int_tstate == can_bsp.IFS);
        
    
    
    
    
    
    
    
    
    
    
    
    end
endmodule