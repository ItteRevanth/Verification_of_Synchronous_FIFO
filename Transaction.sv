//Transaction class - Contains variables for all input & output ports of DUT to share among classes
class transaction;
  rand bit wr,rd;
  rand bit[7:0] data_in;
  bit full,empty;
  bit[7:0] data_out;
  
  constraint wr_rd {
    wr != rd;
    wr dist{0 :/ 50, 1 :/ 50};  //Assumes 50% time write & 50% time read happens
    rd dist{0 :/ 50, 1 :/ 50};
  }
  
  //Function to display, whenever transactions happen in any class - 'cls'
  function void display(input string cls);
    $display("[%0s]: WR:%0b\t RD:%0b\t DATA_IN:%0d\t DATA_OUT:%0d\t FULL:%0b\t EMPTY:%0b\t %0t",cls,wr,rd,data_in,data_out,full,empty,$time);
  endfunction
  
  //Copy constructor for deep copy usage
  function transaction copy();
    copy = new();
    copy.wr = this.wr;
    copy.rd = this.rd;
    copy.data_in = this.data_in;
    copy.data_out = this.data_out;
    copy.full = this.full;
    copy.empty = this.empty;
  endfunction
  
endclass
