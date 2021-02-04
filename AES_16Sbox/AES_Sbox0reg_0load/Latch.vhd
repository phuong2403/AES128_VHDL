library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Latch is
    	generic (N : integer);
	port (
		--clk : in std_logic;
		--reset : in std_logic;
		en : in std_logic;
		i_d : in std_logic_vector(N - 1 downto 0);
		o_q : out std_logic_vector(N - 1 downto 0)
	);
end Latch;


architecture Behavioral of Latch is
    signal DATA : std_logic_vector(N - 1 downto 0);
begin

    DATA <= i_d when (en = '1') else DATA;
    o_q <= DATA;

end Behavioral;
