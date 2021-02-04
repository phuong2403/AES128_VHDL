library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Xor_1share is
  port ( i_a : in std_logic_vector(7 downto 0);
         i_b : in std_logic_vector(7 downto 0);
         o_c : out std_logic_vector(7 downto 0) 
  ) ;
end entity ;
 
architecture Behavioral of Xor_1share is
 
begin

	o_c <= i_a xor i_b;

end architecture ;