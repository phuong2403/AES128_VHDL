----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:48:21 03/01/2017 
-- Design Name: 
-- Module Name:    contrlo_counter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Control_counter is
    Port ( clk 		: in  std_logic;
           en 		: in  std_logic;
           rst 		: in  std_logic;
           o_count 	: out  unsigned (4 downto 0));
end Control_counter;

architecture Behavioral of Control_counter is

	signal count_next, count_regs : unsigned (4 downto 0);
	
begin
	
	count_next <= count_regs + 1 when en = '1'	else
				  count_regs;
	
	process (clk)
	begin
		if (rising_edge(clk)) then  
			if (rst='1') then   
				count_regs <= (others => '0');
			else
				count_regs <= count_next;
			end if;
		end if;
	end process;
					  
	o_count <= count_regs;
end Behavioral;

