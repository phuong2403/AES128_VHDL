--------------------------------------------------------------
-- Module name : KeySchedule
-- Top level : AES_top
-- Implementation of AES 128 bit using loop unrolled techniques (only encryption)
-- except control signal : clock, reset, start, load;
-- other input/output in entities of blocks (not top level) are declared starting with i_/o_
-- signals in architecture start with ri_/ro_

-- This file is KeySchedule to describe how a roundkey can be created
----------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity KeySchedule is
	port(
		i_roundkey : in std_logic_vector(127 downto 0);
		i_rconst : in std_logic_vector(7 downto 0); 	--one byte roundconstant corresponding the last byte of one round
		o_roundkey : out std_logic_vector(127 downto 0)
	);
end entity;

architecture behavioral of KeySchedule is
	signal subwords : std_logic_vector(31 downto 0); -- output after Sbox
	signal rotwords : std_logic_vector(31 downto 0);
	signal w0, w1, w2, w3 : std_logic_vector(31 downto 0); --four 4-byte words
	

begin
	gen : for i in 0 to 3 generate
		Sbox: entity work.Sbox port map (
			mode => '1',
			Sbox_input => i_roundkey((i+1)*8 - 1 downto i*8),
			Sbox_output => subwords((i+1 )*8 - 1 downto (i)*8)
			);
	end generate;
	
	rotwords <= subwords(23 downto 0) & subwords(31 downto 24); -- left circular shift
	w0(23 downto 0) <= i_roundkey(119 downto 96) xor rotwords(23 downto 0); --3 left byte of roundconstant = '0';
	w0(31 downto 24) <= i_roundkey(127 downto 120) xor rotwords(31 downto 24) xor i_rconst;
	w1	<= i_roundkey(95 downto 64) xor w0;
	w2	<= i_roundkey(63 downto 32) xor w1;
	w3	<= i_roundkey(31 downto 0) xor w2;
	
	o_roundkey <= w0 & w1 & w2 & w3;
	
end architecture;

