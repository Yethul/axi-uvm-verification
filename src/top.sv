// Code your testbench here
// or browse Examples
//txn, seq, driver, monitor, scoreboard

`include "axi_if.sv"
`include "axi_pkg.sv"

`include "uvm_macros.svh"
import uvm_pkg::*;
import axi_tb_pkg::*;

module tb_top;
  logic aclk;
  logic aresetn;
  
  axi_inf axi_vif(.aclk(aclk), .aresetn(aresetn));
  
  axi_slave dut (
  .aclk(aclk),
  .aresetn(axi_vif.aresetn),
  .awaddr(axi_vif.awaddr),
  .awlen(axi_vif.awlen),
  .awsize(axi_vif.awsize),
  .awburst(axi_vif.awburst),
  .awvalid(axi_vif.awvalid),
  .awready(axi_vif.awready),
  .wdata(axi_vif.wdata),
  .wstrb(axi_vif.wstrb),
  .wvalid(axi_vif.wvalid),
  .wlast(axi_vif.wlast),
  .wready(axi_vif.wready),
  .bresp(axi_vif.bresp),
  .bvalid(axi_vif.bvalid),
  .bready(axi_vif.bready),
  .araddr(axi_vif.araddr),
  .arlen(axi_vif.arlen),
  .arsize(axi_vif.arsize),
  .arburst(axi_vif.arburst),
  .arvalid(axi_vif.arvalid),
  .arready(axi_vif.arready),
  .rdata(axi_vif.rdata),
  .rresp(axi_vif.rresp),
  .rvalid(axi_vif.rvalid),
  .rlast(axi_vif.rlast),
  .rready(axi_vif.rready)
);

  
  always #5 aclk = ~aclk;
  
  initial begin
  	aclk = 0;
  	aresetn = 0;
  	#10 aresetn = 1;
  end
  
  initial begin
  	uvm_config_db#(virtual axi_inf)::set(null,"*","vif",axi_vif);
  	run_test("axi_test");
  end
  
  initial begin
  	$dumpfile("waveform.vcd");  
  	$dumpvars(0, tb_top);    
  end

endmodule
