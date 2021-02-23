library ieee;
use ieee.std_logic_1164.all;

entity MaquinaDeVendas is
   port (c, clk, reset : in std_logic;
	       S : in std_logic_vector(7 downto 0);
	       d, led_btn : out std_logic;
	       tot_uni, tot_dez, tot_cen, a_uni, a_dez : out std_logic_vector(6 downto 0));
end MaquinaDeVendas;

architecture ckt of MaquinaDeVendas is
 
 component datapath is
   port (S,A : in std_logic_vector(7 downto 0);
	       clk2, reg_ld, reg_clr: in std_logic;
			   reg_mq : out std_logic;
			   tot2 : out std_logic_vector(7 downto 0));
 end component;
 
 component ffd is
    port (clk,D,P,C : in  std_logic;
                  q : out std_logic);
 end component;
 
 component conv_bin_bcd is
    port(SW : in std_logic_vector(7 downto 0);
         HEX2 : out std_logic_vector(6 downto 0);
         HEX1 : out std_logic_vector(6 downto 0);
         HEX0 : out std_logic_vector(6 downto 0));        
 end component;
 
 component ROM is
    port(address : in std_logic_vector(5 downto 0);
	      clock : in std_logic;
			q : out std_logic_vector(7 downto 0));
 end component;

 component Contador is
  port (ld_cnt, clk, clr_cnt : in std_logic;
        Q : out std_logic_vector (5 downto 0));
 end component; 
 
 component button is
  port (C, clk, reset : in std_logic;
        btn : out std_logic);
 end component;
 
 component CLK_Div is
  port (clk_in : in std_logic;
         clk_out : out std_logic);
 end component;
    
 
 signal reg_c_ld, reg_c_clr, n1, n0, s1, s0, tot_lt, not_reset, btn, clk_aux : std_logic;
 signal tot_aux, A : std_logic_vector(7 downto 0);
 signal cnt_out : std_logic_vector(5 downto 0);
 signal a_cen: std_logic_vector(6 downto 0);

 
 begin
 
  not_reset <= not(reset);
  
  botao : button port map(C=>c,clk=>clk_aux,reset=>reset,btn=>btn); 
  comando : datapath port map(S=>S,A=>A,clk2=>clk_aux,reg_ld=>reg_c_ld,reg_clr=>reg_c_clr,reg_mq=>tot_lt,tot2=>tot_aux);
  contar : Contador port map(ld_cnt=>btn,clk=>clk_aux,clr_cnt=>reset,Q=>cnt_out);
  memoria : ROM port map(address=>cnt_out,clock=>clk_aux,q=>A);
  clkk : CLK_Div port map(clk_in=>clk,clk_out=>clk_aux);
  

  
  s11 : ffd port map(clk=>clk_aux,D=>n1,P=>'1',C=>reset,q=>s1);
  s00 : ffd port map(clk=>clk_aux,D=>n0,P=>'1',C=>reset,q=>s0);
  
  n1 <= (not(s1) and s0 and not(btn) and tot_lt) or (not(s1) and s0 and btn);
  n0 <= (not(s1) and s0 and not(btn)) or not(s0);
  reg_c_ld <= s1 and not(s0);
  reg_c_clr <= not(not(s1) and not(s0));
  d <= s1 and s0;
  led_btn <= btn;
  
  display_tot : conv_bin_bcd port map(SW=>tot_aux,HEX2=>tot_cen,HEX1=>tot_dez,HEX0=>tot_uni);
  display_A : conv_bin_bcd port map(SW=>A,HEX2=>a_cen,HEX1=>a_dez,HEX0=>a_uni);
  										
  end ckt;
  
	