// Code for 8-bit synchronous FIFO DUT

//Behavioural design of the FIFO
module fifo(
  input clk,rd,wr,    //clock and control signals
  output empty,full,  //Status flags
  input [7:0] data_in,    // data to be pushed into FIFO
  output reg [7:0] data_out,  //data popped out of FIFO
  input rst
);
  
    
  reg [7:0] mem [31:0]; //FIFO of length/depth 32 bursts, each of size 8-bits
  reg [4:0] rptr,wptr;  //read and write pointers
  
  //Defining the main functionality of FIFO
  always @(posedge clk)
    begin
      if(rst==1)   //reset condition --> reset output and pointers
        begin
          data_out <= 0;
          wptr <= 0;
          rptr <= 0;
          for(int i=0;i<32;i++)
            mem[i] <= 0;
        end
      else
        begin
          if((wr==1'b1) && (full==1'b0)) // write only if FIFO is not full
            begin
              mem[wptr] <= data_in;
              wptr = wptr+1;
            end
          if((rd==1'b1) && (empty==1'b0)) //read only if FIFO is not empty
            begin
              data_out <= mem[rptr];
              rptr = rptr+1;
            end
        end
    end
  
  //Defining the status flags of the FIFO
  assign empty = ((wptr - rptr)==0) ? 1'b1 : 1'b0;
  assign full = ((wptr-rptr)==31) ? 1'b1 : 1'b0;
  
endmodule

