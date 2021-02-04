----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:42:01 05/27/2020 
-- Design Name: 
-- Module Name:    test_sbox - Behavioral 
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

entity test_sbox is
	port(
		clock			: in std_logic;
		x_in 	: in  std_logic_vector(7 downto 0);
		z_out 	: out std_logic_vector(7 downto 0)
		);
end test_sbox;

architecture Behavioral of test_sbox is

	component sbox_shares
		port(X00, X0_1, X02, X03, X10, X11, X12, X13, X20, X21, X22, X23, X30, X31, X32, X33, X40, X41, X42, X43, X50, X51, X52, X53, X60, X61, X62, X63, X70, X71, X72, X73 : in std_logic;
			clock :in std_logic;
			F00, F01, F02, F03, F10, F11, F12, F13, F20, F21, F22, F23, F30, F31, F32, F33, F40, F41, F42, F43, F50, F51, F52, F53, F60, F61, F62, F63, F70, F71, F72, F73 : out std_logic);
	end component;
	signal 	s_in 	: std_logic_vector(31 downto 0) := x"55555555";
	signal	s_out :  std_logic_vector(31 downto 0) := x"55555555";
begin
	sbox : sbox_shares port map (s_in(0), s_in(1), s_in(2), s_in(3), s_in(4), s_in(5), s_in(6), s_in(7), s_in(8), s_in(9), s_in(10), s_in(11), s_in(12), s_in(13), s_in(14), s_in(15), s_in(16), s_in(17), s_in(18), s_in(19), s_in(20), s_in(21), s_in(22), s_in(23), s_in(24), s_in(25), s_in(26), s_in(27), s_in(28), s_in(29), s_in(30), s_in(31), clock,
										s_out(0), s_out(1), s_out(2), s_out(3), s_out(4), s_out(5), s_out(6), s_out(7), s_out(8), s_out(9), s_out(10), s_out(11), s_out(12), s_out(13), s_out(14), s_out(15), s_out(16), s_out(17), s_out(18), s_out(19), s_out(20), s_out(21), s_out(22), s_out(23), s_out(24), s_out(25), s_out(26), s_out(27), s_out(28), s_out(29), s_out(30), s_out(31));
	s_in(3) <= s_in(0) xor s_in(1) xor s_in(2) xor x_in(0);
	s_in(7) <= s_in(4) xor s_in(5) xor s_in(6) xor x_in(1);
	s_in(11) <= s_in(8) xor s_in(9) xor s_in(10) xor x_in(2);
	s_in(15) <= s_in(12) xor s_in(13) xor s_in(14) xor x_in(3);
	s_in(19) <= s_in(16) xor s_in(17) xor s_in(18) xor x_in(4);
	s_in(23) <= s_in(20) xor s_in(21) xor s_in(22) xor x_in(5);
	s_in(27) <= s_in(24) xor s_in(25) xor s_in(26) xor x_in(6);
	s_in(31) <= s_in(28) xor s_in(29) xor s_in(30) xor x_in(7);

	z_out(0) <= s_out(0) xor s_out(1) xor s_out(2) xor s_out(3);
	z_out(1) <= s_out(4) xor s_out(5) xor s_out(6) xor s_out(7);
	z_out(2) <= s_out(8) xor s_out(9) xor s_out(10) xor s_out(11);
	z_out(3) <= s_out(12) xor s_out(13) xor s_out(14) xor s_out(15);
	z_out(4) <= s_out(16) xor s_out(17) xor s_out(18) xor s_out(19);
	z_out(5) <= s_out(20) xor s_out(21) xor s_out(22) xor s_out(23);
	z_out(6) <= s_out(24) xor s_out(25) xor s_out(26) xor s_out(27);
	z_out(7) <= s_out(28) xor s_out(29) xor s_out(30) xor s_out(31);

end Behavioral;

