----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:10:33 05/25/2020 
-- Design Name: 
-- Module Name:    x49 - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity x49 is
port(x7, x6, x5, x4, x3, x2, x1, x0: in std_logic;
		F: out std_logic_vector(7 downto 0));
end x49;

architecture Behavioral of x49 is

begin
F(0) <= (x0 ) xor ( x1 ) xor ( x0 and x1 ) xor ( x1 and x2 ) xor ( x0 and x1 and x2 ) xor ( x3 ) xor ( x1 and x3 ) xor ( x0 and x1 and x3 ) xor ( x2 and x3 ) xor ( x1 and x4 ) xor ( x0 and x1 and x4 ) xor ( x3 and x4 ) xor ( x2 and x3 and x4 ) xor ( x5 ) xor ( x0 and x5 ) xor ( x2 and x5 ) xor ( x3 and x5 ) xor ( x0 and x3 and x5 ) xor ( x2 and x3 and x5 ) xor ( x0 and x4 and x5 ) xor ( x1 and x4 and x5 ) xor ( x2 and x4 and x5 ) xor ( x0 and x1 and x6 ) xor ( x2 and x6 ) xor ( x0 and x2 and x6 ) xor ( x3 and x6 ) xor ( x0 and x3 and x6 ) xor ( x1 and x3 and x6 ) xor ( x4 and x6 ) xor ( x5 and x6 ) xor ( x2 and x5 and x6 ) xor ( x7 ) xor ( x0 and x7 ) xor ( x0 and x1 and x7 ) xor ( x2 and x7 ) xor ( x0 and x3 and x7 ) xor ( x2 and x3 and x7 ) xor ( x1 and x4 and x7 ) xor ( x3 and x4 and x7 ) xor ( x0 and x5 and x7 ) xor ( x2 and x5 and x7 ) xor ( x0 and x6 and x7 ) xor ( x1 and x6 and x7 ) xor ( x2 and x6 and x7 ) xor ( x4 and x6 and x7 ) ;
F(1) <= (x1 ) xor ( x0 and x1 ) xor ( x0 and x2 ) xor ( x0 and x1 and x2 ) xor ( x0 and x3 ) xor ( x0 and x1 and x3 ) xor ( x0 and x1 and x4 ) xor ( x2 and x4 ) xor ( x0 and x2 and x4 ) xor ( x0 and x3 and x4 ) xor ( x5 ) xor ( x1 and x5 ) xor ( x2 and x5 ) xor ( x3 and x5 ) xor ( x1 and x3 and x5 ) xor ( x2 and x3 and x5 ) xor ( x3 and x4 and x5 ) xor ( x6 ) xor ( x1 and x6 ) xor ( x0 and x1 and x6 ) xor ( x2 and x6 ) xor ( x0 and x2 and x6 ) xor ( x0 and x3 and x6 ) xor ( x4 and x6 ) xor ( x1 and x4 and x6 ) xor ( x3 and x5 and x6 ) xor ( x4 and x5 and x6 ) xor ( x7 ) xor ( x1 and x7 ) xor ( x0 and x1 and x7 ) xor ( x0 and x2 and x7 ) xor ( x0 and x3 and x7 ) xor ( x1 and x3 and x7 ) xor ( x2 and x3 and x7 ) xor ( x2 and x4 and x7 ) xor ( x2 and x5 and x7 ) xor ( x1 and x6 and x7 ) xor ( x2 and x6 and x7 ) xor ( x4 and x6 and x7 ) xor ( x5 and x6 and x7 ) ;
F(2) <= (x0 and x1 ) xor ( x2 ) xor ( x3 ) xor ( x1 and x3 ) xor ( x1 and x2 and x3 ) xor ( x4 ) xor ( x0 and x2 and x4 ) xor ( x1 and x2 and x4 ) xor ( x3 and x4 ) xor ( x1 and x3 and x4 ) xor ( x2 and x3 and x4 ) xor ( x0 and x5 ) xor ( x2 and x5 ) xor ( x0 and x2 and x5 ) xor ( x3 and x5 ) xor ( x0 and x3 and x5 ) xor ( x1 and x3 and x5 ) xor ( x4 and x5 ) xor ( x0 and x4 and x5 ) xor ( x2 and x4 and x5 ) xor ( x3 and x4 and x5 ) xor ( x1 and x2 and x6 ) xor ( x3 and x6 ) xor ( x0 and x3 and x6 ) xor ( x1 and x3 and x6 ) xor ( x2 and x3 and x6 ) xor ( x5 and x6 ) xor ( x0 and x5 and x6 ) xor ( x1 and x5 and x6 ) xor ( x2 and x5 and x6 ) xor ( x4 and x5 and x6 ) xor ( x7 ) xor ( x1 and x7 ) xor ( x0 and x1 and x7 ) xor ( x1 and x2 and x7 ) xor ( x3 and x7 ) xor ( x0 and x3 and x7 ) xor ( x4 and x7 ) xor ( x0 and x4 and x7 ) xor ( x1 and x4 and x7 ) xor ( x3 and x4 and x7 ) xor ( x5 and x7 ) xor ( x0 and x5 and x7 ) xor ( x1 and x5 and x7 ) xor ( x6 and x7 ) xor ( x0 and x6 and x7 ) xor ( x1 and x6 and x7 ) xor ( x4 and x6 and x7 );
F(3) <= (x1 ) xor ( x0 and x1 ) xor ( x1 and x2 ) xor ( x0 and x1 and x2 ) xor ( x3 ) xor ( x0 and x1 and x3 ) xor ( x2 and x3 ) xor ( x4 ) xor ( x0 and x4 ) xor ( x0 and x1 and x4 ) xor ( x2 and x4 ) xor ( x0 and x2 and x4 ) xor ( x1 and x2 and x4 ) xor ( x3 and x4 ) xor ( x1 and x5 ) xor ( x2 and x5 ) xor ( x2 and x3 and x5 ) xor ( x0 and x4 and x5 ) xor ( x1 and x4 and x5 ) xor ( x3 and x4 and x5 ) xor ( x6 ) xor ( x0 and x6 ) xor ( x0 and x1 and x6 ) xor ( x2 and x6 ) xor ( x1 and x2 and x6 ) xor ( x3 and x6 ) xor ( x0 and x3 and x6 ) xor ( x4 and x6 ) xor ( x1 and x4 and x6 ) xor ( x5 and x6 ) xor ( x0 and x5 and x6 ) xor ( x1 and x5 and x6 ) xor ( x2 and x5 and x6 ) xor ( x3 and x5 and x6 ) xor ( x4 and x5 and x6 ) xor ( x7 ) xor ( x0 and x2 and x7 ) xor ( x1 and x3 and x7 ) xor ( x0 and x4 and x7 ) xor ( x5 and x7 ) xor ( x0 and x5 and x7 ) xor ( x1 and x5 and x7 ) xor ( x3 and x5 and x7 ) xor ( x0 and x6 and x7 ) xor ( x2 and x6 and x7 ) xor ( x4 and x6 and x7 );
F(4) <= (x0 and x1 ) xor ( x2 ) xor ( x3 ) xor ( x0 and x3 ) xor ( x2 and x3 ) xor ( x0 and x2 and x3 ) xor ( x1 and x2 and x3 ) xor ( x1 and x4 ) xor ( x0 and x1 and x4 ) xor ( x3 and x4 ) xor ( x0 and x3 and x4 ) xor ( x1 and x3 and x4 ) xor ( x2 and x3 and x4 ) xor ( x5 ) xor ( x1 and x5 ) xor ( x0 and x1 and x5 ) xor ( x0 and x2 and x5 ) xor ( x1 and x2 and x5 ) xor ( x3 and x5 ) xor ( x1 and x3 and x5 ) xor ( x2 and x3 and x5 ) xor ( x4 and x5 ) xor ( x0 and x4 and x5 ) xor ( x1 and x4 and x5 ) xor ( x0 and x6 ) xor ( x1 and x6 ) xor ( x0 and x2 and x6 ) xor ( x3 and x6 ) xor ( x2 and x3 and x6 ) xor ( x0 and x4 and x6 ) xor ( x1 and x4 and x6 ) xor ( x5 and x6 ) xor ( x0 and x5 and x6 ) xor ( x4 and x5 and x6 ) xor ( x7 ) xor ( x0 and x7 ) xor ( x1 and x7 ) xor ( x0 and x1 and x7 ) xor ( x2 and x7 ) xor ( x4 and x7 ) xor ( x0 and x4 and x7 ) xor ( x5 and x7 ) xor ( x0 and x5 and x7 ) xor ( x2 and x5 and x7 ) xor ( x4 and x5 and x7 ) xor ( x2 and x6 and x7 ) xor ( x3 and x6 and x7 ) xor ( x4 and x6 and x7 ) ;
F(5) <= (x0 and x1 ) xor ( x2 ) xor ( x0 and x2 ) xor ( x0 and x3 ) xor ( x0 and x1 and x3 ) xor ( x0 and x4 ) xor ( x2 and x4 ) xor ( x0 and x2 and x4 ) xor ( x1 and x2 and x4 ) xor ( x3 and x4 ) xor ( x5 ) xor ( x0 and x5 ) xor ( x0 and x1 and x5 ) xor ( x2 and x5 ) xor ( x3 and x5 ) xor ( x1 and x3 and x5 ) xor ( x4 and x5 ) xor ( x1 and x6 ) xor ( x0 and x2 and x6 ) xor ( x3 and x6 ) xor ( x1 and x3 and x6 ) xor ( x4 and x6 ) xor ( x0 and x4 and x6 ) xor ( x1 and x4 and x6 ) xor ( x2 and x4 and x6 ) xor ( x5 and x6 ) xor ( x1 and x5 and x6 ) xor ( x2 and x5 and x6 ) xor ( x4 and x5 and x6 ) xor ( x1 and x7 ) xor ( x2 and x7 ) xor ( x3 and x7 ) xor ( x0 and x3 and x7 ) xor ( x1 and x3 and x7 ) xor ( x0 and x4 and x7 ) xor ( x0 and x5 and x7 ) xor ( x1 and x5 and x7 ) xor ( x2 and x5 and x7 ) xor ( x3 and x5 and x7 ) xor ( x1 and x6 and x7 ) xor ( x2 and x6 and x7 ) xor ( x3 and x6 and x7 ) xor ( x4 and x6 and x7 ) xor ( x5 and x6 and x7 ) ;
F(6) <= (x1 ) xor ( x2 ) xor ( x1 and x2 ) xor ( x0 and x1 and x2 ) xor ( x0 and x3 ) xor ( x2 and x3 ) xor ( x0 and x2 and x3 ) xor ( x1 and x2 and x3 ) xor ( x4 ) xor ( x0 and x4 ) xor ( x0 and x1 and x4 ) xor ( x2 and x4 ) xor ( x0 and x2 and x4 ) xor ( x1 and x2 and x4 ) xor ( x3 and x4 ) xor ( x0 and x3 and x4 ) xor ( x0 and x5 ) xor ( x2 and x5 ) xor ( x1 and x2 and x5 ) xor ( x0 and x3 and x5 ) xor ( x4 and x5 ) xor ( x3 and x4 and x5 ) xor ( x6 ) xor ( x0 and x6 ) xor ( x1 and x6 ) xor ( x3 and x6 ) xor ( x4 and x6 ) xor ( x1 and x4 and x6 ) xor ( x3 and x4 and x6 ) xor ( x1 and x5 and x6 ) xor ( x2 and x5 and x6 ) xor ( x3 and x5 and x6 ) xor ( x0 and x1 and x7 ) xor ( x0 and x2 and x7 ) xor ( x1 and x2 and x7 ) xor ( x3 and x7 ) xor ( x1 and x3 and x7 ) xor ( x4 and x7 ) xor ( x0 and x4 and x7 ) xor ( x1 and x4 and x7 ) xor ( x2 and x4 and x7 ) xor ( x5 and x7 ) xor ( x0 and x5 and x7 ) xor ( x6 and x7 ) xor ( x0 and x6 and x7 ) xor ( x3 and x6 and x7 );
F(7) <= (x1 ) xor ( x1 and x3 ) xor ( x0 and x1 and x3 ) xor ( x2 and x3 ) xor ( x4 ) xor ( x1 and x4 ) xor ( x2 and x4 ) xor ( x0 and x2 and x4 ) xor ( x3 and x4 ) xor ( x0 and x5 ) xor ( x2 and x5 ) xor ( x0 and x2 and x5 ) xor ( x3 and x5 ) xor ( x0 and x3 and x5 ) xor ( x1 and x3 and x5 ) xor ( x4 and x5 ) xor ( x0 and x4 and x5 ) xor ( x1 and x4 and x5 ) xor ( x3 and x4 and x5 ) xor ( x0 and x6 ) xor ( x1 and x6 ) xor ( x2 and x6 ) xor ( x0 and x2 and x6 ) xor ( x0 and x4 and x6 ) xor ( x1 and x4 and x6 ) xor ( x2 and x4 and x6 ) xor ( x0 and x5 and x6 ) xor ( x1 and x5 and x6 ) xor ( x2 and x5 and x6 ) xor ( x3 and x5 and x6 ) xor ( x4 and x5 and x6 ) xor ( x7 ) xor ( x0 and x1 and x7 ) xor ( x2 and x7 ) xor ( x0 and x2 and x7 ) xor ( x4 and x7 ) xor ( x2 and x4 and x7 ) xor ( x2 and x5 and x7 ) xor ( x6 and x7 ) xor ( x0 and x6 and x7 ) xor ( x3 and x6 and x7 ) xor ( x4 and x6 and x7 ) xor ( x5 and x6 and x7 );

end Behavioral;

