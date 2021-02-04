
library ieee;
use ieee.std_logic_1164.all;

entity AddRoundKey is
	port (
		--clk : in std_logic;
		i_key : in std_logic_vector(127 downto 0);
		i_state : in std_logic_vector(127 downto 0);
		o_state : out std_logic_vector(127 downto 0)
	);
end AddRoundKey;

architecture Behavioral of AddRoundKey is
	
begin
	o_state <= i_key xor i_state;
end architecture Behavioral;
