----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:56:13 05/25/2020 
-- Design Name: 
-- Module Name:    sbox-shared - Behavioral 
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
-- Input_shares: X00, X0_1, X02, X03; X10, X11, X12, X13; X20, X21, X22, X23; X30, X31, X32, X33; X40, X41, X42, X43; X50, X51, X52, X53; X60, X61, X62, X63; X70, X71, X72, X73.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Sbox_shared is
	port(X00, X0_1, X02, X03, X10, X11, X12, X13, X20, X21, X22, X23, X30, X31, X32, X33, X40, X41, X42, X43, X50, X51, X52, X53, X60, X61, X62, X63, X70, X71, X72, X73 : in std_logic;
      	clock :in std_logic;
        F00, F01, F02, F03, F10, F11, F12, F13, F20, F21, F22, F23, F30, F31, F32, F33, F40, F41, F42, F43, F50, F51, F52, F53, F60, F61, F62, F63, F70, F71, F72, F73 : out std_logic);
end Sbox_shared;

architecture Behavioral of Sbox_shared is
	component x26_shares
   		port (X00, X0_1, X02, X03, X10, X11, X12, X13, X20, X21, X22, X23, X30, X31, X32, X33, X40, X41, X42, X43, X50, X51, X52, X53, X60, X61, X62, X63, X70, X71, X72, X73 : in std_logic;
    		F00, F01, F02, F03, F10, F11, F12, F13, F20, F21, F22, F23, F30, F31, F32, F33, F40, F41, F42, F43, F50, F51, F52, F53, F60, F61, F62, F63, F70, F71, F72, F73 : out std_logic);
	end component;
	component x49_shares
   		port (X00, X0_1, X02, X03, X10, X11, X12, X13, X20, X21, X22, X23, X30, X31, X32, X33, X40, X41, X42, X43, X50, X51, X52, X53, X60, X61, X62, X63, X70, X71, X72, X73 : in std_logic;
    		F00, F01, F02, F03, F10, F11, F12, F13, F20, F21, F22, F23, F30, F31, F32, F33, F40, F41, F42, F43, F50, F51, F52, F53, F60, F61, F62, F63, F70, F71, F72, F73 : out std_logic);
	end component;
	component affine
   		port (X00, X0_1, X02, X03, X10, X11, X12, X13, X20, X21, X22, X23, X30, X31, X32, X33, X40, X41, X42, X43, X50, X51, X52, X53, X60, X61, X62, X63, X70, X71, X72, X73 : in std_logic;
    		F00, F01, F02, F03, F10, F11, F12, F13, F20, F21, F22, F23, F30, F31, F32, F33, F40, F41, F42, F43, F50, F51, F52, F53, F60, F61, F62, F63, F70, F71, F72, F73 : out std_logic);
	end component;

--	signal w_reg, x_reg, y_reg, z_reg   :std_logic;
	signal z26 : std_logic_vector(31 downto 0); signal z26_reg : std_logic_vector(31 downto 0);
	signal sig : std_logic_vector(31 downto 0);
--	signal D0 : std_logic_vector(31 downto 0); signal Q0 : std_logic_vector(31 downto 0);
--	signal D1 : std_logic_vector(31 downto 0); signal Q1 : std_logic_vector(31 downto 0);

begin
	p26 : x26_shares port map (X00, X0_1, X02, X03, X10, X11, X12, X13, X20, X21, X22, X23, X30, X31, X32, X33, X40, X41, X42, X43, X50, X51, X52, X53, X60, X61, X62, X63, X70, X71, X72, X73,
		z26(0), z26(1), z26(2), z26(3), z26(4), z26(5), z26(6), z26(7), z26(8), z26(9), z26(10), z26(11), z26(12), z26(13), z26(14), z26(15), z26(16), z26(17), z26(18), z26(19), z26(20), z26(21), z26(22), z26(23), z26(24), z26(25), z26(26), z26(27), z26(28), z26(29), z26(30), z26(31));
	p49 : x49_shares port map (z26_reg(0), z26_reg(1), z26_reg(2), z26_reg(3), z26_reg(4), z26_reg(5), z26_reg(6), z26_reg(7), z26_reg(8), z26_reg(9), z26_reg(10), z26_reg(11), z26_reg(12), z26_reg(13), z26_reg(14), z26_reg(15), z26_reg(16), z26_reg(17), z26_reg(18), z26_reg(19), z26_reg(20), z26_reg(21), z26_reg(22), z26_reg(23), z26_reg(24), z26_reg(25), z26_reg(26), z26_reg(27), z26_reg(28), z26_reg(29), z26_reg(30), z26_reg(31),
		sig(0), sig(1), sig(2), sig(3), sig(4), sig(5), sig(6), sig(7), sig(8), sig(9), sig(10), sig(11), sig(12), sig(13), sig(14), sig(15), sig(16), sig(17), sig(18), sig(19), sig(20), sig(21), sig(22), sig(23), sig(24), sig(25), sig(26), sig(27), sig(28), sig(29), sig(30), sig(31));
	pAff : affine port map (sig(0), sig(1), sig(2), sig(3), sig(4), sig(5), sig(6), sig(7), sig(8), sig(9), sig(10), sig(11), sig(12), sig(13), sig(14), sig(15), sig(16), sig(17), sig(18), sig(19), sig(20), sig(21), sig(22), sig(23), sig(24), sig(25), sig(26), sig(27), sig(28), sig(29), sig(30), sig(31),
		F00, F01, F02, F03, F10, F11, F12, F13, F20, F21, F22, F23, F30, F31, F32, F33, F40, F41, F42, F43, F50, F51, F52, F53, F60, F61, F62, F63, F70, F71, F72, F73);

	
	process (clock) begin
	--if (clock'event and clock='1') then
		if rising_edge(clock) then
			z26_reg <= z26; 
		end if;
	end process;


end Behavioral;

