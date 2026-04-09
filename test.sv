class axi_test extends uvm_test;
  
  `uvm_component_utils(axi_test)
  
  axi_env envh;
  axi_seq seqh;
  
  function new(string name = "axi_test", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    envh = axi_env :: type_id :: create("envh",this);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    seqh = axi_seq :: type_id :: create("seqh");
    seqh.start(envh.agnth.seqrh);
    
    #20;
    phase.drop_objection(this);
  endtask
endclass