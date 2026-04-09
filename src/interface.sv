//----------------------------------------------
//           	    INTERFACE
//----------------------------------------------

interface axi_inf #(parameter addr_width=32, data_width=32)(input logic aclk,logic aresetn);
  
  
  logic [addr_width-1:0]    awaddr;
  logic [7:0]               awlen;
  logic [2:0]               awsize;
  logic[1:0]               awburst;
  logic                    awvalid;
  logic                     awready;

  logic[data_width-1:0]    wdata;
  logic [(data_width/8)-1:0]  wstrb;
  logic                    wvalid;
  logic                    wlast;
  logic                     wready;

  
  logic [1:0]               bresp;
   logic                    bvalid;
   logic                    bready;

  
  logic [addr_width-1:0]    araddr;
  logic [7:0]               arlen;
  logic [2:0]               arsize;
  logic [1:0]               arburst;
   logic                    arvalid;
   logic                     arready;

  
  logic [data_width-1:0]    rdata;
  logic [1:0]               rresp;
   logic                     rvalid;
   logic                     rlast;
   logic                    rready;
endinterface
