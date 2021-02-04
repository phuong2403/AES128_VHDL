library ieee;
use ieee.std_logic_1164.all;

entity Reg_State is
	port (
		clk : in std_logic;
		reset : in std_logic;
		en : in std_logic;
		i_d : in std_logic_vector(127 downto 0);
		o_q : out std_logic_vector(127 downto 0)
	);
end Reg_State;

architecture behavioral of Reg_State is
	
begin
	process(clk)
	begin
		if (rising_edge(clk)) then
			if (reset = '1') then
				o_q <= (others => '0');
			elsif (en = '1') then
				o_q <= i_d;
			end if;
		end if;
	--o_q <= r_reg;
	end process;
	
end architecture;