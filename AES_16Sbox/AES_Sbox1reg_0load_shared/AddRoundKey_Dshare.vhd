library ieee;
use ieee.std_logic_1164.all;

library work;
 use work.globals.all; 
 
entity AddRoundKey_Dshare is	
	port (
	i_key : in shared_state;
	i_state : in shared_state;
	o_state : out shared_state 
		);	
end entity;

architecture Behavioral of AddRoundKey_Dshare is
	component AddRoundKey
		port (
			i_key : in std_logic_vector(127 downto 0);
			i_state : in std_logic_vector(127 downto 0);
			o_state : out std_logic_vector(127 downto 0)
		);
	end component;
	
begin
	gen: for i in 0 to D-1 generate
		Add_D: AddRoundKey port map (
							i_key => i_key(i),
							i_state  => i_state(i),
							o_state  => o_state(i)
							);
			
		end generate;
end architecture;