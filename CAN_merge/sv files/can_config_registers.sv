/*-------------------------------------------
  Project: CAN Controller
  Module: can_config_registers
  Author: Antonio Jimenez
  Date: 7/31/2020
  Module Description: Configuration registers that hold the statuses and configuration of
                      the CAN controller
-------------------------------------------*/

module can_config_registers(
  input  logic i_sys_clk,
  input  logic i_reset,
  input  logic [31:0] i_reg_w_bus,
  input  logic [30:0] i_rs_vector,
  input  logic i_r_neg_w,
  output logic [31:0] o_reg_r_data,
  output logic o_reg_ack,
  output logic o_reg_error,
  output logic o_interrupt,
  output logic o_soft_reset,
  output logic o_cen,
  input  logic [127:0] i_rx_fifo_data,
  input  logic i_tx_full,
  input  logic i_rx_empty,
  output logic [127:0] o_tx_fifo_data,
  output logic o_tx_w_en,
  output logic [127:0] o_hpb_data,
  input  logic i_hpb_r_en,
  output logic o_hpb_full,
  input  logic i_acker,
  input  logic i_berr,
  input  logic i_ster,
  input  logic i_fmer,
  input  logic i_crcer,
  input  logic i_acfbsy,
  output logic o_lback,
  output logic o_sleep,
  input  logic [1:0] i_estat,
  input  logic i_errwrn,
  input  logic i_bbsy,
  input  logic i_bidle,
  input  logic i_normal,
  input  logic i_sleep,
  input  logic i_lback,
  input  logic i_config,
  input  logic i_wakeup,
  input  logic i_bsoff,
  input  logic i_error,
  input  logic i_txok,
  input  logic i_arblst,
  input  logic i_rxnemp,
  input  logic i_rxoflw,
  input  logic i_rxuflw,
  input  logic i_rxok,
  output logic [1:0] o_sjw,
  output logic [2:0] o_ts2,
  output logic [3:0] o_ts1,
  input  logic [7:0] i_rec,
  input  logic [7:0] i_tec,
  output logic o_rx_r_en,
  output logic o_uaf1,
  output logic o_uaf2,
  output logic o_uaf3,
  output logic o_uaf4,
  output logic [31:0] o_afmr1,
  output logic [31:0] o_afmr2,
  output logic [31:0] o_afmr3,
  output logic [31:0] o_afmr4,
  output logic [31:0] o_afir1,
  output logic [31:0] o_afir2,
  output logic [31:0] o_afir3,
  output logic [31:0] o_afir4
);

  localparam SRR_RS     = 31'h0000_0001;
  localparam MSR_RS     = 31'h0000_0002;
  localparam BRPR_RS    = 31'h0000_0004;
  localparam BTR_RS     = 31'h0000_0008;
  localparam ECR_RS     = 31'h0000_0010;
  localparam ESR_RS     = 31'h0000_0020;
  localparam SR_RS      = 31'h0000_0040;
  localparam ISR_RS     = 31'h0000_0080;
  localparam IER_RS     = 31'h0000_0100;
  localparam ICR_RS     = 31'h0000_0200;
  localparam TX_ID_RS   = 31'h0000_0400;
  localparam TX_DLC_RS  = 31'h0000_0800;
  localparam TX_DW1_RS  = 31'h0000_1000;
  localparam TX_DW2_RS  = 31'h0000_2000;
  localparam HPB_ID_RS  = 31'h0000_4000;
  localparam HPB_DLC_RS = 31'h0000_8000;
  localparam HPB_DW1_RS = 31'h0001_0000;
  localparam HPB_DW2_RS = 31'h0002_0000;
  localparam RX_ID_RS   = 31'h0004_0000;
  localparam RX_DLC_RS  = 31'h0008_0000;
  localparam RX_DW1_RS  = 31'h0010_0000;
  localparam RX_DW2_RS  = 31'h0020_0000;
  localparam AFR_RS     = 31'h0040_0000;
  localparam AFIR1_RS   = 31'h0080_0000;
  localparam AFIR2_RS   = 31'h0100_0000;
  localparam AFIR3_RS   = 31'h0200_0000;
  localparam AFIR4_RS   = 31'h0400_0000;
  localparam AFMR1_RS   = 31'h0800_0000;
  localparam AFMR2_RS   = 31'h1000_0000;
  localparam AFMR3_RS   = 31'h2000_0000;
  localparam AFMR4_RS   = 31'h4000_0000;

  logic [31:0] config_reg [0:30];
  
  logic pulse_o_reg_ack;
  logic pulse_o_reg_error;
  logic [31:0] enabled_interrupts;
  logic pulse_o_tx_w_en;
  logic rx_message_reg_init;
  
  // Deals with the read and write logic of configuration registers
  always_ff @(posedge i_sys_clk, posedge i_reset)
  begin: r_w_logic
    if (i_reset) begin
      config_reg[0:5] <= '{default:32'b0};
      config_reg[6]   <= 32'b1000_0000_0000_0000_0000_0000_0000_0000;
      config_reg[8:22]  <= '{default:32'b0};
      o_reg_r_data <= 32'h0000_0000;
      pulse_o_reg_ack <= 1'b0;
      pulse_o_reg_error <= 1'b0;
      pulse_o_tx_w_en <= 1'b0;
      
    end else if (i_r_neg_w == 1'b0) begin
      o_reg_r_data <= 32'h0000_0000;
      
      if (i_rs_vector == 32'h0000_0000) begin
        pulse_o_reg_ack <= 1'b0;
        pulse_o_reg_error <= 1'b0;
        pulse_o_tx_w_en <= 1'b0;
      
      end else begin
        pulse_o_reg_ack <= 1'b1;
        
        if (i_rs_vector == SRR_RS) begin
          config_reg[0] <= i_reg_w_bus;
        
        end else if (i_rs_vector == MSR_RS) begin
          config_reg[1] <= i_reg_w_bus;

        end else if (i_rs_vector == BRPR_RS) begin
          config_reg[2] <= i_reg_w_bus;
        
        end else if (i_rs_vector == BTR_RS) begin
          config_reg[3] <= i_reg_w_bus;
        
        end else if (i_rs_vector == ESR_RS) begin
          // Clears ESR bit position when 1 is written to that bit position
          config_reg[5] <= (config_reg[5] ^ i_reg_w_bus) & config_reg[5];
        
        end else if (i_rs_vector == IER_RS) begin
          config_reg[8] <= i_reg_w_bus;
        
        end else if (i_rs_vector == ICR_RS) begin
          // Clears ISR bit position when 1 is written to ICR in corresponding bit position
          config_reg[7] <= (config_reg[7] ^ i_reg_w_bus) & config_reg[7];
        
        end else if (i_rs_vector == TX_ID_RS) begin
          config_reg[10] <= i_reg_w_bus;
        
        end else if (i_rs_vector == TX_DLC_RS) begin
          config_reg[11] <= i_reg_w_bus;
        
        end else if (i_rs_vector == TX_DW1_RS) begin
          config_reg[12] <= i_reg_w_bus;
        
        end else if (i_rs_vector == TX_DW2_RS) begin
          config_reg[13] <= i_reg_w_bus;
          pulse_o_tx_w_en <= 1'b1;
        
        end else if (i_rs_vector == HPB_ID_RS) begin
          config_reg[14] <= i_reg_w_bus;
        
        end else if (i_rs_vector == HPB_DLC_RS) begin
          config_reg[15] <= i_reg_w_bus;
        
        end else if (i_rs_vector == HPB_DW1_RS) begin
          config_reg[16] <= i_reg_w_bus;
        
        end else if (i_rs_vector == HPB_DW2_RS) begin
          config_reg[17] <= i_reg_w_bus;
        
        end else if (i_rs_vector == AFR_RS) begin
          config_reg[22] <= i_reg_w_bus;
        
        end else if (i_rs_vector == AFMR1_RS) begin
          config_reg[23] <= i_reg_w_bus;
        
        end else if (i_rs_vector == AFIR1_RS) begin
          config_reg[24] <= i_reg_w_bus;
        
        end else if (i_rs_vector == AFMR2_RS) begin
          config_reg[25] <= i_reg_w_bus;
        
        end else if (i_rs_vector == AFIR2_RS) begin
          config_reg[26] <= i_reg_w_bus;
        
        end else if (i_rs_vector == AFMR3_RS) begin
          config_reg[27] <= i_reg_w_bus;
        
        end else if (i_rs_vector == AFIR3_RS) begin
          config_reg[28] <= i_reg_w_bus;
        
        end else if (i_rs_vector == AFMR4_RS) begin
          config_reg[29] <= i_reg_w_bus;
        
        end else if (i_rs_vector == AFIR4_RS) begin
          config_reg[30] <= i_reg_w_bus;
        
        end else begin
          pulse_o_reg_error <= 1'b1;
        
        end
      end
    end
    else begin // i_r_neg_w = 1
      if (i_rs_vector == 32'h0000_0000) begin
        pulse_o_reg_ack   <= 1'b0;
        pulse_o_reg_error <= 1'b0;
        pulse_o_tx_w_en <= 1'b0;
      
      end else begin
        pulse_o_reg_ack <= 1'b1;
        
        if (i_rs_vector == SRR_RS) begin
          o_reg_r_data <= config_reg[0];
        
        end else if (i_rs_vector == MSR_RS) begin
          o_reg_r_data <= config_reg[1];
        
        end else if (i_rs_vector == BRPR_RS) begin
          o_reg_r_data <= config_reg[2];
        
        end else if (i_rs_vector == BTR_RS) begin
          o_reg_r_data <= config_reg[3];
        
        end else if (i_rs_vector == ECR_RS) begin
          o_reg_r_data <= config_reg[4];
        
        end else if (i_rs_vector == ESR_RS) begin
          o_reg_r_data <= config_reg[5];
        
        end else if (i_rs_vector == SR_RS) begin
          o_reg_r_data <= config_reg[6];
        
        end else if (i_rs_vector == ISR_RS) begin
          o_reg_r_data <= config_reg[7];
        
        end else if (i_rs_vector == IER_RS) begin
          o_reg_r_data <= config_reg[8];
        
        end else if (i_rs_vector == RX_ID_RS) begin
          o_reg_r_data <= config_reg[18];
        
        end else if (i_rs_vector == RX_DLC_RS) begin
          o_reg_r_data <= config_reg[19];
        
        end else if (i_rs_vector == RX_DW1_RS) begin
          o_reg_r_data <= config_reg[20];
        
        end else if (i_rs_vector == RX_DW2_RS) begin
          o_reg_r_data <= config_reg[21];
        
        end else if (i_rs_vector == AFR_RS) begin
          o_reg_r_data <= config_reg[22];
        
        end else if (i_rs_vector == AFMR1_RS) begin
          o_reg_r_data <= config_reg[23];
        
        end else if (i_rs_vector == AFIR1_RS) begin
          o_reg_r_data <= config_reg[24];
        
        end else if (i_rs_vector == AFMR2_RS) begin
          o_reg_r_data <= config_reg[25];
        
        end else if (i_rs_vector == AFIR2_RS) begin
          o_reg_r_data <= config_reg[26];
        
        end else if (i_rs_vector == AFMR3_RS) begin
          o_reg_r_data <= config_reg[27];
        
        end else if (i_rs_vector == AFIR3_RS) begin
          o_reg_r_data <= config_reg[28];
        
        end else if (i_rs_vector == AFMR4_RS) begin
          o_reg_r_data <= config_reg[29];
        
        end else if (i_rs_vector == AFIR4_RS) begin
          o_reg_r_data <= config_reg[30];
        
        end else begin
          pulse_o_reg_error <= 1'b1;
          o_reg_r_data <= 32'h0000_0000;
          
        end     
      end
    end
  end
  
  // Deals with the register acknowledge logic
  always_ff @(posedge i_sys_clk, posedge i_reset)
  begin: reg_ack_logic
    if (i_reset) begin
      o_reg_ack <= 1'b0;
    
    end else begin
      if (pulse_o_reg_ack) begin
        o_reg_ack <= 1'b1;
      
      end else begin
        o_reg_ack <= 1'b0;
      
      end
    end
  end
  
  // Deals with register error logic
  always_ff @(posedge i_sys_clk, posedge i_reset)
  begin: reg_error_logic
    if (i_reset) begin
      o_reg_error <= 1'b0;
    
    end else begin
      if (pulse_o_reg_error) begin
        o_reg_error <= 1'b1;
      
      end else begin
        o_reg_error <= 1'b0;
      
      end
    end
  end
  
  // Software Reset Logic
  always_ff @(posedge i_sys_clk)
  begin
    o_soft_reset <= (config_reg[0][31] == 1'b1) ? 1'b1 : 1'b0;

  end
  
  assign o_cen = config_reg[0][30];
  
  // Mode Select Register Output
  assign o_lback = config_reg[1][30];
  assign o_sleep = config_reg[1][31];
  
  // Bit Timing Register Output
  assign o_sjw = config_reg[3][24:23];
  assign o_ts2 = config_reg[3][27:25];
  assign o_ts1 = config_reg[3][31:28];
  
  // Error Count Register Input
  always_ff @(posedge i_sys_clk)
  begin
    config_reg[4] <= {i_tec, i_rec, 16'b0};
  
  end
  
  // Error Status Register Input
  always_ff @(posedge i_sys_clk)
  begin
    config_reg[5] <= {i_crcer, i_fmer, i_ster, i_berr, i_acker, 27'b0};
  
  end
  
  // Status Register Input
  always_ff @(posedge i_sys_clk)
  begin
    config_reg[6] <= {i_config, i_lback, i_sleep, i_normal, i_bidle, i_bbsy, i_errwrn, i_estat, o_hpb_full, i_tx_full, i_acfbsy, 20'b0};
    
  end
  
  // Interrupt Status Register Input
  always_ff @(posedge i_sys_clk, posedge i_reset)
  begin
    if (i_reset) begin
      config_reg[7] <= 32'h0000_0000;
    
    end else if (i_rs_vector != ISR_RS) begin
      config_reg[7] <= ({i_arblst, i_txok, i_tx_full, o_hpb_full, i_rxok, i_rxuflw,
                        i_rxoflw, i_rxnemp, i_error, i_bsoff, i_sleep, i_wakeup, 20'b0}) | config_reg[7];
  
    end
  end
  
  // Interrupt logic
  assign enabled_interrupts = config_reg[7] & config_reg[8];
  assign o_interrupt = (enabled_interrupts == 32'h0000_0000) ? 1'b0 : 1'b1;
  
  // TX FIFO data mapped to configuration registers
  assign o_tx_fifo_data[31:0] = config_reg[13];
  assign o_tx_fifo_data[63:32] = config_reg[12];
  assign o_tx_fifo_data[95:64] = config_reg[11];
  assign o_tx_fifo_data[127:96] = config_reg[10];
  
  // TX FIFO write enable logic
  always_ff @(posedge i_sys_clk, posedge i_reset)
  begin: tx_w_en_logic
    if (i_reset) begin
      o_tx_w_en <= 1'b0;
      
    end else if (pulse_o_tx_w_en) begin
      o_tx_w_en <= 1'b1;
      
    end else begin
      o_tx_w_en <= 1'b0;
    
    end
  end
  
  // HPB data mapped to configuration registers
  assign o_hpb_data[31:0] = config_reg[17];
  assign o_hpb_data[63:32] = config_reg[16];
  assign o_hpb_data[95:64] = config_reg[15];
  assign o_hpb_data[127:96] = config_reg[14];
  
  // HPB full logic
  always_ff @(posedge i_sys_clk, posedge i_reset)
  begin: hpb_full_logic
    if (i_reset) begin
      o_hpb_full <= 1'b0;
      
    end else if (i_rs_vector == HPB_DW2_RS) begin
      o_hpb_full <= 1'b1;
    
    end else if (i_hpb_r_en) begin
      o_hpb_full <= 1'b0;
    
    end
  end
  
  // RX FIFO data stored into config registers
  always_ff @(posedge i_sys_clk, posedge i_reset)
  begin: rx_fifo_data_logic
    if (i_reset) begin
      config_reg[18] <= 32'h0000_0000;
      config_reg[19] <= 32'h0000_0000;
      config_reg[20] <= 32'h0000_0000;
      config_reg[21] <= 32'h0000_0000;
      rx_message_reg_init <= 1'b1;
      o_rx_r_en <= 1'b0;
    
    end else if (rx_message_reg_init) begin
      if (!i_rx_empty) begin
        config_reg[18] <= i_rx_fifo_data[127:96];
        config_reg[19] <= i_rx_fifo_data[95:64];
        config_reg[20] <= i_rx_fifo_data[63:32];
        config_reg[21] <= i_rx_fifo_data[31:0];
        rx_message_reg_init <= 1'b0;
        o_rx_r_en <= 1'b1;
        
      end
    end else begin
      if (i_rs_vector == RX_DW2_RS) begin
        config_reg[18] <= i_rx_fifo_data[127:96];
        config_reg[19] <= i_rx_fifo_data[95:64];
        config_reg[20] <= i_rx_fifo_data[63:32];
        config_reg[21] <= i_rx_fifo_data[31:0];
        o_rx_r_en <= 1'b1;
      
      end else begin
        o_rx_r_en <= 1'b0;
    
      end
    end
  end
  
  // Acceptance Filtering
  assign o_uaf1 = config_reg[22][31];
  assign o_uaf2 = config_reg[22][30];
  assign o_uaf3 = config_reg[22][29];
  assign o_uaf4 = config_reg[22][28];
  assign o_afmr1 = config_reg[23];
  assign o_afir1 = config_reg[24];
  assign o_afmr2 = config_reg[25];
  assign o_afir2 = config_reg[26];
  assign o_afmr3 = config_reg[27];
  assign o_afir3 = config_reg[28];
  assign o_afmr4 = config_reg[29];
  assign o_afir4 = config_reg[30];

endmodule
