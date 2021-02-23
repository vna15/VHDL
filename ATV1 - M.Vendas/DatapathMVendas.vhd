library ieee;
use ieee.std_logic_1164.all;

entity datapath is
   port (S,A : in std_logic_vector(7 downto 0);
	       clk2, reg_ld, reg_clr: in std_logic;
			   reg_mq : out std_logic;
			   tot2 : out std_logic_vector(7 downto 0));
end datapath;

architecture ckt of datapath is

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
 
 component Somador8bits is
   port ( X : in  std_logic_vector(7 downto 0);
           Y : in  std_logic_vector(7 downto 0);
           ci : in std_logic;
            Q : out std_logic_vector(7 downto 0);
            cout : out std_logic);
 end component;
 
 signal reg_out, soma_out : std_logic_vector(7 downto 0);
 signal gb, comp_out, aux_clr, aux_gb : std_logic;
 
 begin
 
 registrar : Registrador8bits port map(X=>soma_out,ld=>reg_ld,clr=>reg_clr,clk=>clk2,cout2=>gb,coutc=>aux_gb,Q=>reg_out);
 
 somar : Somador8bits port map(X=>A,Y=>reg_out,ci=>'0',Q=>soma_out,cout=>gb);
										 
 comp : ComparadorMagnitude8bits port map(X=>S,Y=>reg_out,Q=>comp_out);
 

reg_mq <= comp_out or aux_gb;
tot2(0) <= reg_out(0);
tot2(1) <= reg_out(1);
tot2(2) <= reg_out(2);
tot2(3) <= reg_out(3);
tot2(4) <= reg_out(4);
tot2(5) <= reg_out(5);
tot2(6) <= reg_out(6);
tot2(7) <= reg_out(7);

end ckt;