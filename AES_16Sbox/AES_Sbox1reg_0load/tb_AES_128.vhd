--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:02:16 05/27/2020
-- Design Name:   
-- Module Name:   D:/AES/aes128_vhdl/AES_16Sbox/Testbench/tb_AES_128.vhd
-- Project Name:  AES_16S
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: AES_top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_AES_128 IS
END tb_AES_128;
 
ARCHITECTURE behavior OF tb_AES_128 IS 
 --DUT design under test
	component AES_top is
		port (
			clk : in std_logic;
			reset : in std_logic;
			start : in std_logic;
			key : in std_logic_vector(127 downto 0);
			plaintext : in std_logic_vector(127 downto 0);
			ciphertext : out std_logic_vector(127 downto 0);
			ready : out std_logic		
		);
	end component;
	-- inputs
	signal clk : std_logic := '0';
	signal reset : std_logic := '0';
	signal start : std_logic := '0';
	signal tb_plaintext : std_logic_vector(127 downto 0) := (others => '0');
	signal tb_key : std_logic_vector(127 downto 0):= (others => '0');
	
	-- outputs
	signal tb_ciphertext : std_logic_vector(127 downto 0):= (others => '0');
	signal tb_ready : std_logic := '0';
	
	-- expect results
	signal ex_ciphertext : std_logic_vector(127 downto 0):= (others => '0');
	
	-- clock period
	constant clk_period : time := 10 ns;
	
begin
	--instantiate DUT
	DUT: AES_top
		port map (
			clk => clk,
			reset => reset,
			start => start,
			key => tb_key,
			plaintext => tb_plaintext,
			ciphertext => tb_ciphertext,
			ready => tb_ready
			);
			
	--clock generation porocess
	clk_gen: process is
		begin
			clk <= '1';
			wait for clk_period/2;
			clk <= '0';
			wait for clk_period/2;
		end process clk_gen;
	
	--test process
		test_DUT : process is			
		begin
	--- the first case taken from Prof.Vincent's book
	--plaintext = 3243f6a8885a308d313198a2e0370734
	--key 		= 2b7e151628aed2a6abf7158809cf4f3c		
	--ciphertext= 3925841d02dc09fbdc118597196a0b32	
			reset <= '1';
			wait for clk_period;
			reset <= '0';
			start <= '0';	
						
			tb_plaintext <= x"3243f6a8885a308d313198a2e0370734";
			tb_key 		 <= x"2b7e151628aed2a6abf7158809cf4f3c";
			ex_ciphertext <= x"3925841d02dc09fbdc118597196a0b32";		
			wait for clk_period; -- hold start or load state in one cycle for original key and plaintext
			start <= '1';
			wait for clk_period;
			wait until tb_ready <= '1';
			
			wait for clk_period;		
			start <= '0';						
			tb_plaintext <= x"54776F204F6E65204E696E652054776F";
			tb_key <= x"5468617473206D79204B756E67204675";
			-------------------
		---test another case
		--p = 00000000000000000000000000000000
		--k = 00000000000000000000000000000000
		--c = 66E94BD4EF8A2C3B884CFA59CA342B2E	
			
			wait for clk_period*6;
			start <= '1';
			ex_ciphertext <= x"29C3505F571420F6402299B31A02D73A";
			wait for clk_period; -- hold start or load state in one cycle for original key and plaintext			
			
			wait for clk_period;
			wait until tb_ready <= '1';

			--wait for clk_period;			
			start <= '0';
			--load <= '0';
			wait;		
		end process test_DUT;

END;
