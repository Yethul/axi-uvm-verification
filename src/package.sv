
package axi_tb_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

//------------------------------------------------------
//         include all uvm components
//------------------------------------------------------
	`include "axi_txn.sv"
	`include "axi_seq.sv"
	`include "axi_seqr.sv"
	`include "axi_driver.sv"
	`include "axi_monitor.sv"
	`include "axi_agent.sv"
	`include "axi_scoreboard.sv"
	`include "axi_env.sv"
	`include "axi_test.sv"
endpackage
