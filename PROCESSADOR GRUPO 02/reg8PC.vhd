library ieee;
use ieee.std_logic_1164.all;


entity Registrador8bitsPC is
  port (X, pc_jump : in  std_logic_vector (7 downto 0);
        ld, clr, clk, en_paralelo : in std_logic;
        Q : out std_logic_vector (7 downto 0));
end Registrador8bitsPC;



architecture ckt of Registrador8bitsPC is



  component ffd is

    port (clk,D,P,C : in  std_logic;

                  q : out std_logic);

  end component;

  

  signal mux, aux, preset, clear : std_logic_vector(7 downto 0);

  

  begin


   mux(7) <= (X(7) and ld) or (aux(7) and not(ld));

   mux(6) <= (X(6) and ld) or (aux(6) and not(ld));

   mux(5) <= (X(5) and ld) or (aux(5) and not(ld));

   mux(4) <= (X(4) and ld) or (aux(4) and not(ld));

   mux(3) <= (X(3) and ld) or (aux(3) and not(ld));

   mux(2) <= (X(2) and ld) or (aux(2) and not(ld));

   mux(1) <= (X(1) and ld) or (aux(1) and not(ld));

   mux(0) <= (X(0) and ld) or (aux(0) and not(ld));
	
	
	preset(7) <= not(pc_jump(7) and en_paralelo);
	preset(6) <= not(pc_jump(6) and en_paralelo);
	preset(5) <= not(pc_jump(5) and en_paralelo);
	preset(4) <= not(pc_jump(4) and en_paralelo);
	preset(3) <= not(pc_jump(3) and en_paralelo);
	preset(2) <= not(pc_jump(2) and en_paralelo);
	preset(1) <= not(pc_jump(1) and en_paralelo);
	preset(0) <= not(pc_jump(0) and en_paralelo);
	
	clear(7) <= not(not(pc_jump(7)) and en_paralelo) and not(clr);
	clear(6) <= not(not(pc_jump(6)) and en_paralelo) and not(clr);
	clear(5) <= not(not(pc_jump(5)) and en_paralelo) and not(clr);
	clear(4) <= not(not(pc_jump(4)) and en_paralelo) and not(clr);
	clear(3) <= not(not(pc_jump(3)) and en_paralelo) and not(clr);
	clear(2) <= not(not(pc_jump(2)) and en_paralelo) and not(clr);
	clear(1) <= not(not(pc_jump(1)) and en_paralelo) and not(clr);
	clear(0) <= not(not(pc_jump(0)) and en_paralelo) and not(clr);
	
	

      

   ffd7 : ffd port map (clk => clk, D => mux(7), P => preset(7), C => clear(7), q => aux(7));

   ffd6 : ffd port map (clk => clk, D => mux(6), P => preset(6), C => clear(6), q => aux(6));

   ffd5 : ffd port map (clk => clk, D => mux(5), P => preset(5), C => clear(5), q => aux(5));

   ffd4 : ffd port map (clk => clk, D => mux(4), P => preset(4), C => clear(4), q => aux(4));

   ffd3 : ffd port map (clk => clk, D => mux(3), P => preset(3), C => clear(3), q => aux(3));

   ffd2 : ffd port map (clk => clk, D => mux(2), P => preset(2), C => clear(2), q => aux(2));

   ffd1 : ffd port map (clk => clk, D => mux(1), P => preset(1), C => clear(1), q => aux(1));

   ffd0 : ffd port map (clk => clk, D => mux(0), P => preset(0), C => clear(0), q => aux(0));

        

   Q(7) <= aux(7);

   Q(6) <= aux(6);

   Q(5) <= aux(5);

   Q(4) <= aux(4);

   Q(3) <= aux(3);

   Q(2) <= aux(2);

   Q(1) <= aux(1);

   Q(0) <= aux(0);

     

end ckt;