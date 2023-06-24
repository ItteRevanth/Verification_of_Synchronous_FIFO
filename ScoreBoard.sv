//ScoreBoard Class - Recieve data from monitor and compare with specifications
class scoreboard;
  transaction t;
  mailbox #(transaction) mon2sco;  //mailbox from monitor
  event next;
  bit[7:0] d_in[$];  //Queue to store data from monitor for comparision
  bit[7:0] temp;
  
  function new(mailbox #(transaction) mon2sco);
    this.mon2sco = mon2sco;
  endfunction
  
  task main();
    forever begin
      mon2sco.get(t);
      t.display("SCO");
      
      if(t.wr==1'b1)   //If write is high
        begin
          d_in.push_front(t.data_in);  //Push the incoming data into the queue
          $display("[SCO]:Data stored in Queue");
        end
      if(t.rd==1'b1)   //if read is high
        begin
          if(t.empty==1'b0) begin     //Check if FIFO is empty
            temp = d_in.pop_back();   //If not retrieve data
            if(t.data_out==temp)
              $display("[SCO]:Data Matched!");
            else $error("[SCO]:Data Mismatched!");
          end
          else $display("[SCO]:FIFO is empty!");
        end
      -> next;
    end
  endtask
  
endclass
