library ieee;
use ieee.std_logic_1164.all;

library work;
 use work.globals.all; 
 
entity Mixcolumns_Dshare is
	port (
	i_a : in shared_state;
	o_b : out shared_state 
		);	
end entity;

architecture Behavioral of Mixcolumns_Dshare is
	component Mixcolumns
		port (
		i_a : in std_logic_vector(127 downto 0); --state input from ShiftRows
		o_b : out std_logic_vector(127 downto 0) 
			);	
	end component;
	
begin
	gen: for i in 0 to D-1 generate
		mux: Mixcolumns		port map (
							i_a => i_a(i),
							o_b  => o_b(i)
							);
			
		end generate;
end architecture;