--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:08:59 05/26/2020
-- Design Name:   
-- Module Name:   /users/cosic/zzhang/workspace/sbox_powermap/tb_x49_shares.vhd
-- Project Name:  sbox_powermap
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: x49_shares
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
 
ENTITY tb_x49_shares IS
END tb_x49_shares;
 
ARCHITECTURE behavior OF tb_x49_shares IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT x49_shares
    PORT(
         X00 : IN  std_logic;
         X0_1 : IN  std_logic;
         X02 : IN  std_logic;
         X03 : IN  std_logic;
         X10 : IN  std_logic;
         X11 : IN  std_logic;
         X12 : IN  std_logic;
         X13 : IN  std_logic;
         X20 : IN  std_logic;
         X21 : IN  std_logic;
         X22 : IN  std_logic;
         X23 : IN  std_logic;
         X30 : IN  std_logic;
         X31 : IN  std_logic;
         X32 : IN  std_logic;
         X33 : IN  std_logic;
         X40 : IN  std_logic;
         X41 : IN  std_logic;
         X42 : IN  std_logic;
         X43 : IN  std_logic;
         X50 : IN  std_logic;
         X51 : IN  std_logic;
         X52 : IN  std_logic;
         X53 : IN  std_logic;
         X60 : IN  std_logic;
         X61 : IN  std_logic;
         X62 : IN  std_logic;
         X63 : IN  std_logic;
         X70 : IN  std_logic;
         X71 : IN  std_logic;
         X72 : IN  std_logic;
         X73 : IN  std_logic;
         F00 : OUT  std_logic;
         F01 : OUT  std_logic;
         F02 : OUT  std_logic;
         F03 : OUT  std_logic;
         F10 : OUT  std_logic;
         F11 : OUT  std_logic;
         F12 : OUT  std_logic;
         F13 : OUT  std_logic;
         F20 : OUT  std_logic;
         F21 : OUT  std_logic;
         F22 : OUT  std_logic;
         F23 : OUT  std_logic;
         F30 : OUT  std_logic;
         F31 : OUT  std_logic;
         F32 : OUT  std_logic;
         F33 : OUT  std_logic;
         F40 : OUT  std_logic;
         F41 : OUT  std_logic;
         F42 : OUT  std_logic;
         F43 : OUT  std_logic;
         F50 : OUT  std_logic;
         F51 : OUT  std_logic;
         F52 : OUT  std_logic;
         F53 : OUT  std_logic;
         F60 : OUT  std_logic;
         F61 : OUT  std_logic;
         F62 : OUT  std_logic;
         F63 : OUT  std_logic;
         F70 : OUT  std_logic;
         F71 : OUT  std_logic;
         F72 : OUT  std_logic;
         F73 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal X00 : std_logic := '0';
   signal X0_1 : std_logic := '0';
   signal X02 : std_logic := '0';
   signal X03 : std_logic := '0';
   signal X10 : std_logic := '0';
   signal X11 : std_logic := '0';
   signal X12 : std_logic := '0';
   signal X13 : std_logic := '0';
   signal X20 : std_logic := '0';
   signal X21 : std_logic := '0';
   signal X22 : std_logic := '0';
   signal X23 : std_logic := '0';
   signal X30 : std_logic := '0';
   signal X31 : std_logic := '0';
   signal X32 : std_logic := '0';
   signal X33 : std_logic := '0';
   signal X40 : std_logic := '0';
   signal X41 : std_logic := '0';
   signal X42 : std_logic := '0';
   signal X43 : std_logic := '0';
   signal X50 : std_logic := '0';
   signal X51 : std_logic := '0';
   signal X52 : std_logic := '0';
   signal X53 : std_logic := '0';
   signal X60 : std_logic := '0';
   signal X61 : std_logic := '0';
   signal X62 : std_logic := '0';
   signal X63 : std_logic := '0';
   signal X70 : std_logic := '0';
   signal X71 : std_logic := '0';
   signal X72 : std_logic := '0';
   signal X73 : std_logic := '0';

 	--Outputs
   signal F00 : std_logic;
   signal F01 : std_logic;
   signal F02 : std_logic;
   signal F03 : std_logic;
   signal F10 : std_logic;
   signal F11 : std_logic;
   signal F12 : std_logic;
   signal F13 : std_logic;
   signal F20 : std_logic;
   signal F21 : std_logic;
   signal F22 : std_logic;
   signal F23 : std_logic;
   signal F30 : std_logic;
   signal F31 : std_logic;
   signal F32 : std_logic;
   signal F33 : std_logic;
   signal F40 : std_logic;
   signal F41 : std_logic;
   signal F42 : std_logic;
   signal F43 : std_logic;
   signal F50 : std_logic;
   signal F51 : std_logic;
   signal F52 : std_logic;
   signal F53 : std_logic;
   signal F60 : std_logic;
   signal F61 : std_logic;
   signal F62 : std_logic;
   signal F63 : std_logic;
   signal F70 : std_logic;
   signal F71 : std_logic;
   signal F72 : std_logic;
   signal F73 : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: x49_shares PORT MAP (
          X00 => X00,
          X0_1 => X0_1,
          X02 => X02,
          X03 => X03,
          X10 => X10,
          X11 => X11,
          X12 => X12,
          X13 => X13,
          X20 => X20,
          X21 => X21,
          X22 => X22,
          X23 => X23,
          X30 => X30,
          X31 => X31,
          X32 => X32,
          X33 => X33,
          X40 => X40,
          X41 => X41,
          X42 => X42,
          X43 => X43,
          X50 => X50,
          X51 => X51,
          X52 => X52,
          X53 => X53,
          X60 => X60,
          X61 => X61,
          X62 => X62,
          X63 => X63,
          X70 => X70,
          X71 => X71,
          X72 => X72,
          X73 => X73,
          F00 => F00,
          F01 => F01,
          F02 => F02,
          F03 => F03,
          F10 => F10,
          F11 => F11,
          F12 => F12,
          F13 => F13,
          F20 => F20,
          F21 => F21,
          F22 => F22,
          F23 => F23,
          F30 => F30,
          F31 => F31,
          F32 => F32,
          F33 => F33,
          F40 => F40,
          F41 => F41,
          F42 => F42,
          F43 => F43,
          F50 => F50,
          F51 => F51,
          F52 => F52,
          F53 => F53,
          F60 => F60,
          F61 => F61,
          F62 => F62,
          F63 => F63,
          F70 => F70,
          F71 => F71,
          F72 => F72,
          F73 => F73
        );

--   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
-- 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

--      wait for <clock>_period*10;

      -- insert stimulus here 
		X00 <= '0';
		X0_1 <= '1';
		X02 <= '0';
		X03 <= '1';
		X10 <= '0';
		X11 <= '0';
		X12 <= '1';
		X13 <= '1';
		X20 <= '0';
		X21 <= '0';
		X22 <= '1';
		X23 <= '1';
		X30 <= '1';
		X31 <= '0';
		X32 <= '0';
		X33 <= '1';
		X40 <= '0';
		X41 <= '1';
		X42 <= '0';
		X43 <= '1';
		X50 <= '0';
		X51 <= '1';
		X52 <= '0';
		X53 <= '1';
		X60 <= '0';
		X61 <= '0';
		X62 <= '1';
		X63 <= '1';
		X70 <= '1';
		X71 <= '0';
		X72 <= '0';
		X73 <= '1';
		
		wait for 100 ns;
				X00 <= '0';
		X0_1 <= '1';
		X02 <= '1';
		X03 <= '0';
		X10 <= '1';
		X11 <= '1';
		X12 <= '1';
		X13 <= '1';
		X20 <= '1';
		X21 <= '0';
		X22 <= '0';
		X23 <= '1';
		X30 <= '1';
		X31 <= '1';
		X32 <= '1';
		X33 <= '1';
		X40 <= '1';
		X41 <= '1';
		X42 <= '0';
		X43 <= '0';
		X50 <= '0';
		X51 <= '1';
		X52 <= '0';
		X53 <= '1';
		X60 <= '0';
		X61 <= '0';
		X62 <= '1';
		X63 <= '1';
		X70 <= '0';
		X71 <= '0';
		X72 <= '1';
		X73 <= '1';
		
      wait;
   end process;

END;
