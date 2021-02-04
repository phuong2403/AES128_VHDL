library ieee;
use ieee.std_logic_1164.all;

library work;
 use work.globals.all; 
 
entity Mux2_Dshare is	
	port (
	i_a : in shared_byte;
	i_b : in shared_byte;
	en : in std_logic;
	o_c : out shared_byte 
		);	
end entity;

architecture Behavioral of Mux2_Dshare is
	component Mux2_1share
		port (
		i_a : in std_logic_vector(7 downto 0);
		i_b : in std_logic_vector(7 downto 0);
		en 	: in std_logic;
		o_c : out std_logic_vector(7 downto 0) 
			);	
	end component;
	
begin
	gen: for i in 0 to D-1 generate
		mux: Mux2_1share port map (
							i_a => i_a(i),
							i_b  => i_b(i),
							en 	 => en,
							o_c  => o_c(i)
							);
			
		end generate;
end architecture;