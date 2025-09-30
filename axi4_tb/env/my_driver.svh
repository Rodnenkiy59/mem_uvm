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
    fork
      forever begin
      @(posedge vif.aclk);
        if (vif.aresetn == 0) begin
          reset_write_signals();
          reset_read_signals();
        end
      end
    join_none
  endtask

  virtual task reset_write_signals();
    `uvm_info("MY_DRIVER", "reset_signals", UVM_LOW);vif.awid <= '0;
    vif.awaddr <= '0;
    vif.awlen <= '0;
    vif.awsize <= '0;
    vif.awburst <= '0;
    vif.awlock <= '0;
    vif.awcache <= '0;
    vif.awprot <= '0;
    vif.awvalid <= '0;
    vif.wdata <= '0;
    vif.wstrb <= '0;
    vif.wlast <= '0;
    vif.wvalid <= '0;
    vif.bready <= '0;
  endtask

  virtual task reset_read_signals();
    vif.arid   <= '0;
    vif.araddr <= '0;
    vif.arlen  <= '0;
    vif.arsize <= '0;
    vif.arburst<= '0;
    vif.arlock <= '0;
    vif.arcache<= '0;
    vif.arprot <= '0;
    vif.arvalid<= '0;
    vif.rready <= '0;
  endtask

endclass: my_driver

class writeDriver extends my_driver #(increment_transaction);
  `uvm_component_utils(writeDriver);

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction //new()

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("WRITE_DRIVER", "AFTER SUPER RUN", UVM_LOW);
    #100;
    forever begin
    @(posedge vif.aclk);
    seq_item_port.get_next_item(req);
    // ADDRESS CHANNEL
    vif.awaddr  = req.addr;
    vif.wdata   = req.data;
    vif.awvalid = '1;
    vif.awsize  = 3'd2;
    vif.awburst = 2'd1;
    wait(vif.awready);
    @(posedge vif.aclk);
    vif.awvalid = '0;
    // DATA CHANNEL
    vif.wvalid  = '1;
    vif.wstrb   = '1;
    vif.wlast   = '1;
    wait(vif.wready);
    @(posedge vif.aclk);
    vif.wvalid  = '0;
    // REQUEST CHANNEL
    vif.bready  = '1;
    wait(vif.bvalid);
    @(posedge vif.aclk);
    vif.bready  = '0;
    `uvm_info("WRITE_DRIVER", "Transaction sent to DUT", UVM_LOW);
    seq_item_port.item_done();
    end
  endtask


endclass //writeDriver extends my_driver