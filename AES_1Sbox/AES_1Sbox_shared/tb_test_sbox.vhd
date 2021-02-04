--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:10:31 05/27/2020
-- Design Name:   
-- Module Name:   /users/cosic/zzhang/workspace/sbox_powermap/tb_test_sbox.vhd
-- Project Name:  sbox_powermap
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: test_sbox
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
 
ENTITY tb_test_sbox IS
END tb_test_sbox;
 
ARCHITECTURE behavior OF tb_test_sbox IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT test_sbox
    PORT(
         clock : IN  std_logic;
         x_in : IN  std_logic_vector(7 downto 0);
         z_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal x_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal z_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: test_sbox PORT MAP (
          clock => clock,
          x_in => x_in,
          z_out => z_out
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clock_period*10;

      -- insert stimulus here 
		x_in <= x"5D";
		wait for clock_period;
      
      wait for clock_period*8;
      if(z_out /= x"4C") then
      	 report "Expected 0x4C but got something else";
      end if;
      x_in <= x"01";
      
      wait for clock_period;
      
      wait for clock_period*8;
      if(z_out /= x"7C") then
      	 report "Expected 0x7C but got something else";
      end if;
      x_in <= x"44";
      
      wait for clock_period;
      
      wait for clock_period*8;
      if(z_out /= x"1B") then
      	 report "Expected 0x1B but got something else";
      end if;
      x_in <= x"03";
      
      wait for clock_period;
      
      wait for clock_period*8;
      if(z_out /= x"7B") then
      	 report "Expected 0x7B but got something else";
      end if;
      
      wait;
   end process;

END;
