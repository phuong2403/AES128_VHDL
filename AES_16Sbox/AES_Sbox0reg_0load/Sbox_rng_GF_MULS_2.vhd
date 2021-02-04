----------------------------------------------------------------------------------
-- Company: 
-- Engineer:   Thomas De Cnudde
-- 
-- Create Date:   21/05/2016 
-- Design Name:   AES RNG
-- Module Name: Sbox_rng_GF_MULS_2
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

entity Sbox_rng_GF_MULS_2 is
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
end entity ; -- Sbox_rng_GF_MULS_2

architecture RTL of Sbox_rng_GF_MULS_2 is

	signal abcd, p_small, q_small : std_logic;

begin

	abcd <= not (ab and cd);
	p_small <= (not (A(1) and B(1))) xor abcd;
	q_small <= (not (A(0) and B(0))) xor abcd;
	Q <= p_small & q_small;

end architecture ; -- RTL
