library ieee;
use ieee.std_logic_1164.all;

entity Reg is
	generic (N : integer);
	port (
		clk : in std_logic;
		reset : in std_logic;
		--en : in std_logic;
		i_d : in std_logic_vector(N - 1 downto 0);
		o_q : out std_logic_vector(N - 1 downto 0)
	);
end Reg;

architecture behavioral of Reg is
	--signal r_reg: std_logic_vector(N-1 downto 0);
begin
	
	process(clk)
	begin
		if (rising_edge(clk)) then
			if (reset = '1') then
			o_q <= (others => '0');
			else
				--if (en = '1') then
					o_q <= i_d;
				--else
				--	r_reg <= r_reg;
				--end if;
			end if;
		end if;
	--o_q <= r_reg;
	end process;
	
end architecture;