--
--	XOR de 8 bits
--

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Xor_8_bits is port
(
	X, Y: in std_logic_vector(7 downto 0);									-- Entradas para "lógica" da XOR de 8 bits 
	Q: out std_logic_vector(7 downto 0)										-- Saída da porta XOR de 8 bits
);
end Xor_8_bits;

architecture hardware of Xor_8_bits is
	begin
		Q <= X xor Y;
end hardware;