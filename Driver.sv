//Driver Class - Recieved testcases from generator, applies those stimuli & reset to DUT via interface
class driver;
  virtual fifo_if fif;  //Virtual handler for interface
  
  transaction t;
  mailbox #(transaction) gen2drv;  //Mailbox
  
  function new(mailbox #(transaction) gen2drv); //custom constructor
    this.gen2drv = gen2drv;
  endfunction
  
  //Reset task to reset control signals
  task reset();
    fif.rst <= 1'b1;
    fif.rd <= 1'b0;
    fif.wr <= 1'b0;
    fif.data_in <= 8'b0;
    repeat(5) @(posedge fif.clk);    //Will be in reset state for 5 active clock edges
    fif.rst <= 1'b0;
    $display("[DRV]:DUT reset done");
  endtask
  
  //Main task to send signals to DUT
  task main();
    forever begin
      gen2drv.get(t);
      t.display("DRV");
      fif.rd <= t.rd;
      fif.wr <= t.wr;
      fif.data_in <= t.data_in;
      repeat(2) @(posedge fif.clk);
    end
  endtask
  
endclass
