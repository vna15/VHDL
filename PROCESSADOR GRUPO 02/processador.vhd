library ieee;
use ieee.std_logic_1164.all;

entity processador is
    port (clk : in std_logic;
	       estadoAtual : out std_logic_vector(4 downto 0);
			 IR : out std_logic_vector(15 downto 0);
			ULA_out: out std_logic_vector(7 downto 0);
			entraMemo : out std_logic_vector(15 downto 0));
end processador;

architecture ckt of processador is

component bancoderegistradores is
    port (addr_wr, addr_rd_1, addr_rd_2 : in std_logic_vector(3 downto 0);
	       w_data : in std_logic_vector(7 downto 0);
	       wr, rd_1, rd_2, clk, clr : in std_logic;
			 r_data_1, r_data_2 : out std_logic_vector(7 downto 0));
end component;

component mde is
    port ( ck ,opHLT, opLDR, opSTR, opMOV, opADD, opSUB, opAND, opOR, opNOT, opXOR, opCMP, opJMP, opJNC,opJC,opJNZ,opJZ,flagCarry,flagULA   : in std_logic;
         SEL_addr_RF_escrita,SEL_RF_2_SUM,SEL_RF_leitura_1,en_RF_leitura_1,en_RF_leitura_2,en_RF_escrita,D_en,D_wr,flagCarry_ld,flagCarry_clr,flagULA_ld,flagULA_clr,PC_cnt,PC_ld,PC_clr,IR_ld,I_rd, junt_ld : out std_logic;
          SEL_RF   : out std_logic_vector (1 downto 0);
          SEL_ULA  : out std_logic_vector (2 downto 0);
			 estadoAtual : out std_logic_vector(4 downto 0)
);
end component;

component contadordeprograma is
    port (pc_ld, pc_clr, clk, en_paralelo : in std_logic;
	       pc_jump : in std_logic_vector(7 downto 0);
	       instrucao : out std_logic_vector(7 downto 0));
end component;

component Registrador16bits is
  port (X : in  std_logic_vector (15 downto 0);
        ld, clr, clk : in std_logic;
        Q : out std_logic_vector (15 downto 0));
end component;

component Registrador1bit is
  port (X : in  std_logic;
        ld, clr, clk : in std_logic;
        Q : out std_logic);
end component;

component Registrador8bits is
  port (X : in  std_logic_vector (7 downto 0);
        ld, clr, clk : in std_logic;
        Q : out std_logic_vector (7 downto 0));
end component;

component decodificador is
  port(X : in std_logic_vector(3 downto 0);
       en : in std_logic;
		 Q : out std_logic_vector(15 downto 0));
end component;

component ffd is
  port (clk,D,P,C : in  std_logic;
                q : out std_logic);
end component;

component ULA is port
(
	B,C: in std_logic_vector(7 downto 0);									
	S_full: in std_logic_vector(2 downto 0);								
	SEL_RF_2_SUM: in std_logic;
	Q: out std_logic_vector(7 downto 0);									
	Carry_Out: out std_logic													
);
end component;

component complementoA2 is port
(
	D: in std_logic_vector(7 downto 0);													-- Entradas para o complemento para 2.
	K: out std_logic_vector(7 downto 0)													-- Saída do sistema.
);
end component;

component mux3x1 is
   port(A0,A1,A2 : in std_logic_vector(7 downto 0);
	     sel : in std_logic_vector(1 downto 0);    
      	Z : out std_logic_vector(7 downto 0));

end component;

component mux2x1C is
   port(A0,A1 : in std_logic_vector(3 downto 0);
	     sel : in std_logic;    
      	Z : out std_logic_vector(3 downto 0));
end component;

component memoInst IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
END component;

component memoData IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
END component;





signal aux_opHLT, aux_opLDR, aux_opSTR, aux_opMOV, aux_opADD, aux_opSUB, aux_opAND, aux_opOR, aux_opNOT, aux_opXOR, aux_opCMP, aux_opJMP, aux_opJNC, aux_opJC, aux_opJNZ, aux_opJZ, aux_flagCarry, aux_flagULA, aux_carry, aux_out_carry, ula_or : std_logic;
signal aux_SEL_addr_RF_escrita, aux_SEL_RF_2_SUM, aux_SEL_RF_leitura_1, aux_en_RF_leitura_1, aux_en_RF_leitura_2, aux_en_RF_escrita, aux_D_en, aux_D_wr, aux_flagCarry_ld, aux_flagCarry_clr, aux_flagULA_ld, aux_flagULA_clr, aux_PC_cnt, aux_PC_ld, aux_PC_clr, aux_IR_ld, aux_I_rd, aux_junt_ld : std_logic;
signal aux_SEL_RF : std_logic_vector(1 downto 0);
signal aux_SEL_ULA : std_logic_vector(2 downto 0);
signal aux_instrucao, aux_REGB, aux_REGC, aux_out_ULA, aux_memo_data, aux_out_mux31, out_juntar : std_logic_vector(7 downto 0);
signal aux_mux_WR, aux_mux_RD : std_logic_vector(3 downto 0);
signal data_memoInst, aux_IR : std_logic_vector(15 downto 0);


begin

regInstrucao : Registrador16bits port map(data_memoInst, aux_IR_ld, '1', clk, aux_IR);

decodeOP : decodificador port map(aux_IR(15 downto 12), '1', Q(0) => aux_opHLT, Q(1) => aux_opLDR, Q(2) => aux_opSTR, Q(3) => aux_opMOV, Q(4) => aux_opADD, Q(5) => aux_opSUB, Q(6) => aux_opAND,
                                  Q(7) => aux_opOR, Q(8) => aux_opNOT, Q(9) => aux_opXOR, Q(10) => aux_opCMP, Q(11) => aux_opJMP, Q(12) => aux_opJNC, Q(13) => aux_opJC, Q(14) => aux_opJNZ, Q(15) => aux_opJZ);


blocoControle : mde port map(clk, aux_opHLT, aux_opLDR, aux_opSTR, aux_opMOV, aux_opADD, aux_opSUB, aux_opAND, aux_opOR, aux_opNOT, aux_opXOR, aux_opCMP, aux_opJMP, aux_opJNC, aux_opJC, aux_opJNZ, aux_opJZ, aux_out_carry, aux_flagULA,
                             aux_SEL_addr_RF_escrita, aux_SEL_RF_2_SUM, aux_SEL_RF_leitura_1, aux_en_RF_leitura_1, aux_en_RF_leitura_2, aux_en_RF_escrita, aux_D_en, aux_D_wr, aux_flagCarry_ld, aux_flagCarry_clr, aux_flagULA_ld, aux_flagULA_clr, aux_PC_cnt, aux_PC_ld, aux_PC_clr, aux_IR_ld, aux_I_rd, aux_junt_ld,
									  aux_SEL_RF, aux_SEL_ULA, estadoAtual);
									  
contadorPrograma : contadordeprograma port map(aux_pc_cnt, aux_pc_clr, clk, aux_pc_ld, aux_IR(7 downto 0), aux_instrucao);


blocoULA : ULA port map(aux_REGB, aux_REGC, aux_SEL_ULA, aux_seL_RF_2_SUM, aux_out_ULA, aux_carry);


--regCarry : ffd port map(aux_flagCarry_ld, aux_carry, '1', aux_flagCarry_clr, aux_out_carry); 
regCarry : Registrador1bit port map(aux_carry, aux_flagCarry_ld,aux_flagCarry_clr, clk, aux_out_carry); 

ula_or <= aux_out_ULA(0) or aux_out_ULA(1) or aux_out_ULA(2) or aux_out_ULA(3) or aux_out_ULA(4) or aux_out_ULA(5) or aux_out_ULA(6) or aux_out_ULA(7);

-- regULA : ffd port map( aux_flagULA_ld, ula_or, '1', aux_flagULA_clr, aux_flagULA);
regULA : Registrador1bit port map( ula_or, aux_flagULA_ld, aux_flagULA_clr, clk, aux_flagULA);

mux31 : mux3x1 port map(aux_REGC, aux_memo_data, aux_out_ULA, aux_SEL_RF, aux_out_mux31);

mux21WR : mux2x1C port map(aux_IR(7 downto 4), aux_IR(11 downto 8), aux_SEL_addr_RF_escrita, aux_mux_WR);

mux21RD : mux2x1C port map(aux_IR(7 downto 4), aux_IR(11 downto 8), aux_SEL_RF_leitura_1, aux_mux_RD);

blocoRegistradores : bancoderegistradores port map(aux_mux_WR, aux_mux_RD, aux_IR(3 downto 0), aux_out_mux31, aux_en_RF_escrita, aux_en_RF_leitura_1, aux_en_RF_leitura_2, clk, '1', aux_REGB, aux_REGC);

memoInstrucao : memoInst port map(aux_instrucao, clk, data_memoInst);

memoDados : memoData port map(aux_IR(7 downto 0), clk, aux_REGB, aux_D_wr, aux_memo_data);

IR <= aux_IR;
ULA_out <= aux_out_ULA;

juntar : registrador8bits port map(aux_REGB, aux_junt_ld, '1', clk, out_juntar);

entraMemo(15 downto 8) <= out_juntar;
entraMemo(7 downto 0) <= aux_REGB;

end ckt;











