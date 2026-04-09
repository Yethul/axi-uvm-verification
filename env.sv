class axi_env extends uvm_env;
  `uvm_component_utils(axi_env)
  
  axi_agent agnth;
  axi_scoreboard sbh;
  axi_seq seqh;
  
  function new(string name = "axi_env", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    agnth = axi_agent :: type_id :: create("agnth", this);
    sbh = axi_scoreboard :: type_id :: create("sbh", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    //agnth.monh.mon_ap.connect(sbh.sb_imp);
  endfunction
endclass