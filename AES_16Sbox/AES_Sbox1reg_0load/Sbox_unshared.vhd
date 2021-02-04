----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:19:17 05/25/2020 
-- Design Name: 
-- Module Name:    Sbox_unshared - Behavioral 
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

entity Sbox_unshared is
port(x_in : in std_logic_vector(7 downto 0);
		clock : in std_logic;
		z_out: out std_logic_vector(7 downto 0));
end Sbox_unshared;

architecture Behavioral of Sbox_unshared is
component x26
port(x7, x6, x5, x4, x3, x2, x1, x0: in std_logic;
		F: out std_logic_vector(7 downto 0));
end component;
component x49
port(x7, x6, x5, x4, x3, x2, x1, x0: in std_logic;
		F: out std_logic_vector(7 downto 0));
end component;
component affine
port(x7, x6, x5, x4, x3, x2, x1, x0: in std_logic;
		F: out std_logic_vector(7 downto 0));
end component;
	signal z26 : std_logic_vector(7 downto 0); signal z26_reg : std_logic_vector(7 downto 0);
	signal sig : std_logic_vector(7 downto 0);
begin
	p26 : x26 port map (x_in(7), x_in(6), x_in(5), x_in(4), x_in(3), x_in(2), x_in(1), x_in(0), z26);
	p49 : x49 port map (z26_reg(7), z26_reg(6), z26_reg(5), z26_reg(4), z26_reg(3), z26_reg(2), z26_reg(1), z26_reg(0),
		sig);
	pAff : affine port map (sig(7), sig(6), sig(5), sig(4), sig(3), sig(2), sig(1), sig(0), z_out);

	
	process (clock) begin
		if rising_edge(clock) then
			z26_reg <= z26; 
		end if;
	end process;

end Behavioral;

