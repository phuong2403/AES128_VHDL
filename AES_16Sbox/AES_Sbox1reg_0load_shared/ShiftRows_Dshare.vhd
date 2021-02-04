library ieee;
use ieee.std_logic_1164.all;

library work;
 use work.globals.all; 
 
entity ShiftRows_Dshare is
	port (
	i_a : in shared_state;
	o_a : out shared_state 
		);	
end entity;

architecture Behavioral of ShiftRows_Dshare is
	component ShiftRows
		port (
		i_a : in std_logic_vector(127 downto 0);
		o_a : out std_logic_vector(127 downto 0)	
	);	
	end component;
	
begin
	gen: for i in 0 to D-1 generate
		shift_D: ShiftRows		port map (
							i_a => i_a(i),
							o_a  => o_a(i)
							);
			
		end generate;
end architecture;