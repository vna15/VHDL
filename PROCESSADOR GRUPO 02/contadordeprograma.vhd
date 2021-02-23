library ieee;
use ieee.std_logic_1164.all;

entity contadordeprograma is
    port (pc_ld, pc_clr, clk, en_paralelo : in std_logic;
	       pc_jump : in std_logic_vector(7 downto 0);
	       instrucao : out std_logic_vector(7 downto 0));
end contadordeprograma;

architecture ckt of contadordeprograma is

component Registrador8bitsPC is
  port (X, pc_jump : in  std_logic_vector (7 downto 0);
        ld, clr, clk, en_paralelo : in std_logic;
        Q : out std_logic_vector (7 downto 0));
end component;

component Somador8bits is
  port ( X, Y : in  std_logic_vector(7 downto 0);
           ci : in std_logic;
            Q : out std_logic_vector(7 downto 0);
            cout : out std_logic);
end component;

signal aux_instrucao, data : std_logic_vector(7 downto 0);
signal aux_cout : std_logic;

begin


      reg : registrador8bitsPC port map(X => data, pc_jump => pc_jump, ld => pc_ld, clr => pc_clr, clk => clk, en_paralelo => en_paralelo, Q => aux_instrucao);
		
		soma1 : somador8bits port map(X => aux_instrucao, Y => "00000001", ci => '0', Q => data, cout => aux_cout);

instrucao <= aux_instrucao;

end ckt;