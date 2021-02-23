--
-- Somador de 8 bits.
--

library ieee;
use ieee.std_logic_1164.all;

entity adder_8_bits is port
( 	
	X,Y: in  std_logic_vector(7 downto 0); 			-- Entradas do Somador.
	ci: in std_logic; 										-- Carry In.
   Q: out std_logic_vector(7 downto 0);				-- Saída do Somador.
   cout: out std_logic 										-- Carry Out.
);

end adder_8_bits;

architecture hardware of adder_8_bits is
  signal co : std_logic_vector (7 downto 0);
  begin															-- Lógica do Somador.
    co(0) <= ci;
    Q(0)  <=  Y(0) xor X(0) xor co(0);
    co(1) <= (Y(0) and co(0)) or (X(0) and co(0)) or (X(0) and Y(0));
    Q(1)  <=  Y(1) xor X(1) xor co(1);
    co(2) <= (Y(1) and co(1)) or (X(1) and co(1)) or (X(1) and Y(1));
    Q(2)  <=  Y(2) xor X(2) xor co(2);
    co(3) <= (Y(2) and co(2)) or (X(2) and co(2)) or (X(2) and Y(2));
    Q(3)  <=  Y(3) xor X(3) xor co(3);
    co(4) <= (Y(3) and co(3)) or (X(3) and co(3)) or (X(3) and Y(3));
    Q(4)  <=  Y(4) xor X(4) xor co(4);
    co(5) <= (Y(4) and co(4)) or (X(4) and co(4)) or (X(4) and Y(4));
    Q(5)  <=  Y(5) xor X(5) xor co(5);
    co(6) <= (Y(5) and co(5)) or (X(5) and co(5)) or (X(5) and Y(5));
    Q(6)  <=  Y(6) xor X(6) xor co(6);
    co(7) <= (Y(6) and co(6)) or (X(6) and co(6)) or (X(6) and Y(6));
    Q(7)  <=  Y(7) xor X(7) xor co(7);
    cout <= (Y(7) and co(7)) or (X(7) and co(7)) or (X(7) and Y(7));
end hardware;