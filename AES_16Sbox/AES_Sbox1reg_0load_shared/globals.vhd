--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library STD;
 use STD.textio.all;


  library IEEE;
    use IEEE.std_logic_1164.all;
    

library work;


package globals is
	constant D : integer := 4;


--types

  type column is array (0 to 3) of std_logic_vector(7 downto 0);
  type state  is array (0 to 3) of column; -- 128-bit states
  
  type shared_byte is array(0 to D-1) of std_logic_vector(7 downto 0);
  type shared_16 is array (0 to 15) of shared_byte;
  type shared_2 is array (0 to 3) of shared_byte;
  type shared_state is array(0 to D-1) of std_logic_vector(127 downto 0);
  type shared_word is array (0 to D-1) of std_logic_vector(31 downto 0);
 

end globals;

package body globals is


 
end globals;
