onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/axi4_if_inst/aclk
add wave -noupdate /testbench/axi4_if_inst/aresetn
add wave -noupdate /testbench/axi4_if_inst/awid
add wave -noupdate /testbench/axi4_if_inst/awaddr
add wave -noupdate /testbench/axi4_if_inst/awlen
add wave -noupdate /testbench/axi4_if_inst/awsize
add wave -noupdate /testbench/axi4_if_inst/awburst
add wave -noupdate /testbench/axi4_if_inst/awlock
add wave -noupdate /testbench/axi4_if_inst/awcache
add wave -noupdate /testbench/axi4_if_inst/awprot
add wave -noupdate /testbench/axi4_if_inst/awvalid
add wave -noupdate /testbench/axi4_if_inst/awready
add wave -noupdate /testbench/axi4_if_inst/wdata
add wave -noupdate /testbench/axi4_if_inst/wstrb
add wave -noupdate /testbench/axi4_if_inst/wlast
add wave -noupdate /testbench/axi4_if_inst/wvalid
add wave -noupdate /testbench/axi4_if_inst/wready
add wave -noupdate /testbench/axi4_if_inst/bid
add wave -noupdate /testbench/axi4_if_inst/bresp
add wave -noupdate /testbench/axi4_if_inst/bvalid
add wave -noupdate /testbench/axi4_if_inst/bready
add wave -noupdate /testbench/axi4_if_inst/arid
add wave -noupdate /testbench/axi4_if_inst/araddr
add wave -noupdate /testbench/axi4_if_inst/arlen
add wave -noupdate /testbench/axi4_if_inst/arsize
add wave -noupdate /testbench/axi4_if_inst/arburst
add wave -noupdate /testbench/axi4_if_inst/arlock
add wave -noupdate /testbench/axi4_if_inst/arcache
add wave -noupdate /testbench/axi4_if_inst/arprot
add wave -noupdate /testbench/axi4_if_inst/arvalid
add wave -noupdate /testbench/axi4_if_inst/arready
add wave -noupdate /testbench/axi4_if_inst/rid
add wave -noupdate /testbench/axi4_if_inst/rdata
add wave -noupdate /testbench/axi4_if_inst/rresp
add wave -noupdate /testbench/axi4_if_inst/rlast
add wave -noupdate /testbench/axi4_if_inst/rvalid
add wave -noupdate /testbench/axi4_if_inst/rready
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {2274 ps}
