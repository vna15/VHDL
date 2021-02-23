library ieee;
use ieee.std_logic_1164.all;


entity Registrador13bits is

  port (X : in  std_logic_vector (12 downto 0);

        ld_w, clr, clk : in std_logic;

        Q : out std_logic_vector (12 downto 0));

end Registrador13bits;



architecture ckt of Registrador13bits is



  component ffd is

    port (clk,D,P,C : in  std_logic;

                  q : out std_logic);

  end component;

  

  signal mux, aux : std_logic_vector(12 downto 0);

  

  begin

   mux(12) <= (X(12) and ld_w) or (aux(12) and not(ld_w));

   mux(11) <= (X(11) and ld_w) or (aux(11) and not(ld_w));

   mux(10) <= (X(10) and ld_w) or (aux(10) and not(ld_w));

   mux(9) <= (X(9) and ld_w) or (aux(9) and not(ld_w));

   mux(8) <= (X(8) and ld_w) or (aux(8) and not(ld_w));
  
   mux(7) <= (X(7) and ld_w) or (aux(7) and not(ld_w));

   mux(6) <= (X(6) and ld_w) or (aux(6) and not(ld_w));

   mux(5) <= (X(5) and ld_w) or (aux(5) and not(ld_w));

   mux(4) <= (X(4) and ld_w) or (aux(4) and not(ld_w));

   mux(3) <= (X(3) and ld_w) or (aux(3) and not(ld_w));

   mux(2) <= (X(2) and ld_w) or (aux(2) and not(ld_w));

   mux(1) <= (X(1) and ld_w) or (aux(1) and not(ld_w));

   mux(0) <= (X(0) and ld_w) or (aux(0) and not(ld_w));
	

   ffd12 : ffd port map (clk => clk, D => mux(12), P => '1', C => clr, q => aux(12));

   ffd11 : ffd port map (clk => clk, D => mux(11), P => '1', C => clr, q => aux(11));

   ffd10 : ffd port map (clk => clk, D => mux(10), P => '1', C => clr, q => aux(10));

   ffd9 : ffd port map (clk => clk, D => mux(9), P => '1', C => clr, q => aux(9));

   ffd8 : ffd port map (clk => clk, D => mux(8), P => '1', C => clr, q => aux(8));   

   ffd7 : ffd port map (clk => clk, D => mux(7), P => '1', C => clr, q => aux(7));

   ffd6 : ffd port map (clk => clk, D => mux(6), P => '1', C => clr, q => aux(6));

   ffd5 : ffd port map (clk => clk, D => mux(5), P => '1', C => clr, q => aux(5));

   ffd4 : ffd port map (clk => clk, D => mux(4), P => '1', C => clr, q => aux(4));

   ffd3 : ffd port map (clk => clk, D => mux(3), P => '1', C => clr, q => aux(3));

   ffd2 : ffd port map (clk => clk, D => mux(2), P => '1', C => clr, q => aux(2));

   ffd1 : ffd port map (clk => clk, D => mux(1), P => '1', C => clr, q => aux(1));

   ffd0 : ffd port map (clk => clk, D => mux(0), P => '1', C => clr, q => aux(0));
	
	
	Q(12) <= aux(12); 
	
	Q(11) <= aux(11);
	
	Q(10) <= aux(10);
	
	Q(9) <= aux(9); 
	
	Q(8) <= aux(8); 
	
	Q(7) <= aux(7); 
	
	Q(6) <= aux(6); 
	
	Q(5) <= aux(5); 
	
	Q(4) <= aux(4); 
	
	Q(3) <= aux(3);
	
	Q(2) <= aux(2); 
	
	Q(1) <= aux(1); 
	
	Q(0) <= aux(0); 

     

end ckt;