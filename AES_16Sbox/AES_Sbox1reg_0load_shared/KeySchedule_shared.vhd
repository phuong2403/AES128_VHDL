--------------------------------------------------------------
-- Module name : KeySchedule_shared
-- Top level : AES_top
-- Implementation of AES 128 bit using loop unrolled techniques (only encryption)
-- except control signal : clock, reset, start, load;
-- other input/output in entities of blocks (not top level) are declared starting with i_/o_
-- signals in architecture start with ri_/ro_

-- This file is KeySchedule_shared to describe how a roundkey can be created
-- Sbox 4 shares
----------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.globals.all;
	
entity KeySchedule_shared is
	port(
		clk : in std_logic;
		i_roundkey : in shared_state;
		i_rconst : in std_logic_vector(7 downto 0); 	--one byte roundconstant corresponding the last byte of one round
		o_roundkey : out shared_state
	);
end entity;

architecture behavioral of KeySchedule_shared is
	-- output after Sbox	
	signal Rcon_Dshare : shared_byte;
	signal subwords : shared_word;
	
begin
	
	gen_Sbox : for i in 0 to 3 generate
		Sbox: entity work.Sbox_Dshare port map (
			clk => clk,				
					i_Sbox(0) => i_roundkey(0)((i+1)*8 - 1 downto i*8),
					i_Sbox(1) => i_roundkey(1)((i+1)*8 - 1 downto i*8),
					i_Sbox(2) => i_roundkey(2)((i+1)*8 - 1 downto i*8),
					i_Sbox(3) => i_roundkey(3)((i+1)*8 - 1 downto i*8),
					o_Sbox(0) => subwords(0)((i+1)*8 - 1 downto i*8),
					o_Sbox(1) => subwords(1)((i+1)*8 - 1 downto i*8),
					o_Sbox(2) => subwords(2)((i+1)*8 - 1 downto i*8),
					o_Sbox(3) => subwords(3)((i+1)*8 - 1 downto i*8)
			);		
	end generate gen_Sbox;
	------------------------
	---generate RC shared	
	Rcon_Dshare(0) <= i_rconst;
	
	gen_RC: for i in 1 to D-1 generate
		Rcon_Dshare(i) <= (others =>'0');
	end generate gen_RC;
	------------------------
	---generate key shared	
	gen_key: for i in 0 to D-1 generate	
		Key_F: entity work.KeyFunctions port map(
			i_roundkey => i_roundkey(i),
			subwords => subwords(i),
			i_rconst => Rcon_Dshare(i),
			o_roundkey => o_roundkey(i)
				);
	end generate gen_key;
end architecture;

