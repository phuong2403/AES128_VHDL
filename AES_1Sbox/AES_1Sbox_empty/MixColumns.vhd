library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
 use work.globals.all;


 entity MixColumns is 
 	port (
 	      	in_col : in column;
 	      	out_col : out column
 	);
 end MixColumns;



 architecture Behavioral of MixColumns is 

 component Mixcol_function
		 Port ( in_col  : in  column;
				out_col : out  std_logic_vector(7 downto 0));
	end component;


	signal in1, in2, in3, in4 : column;

 begin 


 	--Wiring for a correct input in "col" block
 	in1 <= in_col;
	
 	-- rotated versions:
	-- next column is the 1-byte rotated version of previous column
	in2(0) <= in_col(1);
	in2(1) <= in_col(2);
	in2(2) <= in_col(3);
	in2(3) <= in_col(0);
	
	in3(0) <= in_col(2);
	in3(1) <= in_col(3);
	in3(2) <= in_col(0);
	in3(3) <= in_col(1);
	
	in4(0) <= in_col(3);
	in4(1) <= in_col(0);
	in4(2) <= in_col(1);
	in4(3) <= in_col(2);
	
	--"col" block
	col_1 : Mixcol_function port map ( in_col  => in1, out_col => out_col(0));
	
	col_2 : Mixcol_function port map ( in_col  => in2, out_col => out_col(1));
	
	col_3 : Mixcol_function port map ( in_col  => in3, out_col => out_col(2));
	
	col_4 : Mixcol_function port map ( in_col  => in4, out_col => out_col(3));




 end Behavioral;
