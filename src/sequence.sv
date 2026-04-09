class axi_seq extends uvm_sequence#(axi_txn);
  `uvm_object_utils(axi_seq)
  
  function new(string name = "axi_seq");
    super.new(name);
  endfunction
  
  task body();
  axi_txn wr_txn, rd_txn;

  // ---------------- RANDOM WRITE ----------------
    wr_txn = axi_txn::type_id::create("wr_txn");
    start_item(wr_txn);
    
    if(!wr_txn.randomize() with { is_write ==1;
                                 len inside {[0:3]};
    })
      `uvm_fatal("RANDFAIL","WRITE RANDOMIZATION FAILED");
    wr_txn.data = new[wr_txn.len + 1];
    wr_txn.strb = new[wr_txn.len + 1];
    
    foreach(wr_txn.data[i]) begin
      wr_txn.data[i] = $urandom;
      wr_txn.strb[i] = 4'b1111;
    end
    finish_item(wr_txn);

  // ---------------- READ ----------------
    rd_txn = axi_txn::type_id::create("rd_txn");
    start_item(rd_txn);
    
    assert(rd_txn.randomize() with{ is_write == 0;
                                 addr == wr_txn.addr;
                                 len == wr_txn.len;
                                 size == wr_txn.size;
                                 burst == wr_txn.burst;})
      else
        `uvm_fatal("RAND","READ RANDOMIZATION FAILED");
    
    
    finish_item(rd_txn);
  endtask

endclass
