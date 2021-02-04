-----------------------
--state array in case use of 1 physical Sbox and 1 physical Column
--So need at least 16 cycles (each cycle for 1 Sbox) to output an full state
--need 4 times mixcolumns
--when output full state, shiftrows is performed - in final cycle - for next round
-- this file is state array after combine D shares
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
 use work.globals.all;


entity State_Array_Dshare is
	port (
		clk 		: in std_logic;
		en 			: in std_logic;	--enable update state registers
		en_shift	: in std_logic; --enable shiftrows function and normal operation
		en_mix 		: in std_logic; --enable mixcolumns function
		i_state 	: in shared_byte;
		o_state 	: out shared_byte
		);
end entity;

architecture Behavioral of State_Array_Dshare is 
	component State_array_1share
		port (
			clk 		: in std_logic;
			en 			: in std_logic;	--enable update state registers
			en_shift	: in std_logic; --enable shiftrows function and normal operation
			en_mix 		: in std_logic; --enable mixcolumns function
			i_state 	: in std_logic_vector(7 downto 0);
			o_state 	: out std_logic_vector(7 downto 0)
			);
	end component;
begin
	
	gen: for i in 0 to D-1 generate
		state_ar: State_array_1share
				port map (
					clk => clk,
					en => en,
					en_shift => en_shift,
					en_mix => en_mix,
					i_state => i_state(i),
					o_state => o_state(i)
				);
	end generate;
end architecture;