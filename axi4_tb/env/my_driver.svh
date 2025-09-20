
`include "uvm_macros.svh" 
`include "../sequence/my_sequence.svh"

class my_driver extends uvm_driver #(my_transaction);

  `uvm_component_utils(my_driver)

  virtual  axi4_if#(32, 16, 8) vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    // get interface reference from config database
    if(!uvm_config_db#(virtual axi4_if#(32, 16, 8, 8))::get(this, "", "axi4_if_inst", vif)) begin
      `uvm_error("", "uvm_config_db::get failed")
    end
  endfunction 

  task run_phase(uvm_phase phase);
    // first toggle reset
    @(posedge vif.aclk);
    #1;
    seq_item_port.get_next_item(req);
    vif.awready = 1;
    seq_item_port.item_done();
  endtask

endclass: my_driver