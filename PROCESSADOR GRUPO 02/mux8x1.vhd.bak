--
-- Mux 8 x 1, 8 sinais de 8 bits.
--

library IEEE;
use IEEE.std_logic_1164.all;

entity Mux_8X1 is port
(
	Adder_Out, Sub_Out, And_Out, Or_Out, Not_Out, Xor_Out, Cmp_Out: in std_logic_vector(7 downto 0);  	-- Entradas do Mux.
	s: in std_logic_vector(2 downto 0);																						-- Sinais Seletores.
	Q: out std_logic_vector(7 downto 0)																						-- Saída do Mux.
);
end Mux_8X1;

architecture hardware of Mux_8X1 is
	begin
		with s select																												-- Lógica do Mux.
					Q <= Adder_Out when "000",																					-- Cod para selecionar a Soma
						  Sub_Out when "001",																					-- Cod para selecionar a Subtração
						  And_Out when "010",																					-- Cod para selecionar a And
						  Or_Out when "011",																						-- Cod para selecionar a Or
						  Not_Out when "100",																					-- Cod para selecionar a Not
						  Xor_Out when "101",																					-- Cod para selecionar a Xor
						  Cmp_Out when "110",																					-- Cod para selecionar o Comparador
						  "00000000" when others;
					
end hardware; 