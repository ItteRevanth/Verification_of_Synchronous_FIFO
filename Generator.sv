//Generator Class - Randomizes the transaction,sends random signals to the driver class and sense events from driver and scoreboard
class generator;
  transaction t;
  mailbox #(transaction) gen2drv; //Parametrized mailbox
  int count=0;
  event next,done; //Events to communicate with other classes
  
  function new(mailbox #(transaction) gen2drv); //custom constructor
    this.gen2drv = gen2drv;
    t = new();
  endfunction
  
  task main();    //Task to generate random signals for CRT
    repeat(count)
      begin
        assert(t.randomize()) else $error("randomization failed!");
        gen2drv.put(t.copy);
        t.display("GEN");
        @(next);  //wait for next event triggering from scoreboard
      end
    -> done;   //Triggering done event once all test signals are sent
  endtask
  
endclass
