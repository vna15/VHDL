library ieee; 
use ieee.std_logic_1164.all;

entity mux2x1C is
   port(A0,A1 : in std_logic_vector(3 downto 0);
	     sel : in std_logic;    
      	Z : out std_logic_vector(3 downto 0));

end mux2x1C;

architecture ARKMUX of mux2x1C is
  
     begin
	with sel select
  	Z<= A0 when '0',
	    A1 when '1',
	    "0000" when others;
	  
end ARKMUX;