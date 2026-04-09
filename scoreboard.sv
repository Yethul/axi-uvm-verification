class axi_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(axi_scoreboard)
  
  uvm_analysis_imp#(axi_txn, axi_scoreboard) sb_imp;
  
  int total_txns;
  int pass_count, fail_count;
  bit [31:0] ref_mem [0:1023];

  
  function new(string name = "axi_scoreboard", uvm_component parent);
    super.new(name,parent);
    sb_imp = new("sb_imp", this);
  endfunction
  
  
  function void write(axi_txn txn);
	  total_txns++;

    if(txn.is_write) begin
      for(int i=0; i<=txn.len; i++) begin
        ref_mem[(txn.addr + (i<<2))>>2] = txn.data[i];
      end
    end
    else begin
      for(int i=0; i<=txn.len; i++) begin
        if(txn.rdata[i] === ref_mem[(txn.addr + (i<<2))>>2]) begin
          pass_count++;
          `uvm_info("SB","READ DATA MATCH", UVM_LOW)
        end else begin
          fail_count++;
          `uvm_error("SB","READ DATA MISMATCH")
        end
      end
    end
  endfunction
  
    function void report_phase(uvm_phase phase);
            `uvm_info(get_type_name(),$sformatf("TOTAL TRANS = %0d, pass count = %0d, fail_count = %0d", total_txns, pass_count, fail_count), UVM_LOW)
  endfunction

endclass