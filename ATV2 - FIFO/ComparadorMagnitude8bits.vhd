library ieee;
use ieee.std_logic_1164.all;




entity ComparadorMagnitude8bits is

  port( X, Y : in std_logic_vector(7 downto 0);

        Q : out std_logic);

end ComparadorMagnitude8bits;



architecture ckt of ComparadorMagnitude8bits is



signal v,f : std_logic_vector(7 downto 0);

signal igual,maior,menor : std_logic;

                                                        

begin                                                     

  
v(7) <= X(7) xnor Y(7); 

v(6) <= X(6) xnor Y(6);

v(5) <= X(5) xnor Y(5);

v(4) <= X(4) xnor Y(4);

v(3) <= X(3) xnor Y(3); 

v(2) <= X(2) xnor Y(2);

v(1) <= X(1) xnor Y(1);

v(0) <= X(0) xnor Y(0);



f(7) <= X(7) and not(Y(7));

f(6) <= X(6) and not(Y(6)) and v(7);                       

f(5) <= X(5) and not(Y(5)) and v(6) and v(7);          

f(4) <= X(4) and not(Y(4)) and v(5) and v(6) and v(7);

f(3) <= X(3) and not(Y(3)) and v(4) and v(5) and v(6) and v(7);

f(2) <= X(2) and not(Y(2)) and v(3) and v(4) and v(5) and v(6) and v(7);

f(1) <= X(1) and not(Y(1)) and v(2) and v(3) and v(4) and v(5) and v(6) and v(7);

f(0) <= X(0) and not(Y(0)) and v(1) and v(2) and v(3) and v(4) and v(5) and v(6) and v(7);



igual <= (v(7) and v(6)) and (v(5) and v(4)) and (v(3) and v(2)) and (v(1) and v(0));



maior <= f(7) or f(6) or f(5) or f(4) or f(3) or f(2) or f(1) or f(0);



menor <= not(maior); 



q <= igual;





end ckt;