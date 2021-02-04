library ieee;
use ieee.std_logic_1164.all;

library work;
 use work.globals.all; 
 
entity Reg_State_Dshare is
	port (
		clk 	: in std_logic;
		reset 	: in std_logic;
		en 		: in std_logic;
		i_d 	: in shared_state;
		o_q 	: out shared_state
		);	
end entity;

architecture Behavioral of Reg_State_Dshare is
	component Reg_State 
		port (
		clk : in std_logic;
		reset : in std_logic;
		en : in std_logic;
		i_d : in std_logic_vector(127 downto 0);
		o_q : out std_logic_vector(127 downto 0)
	);
	end component;
	
begin
	gen: for i in 0 to D-1 generate
		State_D: Reg_State port map (
							clk => clk,
							reset => reset,
							en 	 => en,
							i_d  => i_d(i),
							o_q => o_q(i)
							);
			
		end generate;
end architecture;