
-- Engineer:   Thomas De Cnudde
-- Create Date:   16/04/2016 
--------------------------------------------------------------
-- Module name : MixColumns
-- Top level : AES_top
-- Implementation of AES 128 bit using loop unrolled techniques (only encryption)
-- except control signal : clock, reset, start, load;
-- other input/output in entities of blocks (not top level) are declared starting with i_/o_
-- signals in architecture start with ri_/ro_

-- This file is the third step of each round (1-10)
----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity MixColumns is
	port (
		i_a : in std_logic_vector(127 downto 0); --state input from ShiftRows
		o_b : out std_logic_vector(127 downto 0) --state output from MixColumns
	);
end entity;

architecture RTL of MixColumns is
	signal a00, a01, a02, a03 : std_logic_vector(7 downto 0); -- input four-byte row 1
	signal a10, a11, a12, a13 : std_logic_vector(7 downto 0); -- input four-byte row 2
	signal a20, a21, a22, a23 : std_logic_vector(7 downto 0); -- input four-byte row 3
	signal a30, a31, a32, a33 : std_logic_vector(7 downto 0); -- input four-byte row 4
	
	signal b00, b01, b02, b03 : std_logic_vector(7 downto 0); -- output four-byte row 1
	signal b10, b11, b12, b13 : std_logic_vector(7 downto 0); -- output four-byte row 2
	signal b20, b21, b22, b23 : std_logic_vector(7 downto 0); -- output four-byte row 3
	signal b30, b31, b32, b33 : std_logic_vector(7 downto 0); -- output four-byte row 4	
begin
	a00 <= i_a(127 downto 120); --start with column 1, each box is one byte
	a10 <= i_a(119 downto 112); --comlumn-major order
	a20 <= i_a(111 downto 104);
	a30 <= i_a(103 downto 96);
	a01 <= i_a(95 downto 88); --row 2
	a11<= i_a(87 downto 80); 
	a21 <= i_a(79 downto 72);
	a31 <= i_a(71 downto 64);
	a02 <= i_a(63 downto 56); --row 3
	a12 <= i_a(55 downto 48); 
	a22 <= i_a(47 downto 40);
	a32 <= i_a(39 downto 32);
	a03 <= i_a(31 downto 24); --row 4
	a13 <= i_a(23 downto 16); 
	a23 <= i_a(15 downto 8);
	a33 <= i_a(7 downto 0);
	
	-- output is product of each column to polynomial f(x)=2x^3 + 3x^2 + x + 1 and co-efficient rotation for next boxs in each column
	-- output column 1
	b00 <= ((a00(6 downto 0) & '0') xor (a10(6 downto 0) & '0') xor a10 xor a20 xor a30 xor x"1b") when ((a00(7) xor a10(7))='1') else ((a00(6 downto 0) & '0') xor (a10(6 downto 0) & '0') xor a10 xor a20 xor a30);
	b10 <= ((a10(6 downto 0) & '0') xor (a20(6 downto 0) & '0') xor a20 xor a30 xor a00 xor x"1b") when ((a10(7) xor a20(7))='1') else ((a10(6 downto 0) & '0') xor (a20(6 downto 0) & '0') xor a20 xor a30 xor a00);
	b20 <= ((a20(6 downto 0) & '0') xor (a30(6 downto 0) & '0') xor a30 xor a00 xor a10 xor x"1b") when ((a20(7) xor a30(7))='1') else ((a20(6 downto 0) & '0') xor (a30(6 downto 0) & '0') xor a30 xor a00 xor a10);
	b30 <= ((a30(6 downto 0) & '0') xor (a00(6 downto 0) & '0') xor a00 xor a10 xor a20 xor x"1b") when ((a30(7) xor a00(7))='1') else ((a30(6 downto 0) & '0') xor (a00(6 downto 0) & '0') xor a00 xor a10 xor a20);
	-- output column 2
	b01 <= ((a01(6 downto 0) & '0') xor (a11(6 downto 0) & '0') xor a11 xor a21 xor a31 xor x"1b") when ((a01(7) xor a11(7))='1') else ((a01(6 downto 0) & '0') xor (a11(6 downto 0) & '0') xor a11 xor a21 xor a31);
	b11 <= ((a11(6 downto 0) & '0') xor (a21(6 downto 0) & '0') xor a21 xor a31 xor a01 xor x"1b") when ((a11(7) xor a21(7))='1') else ((a11(6 downto 0) & '0') xor (a21(6 downto 0) & '0') xor a21 xor a31 xor a01);
	b21 <= ((a21(6 downto 0) & '0') xor (a31(6 downto 0) & '0') xor a31 xor a01 xor a11 xor x"1b") when ((a21(7) xor a31(7))='1') else ((a21(6 downto 0) & '0') xor (a31(6 downto 0) & '0') xor a31 xor a01 xor a11);
	b31 <= ((a31(6 downto 0) & '0') xor (a01(6 downto 0) & '0') xor a01 xor a11 xor a21 xor x"1b") when ((a31(7) xor a01(7))='1') else ((a31(6 downto 0) & '0') xor (a01(6 downto 0) & '0') xor a01 xor a11 xor a21);
	-- output column 3
	b02 <= ((a02(6 downto 0) & '0') xor (a12(6 downto 0) & '0') xor a12 xor a22 xor a32 xor x"1b") when ((a02(7) xor a12(7))='1') else ((a02(6 downto 0) & '0') xor (a12(6 downto 0) & '0') xor a12 xor a22 xor a32);
	b12 <= ((a12(6 downto 0) & '0') xor (a22(6 downto 0) & '0') xor a22 xor a32 xor a02 xor x"1b") when ((a12(7) xor a22(7))='1') else ((a12(6 downto 0) & '0') xor (a22(6 downto 0) & '0') xor a22 xor a32 xor a02);
	b22 <= ((a22(6 downto 0) & '0') xor (a32(6 downto 0) & '0') xor a32 xor a02 xor a12 xor x"1b") when ((a22(7) xor a32(7))='1') else ((a22(6 downto 0) & '0') xor (a32(6 downto 0) & '0') xor a32 xor a02 xor a12);
	b32 <= ((a32(6 downto 0) & '0') xor (a02(6 downto 0) & '0') xor a02 xor a12 xor a22 xor x"1b") when ((a32(7) xor a02(7))='1') else ((a32(6 downto 0) & '0') xor (a02(6 downto 0) & '0') xor a02 xor a12 xor a22);
	-- output column 4
	b03 <= ((a03(6 downto 0) & '0') xor (a13(6 downto 0) & '0') xor a13 xor a23 xor a33 xor x"1b") when ((a03(7) xor a13(7))='1') else ((a03(6 downto 0) & '0') xor (a13(6 downto 0) & '0') xor a13 xor a23 xor a33);
	b13 <= ((a13(6 downto 0) & '0') xor (a23(6 downto 0) & '0') xor a23 xor a33 xor a03 xor x"1b") when ((a13(7) xor a23(7))='1') else ((a13(6 downto 0) & '0') xor (a23(6 downto 0) & '0') xor a23 xor a33 xor a03);
	b23 <= ((a23(6 downto 0) & '0') xor (a33(6 downto 0) & '0') xor a33 xor a03 xor a13 xor x"1b") when ((a23(7) xor a33(7))='1') else ((a23(6 downto 0) & '0') xor (a33(6 downto 0) & '0') xor a33 xor a03 xor a13);
	b33 <= ((a33(6 downto 0) & '0') xor (a03(6 downto 0) & '0') xor a03 xor a13 xor a23 xor x"1b") when ((a33(7) xor a03(7))='1') else ((a33(6 downto 0) & '0') xor (a03(6 downto 0) & '0') xor a03 xor a13 xor a23);

	--State output
	o_b <= (b00 & b10 & b20 & b30 &
			b01 & b11 & b21 & b31 &
			b02 & b12 & b22 & b32 &
			b03 & b13 & b23 & b33);
end architecture;
 