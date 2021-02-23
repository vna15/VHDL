library ieee; 
use ieee.std_logic_1164.all;


entity controle is
  port (clk, reset, wr, rd, eq : in std_logic;
        clr, rear_inc, front_inc, rf_wr, rf_rd, cheia, vazia: out std_logic);
end controle;

architecture ckt of controle is
  type st is (Init, WaitMT, WriteMT, Wait1, Read1, Read2, Write1, Write2, WaitFull, ReadFull);
  signal estado : st ;
  begin
-----saidas --------
     
  with estado select     
  clr <= '0' when Init,
           '1' when others;
  
  with estado select     
  rear_inc <= '1' when WriteMT,
              '1' when Write1,
           '0' when others;
  
  with estado select         
  front_inc <= '1' when  Read1,
               '1' when ReadFull,
         '0' when others; 
	
  with estado select         
  rf_wr <= '1' when  WriteMT,
           '1' when Write1,
         '0' when others;	

  with estado select         
  rf_rd <= '1' when  Read1,
           '1'when ReadFull,
         '0' when others;			

  with estado select         
  cheia <= '1' when  WaitFull,
         '0' when others;
	
  with estado select         
  vazia <= '1' when  Init,
           '1' when WaitMT,
         '0' when others;
			
 ------------------
 
abc : process (clk , reset)
begin
  if reset = '0' then
    estado <= Init;
  elsif ( clk'event and clk = '1') then 
   case estado is

        when Init =>
           estado <= WaitMT;
          
         
	 when WaitMT  => 
       
        if (reset = '1' and wr = '1' ) then estado <= WriteMT;
	elsif (reset = '1' and wr = '0' ) then estado <= WaitMT;
          end if;

	when WriteMT =>
           estado <= Wait1;

	when Wait1  =>
	     
        if (reset = '1' and wr = '0' and rd = '1' ) then estado <= Read1;
	elsif (reset = '1' and wr = '0' and rd = '0' ) then estado <= Wait1;
	elsif (reset = '1' and wr = '1' ) then estado <= Write1;
          end if;
			 
	when Read1 =>
	        estado <= Read2;
			  
	when Read2  => 
       
        if (eq = '1' ) then estado <= WaitMT;
	elsif (eq = '0') then estado <= Wait1;
          end if;	
	
   when Write1 =>
	        estado <= Write2;
			  
	when Write2  => 
       
        if (eq = '1' ) then estado <= WaitFull;
	elsif (eq = '0') then estado <= Wait1;
          end if;	

        
	 when WaitFull  => 
       
        if (reset = '1' and rd = '1' ) then estado <= ReadFull;
	elsif (reset = '1' and wr = '0' ) then estado <= WaitFull;
          end if;	
	
    when ReadFull =>
	        estado <= Wait1;	
			  

end case ;
end if;
end process abc ;
end ckt ;