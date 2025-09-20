`ifndef MY_TESTBENCH_PKG_SVH
`define MY_TESTBENCH_PKG_SVH


package my_testbench_pkg;
import uvm_pkg::*;

`include "uvm_macros.svh" 
`include "../env/my_env.svh"

class my_test extends uvm_test;
    `uvm_component_utils(my_test)
  
    my_env env;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
  
    function void build_phase(uvm_phase phase);
      env = my_env::type_id::create("env", this);
    endfunction
  
    task run_phase(uvm_phase phase);
      // We raise objection to keep the test from completing
      phase.raise_objection(this);
      #10;
      `uvm_warning("", "Hello World!")
      // We drop objection to allow the test to complete
      phase.drop_objection(this);
    endtask

    typedef virtual axi4_if#(
        .DATA_WIDTH(32),
        .ADDR_WIDTH(16),
        .ID_WIDTH(8),
        .LEN_WIDTH(8),
        .STRB_WIDTH(4)
    ) vif_t;
    
endclass
endpackage

`endif