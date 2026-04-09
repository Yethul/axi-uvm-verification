class axi_driver extends uvm_driver#(axi_txn);
  `uvm_component_utils(axi_driver)
  
  virtual axi_inf vif;
  
  function new(string name = "axi_driver", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    if(!uvm_config_db#(virtual axi_inf)::get(this,"","vif", vif))
      `uvm_fatal("NO INTERFACE","VIRTUAL INTERFACE IS NOT RECEIVED")
  endfunction
      
     
    task run_phase(uvm_phase phase);
  		axi_txn txn;
  		reset_dut();
	
  		forever begin
    		seq_item_port.get_next_item(txn);

    		if (txn.is_write)
      			drive_write(txn);
    		else
      			drive_read(txn);

    		seq_item_port.item_done();
  		end
    endtask
    
    task reset_dut();
  		vif.awvalid <= 0;
  		vif.wvalid  <= 0;
  		vif.bready  <= 0;
  		vif.arvalid <= 0;
  		vif.rready  <= 0;
    endtask
    
    task drive_write(axi_txn txn);
  		// WRITE ADDRESS
 		 @(posedge vif.aclk);
  		vif.awaddr  <= txn.addr;
  		vif.awlen   <= txn.len;
  		vif.awsize  <= txn.size;
  		vif.awburst <= txn.burst;
  		vif.awvalid <= 1;

 		do @(posedge vif.aclk);
        while(!(vif.awvalid && vif.awready));
  		vif.awvalid <= 0;

  		// WRITE DATA
  		for (int i = 0; i <= txn.len; i++) begin
    		vif.wdata  <= txn.data[i];
    		vif.wstrb  <= txn.strb[i];
    		vif.wvalid <= 1;
    		vif.wlast  <= (i == txn.len);

  		  do @(posedge vif.aclk);
          while(!(vif.wvalid && vif.wready));
 		 end
	  	vif.wvalid <= 0;
        vif.wlast = 0;

	  	// WRITE RESPONSE
 		 vif.bready <= 1;
      
      do @(posedge vif.aclk);
      while(!vif.bvalid);
 	  vif.bready <= 0;
    endtask
    
    
    task drive_read(axi_txn txn);
      // READ AADRESS
	  @(posedge vif.aclk);
	  vif.araddr  <= txn.addr;
	  vif.arlen   <= txn.len;
	  vif.arsize  <= txn.size;
	  vif.arburst <= txn.burst;
	  vif.arvalid <= 1;

	  do @(posedge vif.aclk);
      while (!(vif.arvalid && vif.arready));
	  vif.arvalid <= 0;
      
      // READ DATA

      txn.rdata = new[txn.len + 1];
      vif.rready <= 1;
      for(int i = 0; i <= txn.len; i++) begin
        do @(posedge vif.aclk);
        while(!vif.rvalid);
        txn.rdata[i] = vif.rdata;
      end
      
      vif.rready = 0;
    endtask


endclass
