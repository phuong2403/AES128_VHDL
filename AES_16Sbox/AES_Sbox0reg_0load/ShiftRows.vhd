--------------------------------------------------------------
-- Module name : ShiftRows
-- Top level : AES_top
-- Implementation of AES 128 bit using loop unrolled techniques (only encryption)
-- except control signal : clock, reset, start, load;
-- other input/output in entities of blocks (not top level) are declared starting with i_/o_
-- signals in architecture start with ri_/ro_

-- This file is the second step of each round (1-10)
----------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity ShiftRows is
	port (
		i_a : in std_logic_vector(127 downto 0);
		o_a : out std_logic_vector(127 downto 0)	
	);
end entity;

architecture RTL of ShiftRows is
	signal a00, a01, a02, a03 : std_logic_vector(7 downto 0); -- input four-byte row 1
	signal a10, a11, a12, a13 : std_logic_vector(7 downto 0); -- input four-byte row 2
	signal a20, a21, a22, a23 : std_logic_vector(7 downto 0); -- input four-byte row 3
	signal a30, a31, a32, a33 : std_logic_vector(7 downto 0); -- input four-byte row 4
	
begin
	a00 <= i_a(127 downto 120); --start with row 1, each box is one byte
	a01 <= i_a(95 downto 88); --from left to right, up to down
	a02 <= i_a(63 downto 56);
	a03 <= i_a(31 downto 24);
	--row 2
	a13 <= i_a(119 downto 112); 
	a10 <= i_a(87 downto 80);
	a11 <= i_a(55 downto 48);
	a12 <= i_a(23 downto 16);
	--row 3	
	a22 <= i_a(111 downto 104);
	a23 <= i_a(79 downto 72);
	a20 <= i_a(47 downto 40);
	a21 <= i_a(15 downto 8); 
	--row 4
	a31 <= i_a(103 downto 96);
	a32 <= i_a(71 downto 64);
	a33 <= i_a(39 downto 32); 
	a30 <= i_a(7 downto 0);
	
	--ShiftRows output
	o_a <= (a00 & a10 & a20 & a30 &
			a01 & a11 & a21 & a31 &
			a02 & a12 & a22 & a32 &
			a03 & a13 & a23 & a33);
end architecture;