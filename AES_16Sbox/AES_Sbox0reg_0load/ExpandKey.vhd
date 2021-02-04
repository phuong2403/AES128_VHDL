--------------------------------------------------------------
-- Module name : ExpandKey
-- Top level : AES_top
-- Implementation of AES 128 bit using loop unrolled techniques (only encryption)
-- except control signal : clock, reset, start, load;
-- other input/output in entities of blocks (not top level) are declared starting with i_/o_
-- signals in architecture start with ri_/ro_

-- This file is taking round keys from KeySchedule then output to addroundkey (10 rounds)

----------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity ExpandKey is
	port(
		clk : in std_logic;
		reset : in std_logic;
		start : in std_logic;
		i_key : in std_logic_vector(127 downto 0); -- original key
		i_rconst: in std_logic_vector(7 downto 0); --round constants
		o_roundkey: out std_logic_vector(127 downto 0) -- round key for next rounds
		);
end entity;

architecture Behavioral of ExpandKey is
	signal ro_roundkey : std_logic_vector(127 downto 0);
	signal r_load_key: std_logic_vector(127 downto 0);
	signal r_start_key : std_logic_vector(127 downto 0);
	signal r_reg, r_reg0 : std_logic_vector(127 downto 0);	
	signal r_en : std_logic;

begin
	mux_start_enc: entity work.Mux2 generic map (N => 128)
				port map (
					--i_a => r_load_key,
					i_a => i_key,
					i_b => ro_roundkey,
					en => start,
					o_c => r_start_key
					);
	reg_key: entity work.Reg 	generic map (N => 128)
				port map (
					clk => clk,
					reset => reset,
					--en => '1',
					--i_d => r_load_key,
					i_d => r_start_key,
					o_q => r_reg
					);
	round_key: entity work.KeySchedule
				port map (
					i_roundkey => r_reg,
					i_rconst => i_rconst,
					o_roundkey => ro_roundkey
					);
	o_roundkey <= r_reg;
end architecture;