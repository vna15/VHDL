--
--		Projeto ULA
--

library IEEE;
use IEEE.std_logic_1164.all;

entity ULA is port
(
	B,C: in std_logic_vector(7 downto 0);									-- Entradas da ULA
	S_full: in std_logic_vector(2 downto 0);								-- Sinais para selecionar a operação
	SEL_RF_2_SUM: in std_logic;
	Q: out std_logic_vector(7 downto 0);									-- Saída da ULA
	Carry_Out: out std_logic													-- Sinal Carry_Out
);
end ULA;

architecture hardware of ULA is

	component comparador8bit is
  
		port(X_CMP, Y_CMP : in std_logic_vector(7 downto 0);
      eq_comparador: out std_logic_vector(7 downto 0));
   end component;
	
	component Mux_8X1
		port(
			Adder_Out, And_Out, Or_Out, Not_Out, Xor_Out, Cmp_Out: in std_logic_vector(7 downto 0);
			s: in std_logic_vector(2 downto 0);
			Q: out std_logic_vector(7 downto 0)		
		);
	end component;
	component adder_8_bits
		port(
			X,Y: in  std_logic_vector(7 downto 0);
			ci: in std_logic;
			Q: out std_logic_vector(7 downto 0);
			cout: out std_logic
		);
	end component;
	component And_8_bits
		port(
			X,Y: in std_logic_vector(7 downto 0);
			Q: out std_logic_vector(7 downto 0)
		);
	end component;
	component Or_8_bits
		port(
			X,Y: in std_logic_vector(7 downto 0); 
			Q: out std_logic_vector(7 downto 0)
		);
	end component;
	component Not_8_bits
		port(
			X: in std_logic_vector(7 downto 0);
			Q: out std_logic_vector(7 downto 0)
		);
	end component;
	component Xor_8_bits
		port(
			X,Y: in std_logic_vector(7 downto 0);
			Q: out std_logic_vector(7 downto 0)
		);
	end component;
	
--	component subtrator8bit is
--  
--  port( SU81, SU82: in std_logic_vector(7 downto 0);
--        Z_SU: out std_logic_vector( 7 downto 0);
--        Cs_SU: out std_logic);
--   end component;
	
   component complementoA2 is port
  (
  	D: in std_logic_vector(7 downto 0);													-- Entradas para o complemento para 2.
  	K: out std_logic_vector(7 downto 0)													-- Saída do sistema.
   );
end component;	
	

	
	component MUX_SUM_C is
  
   port( ENTA, ENTB: in std_logic_vector(7 downto 0);
        SELECIONAR: in std_logic;    
        SS : out std_logic_vector(7 downto 0));
   end component;
	
	
	
	signal Out_sum, C_A2, REGC, Out_sub, Out_and, Out_or, Out_not, Out_xor, cmp_Out: std_logic_vector(7 downto 0);		-- Sinais Auxiliares que armazenam as saídas de cada operação.
	
	signal carry_sum, carry_sub : std_logic;
	
	begin
		x0: adder_8_bits PORT MAP(B, REGC, '0', Out_sum, Carry_Out);
		x1: And_8_bits PORT MAP(B, C, Out_and);
		x2: Or_8_bits PORT MAP(B, C, Out_or);
		x3: Xor_8_bits PORT MAP(B, C, Out_xor);
		x4: Not_8_bits PORT MAP(C, Out_not);
		x5: Mux_8X1 PORT MAP(Out_sum, Out_and, Out_or, Out_not, Out_xor, cmp_Out, S_full, Q);-- Existe sinais pré determinados para a simulação fluir.B,
		x6: comparador8bit PORT MAP(B, C, cmp_Out);
		x7: MUX_SUM_C PORT MAP(C, C_A2, SEL_RF_2_SUM, REGC);
		x8: complementoA2 PORT MAP(C, C_A2);
		
		-- x7: subtrator8bit PORT MAP(B, C, Out_sub, carry_sub);
		
		
	
end hardware;