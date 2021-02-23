--
--	Sistema de complemento para 2
--

library IEEE;
use IEEE.std_logic_1164.all;

entity complementoA2 is port
(
	D: in std_logic_vector(7 downto 0);													-- Entradas para o complemento para 2.
	K: out std_logic_vector(7 downto 0)													-- Saída do sistema.
);
end complementoA2;

architecture hardware of complementoA2 is 
signal A1, Cin, S: std_logic_vector(7 downto 0);									-- Sinais para lógica.
begin
	A1(7) <= not(D(7));																		-- Aplicando o not no sinal de entrada.
	A1(6) <= not(D(6));
	A1(5) <= not(D(5));
	A1(4) <= not(D(4));
	A1(3) <= not(D(3));
	A1(2) <= not(D(2));
	A1(1) <= not(D(1));
	A1(0) <= not(D(0));
	
	S(0) <= '1';																				-- Vetor "unitário" para somar com o sinal A1.
	S(1) <= '0';
	S(2) <= '0';
	S(3) <= '0';
	S(4) <= '0';
	S(5) <= '0';
	S(6) <= '0';
	S(7) <= '0';
	
	Cin(0) <= '0';																				-- Carry In que do primeiro somador.
	
	K(0) <= A1(0) xor S(0) xor Cin(0);													-- Início da lógica do Complemento, soma.
   Cin(1) <= (S(0) and Cin(0)) or (A1(0) and Cin(0)) or (A1(0) and S(0));
   K(1) <= A1(1) xor S(1) xor Cin(1);
   Cin(2) <= (S(1) and Cin(1)) or (A1(1) and Cin(1)) or (A1(1) and S(1));
   K(2) <= A1(2) xor S(2) xor Cin(2);
   Cin(3) <= (S(2) and Cin(2)) or (A1(2) and Cin(2)) or (A1(2) and S(2));
   K(3) <= A1(3) xor S(3) xor Cin(3);
   Cin(4) <= (S(3) and Cin(3)) or (A1(3) and Cin(3)) or (A1(3) and S(3));
   K(4) <= A1(4) xor S(4) xor Cin(4);
   Cin(5) <= (S(4) and Cin(4)) or (A1(4) and Cin(4)) or (A1(4) and S(4));
   K(5) <= A1(5) xor S(5) xor Cin(5);
   Cin(6) <= (S(5) and Cin(5)) or (A1(5) and Cin(5)) or (A1(5) and S(5));
   K(6) <= A1(6) xor S(6) xor Cin(6);
	Cin(7) <= (S(6) and Cin(6)) or (A1(6) and Cin(6)) or (A1(6) and S(6));
	K(7) <= A1(7) xor S(7) xor Cin(7);
end hardware;