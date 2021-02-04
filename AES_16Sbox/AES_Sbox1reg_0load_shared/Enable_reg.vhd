

-- This module is for a basic divide by 2 in VHDL
library ieee;
use ieee.std_logic_1164.all;

entity Enable_reg is
         port (
            reset : in std_logic;
            clk : in std_logic;
            enable : out std_logic                                        
                );
end Enable_reg;

-- Architecture definition for divide by 2 circuit
architecture behavior of Enable_reg is
signal r_enable : std_logic;
begin
                process (clk,reset)
                begin
                                if reset = '1' then
                                    r_enable <= '0';
                                elsif (rising_edge(clk)) then
                                    r_enable <= not r_enable;
                                end if;
                end process;
enable <= r_enable;

end architecture;