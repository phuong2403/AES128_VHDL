----------------------------------------------------------------------------------
-- Company: 
-- Engineer:   Thomas De Cnudde
-- 
-- Create Date:   21/05/2016 
-- Design Name:   AES RNG
-- Module Name: Sbox_rng_GF_INV_4
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

-- unsigned datatype is not used
--use ieee.numeric_std.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Sbox_rng_GF_INV_4 is
  -- inverse in GF(2^4)/GF(2^2), using normal basis [alpha^8, alpha^2]
  port (
  	-- inputs
	A : in std_logic_vector(3 downto 0);
	-- outputs
	Q : out std_logic_vector(3 downto 0)
  ) ;
end entity ; -- Sbox_rng_GF_INV_4

architecture RTL of Sbox_rng_GF_INV_4 is

	signal a_small, b, c, d, p, q_small : std_logic_vector(1 downto 0);
	signal sa, sb, sd : std_logic;

	-- Component Instantiations
	component Sbox_rng_GF_MULS_2
  	-- multiply in GF(2^2), shared factors, using normal basis [Omega^2,Omega]
	  port (
	  	-- inputs
		A : in std_logic_vector(1 downto 0);
		ab : in std_logic;
		B : in std_logic_vector(1 downto 0);
		cd : in std_logic;
		-- outputs
		Q : out std_logic_vector(1 downto 0)
	  ) ;
	end component ; -- Sbox_rng_GF_MULS_2

begin

	a_small <= A(3 downto 2);
	b <= A(1 downto 0);
	sa <= a_small(1) xor a_small(0);
	sb <= b(1) xor b(0);
	c <= ((not (a_small(1) or b(1))) xor (not (sa and sb))) &
		 ((not (sa or sb)) xor (not (a_small(0) and b(0)))) ;
	sd <= d(1) xor d(0);	
	d <= c(0) & c(1);

	pmul : Sbox_rng_GF_MULS_2 port map (A=>d, ab=>sd, B=>b, cd=>sb, Q=>p);
	qmul : Sbox_rng_GF_MULS_2 port map (A=>d, ab=>sd, B=>a_small, cd=>sa, Q=>q_small);

	-- Output Assignation
	Q <= p & q_small;

end architecture ; -- RTL
