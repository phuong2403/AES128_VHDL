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


entity Key_array is
	Port ( 
			clk 			: in  std_logic;
			en 				: in  std_logic; -- this control signal enables the key array
        	en_rotate		: in  std_logic; -- this control signal indicates when the rows should en_rotate instead of the normal movement
			i_key	 		: in  std_logic_vector(7 downto 0);
			i_SB_out 		: in  std_logic_vector(7 downto 0); --  input from S-box output
			o_in_SB 		: out std_logic_vector(7 downto 0); -- byte input to Sbox
			o_final_K00 	: out std_logic_vector(7 downto 0);	-- key byte output
			o_K30 	 		: out std_logic_vector(7 downto 0) -- use to calculate key byte ouput
	  );
end Key_array;

architecture Behavioral of Key_array is
	 

	--Registers
	signal key_regs	: state;
	signal key_next	: state;
	
	
begin

	--Outputs
	-- ** Complete the outputs: choose one of the key state bytes for each output signal ** --
	o_in_SB <= key_regs(3)(1); -- key byte going into the s-box
								 -- this byte is the first one go to S-box, after rotation
	
	o_final_K00 <= key_regs(0)(0); -- Key out

	o_K30 <= key_regs(3)(0); -- Another key byte that is used to compute the round key
	

	
	-- Regs wiring
 	-- ** Implement the key state wiring here ** --
 	-- In normal operation, all the bytes in a column shift one row up and the first byte of the column goes to the last byte of the previous column --
 	-- When en_rotate=1, all the columns should en_rotate, so the first byte of the column goes to the last byte of the same column --
 	-- See also the figure and the AES animation on youtube --
 	-- Remember the state is an array of 4 columns so the first indices refer to columns and the second to rows --

	-- Row 0: shift up 
	key_next(0)(0) <= key_regs(0)(1);
	key_next(1)(0) <= key_regs(1)(1);
	key_next(2)(0) <= key_regs(2)(1);
	key_next(3)(0) <= key_regs(3)(1);

	--Row 1: shift up 
	key_next(0)(1) <= key_regs(0)(2);
	key_next(1)(1) <= key_regs(1)(2);
	key_next(2)(1) <= key_regs(2)(2);
	key_next(3)(1) <= key_regs(3)(2);

	-- Row2 : shift up
	key_next(0)(2) <= key_regs(0)(3);
	key_next(1)(2) <= key_regs(1)(3);
	key_next(2)(2) <= key_regs(2)(3);
	key_next(3)(2) <= key_regs(3)(3);

	-- Row 3 : normal movement or en_rotate 
	-- choose ONE of the bytes to xor the S-box output to. (only use one of the xors!)
	key_next(0)(3) <= key_regs(0)(0) xor i_SB_out 	when (en_rotate = '1') else key_regs(1)(0);
	key_next(1)(3) <= key_regs(1)(0) 				when (en_rotate = '1') else key_regs(2)(0);
	key_next(2)(3) <= key_regs(2)(0) 				when (en_rotate = '1') else key_regs(3)(0);
	key_next(3)(3) <= key_regs(3)(0)  				when (en_rotate = '1') else i_key;


	--Sequential logic
	seq : process(clk)
	begin  
		if (rising_edge(clk)) then
			if(en = '1') then 
				-- ** Update the key state registers here ** --
				key_regs <= key_next;
			end if;
		end if;
	end process;
	

end Behavioral;



