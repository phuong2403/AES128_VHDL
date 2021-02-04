---------------------------------------------------------------
-- Module name : AES_128_shared
-- Top level : AES_128_shared
-- There is one register in Sbox

-- Implementation of AES 128 bit using loop unrolled techniques (only encryption)
-- except control signal : clock, reset, start, load;
-- other input/output in entities of blocks (not top level) are declared starting with i_/o_
-- signals in architecture start with ri_/ro_

-- This file is top level of design
----------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.globals.all;
	
entity AES_128_shared is
	port (
		clk 			: in std_logic;
		reset 		: in std_logic;
		start 		: in std_logic;		--start computation when inputs's already loaded
		key 			: in shared_state;
		plaintext	: in shared_state;
		ciphertext 	: out shared_state;
		ready 		: out std_logic		
	);
end entity;

architecture RTL of AES_128_shared is
	signal r_state 					: shared_state;
	signal r_mux_text, r_text 		: shared_state;
	signal r_rconst 				: std_logic_vector(7 downto 0);
	signal r_key 					: shared_state;
	signal r_addround, r_subbyte 	: shared_state;
	signal r_shiftrow, r_mixcolumn 	: shared_state;
	
	--signal enable			: std_logic; 			-- select state and key for rounds
	signal r_final_round 	: std_logic; 		-- if it is final round
	signal r_ready 			: std_logic;			-- ready for ciphertext
	signal enable, start1, start2 : std_logic;

begin
		
	en_text: entity work.Enable_reg
						port map(
						reset => reset,
						clk => clk,
						enable => enable
						);
	mux_text: entity work.Mux_State_Dshare				
				port map (
				i_a => plaintext,
				i_b => r_state,
				en => start,
				o_c => r_mux_text 
					);
	reg_text: entity work.Reg_State_Dshare
				port map (
					clk => clk,
					reset => reset,
					en => enable,
					i_d => r_mux_text,
					o_q => r_text
					);	
	expand_key: entity work.ExpandKey_shared
				port map(
					clk => clk,
					reset => reset,
					start => start,
					i_key => key,
					i_rconst => r_rconst,
					o_roundkey => r_key
					);	
				
	add_rkey: entity work.AddRoundKey_Dshare
				port map(
					i_key => r_key,
					i_state => r_text,
					o_state => r_addround
					);
	sub_byte: entity work.SubBytes_shared
				port map(
					clk => clk,
					i_S => r_addround,
					o_S => r_subbyte
					);
	shift_row: entity work.ShiftRows_Dshare
				port map(
					i_a => r_subbyte,
					o_a => r_shiftrow	
					);
	mix_column: entity work.MixColumns_Dshare
				port map(
					i_a => r_shiftrow,
					o_b => r_mixcolumn
					);
	mux_finalround: entity work.Mux_State_Dshare
				
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
	mux_cipher: entity work.Mux_State_Dshare -- output ciphertext
				
				port map (
				i_a => (others =>(others => '0')),
				i_b => r_addround,
				en => r_ready,
				o_c => ciphertext 
				);	
	ready <= r_ready;
end architecture;