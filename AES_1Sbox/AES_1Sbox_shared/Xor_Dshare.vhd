library ieee;
use ieee.std_logic_1164.all;

library work;
 use work.globals.all; 
 
entity Xor_Dshare is	
	port (
	i_a : in shared_byte;
	i_b : in shared_byte;
	o_c : out shared_byte 
		);	
end entity;

architecture Behavioral of Xor_Dshare is
	component Xor_1share
		port (
		i_a : in std_logic_vector(7 downto 0);
		i_b : in std_logic_vector(7 downto 0);
		o_c : out std_logic_vector(7 downto 0) 
			);	
	end component;
	
begin
	gen: for i in 0 to D-1 generate
		xor_D: Xor_1share port map (
							i_a => i_a(i),
							i_b  => i_b(i),
							o_c  => o_c(i)
							);
			
		end generate;
end architecture;