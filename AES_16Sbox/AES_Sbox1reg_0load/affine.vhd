----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:16:29 05/25/2020 
-- Design Name: 
-- Module Name:    affine - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity affine is
port(x7, x6, x5, x4, x3, x2, x1, x0: in std_logic;
		F: out std_logic_vector(7 downto 0));
end affine;

architecture Behavioral of affine is

begin
	F(0) <= X0 xor X4 xor X5 xor X6 xor X7 xor '1';
	F(1) <= X0 xor X1 xor X5 xor X6 xor X7 xor '1';
	F(2) <= X0 xor X1 xor X2 xor X6 xor X7 xor '0';
	F(3) <= X0 xor X1 xor X2 xor X3 xor X7 xor '0';
	F(4) <= X0 xor X1 xor X2 xor X3 xor X4 xor '0';
	F(5) <= X1 xor X2 xor X3 xor X4 xor X5 xor '1';
	F(6) <= X2 xor X3 xor X4 xor X5 xor X6 xor '1';
	F(7) <= X3 xor X4 xor X5 xor X6 xor X7 xor '0';

end Behavioral;

