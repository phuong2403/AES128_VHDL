----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:53:30 05/25/2020 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity affine is
    port (
    X00, X0_1, X02, X03, X10, X11, X12, X13, X20, X21, X22, X23, X30, X31, X32, X33, X40, X41, X42, X43, X50, X51, X52, X53, X60, X61, X62, X63, X70, X71, X72, X73 : in std_logic;
    F00, F01, F02, F03, F10, F11, F12, F13, F20, F21, F22, F23, F30, F31, F32, F33, F40, F41, F42, F43, F50, F51, F52, F53, F60, F61, F62, F63, F70, F71, F72, F73 : out std_logic);
end affine;

architecture Behavioral of affine is

begin

	F00 <= X00 xor X40 xor X50 xor X60 xor X70 xor '1';
	F10 <= X00 xor X10 xor X50 xor X60 xor X70 xor '1';
	F20 <= X00 xor X10 xor X20 xor X60 xor X70 xor '0';
	F30 <= X00 xor X10 xor X20 xor X30 xor X70 xor '0';
	F40 <= X00 xor X10 xor X20 xor X30 xor X40 xor '0';
	F50 <= X10 xor X20 xor X30 xor X40 xor X50 xor '1';
	F60 <= X20 xor X30 xor X40 xor X50 xor X60 xor '1';
	F70 <= X30 xor X40 xor X50 xor X60 xor X70 xor '0';

	F01 <= X0_1 xor X41 xor X51 xor X61 xor X71;
	F11 <= X0_1 xor X11 xor X51 xor X61 xor X71;
	F21 <= X0_1 xor X11 xor X21 xor X61 xor X71;
	F31 <= X0_1 xor X11 xor X21 xor X31 xor X71;
	F41 <= X0_1 xor X11 xor X21 xor X31 xor X41;
	F51 <= X11 xor X21 xor X31 xor X41 xor X51;
	F61 <= X21 xor X31 xor X41 xor X51 xor X61;
	F71 <= X31 xor X41 xor X51 xor X61 xor X71;

	F02 <= X02 xor X42 xor X52 xor X62 xor X72;
	F12 <= X02 xor X12 xor X52 xor X62 xor X72;
	F22 <= X02 xor X12 xor X22 xor X62 xor X72;
	F32 <= X02 xor X12 xor X22 xor X32 xor X72;
	F42 <= X02 xor X12 xor X22 xor X32 xor X42;
	F52 <= X12 xor X22 xor X32 xor X42 xor X52;
	F62 <= X22 xor X32 xor X42 xor X52 xor X62;
	F72 <= X32 xor X42 xor X52 xor X62 xor X72;

	F03 <= X03 xor X43 xor X53 xor X63 xor X73;
	F13 <= X03 xor X13 xor X53 xor X63 xor X73;
	F23 <= X03 xor X13 xor X23 xor X63 xor X73;
	F33 <= X03 xor X13 xor X23 xor X33 xor X73;
	F43 <= X03 xor X13 xor X23 xor X33 xor X43;
	F53 <= X13 xor X23 xor X33 xor X43 xor X53;
	F63 <= X23 xor X33 xor X43 xor X53 xor X63;
	F73 <= X33 xor X43 xor X53 xor X63 xor X73;


end Behavioral;

