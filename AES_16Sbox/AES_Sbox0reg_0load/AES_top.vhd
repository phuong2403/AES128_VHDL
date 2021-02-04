---------------------------------------------------------------
-- Module name : AES_top
-- Top level : AES_top
-- There is no register in Sbox

-- Implementation of AES 128 bit using loop unrolled techniques (only encryption)
-- except control signal : clock, reset, start, load;
-- other input/output in entities of blocks (not top level) are declared starting with i_/o_
-- signals in architecture start with ri_/ro_

-- This file is top level of design
----------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity AES_top is
	port (
		clk 		: in std_logic;
		reset 		: in std_logic;
		start 		: in std_logic;		--start computation when inputs's already loaded
		key 		: in std_logic_vector(127 downto 0);
		plaintext 	: in std_logic_vector(127 downto 0);
		ciphertext 	: out std_logic_vector(127 downto 0);
		ready 		: out std_logic		
	);
end entity;

architecture RTL of AES_top is
	signal r_state, r_load_text		: std_logic_vector(127 downto 0);
	signal r_start_text, r_text, r_text0 		: std_logic_vector(127 downto 0);
	signal r_rconst 				: std_logic_vector(7 downto 0);
	signal r_key 					: std_logic_vector(127 downto 0);
	signal r_addround, r_subbyte 	: std_logic_vector(127 downto 0);
	signal r_shiftrow, r_mixcolumn 	: std_logic_vector(127 downto 0);
	
	signal r_en 			: std_logic; 			-- select state and key for rounds
	signal r_final_round 	: std_logic; 			-- if it is final round
	signal r_ready 			: std_logic;			-- ready for ciphertext
begin
	mux_start_enc: entity work.Mux2
				generic map ( N => 128 )
				port map (
				--i_a => r_load_text,
				i_a => plaintext,
				i_b => r_state,
	--			en => r_en,
				en => start,
				o_c => r_start_text 
					);
	reg_text: entity work.Reg
				generic map (N => 128)
				port map (
					clk => clk,
					reset => reset,
					--en => '1',
					i_d => r_start_text,
					--i_d => r_mux_text,
					o_q => r_text
					);
	expand_key: entity work.ExpandKey
				port map(
					clk => clk,
					reset => reset,
					start => start,
					i_key => key,
					i_rconst => r_rconst,
					o_roundkey => r_key
					);	
	add_rkey: entity work.AddRoundKey
				port map(
					i_key => r_key,
					i_state => r_text,
					o_state => r_addround
					);
	sub_byte: entity work.SubBytes
				port map(
					i_S => r_addround,
					o_S => r_subbyte
					);
	shift_row: entity work.ShiftRows
				port map(
					i_a => r_subbyte,
					o_a => r_shiftrow	
					);
	mix_column: entity work.MixColumns
				port map(
					i_a => r_shiftrow,
					o_b => r_mixcolumn
					);
	mux_finalround: entity work.Mux2
				generic map ( N => 128 )
				port map (
					i_a => r_mixcolumn,
					i_b => r_shiftrow,
					en => r_final_round,
					o_c => r_state 
					);
	controller: entity work.Controller
				port map(
				clk => clk,
				reset => reset,
				start => start,
				o_rconst => r_rconst,
				o_final_round => r_final_round,
				o_ready => r_ready
				);
	mux_cipher: entity work.Mux2 -- output ciphertext
				generic map ( N => 128 )
				port map (
				i_a => (others => '0'),
				i_b => r_addround,
				en => r_ready,
				o_c => ciphertext 
				);
	ready <= r_ready;
end architecture;