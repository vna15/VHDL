library ieee;
use ieee.std_logic_1164.all;

entity decodificador is
  port(X : in std_logic_vector(3 downto 0);
       en : in std_logic;
		 Q : out std_logic_vector(15 downto 0));
end decodificador;

architecture ckt of decodificador is

   signal aux_2 : std_logic_vector(15 downto 0);	
	
	begin
	
	aux_2(0) <= en and not(X(3)) and not(X(2)) and not(X(1)) and not(X(0));
	aux_2(1) <= en and not(X(3)) and not(X(2)) and not(X(1)) and X(0);
	aux_2(2) <= en and not(X(3)) and not(X(2)) and X(1) and not(X(0));
	aux_2(3) <= en and not(X(3)) and not(X(2)) and X(1) and X(0);
	aux_2(4) <= en and not(X(3)) and X(2) and not(X(1)) and not(X(0));
	aux_2(5) <= en and not(X(3)) and X(2) and not(X(1)) and X(0);
	aux_2(6) <= en and not(X(3)) and X(2) and X(1) and not(X(0));
	aux_2(7) <= en and not(X(3)) and X(2) and X(1) and X(0);
	aux_2(8) <= en and X(3) and not(X(2)) and not(X(1)) and not(X(0));
	aux_2(9) <= en and X(3) and not(X(2)) and not(X(1)) and X(0);
	aux_2(10) <= en and X(3) and not(X(2)) and X(1) and not(X(0));
	aux_2(11) <= en and X(3) and not(X(2)) and X(1) and X(0);
	aux_2(12) <= en and X(3) and X(2) and not(X(1)) and not(X(0));
	aux_2(13) <= en and X(3) and X(2) and not(X(1)) and X(0);
	aux_2(14) <= en and X(3) and X(2) and X(1) and not(X(0));
	aux_2(15) <= en and X(3) and X(2) and X(1) and X(0);
	
	Q <= aux_2;
	
end ckt;
