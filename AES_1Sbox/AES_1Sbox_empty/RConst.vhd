
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Rconst is 
  port(	clk 	: in std_logic;
		rst 	: in std_logic;
		en	 	: in  std_logic; 
        o_Rcon 	: out std_logic_vector(7 downto 0)
		); 
end Rconst; 

architecture archi of Rconst is 
  signal lfsr_reg: std_logic_vector(7 downto 0); 
  signal lfsr_next : std_logic_vector(7 downto 0);
  
  begin 
  -- using Linear-feedback shift register
    lfsr_next(0) <= lfsr_reg(7); -- multiplied by 2
    lfsr_next(1) <= lfsr_reg(0) xor lfsr_reg(7);
    lfsr_next(2) <= lfsr_reg(1);
    lfsr_next(3) <= lfsr_reg(2) xor lfsr_reg(7);
    lfsr_next(4) <= lfsr_reg(3) xor lfsr_reg(7);
    lfsr_next(5) <= lfsr_reg(4);
    lfsr_next(6) <= lfsr_reg(5);
    lfsr_next(7) <= lfsr_reg(6);
	 
    process (clk) 
      begin 
			if (rising_edge(clk)) then
				if(rst = '1') then 
					lfsr_reg <= x"8d"; --reset register to x"01" for a new encryption
				elsif (en = '1') then
					lfsr_reg <= lfsr_next; -- load  the register when each round is completed
				end if;
        end if; 
	 end process; 
	 
	 o_Rcon <= lfsr_reg;
	 
end archi;

