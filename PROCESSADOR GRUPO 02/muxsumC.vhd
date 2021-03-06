-- Mux 16 para 8 em VHDL
-- Entradas: ENTA, ENTB, SELECIONAR
-- Saídas: SS
--
-- SELECIONAR SS
-- --------------
-- 0    ENTA
-- 1    ENTB
--
-- Estudante: Kaike C. 
-- 24/02/2020

library ieee;
use ieee.std_logic_1164.all;

entity MUX_SUM_C is
  
  port( ENTA, ENTB: in std_logic_vector(7 downto 0);
        SELECIONAR: in std_logic;
    
        SS : out std_logic_vector(7 downto 0));
end;

architecture ckt_MUX_SUM_C of MUX_SUM_C is
  
  component mux2x1 is
    
  port( Ea, Eb, SEL: in std_logic;    
        Saida : out std_logic);
        
end component;

signal Saidas: std_logic_vector(7 downto 0);

 begin
  
  M0: mux2x1 port map(
    
    Ea => ENTA(0),
    Eb => ENTB(0),
    SEL => SELECIONAR,
    Saida => Saidas(0));
   
  M1: mux2x1 port map(
    
    Ea => ENTA(1),
    Eb => ENTB(1),
    SEL => SELECIONAR,
    Saida => Saidas(1)); 
    
  M2: mux2x1 port map(
    
    Ea => ENTA(2),
    Eb => ENTB(2),
    SEL => SELECIONAR,
    Saida => Saidas(2));
    
  M3: mux2x1 port map(
    
    Ea => ENTA(3),
    Eb => ENTB(3),
    SEL => SELECIONAR,
    Saida => Saidas(3));
    
  M4: mux2x1 port map(
    
    Ea => ENTA(4),
    Eb => ENTB(4),
    SEL => SELECIONAR,
    Saida => Saidas(4));
    
  M5: mux2x1 port map(
    
    Ea => ENTA(5),
    Eb => ENTB(5),
    SEL => SELECIONAR,
    Saida => Saidas(5));
    
  M6: mux2x1 port map(
    
    Ea => ENTA(6),
    Eb => ENTB(6),
    SEL => SELECIONAR,
    Saida => Saidas(6));
    
  M7: mux2x1 port map(
    
    Ea => ENTA(7),
    Eb => ENTB(7),
    SEL => SELECIONAR,
    Saida => Saidas(7));
   
  SS <= Saidas; 
  
end ckt_MUX_SUM_C;