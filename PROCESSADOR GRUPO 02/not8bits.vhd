--
-- Not de 8 bits
--

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Not_8_bits is port
(
	X: in std_logic_vector(7 downto 0);							-- Entradas para "lógica" da NOT de 8 bits 
	Q: out std_logic_vector(7 downto 0)							-- Saída da porta NOT de 8 bits
);
end Not_8_bits;

architecture hardware of Not_8_bits is
	begin
		Q <= not(X);
end hardware;