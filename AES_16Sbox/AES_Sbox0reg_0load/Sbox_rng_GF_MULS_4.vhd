----------------------------------------------------------------------------------
-- Company: 
-- Engineer:   Thomas De Cnudde
-- 
-- Create Date:   21/05/2016 
-- Design Name:   AES RNG
-- Module Name: Sbox_rng_GF_MULS_4
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

entity Sbox_rng_GF_MULS_4 is
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
end entity ; -- Sbox_rng_GF_MULS_4

architecture RTL of Sbox_rng_GF_MULS_4 is

	signal ph, pl, p : std_logic_vector(1 downto 0);
	
	-- Component Instantiation
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

	component Sbox_rng_GF_MULS_SCL_2
	  -- multiply & scale by N in GF(2^2), shared factors, basis [Omega^2,Omega]
	  port (
	  	-- inputs
		A : in std_logic_vector(1 downto 0);
		ab : in std_logic;
		B : in std_logic_vector(1 downto 0);
		cd : in std_logic;
		-- outputs
		Q : out std_logic_vector(1 downto 0)
	  ) ;
	end component ; -- Sbox_rng_GF_MULS_SCL_2

begin

	himul : Sbox_rng_GF_MULS_2 
		port map(
			A=>AAA(3 downto 2), 
			ab=>Ah, 
			B=>BBB(3 downto 2), 
			cd=>Bh, 
			Q=>ph );

	lomul : Sbox_rng_GF_MULS_2 
		port map (
			A=>AAA(1 downto 0), 
			ab=>Al, 
			B=>BBB(1 downto 0), 
			cd=>Bl, 
			Q=>pl );
	summul : Sbox_rng_GF_MULS_SCL_2 
		port map ( 
			A=>a, 
			ab=>aa, 
			B=>b, 
			cd=>bb, 
			Q=>p );
	-- Output Assignation
	Q <= (ph xor p) & (pl xor p);

end architecture ; -- RTL
