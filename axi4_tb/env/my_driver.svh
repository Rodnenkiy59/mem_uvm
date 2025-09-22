`include "uvm_macros.svh" 
`include "../sequence/my_sequence.svh"

class my_driver #(type T = uvm_sequence_item) extends uvm_driver #(T);

  `uvm_component_utils(my_driver#(T))

  virtual  axi4_if#(32, 16, 8, 8) vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    // get interface reference from config database
    super.build_phase(phase);
    if(!uvm_config_db#(virtual axi4_if#(32, 16, 8, 8))::get(this, "", "axi4_if_inst", vif)) begin
      `uvm_error("", "uvm_config_db::get failed")
    end
  endfunction 

  task run_phase(uvm_phase phase);
  super.run_phase(phase);
        
        // Проверка интерфейса
        if (vif == null) begin
            `uvm_fatal("NOVIF", "Virtual interface is null")
        end
        
        @(posedge vif.aclk);
        forever begin
            seq_item_port.get_next_item(req);
            
            if (req != null) begin
                `uvm_info("MY_DRIVER", $sformatf("Processed transaction: %s", req.sprint()), UVM_MEDIUM)
            end else begin
                `uvm_warning("MY_DRIVER", "Received null transaction")
            end
            
            seq_item_port.item_done();
        end
  endtask

endclass: my_driver

class writeDriver extends my_driver #(my_transaction);
  `uvm_component_utils(writeDriver);

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction //new()

  task run_phase(uvm_phase phase);
    @(posedge vif.aclk);
    forever begin
    @(posedge vif.aclk);
    seq_item_port.get_next_item(req);
    vif.awaddr = req.addr;
    vif.wdata  = req.data;
    `uvm_info("WRITE_DRIVER", "Transaction sent to DUT", UVM_LOW);
    seq_item_port.item_done();
    end
  endtask

endclass //writeDriver extends my_driver