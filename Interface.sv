//Inteface for communication between DUT and TB
interface fifo_if;
  logic clk,rd,wr;
  logic [7:0] data_in,data_out;
  logic empty, full;
  logic rst;
endinterface
