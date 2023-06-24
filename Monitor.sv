//Monitor Class - Captures response of DUT and sent it to the scoreboard
class monitor;
  transaction t;
  mailbox #(transaction) mon2sco;  //mailbox
  virtual fifo_if fif;
  
  function new(mailbox #(transaction) mon2sco);
    this.mon2sco = mon2sco;
  endfunction
  
  task main();
    t = new();
    forever begin
      repeat(2) @(posedge fif.clk);  //wait for 2 active clock edges to match system latency
      t.rd = fif.rd;
      t.wr = fif.wr;
      t.data_in = fif.data_in;
      t.data_out = fif.data_out;
      t.full = fif.full;
      t.empty = fif.empty;
    
      mon2sco.put(t);
      t.display("MON");
    end
  endtask
  
endclass
