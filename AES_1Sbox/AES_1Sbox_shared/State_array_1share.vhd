-----------------------
--state array in case use of 1 physical Sbox and 1 physical Column
--So need at least 16 cycles (each cycle for 1 Sbox) to output an full state
--need 4 times mixcolumns
--when output full state, shiftrows is performed - in final cycle - for next round
--this file is state array for each share
-----------------------
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.globals.all;

entity State_Array_1share is
	port (
		clk 		: in std_logic;
		en 			: in std_logic;	--enable update state registers
		en_shift	: in std_logic; --enable shiftrows function and normal operation
		en_mix 		: in std_logic; --enable mixcolumns function
		i_state 	: in std_logic_vector(7 downto 0);
		o_state 	: out std_logic_vector(7 downto 0)
		);
end entity;

architecture Behavioral of State_Array_1share is

	--component mixcolumns
	component MixColumns
		port (
			in_col : in column;
			out_col : out column
			);
	end component;
	
	--signal for transfer states
	signal state_regs: state;
	signal state_next: state;
	
	--signal mixcolumns
	signal ri_mix : column;
	signal ro_mix : column;
	
begin	

		
	--**MixColumns
	ri_mix <= state_regs(0);
	
	MixCol: MixColumns port map (
							in_col => ri_mix,
							out_col=> ro_mix
							);
							
	--**compute the output byte of the state here
	--normally, the output of the state is the first byte
	--but during mixcolumns, it is the first mixcolumns output byte
		
	o_state <= ro_mix(0) 				when (en_mix = '1')	 else state_regs(0)(0);
	
	--all assignments after "else" clause indecate to normal operation
	--column index first, row index second : different from conventional types
	
	--row 0 
	state_next(0)(0) <= ro_mix(1) 			when (en_mix = '1')	 else state_regs(0)(1);
	state_next(1)(0) <= state_regs(1)(1);
	state_next(2)(0) <= state_regs(2)(1);
	state_next(3)(0) <= state_regs(3)(1);
	
	--row 1
	state_next(0)(1) <= ro_mix(2) 			when (en_mix = '1')	 else
						state_regs(1)(2) 	when (en_shift = '1')else state_regs(0)(2);
	state_next(1)(1) <= state_regs(2)(2)	when (en_shift = '1')else state_regs(1)(2);
	state_next(2)(1) <= state_regs(3)(2)	when (en_shift = '1')else state_regs(2)(2);
	state_next(3)(1) <= state_regs(0)(2)	when (en_shift = '1')else state_regs(3)(2);
	
	--row 2
	state_next(0)(2) <= ro_mix(3) 			when (en_mix = '1')	 else
						state_regs(2)(3) 	when (en_shift = '1')else state_regs(0)(3);
	state_next(1)(2) <= state_regs(3)(3)	when (en_shift = '1')else state_regs(1)(3);
	state_next(2)(2) <= state_regs(0)(3)	when (en_shift = '1')else state_regs(2)(3);
	state_next(3)(2) <= state_regs(1)(3)	when (en_shift = '1')else state_regs(3)(3);
	
	--row 3
	state_next(0)(3) <= i_state			 	when (en_shift = '1')else state_regs(1)(0);
	state_next(1)(3) <= state_regs(1)(0)	when (en_shift = '1')else state_regs(2)(0);
	state_next(2)(3) <= state_regs(2)(0)	when (en_shift = '1')else state_regs(3)(0);
	state_next(3)(3) <= state_regs(3)(0)	when (en_shift = '1')else i_state;
	
	
	--**update the state registers here
	update: process (clk)
	begin
		if (rising_edge(clk)) then
			if (en = '1') then
				state_regs <= state_next;
			end if;
		end if;
	end process;
end architecture;