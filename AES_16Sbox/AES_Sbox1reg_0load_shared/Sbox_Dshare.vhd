
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.globals.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity Sbox_Dshare is
	port (	
		clk: std_logic;
		i_Sbox : in shared_byte;
		o_Sbox: out shared_byte);
end entity;


architecture RTL of Sbox_Dshare is

	component Sbox_shared
	port(X00, X0_1, X02, X03, X10, X11, X12, X13, X20, X21, X22, X23, X30, X31, X32, X33, X40, X41, X42, X43, X50, X51, X52, X53, X60, X61, X62, X63, X70, X71, X72, X73 : in std_logic;
      	clock :in std_logic;
        F00, F01, F02, F03, F10, F11, F12, F13, F20, F21, F22, F23, F30, F31, F32, F33, F40, F41, F42, F43, F50, F51, F52, F53, F60, F61, F62, F63, F70, F71, F72, F73 : out std_logic);
end component;

begin
	AES_Sbox: Sbox_shared 
 		Port map(
				-- type shared_byte is array(0 to D-1) of std_logic_vector(7 downto 0)
				-- X00, X0_1, X02, X03 least significant bits
				-- X70, X71, X72, X73 most significant bits
				clock => clk,
				--1st share input byte
				X00 => i_Sbox(0)(0),
				X10 => i_Sbox(0)(1),
				X20 => i_Sbox(0)(2),
				X30 => i_Sbox(0)(3),
				X40 => i_Sbox(0)(4),
				X50 => i_Sbox(0)(5),
				X60 => i_Sbox(0)(6),
				X70 => i_Sbox(0)(7),
				
				--2nd share input byte
				X0_1 => i_Sbox(1)(0),
				X11 => i_Sbox(1)(1),
				X21 => i_Sbox(1)(2),
				X31 => i_Sbox(1)(3),
				X41 => i_Sbox(1)(4),
				X51 => i_Sbox(1)(5),
				X61 => i_Sbox(1)(6),
				X71 => i_Sbox(1)(7),
				
				--3rd share input byte
				X02 => i_Sbox(2)(0),
				X12 => i_Sbox(2)(1),
				X22 => i_Sbox(2)(2),
				X32 => i_Sbox(2)(3),
				X42 => i_Sbox(2)(4),
				X52 => i_Sbox(2)(5),
				X62 => i_Sbox(2)(6),
				X72 => i_Sbox(2)(7),
				
				--4th share input byte
				X03 => i_Sbox(3)(0),
				X13 => i_Sbox(3)(1),
				X23 => i_Sbox(3)(2),
				X33 => i_Sbox(3)(3),
				X43 => i_Sbox(3)(4),
				X53 => i_Sbox(3)(5),
				X63 => i_Sbox(3)(6),
				X73 => i_Sbox(3)(7),
				
				--1st share output byte
				F00 => o_Sbox(0)(0),
				F10 => o_Sbox(0)(1),
				F20 => o_Sbox(0)(2),
				F30 => o_Sbox(0)(3),
				F40 => o_Sbox(0)(4),
				F50 => o_Sbox(0)(5),
				F60 => o_Sbox(0)(6),
				F70 => o_Sbox(0)(7),
				
				--2nd share output byte
				F01 => o_Sbox(1)(0),
				F11 => o_Sbox(1)(1),
				F21 => o_Sbox(1)(2),
				F31 => o_Sbox(1)(3),
				F41 => o_Sbox(1)(4),
				F51 => o_Sbox(1)(5),
				F61 => o_Sbox(1)(6),
				F71 => o_Sbox(1)(7),
				
				--3rd share output byte
				F02 => o_Sbox(2)(0),
				F12 => o_Sbox(2)(1),
				F22 => o_Sbox(2)(2),
				F32 => o_Sbox(2)(3),
				F42 => o_Sbox(2)(4),
				F52 => o_Sbox(2)(5),
				F62 => o_Sbox(2)(6),
				F72 => o_Sbox(2)(7),
				
				--4th share output byte
				F03 => o_Sbox(3)(0),
				F13 => o_Sbox(3)(1),
				F23 => o_Sbox(3)(2),
				F33 => o_Sbox(3)(3),
				F43 => o_Sbox(3)(4),
				F53 => o_Sbox(3)(5),
				F63 => o_Sbox(3)(6),
				F73 => o_Sbox(3)(7)
				);
end RTL;

