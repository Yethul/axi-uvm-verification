class axi_monitor extends uvm_monitor;
  `uvm_component_utils(axi_monitor)
  
  virtual axi_inf vif;
  uvm_analysis_port#(axi_txn) mon_ap;
  
  
  function new(string name = "axi_monitor", uvm_component parent);
    super.new(name,parent);
    mon_ap = new("mon_ap", this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(virtual axi_inf)::get(this,"","vif",vif))
      `uvm_fatal(get_type_name(),"CANNOT GET INTERFACE INSTANCE")
  endfunction
      
   task run_phase(uvm_phase phase);
    fork
      mon_write();
      mon_read();
    join
    endtask
  

    
    task mon_write();
      axi_txn txn;
  forever begin
    @(posedge vif.aclk);

    // WRITE transaction
    if (vif.wvalid && vif.wready) begin
      txn = axi_txn::type_id::create("mon_wr");
      txn.is_write = 1;
      txn.data = new[1];
      txn.data[0] = vif.wdata;

      mon_ap.write(txn);
      
      `uvm_info("MONITOR : ", $sformatf("WRITE DATA = %0h WLAST = %0b",vif.wdata, vif.wlast), UVM_LOW);
    end
  end
    endtask

    // READ transaction
    // READ ADDRESS
    task mon_read();
      axi_txn txn;
      forever begin
        @(posedge vif.aclk);
    if(vif.rvalid && vif.rready) begin
      txn = axi_txn::type_id::create("mon_rd");
      txn.is_write = 0;;
      txn.data = new[1];
      txn.data[0] = vif.rdata;
      
      mon_ap.write(txn);
      
      `uvm_info("MONITOR : ", $sformatf("READ DATA = %0h",vif.rdata), UVM_LOW);
    end
  end
    endtask


endclass
