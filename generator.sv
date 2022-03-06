
class generator;
  transaction  trans;
  int          a_array[*]; 
  int          i =0;
  int          w=1;
  int          no_transactions=0;
  int          gen_counter=0;
  logic   [31:0] TEMP_ADDR;
  logic   [31:0] start_addr;
  logic   [31:0] next_addr;
  int          bound_check;
  
  mailbox gtd;

  function new(mailbox gtd);
    this.gtd = gtd;
  endfunction

  task main();
    int ok;
      repeat(gen_counter) begin
       trans = new();
        ok = trans.randomize();
        if(ok)
          begin
            gtd.put(trans);
          end
        else
          begin
            $display("Randomization Failed");
          end
     end
      $display("Transactions Generation Done");
      no_transactions++;
  endtask: main

    task write_w_gen();
        $display($time," %d ,, task write generator", i);
        trans = new();  
    if(!trans.randomize()) 
      $fatal("Gen:: trans randomization failed"); 
    		a_array[i] = trans.haddr;
            trans.hwrite = 1;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b000;//Single burst
            trans.htrans = 2'b11;//SEQ
            if (i ==0 )
            trans.htrans = 2'b10;
            trans.hprot  = 4'b0001;
            gtd.put(trans);                 
            i++;
    if (i == 4) i=0;
    endtask
  
   task read_w_gen ();
            $display($time, "   task read in generator");
            trans = new();                       
     		trans.haddr = a_array[i];
            trans.hwrite = 0;
            trans.hsize  = 3'b010;
            trans.hburst = 3'b000;//Single burst
            trans.htrans = 2'b11;//SEQ
            if (i ==0 )
            trans.htrans = 2'b10;
            trans.hprot  = 4'b0001;
            gtd.put(trans);               
            i++;
     if (i == 4) i=0;
    endtask

  task write_INCR4_gen();
        $display($time," %d ,, task write generator", i);
        trans = new();  
          if(i==0)
           begin
            trans.randomize();
            trans.htrans = 2'b10;//Non-SEq
            a_array[i] = trans.haddr;
            TEMP_ADDR = a_array[i];
            trans.hwrite = 1;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b011;//4-beat incrementing burst
            trans.hprot  = 4'b0001;
            gtd.put(trans);                
            i++;
            end            
    		else begin
            trans.randomize();
            TEMP_ADDR    = TEMP_ADDR +4;
            a_array[i]  =  TEMP_ADDR;
            trans.haddr  = a_array[i];
            trans.hwrite = 1;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b011;//4-beat incrementing burst
            trans.htrans = 2'b11;//SEQ
            trans.hprot  = 4'b0001;
            gtd.put(trans);                 
            i++;
            end
      if (i == 4) i=0;
    endtask
  
      task read_INCR4_gen();
            $display($time, "   task read in generator");
            trans = new();
            trans.haddr  = a_array[i];
            trans.hwrite = 0;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b011;//4-beat incrementing burst
            trans.htrans = 2'b11;//SEQ
            if (i == 0 )
            trans.htrans = 2'b10;//Non-SEQ
            trans.hprot  = 4'b0001;
            gtd.put(trans);                 
            i++;
        if (i == 4) i=0;
    endtask

      task write_INCR8_gen();
        $display($time," %d ,, task write generator", i);
        trans = new();  
          if(i==0)
           begin
            trans.randomize();
            trans.htrans = 2'b10;//Non-SEq
            a_array[i] = trans.haddr;
            TEMP_ADDR = a_array[i];
            trans.hwrite = 1;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b101;//8-beat incrementing burst
            trans.hprot  = 4'b0001;
            gtd.put(trans);                
            i++;
            end            
    		else begin
            trans.randomize();
            TEMP_ADDR = TEMP_ADDR +4;
            a_array[i] = TEMP_ADDR;
            trans.haddr = a_array[i];
            trans.hwrite = 1;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b101;//8-beat incrementing burst
            trans.htrans = 2'b11;//SEQ
            trans.hprot  = 4'b0001;
            gtd.put(trans);                 
            i++;
            end
        if (i == 8) i=0;
    endtask
  
      task read_INCR8_gen();
            $display($time, "   task read in generator");
            trans = new();
            trans.haddr  = a_array[i];
            trans.hwrite = 0;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b101;//8-beat incrementing burst
            trans.htrans = 2'b11;//SEQ
            if (i == 0 )
            trans.htrans = 2'b10;//Non-SEQ
            trans.hprot  = 4'b0001;
            gtd.put(trans);                 
            i++;
        if (i == 8) i=0;
    endtask
  
      task write_INCR16_gen();
        $display($time," %d ,, task write generator", i);
        trans = new();  
          if(i==0)
           begin
            trans.randomize();
            trans.htrans = 2'b10;//Non-SEq
            a_array[i] = trans.haddr;
            TEMP_ADDR = a_array[i];
            trans.hwrite = 1;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b111;//16-beat incrementing burst
            trans.hprot  = 4'b0001;
            gtd.put(trans);                 
            i++;
            end            
    		else begin
            trans.randomize();
            TEMP_ADDR = TEMP_ADDR +4;
            a_array[i] = TEMP_ADDR;
            trans.haddr = a_array[i];
            trans.hwrite = 1;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b111;//16-beat incrementing burst
            trans.htrans = 2'b11;//SEQ
            trans.hprot  = 4'b0001;
            gtd.put(trans);                
            i++;
            end
        if (i == 16) i=0;
    endtask
  
      task read_INCR16_gen();
            $display($time, "   task read in generator");
            trans = new();
            trans.haddr  = a_array[i];
            trans.hwrite = 0;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b111;//16-beat incrementing burst
            trans.htrans = 2'b11;//SEQ
            if (i == 0 )
            trans.htrans = 2'b10;//Non-SEQ
            trans.hprot  = 4'b0001;
            gtd.put(trans);                 
            i++;
        if (i == 16) i=0;
    endtask

        task write_UND_INCR_gen();
        $display($time," %d ,, task write generator", i);
        trans = new();  
          if(i==0)
           begin
            trans.randomize();
            trans.htrans = 2'b10;//Non-SEq
            a_array[i] = trans.haddr;
            TEMP_ADDR = a_array[i];
            trans.hwrite = 1;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b001;//Incrementing burst of undefined length
            trans.hprot  = 4'b0001;
            gtd.put(trans);                
            i++;
            end            
    		else begin
            trans.randomize();
            TEMP_ADDR = TEMP_ADDR +4;
            a_array[i] = TEMP_ADDR;
            trans.haddr = a_array[i];
            trans.hwrite = 1;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b001;//Incrementing burst of undefined length
            trans.htrans = 2'b11;//SEQ
            trans.hprot  = 4'b0001;
            gtd.put(trans);                 
            i++;
            end
        if (i == gen_counter) i=0;
    endtask
  
      task read_UND_INCR_gen();
            $display($time, "   task read in generator");
            trans = new();
            trans.haddr  = a_array[i];
            trans.hwrite = 0;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b001;//Incrementing burst of undefined length
            trans.htrans = 2'b11;//SEQ
            if (i == 0 )
            trans.htrans = 2'b10;//Non-SEQ
            trans.hprot  = 4'b0001;
            gtd.put(trans);                
            i++;
        if (i == gen_counter) i=0;
    endtask

   task write_WRAP4_gen();
        $display($time," %d ,, task write generator", i);
        trans = new();  
          if(i==0)
           begin
            trans.randomize();
            trans.htrans = 2'b10;//Non-SEq
            a_array[i]   = trans.haddr;
            start_addr    = a_array[i];
            trans.hwrite = 1;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b010;//4-beat wrapping burst
            trans.hprot  = 4'b0001;
            gtd.put(trans);                 
            i++;
            end            
    		else begin
            trans.randomize();
            next_addr=    start_addr + w * (2 ** trans.hsize);
            bound_check  = 4*2**trans.hsize;
            if(((next_addr%bound_check)==0) &&(next_addr!=start_addr))
            next_addr=next_addr-bound_check;
            a_array[i]   = next_addr;
            trans.haddr  = a_array[i];
            trans.hwrite = 1;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b010;//4-beat wrapping burst
            trans.htrans = 2'b11;//SEQ
            trans.hprot  = 4'b0001;
            gtd.put(trans);                 
            i++;
            w++;
            end
      if (i == 4) i=0;
    endtask
  
      task read_WRAP4_gen();
            $display($time, "   task read in generator");
            trans = new();
            trans.haddr  = a_array[i];
            trans.hwrite = 0;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b010;//4-beat wrapping burst
            trans.htrans = 2'b11;//SEQ
            if (i == 0 )
            trans.htrans = 2'b10;//Non-SEQ
            trans.hprot  = 4'b0001;
            gtd.put(trans);                
            i++;
        if (i == 4) i=0;
    endtask
  
    task write_WRAP8_gen();
        $display($time," %d ,, task write generator", i);
        trans = new();  
          if(i==0)
           begin
            trans.randomize();
            trans.htrans = 2'b10;//Non-SEq
            a_array[i]   = trans.haddr;
            start_addr    = a_array[i];
            trans.hwrite = 1;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b010;//4-beat wrapping burst
            trans.hprot  = 4'b0001;
            gtd.put(trans);                 
            i++;
            end            
    		else begin
            trans.randomize();
            next_addr=    start_addr + w * (2 ** trans.hsize);
            bound_check  = 8*2**trans.hsize;
            if(((next_addr%bound_check)==0) &&(next_addr!=start_addr))
            next_addr=next_addr-bound_check;
            a_array[i]   = next_addr;
            trans.haddr  = a_array[i];
            trans.hwrite = 1;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b100;//8-beat wrapping burst 
            trans.htrans = 2'b11;//SEQ
            trans.hprot  = 4'b0001;
            gtd.put(trans);                
            i++;
            w++;
            end
      if (i == 8) i=0;
    endtask
  
      task read_WRAP8_gen();
            $display($time, "   task read in generator");
            trans = new();
            trans.haddr  = a_array[i];
            trans.hwrite = 0;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b100;//8-beat wrapping burst 
            trans.htrans = 2'b11;//SEQ
            if (i == 0 )
            trans.htrans = 2'b10;//Non-SEQ
            trans.hprot  = 4'b0001;
            gtd.put(trans);                 
            i++;
        if (i == 8) i=0;
    endtask
 
      task write_WRAP16_gen();
        $display($time," %d ,, task write generator", i);
        trans = new();  
          if(i==0)
           begin
            trans.randomize();
            trans.htrans = 2'b10;//Non-SEq
            a_array[i]   = trans.haddr;
            start_addr    = a_array[i];
            trans.hwrite = 1;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b010;//4-beat wrapping burst
            trans.hprot  = 4'b0001;
            gtd.put(trans);                
            i++;
            end            
    		else begin
            trans.randomize();
            next_addr=    start_addr + w * (2 ** trans.hsize);
            bound_check  = 16*2**trans.hsize;
            if(((next_addr%bound_check)==0) &&(next_addr!=start_addr))
            next_addr=next_addr-bound_check;
            a_array[i]   = next_addr;
            trans.haddr  = a_array[i];
            trans.hwrite = 1;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b110;//16-beat wrapping burst
            trans.htrans = 2'b11;//SEQ
            trans.hprot  = 4'b0001;
            gtd.put(trans);                
            i++;
            w++;
            end
        if (i == 16) i=0;
    endtask
  
      task read_WRAP16_gen();
            $display($time, "   task read in generator");
            trans = new();
            trans.haddr  = a_array[i];
            trans.hwrite = 0;
            trans.hsize  = 3'b010;           
            trans.hburst = 3'b110;//16-beat wrapping burst
            trans.htrans = 2'b11;//SEQ
            if (i == 0 )
            trans.htrans = 2'b10;//Non-SEQ
            trans.hprot  = 4'b0001;
            gtd.put(trans);                 
            i++;
        if (i == 16) i=0;
    endtask

endclass

