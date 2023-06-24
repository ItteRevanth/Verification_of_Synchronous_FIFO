//TestBench top - Stores environment and generates clk
module tb_top();
  fifo_if fif();
  fifo dut(fif.clk,fif.rd,fif.wr,fif.empty,fif.full,fif.data_in,fif.data_out,fif.rst);  //Connecting DUT with testbench
  
  environment env;

  initial begin   //initialising clock
    fif.clk <= 0;
  end

  
  always #10 fif.clk <= ~fif.clk;  //generating clock
  
  initial begin           //Creating environment and running it
    env = new(fif);
    env.gen.count = 20;
    env.main();
  end
  
  initial begin              //Storing all the variables and signlas in VCD file
    $dumpfile("FIFO.vcd");
    $dumpvars(0,tb_top);
  end
      
endmodule
