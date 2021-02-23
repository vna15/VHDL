library ieee;
use ieee.std_logic_1164.all;

entity Registrador1bit is
  port (X : in  std_logic;
        ld, clr, clk : in std_logic;
        Q : out std_logic);
end Registrador1bit;

architecture ckt of Registrador1bit is

  component ffd is
    port (clk,D,P,C : in  std_logic;
                  q : out std_logic);
  end component;
  
  signal mux, aux : std_logic;
  begin

 mux <= (X and ld) or (aux and not(ld));
ffd0 : ffd port map (clk => clk, D => mux, P => '1', C => clr, q => aux);

   Q <= aux;
     
end ckt;