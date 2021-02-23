library ieee;
use ieee.std_logic_1164.all;

entity Contador is
  port (ld_cnt, clk, clr_cnt : in std_logic;
        Q : out std_logic_vector (5 downto 0));
end Contador;

architecture ckt of Contador is

 component Somador8bits is
   port ( X, Y : in  std_logic_vector(7 downto 0);
           ci : in std_logic;
            Q : out std_logic_vector(7 downto 0);
            cout : out std_logic);
 end component;        

 component Registrador8bits is
   port (X : in  std_logic_vector (7 downto 0);
        ld, clr, clk, cout2 : in std_logic;
		  coutc : out std_logic;
        Q : out std_logic_vector (7 downto 0));
 end component;
 
 component ComparadorMagnitude8bits is
   port( X, Y : in std_logic_vector(7 downto 0);
        Q : out std_logic);
 end component;
 
 signal soma_um, soma_out, reg_out, comp_64 : std_logic_vector(7 downto 0);
 signal aux_not_clr_cnt, comp_out, gb, aux_gb : std_logic;
 
 begin
   
   
   aux_not_clr_cnt <= clr_cnt and not(comp_out);
   
   soma_um <= "00000001";
   comp_64 <= "01111111";
   
   registrar : Registrador8bits port map(X=>soma_out,ld=>ld_cnt,clr=>aux_not_clr_cnt,clk=>clk,cout2=>gb,coutc=>aux_gb, Q=>reg_out);
 
   somar : Somador8bits port map(X=>soma_um,Y=>reg_out,ci=>'0',Q=>soma_out,cout=>gb);
										 
   comp : ComparadorMagnitude8bits port map(X=>comp_64,Y=>reg_out,Q=>comp_out);
     
   Q(5) <= reg_out(5);
   Q(4) <= reg_out(4);
   Q(3) <= reg_out(3);
   Q(2) <= reg_out(2);
   Q(1) <= reg_out(1);
   Q(0) <= reg_out(0);
   
end ckt;