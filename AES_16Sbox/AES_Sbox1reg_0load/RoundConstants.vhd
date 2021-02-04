--------------------------------------------------------------
-- Implementation of AES 128 bit using loop unrolled techniques (only encryption)
-- except control signal : clock, reset, start, load;
-- other input/output in entities of blocks (not top level) are declared starting with i_/o_
-- signals in architecture start with ri_/ro_

-- This file is RoundConstants to describe how a round constant can be created

----------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity RoundConstants is
	port (
		ib_rconst : in std_logic_vector(7 downto 0);
		ob_rconst : out std_logic_vector(7 downto 0)
	);
end entity;

architecture behavioral of RoundConstants is
	signal r_shifted_state : std_logic_vector(7 downto 0);
	signal r_constant_xor: std_logic_vector(7 downto 0);
begin
	
	r_shifted_state <= ib_rconst(6 downto 0) & '0';
	r_constant_xor <= "000" & ib_rconst(7) & ib_rconst(7) & '0' & ib_rconst(7) & ib_rconst(7);
	ob_rconst <= r_shifted_state xor r_constant_xor;
	
end architecture;