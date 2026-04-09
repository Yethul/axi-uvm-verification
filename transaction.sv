// sequence  item ******************************************************

class axi_txn extends uvm_sequence_item;
  //---------------------------------------------
  //-               DATA ITEMS                  -
  //---------------------------------------------
  
  // WRITE address channel
  rand bit        is_write;   // 1=write, 0=read
  rand bit [31:0] addr;
  rand bit [7:0]  len;
  rand bit [2:0]  size;
  rand bit [1:0]  burst;

  // WRITE data
  rand bit [31:0] data[];
  rand bit [3:0]  strb[];

  // READ response
  bit [31:0] rdata[];

  // Response
  bit [1:0] resp;
  
  
  //------------------- constraints -----------------------------
  
  constraint c_burst { burst == 2'b01;}
  constraint c_size { size == 3'b010;}
  constraint c_len { len inside {[0:7]};}
  constraint c_addr_align { addr[1:0] == 2'b00;}
  constraint c_addr_range { addr inside {[32'h0000_0000 : 32'h0000_0FFF]};}
  constraint c_array_size { data.size() == len +1;}
  constraint Burst_addr_limit_c {addr + ((len + 1) * (1 << size)) <= 32'h1000;}
  constraint c_strb {
    foreach(strb[i])
      strb[i] == 4'b1111;
  }
  
  `uvm_object_utils(axi_txn)
  function new(string name = "axi_txn");
    super.new(name);
  endfunction
endclass