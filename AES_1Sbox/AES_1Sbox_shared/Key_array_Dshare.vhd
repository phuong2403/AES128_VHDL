----------------------------------------------------------------------------------
-- key array in case use of 1 physical Sbox and 1 physical Column
-- each byte is calculated consequentally
-- key byte output:
-- first column:		 o_final_K00 = key_regs(0)(0)+ i_SB_out + RC
-- three left columns:	 o_final_K00 = key_regs(0)(0) + o_K30
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
 use work.globals.all;


entity Key_array_Dshare is
	Port ( 
			clk 			: in  std_logic;
			en 				: in  std_logic; -- this control signal enables the key array
        	en_rotate		: in  std_logic; -- this control signal indicates when the rows should en_rotate instead of the normal movement
			en_xor			: in  std_logic; -- this control signal enables xor with i_SB_out
			i_key	 		: in  shared_byte;
			i_SB_out 		: in  shared_byte; --  input from S-box output
			o_in_SB 		: out shared_byte; -- byte input to Sbox
			o_final_K00 	: out shared_byte;	-- key byte output
			o_K30 	 		: out shared_byte -- use to calculate key byte ouput
	  );
end entity;

architecture Behavioral of Key_array_Dshare is
	component Key_array_1share
		Port ( 
				clk 			: in  std_logic;
				en 				: in  std_logic; -- this control signal enables the key array
				en_rotate		: in  std_logic; -- this control signal indicates when the rows should en_rotate instead of the normal movement
				en_xor			: in  std_logic; -- this control signal enables xor with i_SB_out
				i_key	 		: in  std_logic_vector(7 downto 0);
				i_SB_out 		: in  std_logic_vector(7 downto 0); --  input from S-box output
				o_in_SB 		: out std_logic_vector(7 downto 0); -- byte input to Sbox
				o_final_K00 	: out std_logic_vector(7 downto 0);	-- key byte output
				o_K30 	 		: out std_logic_vector(7 downto 0) -- use to calculate key byte ouput
		  );
	end component;
begin
	gen: for i in 0 to D-1 generate
		key_ar: Key_array_1share
				port map (
				clk => clk,
				en => en,
				en_rotate => en_rotate,
				en_xor => en_xor,
				i_key => i_key(i),
				i_SB_out => i_SB_out(i),
				o_in_SB => o_in_SB(i),
				o_final_K00 => o_final_K00(i),
				o_K30 => o_K30(i)
				);
	end generate;			
end architecture;