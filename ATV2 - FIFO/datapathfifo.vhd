library ieee;
use ieee.std_logic_1164.all;

entity datapath is
  port (clk, clr, inc_f, inc_i, wr, rd : in std_logic;
        w_data : in std_logic_vector(12 downto 0);
		  eq : out std_logic;
		  r_data : out std_logic_vector(12 downto 0));
end datapath;

architecture ckt of datapath is

  component ContadorDP is
    port (ld_cnt, clk, clr_cnt : in std_logic;
          Q : out std_logic_vector (3 downto 0));
  end component;
  
  component ComparadorMagnitude8bits is
    port(X, Y : in std_logic_vector(7 downto 0);
         Q : out std_logic);
  end component;
  
  component decodificador is
    port(X : in std_logic_vector(3 downto 0);
       en : in std_logic;
		 Q : out std_logic_vector(15 downto 0));
  end component;
  
  component Registrador13bits is
    port (X : in  std_logic_vector (12 downto 0);
          ld_w, clr, clk : in std_logic;
          Q : out std_logic_vector (12 downto 0));
  end component;
  
  component multiplexador is
    port(X, en : in std_logic_vector(15 downto 0);
		 Q : out std_logic);
  end component;

  
  signal cont_fim_out, cont_inicio_out : std_logic_vector(3 downto 0);
  signal add_out_w, add_out_r : std_logic_vector(15 downto 0);
  signal q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15 : std_logic_vector(12 downto 0);
  
  
  begin
  
    cont_fim : ContadorDP port map(ld_cnt=>inc_f,clk=>clk,clr_cnt=>clr,Q=>cont_fim_out);
	 cont_inicio : ContadorDP port map(ld_cnt=>inc_i,clk=>clk,clr_cnt=>clr,Q=>cont_inicio_out);
	 comparar : ComparadorMagnitude8bits port map(X(7)=>'0',X(6)=>'0',X(5)=>'0',X(4)=>'0',X(3)=>cont_fim_out(3),X(2)=>cont_fim_out(2),
	                                     X(1)=>cont_fim_out(1),X(0)=>cont_fim_out(0),
													 Y(7)=>'0',Y(6)=>'0',Y(5)=>'0',Y(4)=>'0',Y(3)=>cont_inicio_out(3),Y(2)=>cont_inicio_out(2),
	                                     Y(1)=>cont_inicio_out(1),Y(0)=>cont_inicio_out(0),Q=>eq);
	 decodificar_w : decodificador port map(X=>cont_fim_out,en=>wr,Q=>add_out_w);
	 decodificar_r : decodificador port map(X=>cont_inicio_out,en=>rd,Q=>add_out_r);
	 
	 	 
	 reg0 : Registrador13bits port map(X=>w_data,ld_w=>add_out_w(0),clr=>clr,clk=>clk,Q=>q0);
	 reg1 : Registrador13bits port map(X=>w_data,ld_w=>add_out_w(1),clr=>clr,clk=>clk,Q=>q1);
	 reg2 : Registrador13bits port map(X=>w_data,ld_w=>add_out_w(2),clr=>clr,clk=>clk,Q=>q2);
	 reg3 : Registrador13bits port map(X=>w_data,ld_w=>add_out_w(3),clr=>clr,clk=>clk,Q=>q3);
	 reg4 : Registrador13bits port map(X=>w_data,ld_w=>add_out_w(4),clr=>clr,clk=>clk,Q=>q4);
	 reg5 : Registrador13bits port map(X=>w_data,ld_w=>add_out_w(5),clr=>clr,clk=>clk,Q=>q5);
	 reg6 : Registrador13bits port map(X=>w_data,ld_w=>add_out_w(6),clr=>clr,clk=>clk,Q=>q6);
	 reg7 : Registrador13bits port map(X=>w_data,ld_w=>add_out_w(7),clr=>clr,clk=>clk,Q=>q7);
	 reg8 : Registrador13bits port map(X=>w_data,ld_w=>add_out_w(8),clr=>clr,clk=>clk,Q=>q8);
	 reg9 : Registrador13bits port map(X=>w_data,ld_w=>add_out_w(9),clr=>clr,clk=>clk,Q=>q9);
	 reg10 : Registrador13bits port map(X=>w_data,ld_w=>add_out_w(10),clr=>clr,clk=>clk,Q=>q10);
	 reg11 : Registrador13bits port map(X=>w_data,ld_w=>add_out_w(11),clr=>clr,clk=>clk,Q=>q11);
	 reg12 : Registrador13bits port map(X=>w_data,ld_w=>add_out_w(12),clr=>clr,clk=>clk,Q=>q12);
	 reg13 : Registrador13bits port map(X=>w_data,ld_w=>add_out_w(13),clr=>clr,clk=>clk,Q=>q13);
	 reg14 : Registrador13bits port map(X=>w_data,ld_w=>add_out_w(14),clr=>clr,clk=>clk,Q=>q14);
	 reg15 : Registrador13bits port map(X=>w_data,ld_w=>add_out_w(15),clr=>clr,clk=>clk,Q=>q15);
	 
	 mux0 : multiplexador port map(x(0)=>q0(0),x(1)=>q1(0),x(2)=>q2(0),x(3)=>q3(0),x(4)=>q4(0),x(5)=>q4(0),x(6)=>q6(0),x(7)=>q7(0),
	                               x(8)=>q8(0),x(9)=>q9(0),x(10)=>q10(0),x(11)=>q11(0),x(12)=>q12(0),x(13)=>q13(0),x(14)=>q14(0),x(15)=>q15(0),
											 en=>add_out_r,Q=>r_data(0));
    mux1 : multiplexador port map(x(0)=>q0(1),x(1)=>q1(1),x(2)=>q2(1),x(3)=>q3(1),x(4)=>q4(1),x(5)=>q4(1),x(6)=>q6(1),x(7)=>q7(1),
	                               x(8)=>q8(1),x(9)=>q9(1),x(10)=>q10(1),x(11)=>q11(1),x(12)=>q12(1),x(13)=>q13(1),x(14)=>q14(1),x(15)=>q15(1),
											 en=>add_out_r,Q=>r_data(1));
	 mux2 : multiplexador port map(x(0)=>q0(2),x(1)=>q1(2),x(2)=>q2(2),x(3)=>q3(2),x(4)=>q4(2),x(5)=>q4(2),x(6)=>q6(2),x(7)=>q7(2),
	                               x(8)=>q8(2),x(9)=>q9(2),x(10)=>q10(2),x(11)=>q11(2),x(12)=>q12(2),x(13)=>q13(2),x(14)=>q14(2),x(15)=>q15(2),
											 en=>add_out_r,Q=>r_data(2));
	 mux3 : multiplexador port map(x(0)=>q0(3),x(1)=>q1(3),x(2)=>q2(3),x(3)=>q3(3),x(4)=>q4(3),x(5)=>q4(3),x(6)=>q6(3),x(7)=>q7(3),
	                               x(8)=>q8(3),x(9)=>q9(3),x(10)=>q10(3),x(11)=>q11(3),x(12)=>q12(3),x(13)=>q13(3),x(14)=>q14(3),x(15)=>q15(3),
											 en=>add_out_r,Q=>r_data(3));
	 mux4 : multiplexador port map(x(0)=>q0(4),x(1)=>q1(4),x(2)=>q2(4),x(3)=>q3(4),x(4)=>q4(4),x(5)=>q4(4),x(6)=>q6(4),x(7)=>q7(4),
	                               x(8)=>q8(4),x(9)=>q9(4),x(10)=>q10(4),x(11)=>q11(4),x(12)=>q12(4),x(13)=>q13(4),x(14)=>q14(4),x(15)=>q15(4),
											 en=>add_out_r,Q=>r_data(4));
	 mux5 : multiplexador port map(x(0)=>q0(5),x(1)=>q1(5),x(2)=>q2(5),x(3)=>q3(5),x(4)=>q4(5),x(5)=>q4(5),x(6)=>q6(5),x(7)=>q7(5),
	                               x(8)=>q8(5),x(9)=>q9(5),x(10)=>q10(5),x(11)=>q11(5),x(12)=>q12(5),x(13)=>q13(5),x(14)=>q14(5),x(15)=>q15(5),
											 en=>add_out_r,Q=>r_data(5));
	 mux6 : multiplexador port map(x(0)=>q0(6),x(1)=>q1(6),x(2)=>q2(6),x(3)=>q3(6),x(4)=>q4(6),x(5)=>q4(6),x(6)=>q6(6),x(7)=>q7(6),
	                               x(8)=>q8(6),x(9)=>q9(6),x(10)=>q10(6),x(11)=>q11(6),x(12)=>q12(6),x(13)=>q13(6),x(14)=>q14(6),x(15)=>q15(6),
											 en=>add_out_r,Q=>r_data(6));
	 mux7 : multiplexador port map(x(0)=>q0(7),x(1)=>q1(7),x(2)=>q2(7),x(3)=>q3(7),x(4)=>q4(7),x(5)=>q4(7),x(6)=>q6(7),x(7)=>q7(7),
	                               x(8)=>q8(7),x(9)=>q9(7),x(10)=>q10(7),x(11)=>q11(7),x(12)=>q12(7),x(13)=>q13(7),x(14)=>q14(7),x(15)=>q15(7),
											 en=>add_out_r,Q=>r_data(7));
	 mux8 : multiplexador port map(x(0)=>q0(8),x(1)=>q1(8),x(2)=>q2(8),x(3)=>q3(8),x(4)=>q4(8),x(5)=>q4(8),x(6)=>q6(8),x(7)=>q7(8),
	                               x(8)=>q8(8),x(9)=>q9(8),x(10)=>q10(8),x(11)=>q11(8),x(12)=>q12(8),x(13)=>q13(8),x(14)=>q14(8),x(15)=>q15(8),
											 en=>add_out_r,Q=>r_data(8));
	 mux9 : multiplexador port map(x(0)=>q0(9),x(1)=>q1(9),x(2)=>q2(9),x(3)=>q3(9),x(4)=>q4(9),x(5)=>q4(9),x(6)=>q6(9),x(7)=>q7(9),
	                               x(8)=>q8(9),x(9)=>q9(9),x(10)=>q10(9),x(11)=>q11(9),x(12)=>q12(9),x(13)=>q13(9),x(14)=>q14(9),x(15)=>q15(9),
											 en=>add_out_r,Q=>r_data(9));
	 mux10 : multiplexador port map(x(0)=>q0(10),x(1)=>q1(10),x(2)=>q2(10),x(3)=>q3(10),x(4)=>q4(10),x(5)=>q4(10),x(6)=>q6(10),x(7)=>q7(10),
	                               x(8)=>q8(10),x(9)=>q9(10),x(10)=>q10(10),x(11)=>q11(10),x(12)=>q12(10),x(13)=>q13(10),x(14)=>q14(10),x(15)=>q15(10),
											 en=>add_out_r,Q=>r_data(10));
	 mux11 : multiplexador port map(x(0)=>q0(11),x(1)=>q1(11),x(2)=>q2(11),x(3)=>q3(11),x(4)=>q4(11),x(5)=>q4(11),x(6)=>q6(11),x(7)=>q7(11),
	                               x(8)=>q8(11),x(9)=>q9(11),x(10)=>q10(11),x(11)=>q11(11),x(12)=>q12(11),x(13)=>q13(11),x(14)=>q14(11),x(15)=>q15(11),
											 en=>add_out_r,Q=>r_data(11));
	 mux12 : multiplexador port map(x(0)=>q0(12),x(1)=>q1(12),x(2)=>q2(12),x(3)=>q3(12),x(4)=>q4(12),x(5)=>q4(12),x(6)=>q6(12),x(7)=>q7(12),
	                               x(8)=>q8(12),x(9)=>q9(12),x(10)=>q10(12),x(11)=>q11(12),x(12)=>q12(12),x(13)=>q13(12),x(14)=>q14(12),x(15)=>q15(12),
											 en=>add_out_r,Q=>r_data(12));
											 
	 
end ckt;
	 
	 
	 
	 
	 
	 
	 
	 