library ieee;
use ieee.std_logic_1164.all;

library work;
 use work.globals.all; 
 
entity Mux_State_Dshare is
	port (
	i_a : in shared_state;
	i_b : in shared_state;
	en : in std_logic;
	o_c : out shared_state 
		);	
end entity;

architecture Behavioral of Mux_State_Dshare is
	component Mux_State	
		port (
		i_a : in std_logic_vector(127 downto 0);
		i_b : in std_logic_vector(127 downto 0);
		en 	: in std_logic;
		o_c : out std_logic_vector(127 downto 0) 
			);	
	end component;
	
begin
	gen: for i in 0 to D-1 generate
		MState_D: Mux_State port map (
								i_a => i_a(i),
								i_b  => i_b(i),
								en 	 => en,
								o_c  => o_c(i)
							);
			
		end generate;
end architecture;