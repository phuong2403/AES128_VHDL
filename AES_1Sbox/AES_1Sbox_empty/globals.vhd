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



--types

  type column is array (0 to 3) of std_logic_vector(7 downto 0);
  type state  is array (0 to 3) of column; -- 128-bit states
  

end globals;

package body globals is


 
end globals;
