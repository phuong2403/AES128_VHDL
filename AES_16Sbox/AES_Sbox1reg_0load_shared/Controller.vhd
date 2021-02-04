--------------------------------------------------------------
-- Module name : Controller
-- Top level : AES_top
-- Implementation of AES 128 bit using loop unrolled techniques (only encryption)
-- except control signal : clock, reset, start, load;
-- other input/output in entities of blocks (not top level) are declared starting with i_/o_
-- signals in architecture start with ri_/ro_

-- This file is to synchronise signals of each round and let us know if output is ready
---------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Controller is
	port (
		clk : in std_logic;
		reset : in std_logic;
		start: in std_logic;	
		o_rconst: out std_logic_vector(7 downto 0); -- for key schedule function, but just care for first byte, 3 left = x"00";
		o_final_round: out std_logic; -- = '1' in case final round
		o_ready: out std_logic 		  -- ready for ciphertext
	);
end entity;

architecture Behavioral of Controller is
	signal r_mux_rconst: std_logic_vector(7 downto 0);
	signal ro_rconst : std_logic_vector(7 downto 0);
	signal r_reg : std_logic_vector(7 downto 0); -- output to KeySchedule
	signal r_final_round, r_ready, enable: std_logic;
begin
	mux_rconst: entity work.Mux_RC 
						port map (
							i_a => x"01",
							i_b => ro_rconst,
							en => start,
							o_c => r_mux_rconst
							);	
	en_RC: entity work.Enable_reg
						port map(
						reset => reset,
						clk => clk,
						enable => enable
						);
	next_reg_rconst: entity work.Reg_RC  
						port map (
							clk => clk,
							reset => reset,
							en => enable,
							i_d => r_mux_rconst,
							o_q => r_reg -- output roundconstant for each round here
						);
	
	round_const: entity work.RoundConstants
						port map (
							ib_rconst => r_reg,
							ob_rconst => ro_rconst
						);
						
	r_final_round <= '1' when (r_reg = x"36") else '0';	
	o_final_round <= r_final_round;
	
	o_rconst <= r_reg;
	
	o_ready <= r_ready;
	
	RC_process: process (clk, enable) -- ready for outputs
	begin
		if (rising_edge(clk)) then
		if (enable = '1') then
				r_ready <= r_final_round;
			else 
				r_ready <= '0';				
			end if;	
		end if;
	end process;	

end architecture;