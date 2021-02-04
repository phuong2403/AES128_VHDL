----------------------------------------------------------------------------------
-- Module name : Sbox
-- Top level : AES_top
---
-- Engineer:   Thomas De Cnudde
-- 
-- Create Date:   21/05/2016 
-- S-box using all normal bases
--
-- case # 4 : [d^16, d], [alpha^8, alpha^2], [Omega^2, Omega]
-- beta^8 = N^2*alpha^2, N = w^2
-- optimized using OR gates and NAND gates
-- square in GF(2^2), using normal basis [Omega^2,Omega]
-- inverse is the same as square in GF(2^2), using any normal basis
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity Sbox is
	port (
		mode : in std_logic; -- 1 for Sbox, 0 for inverse Sbox
		Sbox_input : in std_logic_vector(7 downto 0);
		Sbox_output : out std_logic_vector(7 downto 0)
	);
end entity;

architecture RTL of Sbox is
	signal A, Q, B, C, D, X, Y, Z : std_logic_vector(7 downto 0);
	signal R1, R2, R3, R4, R5, R6, R7, R8, R9 : std_logic;
	signal T1, T2, T3, T4, T5, T6, T7, T8, T9, T10 : std_logic;
	
	component Sbox_rng_GF_INV_8
		port (
			A : in std_logic_vector(7 downto 0);
			Q : out std_logic_vector(7 downto 0)
			);
	end component;
	
begin
	A <= Sbox_input;
	Sbox_output <= Q;
	-- change basis from GF(2^8) to GF(2^8)/GF(2^4)/GF(2^2)
	-- combine with bit inverse matrix multiply of Sbox
	R1 <= A(7) xor A(5);
	R2 <= A(7) xnor A(4);
	R3 <= A(6) xor A(0);
	R4 <= A(5) xnor R3;
	R5 <= A(4) xor R4;
	R6 <= A(3) xor A(0);
	R7 <= A(2) xor R1;
	R8 <= A(1) xor R3;
	R9 <= A(3) xor R8;
	B(7) <= R7 xnor R8;
	B(6) <= R5;
	B(5) <= A(1) xor R4;
	B(4) <= R1 xnor R3;
	B(3) <= A(1) xor R2 xor R6;
	B(2) <= not A(0);
	B(1) <= R4;
	B(0) <= A(2) xnor R9;
	Y(7) <= R2;
	Y(6) <= A(4) xor R8 ;
	Y(5) <= A(6) xor A(4);
	Y(4) <= R9;
	Y(3) <= A(6) xnor R2;
	Y(2) <= R7;
	Y(1) <= A(4) xor R6;
	Y(0) <= A(1) xor R5;
	
	-- Components
	Z <= (not B) when mode='1' else (not Y);

	inv : Sbox_rng_GF_INV_8 port map ( A=>Z, Q=>C );
	
	-- change basis back from GF(2^8)/GF(2^4)/GF(2^2) to GF(2^8)
	T1 <= C(7) xor C(3);
	T2 <= C(6) xor C(4);
	T3 <= C(6) xor C(0);
	T4 <= C(5) xnor C(3);
	T5 <= C(5) xnor T1;
	T6 <= C(5) xnor C(1);
	T7 <= C(4) xnor T6;
	T8 <= C(2) xor T4;
	T9 <= C(1) xor T2;
	T10 <= T3 xor T5;
	D(7) <= T4;
	D(6) <= T1;
	D(5) <= T3;
	D(4) <= T5;
	D(3) <= T2 xor T5;
	D(2) <= T3 xor T8;
	D(1) <= T7;
	D(0) <= T9;
	X(7) <= C(4) xnor C(1);
	X(6) <= C(1) xor T10;
	X(5) <= C(2) xor T10;
	X(4) <= C(6) xnor C(1);
	X(3) <= T8 xor T9;
	X(2) <= C(7) xnor T7;
	X(1) <= T6;
	X(0) <= not C(2);

	Q <= (not D) when mode='1' else (not X);

end architecture;


