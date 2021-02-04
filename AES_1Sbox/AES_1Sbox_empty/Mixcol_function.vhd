
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.globals.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- Mixclolumns function for first column, left column created by rotation
entity Mixcol_function is
    Port ( in_col  : in  column; 					   -- an input 1-byte matrix 4x4
           out_col : out  std_logic_vector(7 downto 0) 
		   );
end Mixcol_function;

architecture Behavioral of Mixcol_function is
	
	signal s0, s1, s2, s3 : std_logic_vector(7 downto 0); -- regs of 4 input columns
  	signal s0_2, s1_3 : std_logic_vector(7 downto 0);
	
	
begin
	
	--Name bytes
	s0 <= in_col(0);
	s1 <= in_col(1);
	s2 <= in_col(2);
	s3 <= in_col(3);

	-- Multiply s0 by 2
    s0_2 <= s0(6) & s0(5) & s0(4) & ( s0(3) xor s0(7) ) & ( s0(2) xor s0(7) ) & s0(1) & ( s0(0) xor s0(7) ) & s0(7); -- xor x"1b"=0001 1011 incase s(7) = 1

    -- Multiply s1 by 3
    s1_3 <= ( s1(7) xor s1(6) ) & ( s1(6) xor s1(5) ) & ( s1(5) xor s1(4) ) & ( s1(4) xor s1(3) xor s1(7) ) & 
            ( s1(3) xor s1(2) xor s1(7) ) & ( s1(2) xor s1(1) ) & ( s1(1) xor s1(0) xor s1(7) ) & ( s1(0) xor s1(7) );
	
	
	--Output byte = 2*s0 + 3*s1 + s2 + s3
    out_col <= s0_2 xor s1_3 xor s2 xor s3;

		

end Behavioral;

