--------------------------------------------------------------
-- Module name : SubBytes_shared
-- Top level : AES_top
-- Implementation of AES 128 bit using loop unrolled techniques (only encryption)
-- except control signal : clock, reset, start, load;
-- other input/output in entities of blocks (not top level) are declared starting with i_/o_
-- signals in architecture start with ri_/ro_

-- This file is the first step of each round (1-10)
----------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.globals.all;
	
entity SubBytes_shared is
	port (
	clk : in std_logic;
	i_S : in shared_state;
	o_S : out shared_state
	);
end entity;

architecture Behavioral of SubBytes_shared is

	component Sbox_Dshare
	port (
		i_Sbox : shared_byte;
		clk: std_logic;
		o_Sbox: shared_byte);
	end component;
	
begin
	--repalce each input byte by one SubBytes_shared 8 bit using Sbox
	
	gen_sub: for i in 0 to 15 generate
		Sub: entity work.Sbox_Dshare port map(
					clk => clk,
					i_Sbox(0) => i_S(0)((i+1)*8 - 1 downto i*8),
					i_Sbox(1) => i_S(1)((i+1)*8 - 1 downto i*8),
					i_Sbox(2) => i_S(2)((i+1)*8 - 1 downto i*8),
					i_Sbox(3) => i_S(3)((i+1)*8 - 1 downto i*8),
					o_Sbox(0) => o_S(0)((i+1)*8 - 1 downto i*8),
					o_Sbox(1) => o_S(1)((i+1)*8 - 1 downto i*8),
					o_Sbox(2) => o_S(2)((i+1)*8 - 1 downto i*8),
					o_Sbox(3) => o_S(3)((i+1)*8 - 1 downto i*8)
					);
	end generate gen_sub;
	
end architecture;