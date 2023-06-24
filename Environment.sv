//Environment Class - TO hold all classes and schedule the events & merging them
class environment;
 //Creating handles for classes and mailboxes 
  generator gen;
  driver drv;
  mailbox #(transaction) gen2drv;
  monitor mon;
  scoreboard sco;
  mailbox #(transaction) mon2sco;
  
  event nextgs;
  
  virtual fifo_if fif; //handler for the interface
  
  function new(virtual fifo_if fif);  //custom constructor
    gen2drv = new();     //Initialize mailboxes
    mon2sco = new();
    
    gen = new(gen2drv);   //initialising classes
    drv = new(gen2drv);
    mon = new(mon2sco);
    sco = new(mon2sco);
    
    this.fif = fif;      //Merging the interfaces of classes
    drv.fif = this.fif;
    mon.fif = this.fif;
    
    gen.next = nextgs;  //Event merging
    sco.next = nextgs;
  endfunction
  
  task pre_test();  //Pretest - To reset the FIFO
    drv.reset;
  endtask
  
  task test();  //Applying test cases
    fork
      gen.main;
      drv.main;
      mon.main;
      sco.main;
    join_any
  endtask
  
  task post_test();     //After all testcases are done, triggering finish
    wait(gen.done.triggered);
    $finish();
  endtask
  
  task main();   //Main task
    pre_test();
    test();
    post_test();
  endtask
  
endclass

