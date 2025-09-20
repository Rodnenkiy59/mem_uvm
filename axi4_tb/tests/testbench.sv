`timescale 1ns/100ps

`include "../interfaces/axi4_if.sv"
`include "uvm_macros.svh"
`include "my_testbench_pkg.svh"
`include "../env/my_env.svh"

module testbench ();
  import uvm_pkg::*;
  import my_testbench_pkg::*;
    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 16;
    parameter ID_WIDTH = 8;
    parameter STRB_WIDTH = DATA_WIDTH/8;
    parameter PIPELINE_OUTPUT = 0;
    parameter LEN_WIDTH = 8;
    
    logic clk;
    logic rst_n;

    initial begin
        clk = 0;
        forever begin
            #10 clk = ~clk;
        end    
    end

    initial begin
        rst_n       = 0; 
        #20 rst_n   = 1;
    end

    axi4_if #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .ID_WIDTH(ID_WIDTH),
        .LEN_WIDTH(LEN_WIDTH),
        .STRB_WIDTH(STRB_WIDTH)
    ) axi4_if_inst (.aclk(clk), .aresetn(rst_n));


    axi_ram #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .ID_WIDTH(ID_WIDTH),
        .STRB_WIDTH(STRB_WIDTH),
        .PIPELINE_OUTPUT(PIPELINE_OUTPUT)
    ) dut (
        .axi4_s(axi4_if_inst.slave_mp)
    );

    initial begin
        uvm_config_db#(virtual axi4_if#(
            .DATA_WIDTH(DATA_WIDTH),
            .ADDR_WIDTH(ADDR_WIDTH),
            .ID_WIDTH(ID_WIDTH),
            .LEN_WIDTH(LEN_WIDTH),
            .STRB_WIDTH(STRB_WIDTH)
        ))::set(null, "*", "axi4_if_inst", axi4_if_inst);
        run_test("my_test");
        #100 $stop;
    end
    
endmodule