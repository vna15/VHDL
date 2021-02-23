library ieee;
use ieee.std_logic_1164.all;

entity FIFO is
   port (clk, reset, wr, rd : in std_logic;
	      em, fu : out std_logic;
			r_data_mil, r_data_cen, r_data_dez, r_data_uni, cont_dez, cont_uni : out std_logic_vector(6 downto 0));
end FIFO;

architecture ckt of FIFO is

  component datapath is
    port (clk, clr, inc_f, inc_i, wr, rd : in std_logic;
          w_data : in std_logic_vector(12 downto 0);
		    eq : out std_logic;
		    r_data : out std_logic_vector(12 downto 0));
  end component;
  
  component controle is
    port (clk, reset, wr, rd, eq : in std_logic;
         clr, rear_inc, front_inc, rf_wr, rf_rd, cheia, vazia: out std_logic);
  end component;
  
  component Contador is
    port (ld_cnt, clk, clr_cnt : in std_logic;
          Q : out std_logic_vector (5 downto 0));
  end component;
  
  component memo IS
	 port (address	: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		    clock		: IN STD_LOGIC;
		    q		: OUT STD_LOGIC_VECTOR (12 DOWNTO 0));
  end component;
  
  component conv_bin_bcd is
    port(SW : in std_logic_vector(15 downto 0);
	      HEX4 : out std_logic_vector(6 downto 0);
         HEX3 : out std_logic_vector(6 downto 0);
         HEX2 : out std_logic_vector(6 downto 0);
         HEX1 : out std_logic_vector(6 downto 0);
         HEX0 : out std_logic_vector(6 downto 0));
  end component;
  
  component Registrador13bits is
    port(X : in  std_logic_vector (12 downto 0);
         ld_w, clr, clk : in std_logic;
         Q : out std_logic_vector (12 downto 0));
  end component;
  
  component button is
    port(C, clk, reset : in std_logic;
         btn : out std_logic);
  end component;

  component CLK_Div is
    port (clk_in : in std_logic;
          clk_out : out std_logic);
  end component;
  
  signal cnt_out : std_logic_vector(5 downto 0);
  signal cont_mil, cont_cen, data_d_mil, cont_d_mil : std_logic_vector(6 downto 0);
  signal w_data_aux, r_data_aux, r_data_aux2 : std_logic_vector(12 downto 0);
  signal clr_cntrl, fim_inc, ini_inc, aux_wr, aux_rd, aux_clk, comp_out, btnrd, btnwr : std_logic;
  
  begin
  
  swrd : button port map(C=>rd,clk=>aux_clk,reset=>reset,btn=>btnrd);
  swwr : button port map(C=>wr,clk=>aux_clk,reset=>reset,btn=>btnwr);
  
  clock1 : CLK_Div port map(clk_in=>clk,clk_out=>aux_clk);
  contar : Contador port map(ld_cnt=>aux_wr,clk=>aux_clk,clr_cnt=>reset,Q=>cnt_out);
  memoria : memo port map(address=>cnt_out,clock=>aux_clk,q=>w_data_aux);
  bc : controle port map(clk=>aux_clk,reset=>reset,wr=>btnwr,rd=>btnrd,eq=>comp_out,clr=>clr_cntrl,rear_inc=>fim_inc,front_inc=>ini_inc, 
                         rf_wr=>aux_wr,rf_rd=>aux_rd,cheia=>fu,vazia=>em);
  dp : datapath port map(clk=>aux_clk,clr=>clr_cntrl,inc_f=>fim_inc,inc_i=>ini_inc,wr=>aux_wr,rd=>aux_rd,w_data=>w_data_aux,eq=>comp_out,r_data=>r_data_aux);
  registrar_saida : Registrador13bits port map(X=>r_data_aux,ld_w=>aux_rd,clr=>reset,clk=>aux_clk,Q=>r_data_aux2);
  
  display_data : conv_bin_bcd port map(SW(15)=>'0',SW(14)=>'0',SW(13)=>'0',SW(12)=>r_data_aux2(12),SW(11)=>r_data_aux2(11),SW(10)=>r_data_aux2(10),
                                       SW(9)=>r_data_aux2(9),SW(8)=>r_data_aux2(8),SW(7)=>r_data_aux2(7),SW(6)=>r_data_aux2(6),SW(5)=>r_data_aux2(5),
													SW(4)=>r_data_aux2(4),SW(3)=>r_data_aux2(3),SW(2)=>r_data_aux2(2),SW(1)=>r_data_aux2(1),SW(0)=>r_data_aux2(0),
													HEX4=>data_d_mil,HEX3=>r_data_mil,HEX2=>r_data_cen,HEX1=>r_data_dez,HEX0=>r_data_uni);
  display_cont : conv_bin_bcd port map(SW(15)=>'0',SW(14)=>'0',SW(13)=>'0',SW(12)=>'0',SW(11)=>'0',SW(10)=>'0',SW(9)=>'0',SW(8)=>'0',SW(7)=>'0',SW(6)=>'0',
                                       SW(5)=>cnt_out(5),SW(4)=>cnt_out(4),SW(3)=>cnt_out(3),SW(2)=>cnt_out(2),SW(1)=>cnt_out(1),SW(0)=>cnt_out(0),
													HEX4=>cont_d_mil,HEX3=>cont_mil,HEX2=>cont_cen,HEX1=>cont_dez,HEX0=>cont_uni);
   
  
end ckt;


    