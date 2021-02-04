--------------------------------------------------------------
-- Module name : ExpandKey_shared
-- Top level : AES_top
-- Implementation of AES 128 bit using loop unrolled techniques (only encryption)
-- except control signal : clock, reset, start, load;
-- other input/output in entities of blocks (not top level) are declared starting with i_/o_
-- signals in architecture start with ri_/ro_

-- This file is taking round keys from KeySchedule then output to addroundkey (10 rounds)

----------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.globals.all;
	
entity ExpandKey_shared is
	port(
		clk : in std_logic;
		reset : in std_logic;
		start : in std_logic;
		i_key : in shared_state; -- original key
		i_rconst: in std_logic_vector(7 downto 0); --round constants
		o_roundkey: out shared_state -- round key for next rounds
		);
end entity;

architecture Behavioral of ExpandKey_shared is
	signal r_reg: shared_state;
	signal r_mux : shared_state;
	signal ro_roundkey : shared_state;	
	signal enable : std_logic;

begin
	en_key: entity work.Enable_reg
						port map(
						reset => reset,
						clk => clk,
						enable => enable
						);
						
	mux_key: entity work.Mux_State_Dshare 
				port map (
					i_a => i_key,
					i_b => ro_roundkey,
					en => start,
					o_c => r_mux
					);
					
	reg_key: entity work.Reg_State_Dshare 
				port map (
					clk => clk,
					reset => reset,
					en => enable,
					i_d => r_mux,
					o_q => r_reg --output key for each round here
					);
	round_key: entity work.KeySchedule_shared
				port map (
				
					clk => clk,
					i_roundkey => r_reg ,
					i_rconst => i_rconst,
					o_roundkey => ro_roundkey
					);
	o_roundkey <= r_reg;
end architecture;