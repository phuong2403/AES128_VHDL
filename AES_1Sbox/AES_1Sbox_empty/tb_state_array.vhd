library ieee;
use ieee.std_logic_1164.all;

entity tb_state_array is
end entity;

architecture Behavioral of tb_state_array is

	--design under test
	component State_Array is
	port (
			clk 		: in std_logic;
			en 			: in std_logic;	--enable update state registers
			en_shift	: in std_logic; --enable shiftrows function and normal operation
			en_mix 		: in std_logic; --enable mixcolumns function
			i_state 	: in std_logic_vector(7 downto 0);
			o_state 	: out std_logic_vector(7 downto 0)
		);
	end component;
	
	--signals
	signal ri_state 	: std_logic_vector(7 downto 0) 	:=(others => '0');
	signal ro_state 	: std_logic_vector(7 downto 0) 	:=(others => '0');
	signal ex_state		: std_logic_vector(127 downto 0):=(others => '0'); -- expected output
	signal clk		: std_logic := '0';
	signal en		: std_logic := '0';
	signal en_mix, en_shift	: std_logic := '0';
	--constant for clk cycle
	constant clk_period : time := 10 ns;
	--signal state_regs
begin
	DUT: State_Array 
			port map (
				clk => clk,
				en  => en,
				en_mix => en_mix,
				en_shift=> en_shift,
				i_state => ri_state,
				o_state => ro_state
				);
			
	clock: process is -- clock generation
			begin
				clk <= '1';
				wait for clk_period/2;
				clk <= '0';
				wait for clk_period/2;
			end process clock;
			
	test: process is
	--* input states: x"d42711aee0bf98f1b8b45de51e415230";
	-- output states: x"046681e5e0cb199a48f8d37a2806264c";
	--put 16 state inputs in 16 clock cycle 0-15
	--each state needs 16 cycles to go to outputs
	--en_mix at cycles 0, 4, 8, 12, 16, 20, 24, 28
	--en_shift at cycles 15, 31
			begin
				en <= '0';
				wait for clk_period;
				en <= '1';				
				wait for clk_period;--0
				--en_mix <= '1';
				en_shift <= '0';
				ri_state <= x"d4";
				wait for clk_period;
				en_mix <= '0';
				ri_state <= x"27";
				wait for clk_period;
				ri_state <= x"11";
				wait for clk_period;
				ri_state <= x"ae";
				wait for clk_period;--4
				ri_state <= x"e0";
				--en_mix <= '1';
				wait for clk_period;
				en_mix <= '0';				
				ri_state <= x"bf";
				wait for clk_period;
				ri_state <= x"98";
				wait for clk_period;
				ri_state <= x"f1";
				wait for clk_period;--8
				ri_state <= x"b8";
				--en_mix <= '1';
				wait for clk_period;
				en_mix <= '0';
				ri_state <= x"b4";
				wait for clk_period;
				ri_state <= x"5d";
				wait for clk_period;
				ri_state <= x"e5";
				wait for clk_period;--12
				ri_state <= x"1e";
				--en_mix <= '1';
				wait for clk_period;
				en_mix <= '0';
				ri_state <= x"41";
				wait for clk_period;
				ri_state <= x"52";
				wait for clk_period;				
				ri_state <= x"30";	
				en_shift <= '1';				
				wait for clk_period;--16
				en_mix <= '1';
				en_shift <= '0';
				ex_state <= x"046681e5e0cb199a48f8d37a2806264c";
				wait for clk_period;
				en_mix <= '0';
				wait for clk_period * 3;--20
				en_mix <= '1';
				wait for clk_period;
				en_mix <= '0';
				wait for clk_period * 3;--24
				en_mix <= '1';
				wait for clk_period;
				en_mix <= '0';
				wait for clk_period * 3;--28
				en_mix <= '1';
				wait for clk_period;
				en_mix <= '0';
				wait for clk_period * 2;--31
				en_shift <= '1';
				wait for clk_period;
				en <= '0';
				wait;				
			end process test;
end architecture;