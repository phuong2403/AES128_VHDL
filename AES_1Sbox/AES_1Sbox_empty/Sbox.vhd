
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sbox is
	port(
		i_Sbox	:	in  std_logic_vector(7 downto 0); 
		o_Sbox	:	out std_logic_vector(7 downto 0)  
	);
end Sbox;


architecture Behavioral of Sbox is 

	signal x : std_logic_vector(7 downto 0);
	signal t : std_logic_vector(0 to 67);
	signal y : std_logic_vector(0 to 21);
	signal z : std_logic_vector(0 to 17);
	signal s3buf : std_logic;


begin 

	x(0) <= i_Sbox(7);
	x(1) <= i_Sbox(6);
	x(2) <= i_Sbox(5);
	x(3) <= i_Sbox(4);
	x(4) <= i_Sbox(3);
	x(5) <= i_Sbox(2);
	x(6) <= i_Sbox(1);
	x(7) <= i_Sbox(0);

    -- first linear layer
	y(14) <= x(3) xor x(5);
	y(13) <= x(0) xor x(6);
	y(9) <= x(0) xor x(3);
	y(8) <= x(0) xor x(5); 
	t(0) <= x(1) xor x(2);
	y(1) <= t(0) xor x(7);
	y(4) <= y(1) xor x(3);
	y(12) <= y(13) xor y(14);
	y(2) <= y(1) xor x(0);
	y(5) <= y(1) xor x(6);
	y(3) <= y(5) xor y(8);
	t(1) <= x(4) xor y(12);
	y(15) <= t(1) xor x(5);
	y(20) <= t(1) xor x(1);
	y(6) <= y(15) xor x(7);
	y(10) <= y(15) xor t(0);
	y(11) <= y(20) xor y(9);
	y(7) <= x(7) xor y(11);
	y(17) <= y(10) xor y(11);
	y(19) <= y(10) xor y(8);
	y(16) <= t(0) xor y(11);
	y(21) <= y(13) xor y(16);
	y(18) <= x(0) xor y(16);


	--  nonlinear layer 
	t(2) <= y(12) and y(15);
	t(3) <= y(3) and y(6);
	t(4) <= t(3) xor t(2);
	t(5) <= y(4) and x(7);
	t(6) <= t(5) xor t(2);
	t(7) <= y(13) and y(16);
	t(8) <= y(5) and y(1);
	t(9) <= t(8) xor t(7);
	t(10) <= y(2) and y(7);
	t(11) <= t(10) xor t(7);
	t(12) <= y(9) and y(11);
	t(13) <= y(14) and y(17);
	t(14) <= t(13) xor t(12);
	t(15) <= y(8) and y(10);
	t(16) <= t(15) xor t(12);
	t(17) <= t(4) xor t(14);
	t(18) <= t(6) xor t(16);
	t(19) <= t(9) xor t(14);
	t(20) <= t(11) xor t(16);
	t(21) <= t(17) xor y(20);
	t(22) <= t(18) xor y(19);
	t(23) <= t(19) xor y(21);
	t(24) <= t(20) xor y(18);

	t(25) <= t(21) xor t(22);
	t(26) <= t(21) and t(23);
	t(27) <= t(24) xor t(26);
	t(28) <= t(25) and t(27);
	t(29) <= t(28) xor t(22);
	t(30) <= t(23) xor t(24);
	t(31) <= t(22) xor t(26);
	t(32) <= t(31) and t(30);
	t(33) <= t(32) xor t(24);
	t(34) <= t(23) xor t(33);
	t(35) <= t(27) xor t(33);
	t(36) <= t(24) and t(35);
	t(37) <= t(36) xor t(34);
	t(38) <= t(27) xor t(36);
	t(39) <= t(29) and t(38);
	t(40) <= t(25) xor t(39);

	t(41) <= t(40) xor t(37);
	t(42) <= t(29) xor t(33);
	t(43) <= t(29) xor t(40);
	t(44) <= t(33) xor t(37);
	t(45) <= t(42) xor t(41);
	z(0) <= t(44) and y(15);
	z(1) <= t(37) and y(6);
	z(2) <= t(33) and x(7);
	z(3) <= t(43) and y(16);
	z(4) <= t(40) and y(1);
	z(5) <= t(29) and y(7);
	z(6) <= t(42) and y(11);
	z(7) <= t(45) and y(17);
	z(8) <= t(41) and y(10);
	z(9) <= t(44) and y(12);
	z(10) <= t(37) and y(3);
	z(11) <= t(33) and y(4);
	z(12) <= t(43) and y(13);
	z(13) <= t(40) and y(5);
	z(14) <= t(29) and y(2);
	z(15) <= t(42) and y(9);
	z(16) <= t(45) and y(14);
	z(17) <= t(41) and y(8);



	-- last linear layer 
	t(46)<=z(15) xor z(16);
    t(47)<=z(10) xor z(11);
    t(48)<=z(5) xor z(13);
    t(49)<=z(9) xor z(10);
    t(50)<=z(2) xor z(12);
    t(51)<=z(2) xor z(5);
    t(52)<=z(7) xor z(8);
    t(53)<=z(0) xor z(3);
    t(54)<=z(6) xor z(7);
    t(55)<=z(16) xor z(17);
    t(56)<=z(12) xor t(48);
    t(57)<=t(50) xor t(53);
    t(58)<=z(4) xor t(46);
    t(59)<=z(3) xor t(54);
    t(60)<=t(46) xor t(57);
    t(61)<=z(14) xor t(57);
    t(62)<=t(52) xor t(58);
    t(63)<=t(49) xor t(58);
    t(64)<=z(4) xor t(59);
    t(65)<=t(61) xor t(62);
    t(66)<=z(1) xor t(63);
    o_Sbox(7)<=t(59) xor t(63);
    o_Sbox(1)<=t(56) xor t(62) xor '1';
    o_Sbox(0)<=t(48) xor t(60)  xor '1';
    t(67) <=t(64) xor t(65);
    s3buf <= t(53) xor t(66);
    o_Sbox(4)<=s3buf;
    o_Sbox(3)<=t(51) xor t(66);
    o_Sbox(2)<=t(47) xor t(65);
    o_Sbox(6)<=t(64) xor s3buf xor '1';
    o_Sbox(5)<=t(55) xor t(67) xor '1';




end Behavioral;