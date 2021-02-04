--------------------------------------------------------------
-- Module name : SubBytes
-- Top level : AES_top
-- Implementation of AES 128 bit using loop unrolled techniques (only encryption)
-- except control signal : clock, reset, start, load;
-- other input/output in entities of blocks (not top level) are declared starting with i_/o_
-- signals in architecture start with ri_/ro_

-- This file is the first step of each round (1-10)
----------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity SubBytes is
	port (
	clk : in std_logic;
	i_S : in std_logic_vector(127 downto 0);
	o_S : out std_logic_vector(127 downto 0)
	);
end entity;

architecture Behavioral of SubBytes is
	--signal o_S : std_logic_vector(127 downto 0);
begin
	--repalce each input byte by one SubBytes 8 bit using Sbox
	
	gen: for i in 0 to 15 generate
	Sbox: entity work.Sbox_unshared port map (
					clock => clk,
					x_in => i_S((i+1)*8 - 1 downto i*8),
					z_out => o_S((i+1)*8 - 1 downto i*8)
				);
	end generate;
	
end architecture;