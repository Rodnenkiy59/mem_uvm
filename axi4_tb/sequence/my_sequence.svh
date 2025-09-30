`include "uvm_macros.svh" 
import uvm_pkg::*;

class my_transaction extends uvm_sequence_item;

  `uvm_object_utils(my_transaction)

  rand int addr;
  rand int data;

  constraint c_addr { addr >= 0; addr < 256; }
  constraint c_data { data >= 0; data < 256; }

  function new (string name = "");
    super.new(name);
  endfunction

endclass: my_transaction

class increment_transaction extends uvm_sequence_item;

  `uvm_object_utils(increment_transaction)

  int addr;
  int data;

  static int current_addr = 0;
  static int current_data = 0;

  int addr_increment = 4;
  int data_increment = 1;
  int addr_max = 256;
  int data_max = 256;

  function new(string name = "");
    super.new(name);
    addr = current_addr;
    data = current_data;
  endfunction //new()

  function void update_values();
    addr = current_addr;
    data = current_data;

    current_addr = (current_addr + addr_increment) % addr_max;
    current_data = (current_data + data_increment) % data_max;
  endfunction

  function void do_copy(uvm_object rhs);
    increment_transaction rhs_;
    super.do_copy(rhs);
    $cast(rhs_,rhs);
    addr = rhs_.addr;
    data = rhs_.data;
  endfunction

endclass //increment_transaction

class my_sequence extends uvm_sequence#(my_transaction);

  `uvm_object_utils(my_sequence)

  function new (string name = "");
    super.new(name);
  endfunction

  task body;
    repeat(8) begin
      req = my_transaction::type_id::create("req");
      start_item(req);

      if (!req.randomize()) begin
        `uvm_error("MY_SEQUENCE", "Randomize failed.");
      end

      finish_item(req);
    end
  endtask: body

endclass: my_sequence

class increment_sequence extends uvm_sequence#(increment_transaction);
  `uvm_object_utils(increment_sequence)

  function new(string name = "");
    super.new(name);
  endfunction

  task body;
    repeat(8) begin
      req = increment_transaction::type_id::create("req");
      start_item(req);
      req.update_values();
      finish_item(req);
    end
  endtask: body;

endclass: increment_sequence
