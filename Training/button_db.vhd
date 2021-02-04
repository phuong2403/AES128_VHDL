----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:26:23 11/12/2015 
-- Design Name: 
-- Module Name:    button_db - Behavioral 
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity button_db is
	generic (
				active_high	:	boolean	:= true;
				counts		:	integer	:= 1000000		-- 20 ms
				);
	port (	clk		:	in std_logic;
				button	:	in std_logic;		-- debounce 20ms
				pulse		:	out std_logic
			);
end button_db;

architecture Behavioral of button_db is
	signal db_cnt: std_logic_vector (19 downto 0) := (others => '0');
begin
debounce20ms: process (clk)
	begin
		if (clk'event and clk = '1') then
			----- debounce 20 ms -----
				-- active_high := true --
				if (active_high) then
					if (button = '1') then
						if (db_cnt < counts) then
							db_cnt <= db_cnt + 1;
						end if;
					else
							db_cnt <= (others => '0');
					end if;
				-- active_high := false --
				else
					if (button = '0') then
						if (db_cnt < counts) then
							db_cnt <= db_cnt + 1;
						end if;
					else
							db_cnt <= (others => '0');
					end if;
				end if;
			---- pulse output -----
				if (db_cnt = counts - 1) then
					pulse <= '1';
				else
					pulse <= '0';
				end if;
		end if;
	end process;
end Behavioral;

