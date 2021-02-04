library ieee;
use ieee.std_logic_1164.all;

entity Mux_State is
	port (
	i_a : in std_logic_vector(127 downto 0);
	i_b : in std_logic_vector(127 downto 0);
	en : in std_logic;
	o_c : out std_logic_vector(127 downto 0) 
		);	
end entity;

architecture Behavioral of Mux_State is
begin
	o_c <= i_a when (en = '0') else i_b;
end Behavioral;