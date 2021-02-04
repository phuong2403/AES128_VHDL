----------------------------------------------------------------------------------
-- Company: 
-- Engineer:   Thomas De Cnudde
-- 
-- Create Date:   21/05/2016 
-- Design Name:   AES RNG
-- Module Name: Sbox_rng_GF_INV_8
-- Project Name: Lab FPGA Frame
-- Target Devices:
-- Tool versions:
-- Description: 
-- Top level AES RNG
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
-- 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity Sbox_rng_GF_INV_8 is
	port (
	A : in std_logic_vector(7 downto 0);
	Q : out std_logic_vector(7 downto 0)
	);
end entity;

architecture RTL of Sbox_rng_GF_INV_8 is

	signal a_small, b, c ,d ,p , q_small : std_logic_vector(3 downto 0);
	signal sa, sb, sd : std_logic_vector(1 downto 0);
	signal al, ah, aa, bl, bh, bb, dl, dh, dd : std_logic;
	signal c1, c2, c3 : std_logic;

	-- Component Instantiation
	component Sbox_rng_GF_MULS_4
  	-- multiply in GF(2^4)/GF(2^2), shared factors, basis [alpha^8, alpha^2]
	  port (
	  	-- inputs
		AAA : in std_logic_vector(3 downto 0);
		a : in std_logic_vector(1 downto 0);
		Al, Ah, aa : in std_logic;
		BBB : in std_logic_vector(3 downto 0);
		b : in std_logic_vector(1 downto 0);
		Bl : in std_logic;
		Bh : in std_logic;
		bb : in std_logic;
		-- outputs
		Q : out std_logic_vector(3 downto 0)
	  ) ;
	end component ; -- Sbox_rng_GF_MULS_4

	component Sbox_rng_GF_INV_4 
	  -- inverse in GF(2^4)/GF(2^2), using normal basis [alpha^8, alpha^2]
	  port (
	  	-- inputs
		A : in std_logic_vector(3 downto 0);
		-- outputs
		Q : out std_logic_vector(3 downto 0)
	  ) ;
	end component ; -- Sbox_rng_GF_INV_4
	
begin
	a_small <= A(7 downto 4);
	b <= A(3 downto 0);
	sa <= a_small(3 downto 2) xor a_small(1 downto 0);
	sb <= b(3 downto 2) xor b(1 downto 0);
	al <= a_small(1) xor a_small(0);
	ah <= a_small(3) xor a_small(2);
	aa <= sa(1) xor sa(0);
	bl <= b(1) xor b(0);
	bh <= b(3) xor b(2);
	bb <= sb(1) xor sb(0);
	c1 <= not (ah and bh);
	c2 <= not (sa(0) and sb(0));
	c3 <= not (aa and bb);

	c <= (	(( not (sa(0) or sb(0)) xor ( not (a_small(3) and b(3)))) xor c1 xor c3) &
			(( not (sa(1) or sb(1)) xor ( not (a_small(2) and b(2)))) xor c1 xor c2) &
			(( not (al or bl) xor ( not (a_small(1) and b(1)))) xor c2 xor c3) &
			(( not (a_small(0) or b(0)) xor ( not (al and bl))) xor ( not (sa(1) and sb(1))) xor c2) );

	dinv : Sbox_rng_GF_INV_4 port map ( A=>c, Q=>d);

	sd <= d(3 downto 2) xor d(1 downto 0);
	dl <= d(1) xor d(0);
	dh <= d(3) xor d(2);
	dd <= sd(1) xor sd(0);

	pmul : Sbox_rng_GF_MULS_4 port map (
		AAA=>d, a=>sd, Al=>dl, Ah=>dh, 
		aa=>dd, BBB=>b, b=>sb, Bl=>bl, 
		Bh=>bh, bb=>bb, Q=>p );
	qmul : Sbox_rng_GF_MULS_4 port map (
		AAA=>d, a=>sd, Al=>dl, Ah=>dh, 
		aa=>dd, BBB=>a_small, b=>sa, Bl=>al, 
		Bh=>ah, bb=>aa, Q=>q_small );
	
	-- Output Assignation
	Q <= p & q_small;	
end architecture;