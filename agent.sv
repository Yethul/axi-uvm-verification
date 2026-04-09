class axi_agent extends uvm_agent;
  `uvm_component_utils(axi_agent)
  
  axi_driver drvh;
  axi_monitor monh;
  axi_seqr seqrh;
  
  virtual axi_inf vif;
  
  function new(string name = "axi_agent", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(virtual axi_inf)::get(this,"","vif",vif))
      `uvm_fatal("NO INF","CANNOT GET INTERFACE INSTANCE")
      
      drvh = axi_driver :: type_id :: create ("drvh", this);
    monh = axi_monitor :: type_id :: create ("monh", this);
    seqrh = axi_seqr :: type_id :: create ("seqr", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    drvh.seq_item_port.connect(seqrh.seq_item_export);
    drvh.vif = vif;
    monh.vif = vif;
  endfunction
endclass