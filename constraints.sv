//Define a constraint in SystemVerilog to ensure that even locations in a random array contain odd numbers, and odd locations contain even numbers?
class packet;
  rand bit [3:0] a[];
 
  constraint aa {a.size inside {[4:10]};}
  constraint bb { foreach(a[i])
                     if(i%2==0)
                       a[i] %2 == 1;
                 else if(i%2==1)     
                   a[i] %2 == 0;
                }
endclass

module test;
  packet pkt = new();
  initial begin
    repeat(1) begin
      pkt.randomize();
      $display("%p", pkt.a);
    end
  end
endmodule

/*==================================================================================*/

//Print the pattern 9, 99, 999, 9999, 99999, 999999, 9999999, 99999999, 999999999
class C;
  rand bit [255:0] a[];
 
  //constraint c1 { a.size == 12;}
  constraint c2 {
	           foreach ( a[ i ] )
                      {
                        if(i==0)
                           a[i] == 9;
                        else  
                           a[i] == (a[i-1]*10)+9;                                    
	              }  
	        } 
endclass

module test;
  C pkt = new();
  initial begin
    repeat(1) begin
      pkt.randomize();
      $display("%p", pkt.a);
    end
   end
endmodule

/*==================================================================================*/

//Write a SystemVerilog program to randomize a 32-bit variable, but only randomize the 12th bit.
class packet;
  rand bit [31:0]a;
  
  constraint aa { foreach(a[i])
                    { 
                      if(i==12)
                        a[i] inside {0,1};
                      else 
                        a[i] == 0;
                    }  
                }
  
    function void post_randomize();
        $display("A in Post randomize=%b",a);   
    endfunction
endclass

module test 
  packet pkt = new();
  initial begin
    repeat(5) begin
      pkt.randomize();
      $display("%p",pkt.a);
      $display("Aa= %d AA=%b", pkt.a, pkt.a);
    end
  end
endmodule

/*==================================================================================*/
//constraint to generate 0, 5, -10, 15 , -20, 25,...
class packet;

  rand int a[10];
  rand int b[9];
   
  constraint aa { foreach(a[i])
                     {
                       if(i%2==0)
                         a[i] == i*-5;
                       else
                         a[i] == i*5;
                     }
                } 
endclass

module test;
  packet pkt = new();
  initial begin
    repeat(3) begin
    pkt.randomize();
    //$display("%p", pkt.b);
      $display("%p", pkt.a);
  end
  end
endmodule

/*==================================================================================*/
//Print unique values without using a unique keywords
class C;
  rand int unsigned a[];
 
  constraint c1 { a.size == 10; }
  constraint c2 { foreach ( a [i] )
                   {
                     a[i] == i*2; 
                   }             
                } 
endclass

module test;
  C pkt = new();
  initial begin
    repeat(1) begin
      pkt.randomize();
      $display("%p", pkt.a);
    end
  end
endmodule
/*==================================================================================*/
//Constraint for Ascending order pattern
class C;
  rand bit [3:0] A[] ;
  constraint c1 { A.size == 10; }
  constraint c2 { foreach ( A[ k ] ) (k < A.size - 1) -> A[k + 1] > A[k]; }
endclass

module test;
  C pkt = new();
  initial begin
    repeat(3) begin
      pkt.randomize();
      $display("%p", pkt.A);
    end
  end
endmodule
/*==================================================================================*/
//Constraint for discending order pattern
class C;
  rand bit [3:0] A[] ;
  constraint c1 { A.size == 10; }
  constraint c2 { foreach ( A[ k ] ) (k < A.size - 1) -> A[k + 1] < A[k];}
endclass

module test;
  C pkt = new();
  initial begin
    repeat(3) begin
      pkt.randomize();
      $display("%p", pkt.A);
    end
  end
endmodule
/*==================================================================================*/
//Diagonal array values should be odd numbers
class packet;
  rand bit[3:0] a [2:0][2:0] ;             
  constraint aa_c {
	            foreach(a[i,j])
                      {
                        if(i == j && j == i) 
                           a[i][j] % 2 == 1; 
                        else
                           a[i][j] % 2 == 0; 
                      }
                   }
endclass

module func_constr;
  initial begin
    packet pkt;
    pkt = new();
    repeat(1) begin
      pkt.randomize();
      foreach (pkt.a[i,j])
        $display("\t aaray[%0d,%0d] = %0d",i,j,pkt.a[i][j]);      
    end
  end
endmodule
/*==================================================================================*/
// Print this pattern 001001001001
class constr;
  rand bit a [12];
constraint seq_gen{
                   foreach(a[i])
                     if(i%3==0  || i%3==1 )
                       a[i] == 0;
                     else 
                        a[i] == 1;
                  }
endclass

module test;
constr c = new();
initial begin
  c.randomize();
  $display("%p",c.a);
  end
endmodule
/*==================================================================================*/
// Print this pattern 011011011011
class constr;
  rand bit a [12];
constraint seq_gen{
                   foreach(a[i])
                     if(i%3==0)
                       a[i] == 0;
                     else 
                        a[i] == 1;
                  }
endclass

module test;
constr c = new();
initial begin
  c.randomize();
  $display("%p",c.a);
  end
endmodule
/*==================================================================================*/
//For Below code what is the output and why?
module test;
 bit a;
  initial begin
    a = 0;
    a <= 1;
    $display("a=%0b",a);
  end
endmodule

output is  a = 0;

/*==================================================================================*/
//Generate a Pattern 2,5,8,11,14.......
class abc;
  rand bit [4:0]a[10];
  constraint ss{ 
	         foreach(a[i])
	            {
                       if(i==0)
      	         	 a[i]==2;
                       else
                          a[i]==(a[i-1]+3);
                    }
               }
endclass
   
module test;
  initial begin
  abc ab;
  ab=new();
    ab.randomize();
    $display("value of b=%p",ab.a);
  end
endmodule
/*==================================================================================*/
Limitations: A dist operation shall not be applied to randc variables.
             A dist expression requires that expression contain at least one rand variable.
/*==================================================================================*/
// Write a constraint to generate 1100110011001100 
class packet;
  rand bit A [];
  constraint c1 {A.size() == 16 ;}
  constraint c2 {foreach (A[i]) 
                    {
                       if(i%4 == 0 || i%4 == 1) 
			 {
                            A[i] == 1; 
	                 }
                       else    
                            A[i] == 0;
	             } 
	         }
endclass
      
module top;
 packet pkt;
 initial begin
   pkt = new();
   pkt.randomize();
   $display("pattern of the array is %p",pkt.A);
 end
endmodule
/*==================================================================================*/
// Write a constraint to generate 000111000111
class packet;
  rand bit A [];
  constraint c1 {A.size() == 16 ;}
  constraint c2 {foreach (A[i]) 
                    {
                      if(i%6 == 0 || i%6 == 1 || i%6==2) 
			 {
                            A[i] == 0; 
	                 }
                      else    
                         A[i] == 1;
	             } 
	         }
endclass
      
module top;
 packet pkt;
 initial begin
   pkt = new();
   pkt.randomize();
   $display("pattern of the array is %p",pkt.A);
 end
endmodule

/*==================================================================================*/
//Pattern to print 000000011000000011
class C;
  rand bit [3:0] A[] ;
  constraint c1 {A.size == 35;}
  constraint c2 {
	         foreach ( A[ k ] )
                    {
                       if(k%9==0 || k%9==1 || k%9==2 || k%9==3 || k%9==4 || k%9==5 || k%9==6)
                          A[k] == 0;
                       else 
                          A[k] == 1;   
                    }             
	        }
endclass

module test;
  C pkt = new();
  initial begin
    repeat(1) begin
      pkt.randomize();
      $display("%p", pkt.A);
    end
  end
endmodule
/*==================================================================================*/
//Pattern to print 010203302010
class packet;
  rand bit[7:0]a[12];
  constraint cc{
                  foreach(a[i])
                     {
                       if(i<=5)
                         {
                            if(i%2==0)
                               {
                                  a[i]==0;
                               }
                            else
                               {
                                  a[i]==(i+1)/2;
                               }
                         }
                       else
                         {
                            a[i]==a[11-i];
                         }
                     }
               }
endclass

module func_constr;
  initial begin
    packet pkt;
    pkt = new();
    pkt.randomize();
    $display("\t aaray = %p",pkt.a);      
   end
endmodule

OR: 
//       Note: Avoid unnecessary curly brackets	

class packet;
rand bit[7:0]a[12];
constraint cc{foreach(a[i])
                 {
                   if(i<=5)
                     if(i%2==0)
                        a[i]==0;
                     else
                        a[i]==(i+1)/2;
                   else
                      a[i]==a[11-i];
                }
            }
endclass

module func_constr;
  initial begin
    packet pkt;
    pkt = new();
    pkt.randomize();
    $display("\t aaray = %p",pkt.a);      
   end
endmodule

/*==================================================================================*/
//Multiple processes execution with disable fork
class multiple_process_class;
  string name;
  task multiple_process(input int unsigned delay);
    fork
      begin
      //  forever begin
       #20;
          $display($time, "%s, Process:1", name);
        end
        begin
          #15;
          $display($time, "%s, Process:4", name);
     //   end
      end
       begin
          #10;
         $display($time, "%s, Process:5", name);
       end
    join_any
     // end
   // join_none
    
    fork
      begin
       #delay;
        $display($time, "%s, Process:2", name);
      end
      begin
       #2;
        $display($time, "%s, Process:3", name);
      end
    join_any
  disable fork;
      $display($time, "%s, multiple Process completed", name);
   endtask
endclass

      module test;
        
        multiple_process_class a1, a2;
        initial begin
        a1 = new();
        a1.name = "a1";
        a2 = new();
        a2.name = "a2";
        fork
          a1.multiple_process(7);
          a2.multiple_process(9);
        join
        #30 $finish;
        end
      endmodule

 Result:
	   10a1, Process:5
           10a2, Process:5
           12a1, Process:3
           12a1, multiple Process completed
           12a2, Process:3
           12a2, multiple Process completed
$finish called from file "testbench.sv", line 50.
$finish at simulation time                   42
           V C S   S i m u l a t i o n   R e p o r t 
/*==================================================================================*/
//Multi dimensional array diagonal values should be odd remaining even values
class packet;

  rand bit[3:0] a [2:0][2:0] [2:0];
                          
  constraint aa_c { foreach(a[i,j,k]){
                          if (i == j && j == k && k==i) 
                               a[i][j][k] % 2 == 1; 
                            else
                                a[i][j][k] % 2 == 0; 
   }
  }
endclass

module func_constr;
  initial begin
    packet pkt;
    pkt = new();
    repeat(1) begin
      pkt.randomize();
      foreach (pkt.a[i,j,k])
             $display("\t array[%0d,%0d,%0d] = %0d",i,j,k,pkt.a[i][j][k]);      
    end
  end
endmodule

Result:
	 array[2,2,2] = 3
	 array[2,2,1] = 8
	 array[2,2,0] = 4
	 array[2,1,2] = 12
	 array[2,1,1] = 2
	 array[2,1,0] = 10
	 array[2,0,2] = 4
	 array[2,0,1] = 0
	 array[2,0,0] = 14
	 array[1,2,2] = 8
	 array[1,2,1] = 12
	 array[1,2,0] = 10
	 array[1,1,2] = 0
	 array[1,1,1] = 11
	 array[1,1,0] = 10
	 array[1,0,2] = 12
	 array[1,0,1] = 12
	 array[1,0,0] = 4
	 array[0,2,2] = 6
	 array[0,2,1] = 8
	 array[0,2,0] = 2
	 array[0,1,2] = 14
	 array[0,1,1] = 10
	 array[0,1,0] = 4
	 array[0,0,2] = 10
	 array[0,0,1] = 0
	 array[0,0,0] = 11
/*==================================================================================*/
//Write a system verilog constraint for fibonacci series
class packet;
  rand bit [3:0] a [];
       bit kk;
  
  constraint a_size {a.size == 20;}
  
  constraint fibonacci_series { 
                           foreach(a[kk]){
                           if(kk==0)
                              a[kk] == 0;
                           else if(kk==1)
                              a[kk] == 1;
                           else a[kk] == a[kk-1]+a[kk-2];
    }    }
  
endclass

module test;
packet pkt = new();
initial begin
  repeat(1) begin
    pkt.randomize();
    $display("%p", pkt.a);
  end
end 
endmodule
/*==================================================================================*/
//For Below code what is the output and why?
module test;
 bit a;
  initial begin
    a = 0;
    a <= 1;
    $display("a=%0b",a);
  end
endmodule

output is  a = 0; 
   o a is declared as a bit type variable
   o In the initial block a is first assigend the value 0 using the non-blocking assignment a=0
   o Then, there is another assignment a<=1 using blocking assignment.
   o However,non-blocking assignments schedule the assigned value to be updated at the end of the current simulation time step. So even though a is assigned value 1, it doesn't update immediately.
   o $display statement is executed immediately after assignment, so that point, the scheduled update from the non-blocking assignment has not occured yet
   o Hence, the displayed output is a=0.

/*==================================================================================*/
//For Below code what is the output and why?
module test;
 int a;
  initial begin
    a = 20;
    a <= 30;
    $display("a1=%0d",a);
  end
  final begin
    $display("a2=%0d",a);
  end
endmodule
output:
       # run -all
       # a1=20
       # exit
       # a2=30
/==================================================================================/
17
//Generate the constraint pattern 001002003004....
//001002003004
class packet;
  rand bit [3:0] a [];
  constraint ab {a.size() == 16;}
  constraint aa {foreach(a[i])
                    if(i%3 == 0 || i%3 == 1)            
                       a[i] == 0;
                    else 
                       a[i] == (i+1)/3;
                }
endclass

module test;
  packet pkt = new();
  initial begin
    pkt.randomize();
    $display("%p", pkt.a);
  end
endmodule
/==================================================================================/
18
//Generate the constraint pattern 0001000200030004...

class packet;
  rand bit [3:0] a [];
  constraint ab {a.size() == 16;}
  constraint aa {foreach(a[i])
    if(i%4 == 0 || i%4 == 1 || i%4 ==2)            
                        a[i] == 0;
                    else 
                      a[i] == (i+1)/4;
     }
endclass

module test;
  packet pkt = new();
  initial begin
    pkt.randomize();
    $display("%p", pkt.a);
  end
endmodule

/==================================================================================/
𝐎𝐮𝐭-𝐨𝐟-𝐨𝐫𝐝𝐞𝐫 𝐭𝐫𝐚𝐧𝐬𝐚𝐜𝐭𝐢𝐨𝐧𝐬 𝐢𝐧 𝐀𝐗𝐈:
The concept of out-of-order transactions in the context of the AXI (Advanced eXtensible Interface) protocol is related to how data transfers and requests are handled within a system-on-chip (SoC). 

In an AXI-based system, transactions typically include read and write requests for data transfers between different components such as CPUs, memory, and peripherals. These transactions are supposed to follow a specific order to ensure data consistency and maintain the integrity of the system. However, in some cases, it's beneficial to allow transactions to occur out of order.

Let's consider an example of out-of-order transactions in an AXI-based system involving a CPU, memory, and multiple peripherals. This scenario highlights the potential performance benefits of out-of-order transactions:

Suppose you have a CPU that needs to perform the following tasks:

1. Read data from memory.
2. Write data to a display peripheral.
3. Read data from a sensor peripheral.
4. Write data to memory.

In a strictly in-order transaction system, the CPU would have to wait for each transaction to complete before starting the next one. This could result in inefficient use of the CPU's processing power and the system's interconnect, as it would introduce idle time between transactions.

In contrast, with out-of-order transactions:

1. The CPU can issue the read data from memory request.
2. While waiting for the memory read to complete, the CPU can issue the write data to the display peripheral request, as these two transactions are independent and don't depend on each other.
3. As the CPU continues to wait for the memory read, it can also issue the read data from the sensor peripheral request.
4. Finally, after the memory read completes, the CPU can issue the write data to memory request.

In this out-of-order scenario, the CPU's idle time is minimized, and the system's interconnect resources are better utilized because independent transactions are allowed to proceed simultaneously. This leads to improved system throughput and reduced latency, which is especially important in real-time and high-performance applications.

However, it's important to ensure that mechanisms are in place to handle data dependencies, maintain data coherency, and manage potential conflicts when transactions are allowed to occur out of order.

/*==================================================================================*/
