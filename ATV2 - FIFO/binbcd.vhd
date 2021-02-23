library ieee;
use ieee.std_logic_1164.all;


entity conv_bin_bcd is

  port( SW : in std_logic_vector(15 downto 0);
  
        HEX4 : out std_logic_vector(6 downto 0);

        HEX3 : out std_logic_vector(6 downto 0);

        HEX2 : out std_logic_vector(6 downto 0);

        HEX1 : out std_logic_vector(6 downto 0);
        
        HEX0 : out std_logic_vector(6 downto 0));

        
end conv_bin_bcd;



architecture bin_bcd of conv_bin_bcd is

  

  component conversor_somador

     port ( A : in std_logic_vector(3 downto 0);

            S : out std_logic_vector(3 downto 0));

  end component;

  

  component bcd_display 

    port( X : in std_logic_vector(3 downto 0);

          D : out std_logic_vector(0 to 6));



  end component;

  

  signal m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16, m17, m18, m19, m20, m21,
         m22, m23, m24, m25, m26, m27, m28, m29, m30 : std_logic_vector(3 downto 0);

  signal bcd : std_logic_vector(19 downto 0);

  

  begin 

    

     bloco1 : conversor_somador port map(A(3) => '0', A(2) => SW(15), A(1) => SW(14), A(0) => SW(13),

                            S(3) => m1(3), S(2) => m1(2), S(1) => m1(1), S(0) => m1(0));

     bloco2 : conversor_somador port map(A(3) => m1(2), A(2) => m1(1), A(1) => m1(0), A(0) => SW(12),

                            S(3) => m2(3), S(2) => m2(2), S(1) => m2(1), S(0) => m2(0));

     bloco3 : conversor_somador port map(A(3) => m2(2), A(2) => m2(1), A(1) => m2(0), A(0) => SW(11),

                            S(3) => m3(3), S(2) => m3(2), S(1) => m3(1), S(0) => m3(0));

     bloco4 : conversor_somador port map(A(3) => '0', A(2) => m1(3), A(1) => m2(3), A(0) => m3(3),

                            S(3) => m4(3), S(2) => m4(2), S(1) => m4(1), S(0) => m4(0));

     bloco5 : conversor_somador port map(A(3) => m3(2), A(2) => m3(1), A(1) => m3(0), A(0) => SW(10),

                            S(3) => m5(3), S(2) => m5(2), S(1) => m5(1), S(0) => m5(0));

     bloco6 : conversor_somador port map(A(3) => m4(2), A(2) => m4(1), A(1) => m4(0), A(0) => m5(3),

                            S(3) => m6(3), S(2) => m6(2), S(1) => m6(1), S(0) => m6(0));

     bloco7 : conversor_somador port map(A(3) => m5(2), A(2) => m5(1), A(1) => m5(0), A(0) => SW(9),

                            S(3) => m7(3), S(2) => m7(2), S(1) => m7(1), S(0) => m7(0));
     
     bloco8 : conversor_somador port map(A(3) => m6(2), A(2) => m6(1), A(1) => m6(0), A(0) => m7(3),

                            S(3) => m8(3), S(2) => m8(2), S(1) => m8(1), S(0) => m8(0));
                            
     bloco9 : conversor_somador port map(A(3) => m7(2), A(2) => m7(1), A(1) => m7(0), A(0) => SW(8),

                            S(3) => m9(3), S(2) => m9(2), S(1) => m9(1), S(0) => m9(0));
            
     bloco10 : conversor_somador port map(A(3) => '0', A(2) => m4(3), A(1) => m6(3), A(0) => m8(3),

                            S(3) => m10(3), S(2) => m10(2), S(1) => m10(1), S(0) => m10(0));
                            
     bloco11 : conversor_somador port map(A(3) => m8(2), A(2) => m8(1), A(1) => m8(0), A(0) => m9(3),

                            S(3) => m11(3), S(2) => m11(2), S(1) => m11(1), S(0) => m11(0));
                            
     bloco12 : conversor_somador port map(A(3) => m9(2), A(2) => m9(1), A(1) => m9(0), A(0) => SW(7),

                            S(3) => m12(3), S(2) => m12(2), S(1) => m12(1), S(0) => m12(0));
									 
	  bloco13 : conversor_somador port map(A(3) => m10(2), A(2) => m10(1), A(1) => m10(0), A(0) => m11(3),

                            S(3) => m13(3), S(2) => m13(2), S(1) => m13(1), S(0) => m13(0));
									 
	  bloco14 : conversor_somador port map(A(3) => m11(2), A(2) => m11(1), A(1) => m11(0), A(0) => m12(3),

                            S(3) => m14(3), S(2) => m14(2), S(1) => m14(1), S(0) => m14(0));	
		
     bloco15 : conversor_somador port map(A(3) => m12(2), A(2) => m12(1), A(1) => m12(0), A(0) => SW(6),

                            S(3) => m15(3), S(2) => m15(2), S(1) => m15(1), S(0) => m15(0));	
									
	  bloco16 : conversor_somador port map(A(3) => m13(2), A(2) => m13(1), A(1) => m13(0), A(0) => m14(3),

                            S(3) => m16(3), S(2) => m16(2), S(1) => m16(1), S(0) => m16(0));
									
	  bloco17 : conversor_somador port map(A(3) => m14(2), A(2) => m14(1), A(1) => m14(0), A(0) => m15(3),

                            S(3) => m17(3), S(2) => m17(2), S(1) => m17(1), S(0) => m17(0));	
									 
	  bloco18 : conversor_somador port map(A(3) => m15(2), A(2) => m15(1), A(1) => m15(0), A(0) => SW(5),

                            S(3) => m18(3), S(2) => m18(2), S(1) => m18(1), S(0) => m18(0));
									 
	  bloco19 : conversor_somador port map(A(3) => '0', A(2) => m10(3), A(1) => m13(3), A(0) => m16(3),

                            S(3) => m19(3), S(2) => m19(2), S(1) => m19(1), S(0) => m19(0));
									 
	  bloco20 : conversor_somador port map(A(3) => m16(2), A(2) => m16(1), A(1) => m16(0), A(0) => m17(3),

                            S(3) => m20(3), S(2) => m20(2), S(1) => m20(1), S(0) => m20(0));
									 
	  bloco21 : conversor_somador port map(A(3) => m17(2), A(2) => m17(1), A(1) => m17(0), A(0) => m18(3),

                            S(3) => m21(3), S(2) => m21(2), S(1) => m21(1), S(0) => m21(0));
									 
	  bloco22 : conversor_somador port map(A(3) => m18(2), A(2) => m18(1), A(1) => m18(0), A(0) => SW(4),

                            S(3) => m22(3), S(2) => m22(2), S(1) => m22(1), S(0) => m22(0));
									 
	  bloco23 : conversor_somador port map(A(3) => m19(2), A(2) => m19(1), A(1) => m19(0), A(0) => m20(3),

                            S(3) => m23(3), S(2) => m23(2), S(1) => m23(1), S(0) => m23(0));
									 
	  bloco24 : conversor_somador port map(A(3) => m20(2), A(2) => m20(1), A(1) => m20(0), A(0) => m21(3),

                            S(3) => m24(3), S(2) => m24(2), S(1) => m24(1), S(0) => m24(0));
									 
	  bloco25 : conversor_somador port map(A(3) => m21(2), A(2) => m21(1), A(1) => m21(0), A(0) => m22(3),

                            S(3) => m25(3), S(2) => m25(2), S(1) => m25(1), S(0) => m25(0));
									 
	  bloco26 : conversor_somador port map(A(3) => m22(2), A(2) => m22(1), A(1) => m22(0), A(0) => SW(3),

                            S(3) => m26(3), S(2) => m26(2), S(1) => m26(1), S(0) => m26(0));
									 
	  bloco27 : conversor_somador port map(A(3) => m23(2), A(2) => m23(1), A(1) => m23(0), A(0) => m24(3),

                            S(3) => m27(3), S(2) => m27(2), S(1) => m27(1), S(0) => m27(0));
									 
	  bloco28 : conversor_somador port map(A(3) => m24(2), A(2) => m24(1), A(1) => m24(0), A(0) => m25(3),

                            S(3) => m28(3), S(2) => m28(2), S(1) => m28(1), S(0) => m28(0));
									 
	  bloco29 : conversor_somador port map(A(3) => m25(2), A(2) => m25(1), A(1) => m25(0), A(0) => m26(3),

                            S(3) => m29(3), S(2) => m29(2), S(1) => m29(1), S(0) => m29(0));
									 
	  bloco30 : conversor_somador port map(A(3) => m26(2), A(2) => m26(1), A(1) => m26(0), A(0) => SW(2),

                            S(3) => m30(3), S(2) => m30(2), S(1) => m30(1), S(0) => m30(0));
									 
	  bloco31 : conversor_somador port map(A(3) => m27(2), A(2) => m27(1), A(1) => m27(0), A(0) => m28(3),

                            S(3) => bcd(16), S(2) => bcd(15), S(1) => bcd(14), S(0) => bcd(13));
									 
	  bloco32 : conversor_somador port map(A(3) => m28(2), A(2) => m28(1), A(1) => m28(0), A(0) => m29(3),

                            S(3) => bcd(12), S(2) => bcd(11), S(1) => bcd(10), S(0) => bcd(9));
									 
	  bloco33 : conversor_somador port map(A(3) => m29(2), A(2) => m29(1), A(1) => m29(0), A(0) => m30(3),

                            S(3) => bcd(8), S(2) => bcd(7), S(1) => bcd(6), S(0) => bcd(5));
									 
	  bloco34 : conversor_somador port map(A(3) => m30(2), A(2) => m30(1), A(1) => m30(0), A(0) => SW(1),

                            S(3) => bcd(4), S(2) => bcd(3), S(1) => bcd(2), S(0) => bcd(1));
		
	  bcd(19) <= m19(3);	
     
	  bcd(18) <= m23(3);
	  
     bcd(17) <= m27(3);

     bcd(0) <= SW(0);

     
	   DEZENA_MILHAR : bcd_display port map(X => bcd(19 downto 16), D => HEX4);
      
		MILHAR : bcd_display port map(X => bcd(15 downto 12), D =>  HEX3);

      CENTENA : bcd_display port map(X => bcd(11 downto 8), D =>  HEX2);

      DEZENA : bcd_display port map(X => bcd(7 downto 4), D =>  HEX1);

      UNIDADE : bcd_display port map(X => bcd(3 downto 0), D =>  HEX0);

     

end bin_bcd;