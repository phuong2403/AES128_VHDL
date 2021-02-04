library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

library work;
use work.globals.all;
	
entity tb_AES_128_shared is
end tb_AES_128_shared;

architecture Behavioral of tb_AES_128_shared is

	--Design under test
	component AES_128_shared
	port(
		clk			: in std_logic;
		rst			: in std_logic;
		load			: in std_logic; 
		start 		: in std_logic; 
		plaintext 	: in  shared_byte;
		key			: in  shared_byte;
		ciphertext 	: out shared_byte;
    	ready 		: out std_logic
		);
	end component;
	
	--input signals
	signal		clk			:  std_logic :='0';
	signal		rst			:  std_logic :='0';
	signal		load		:  std_logic :='0'; 
	signal		start 		:  std_logic :='0'; 
	signal		tb_plaintext:  shared_byte:=(others =>(others =>'0'));
	signal		tb_key		:  shared_byte:=(others =>(others =>'0'));
	--output signals
	signal		tb_ciphertext:  shared_byte:=(others =>(others =>'0'));
	signal		tb_ready 	 : std_logic :='0';
			
	-- expect results
	signal 		ex_ciphertext : std_logic_vector(127 downto 0):= (others => '0');
	
	--clock definition
	constant	clk_period	: time := 10 ns;

	
	signal 		o_cnt_start : INTEGER RANGE 0 TO 255;
	--other share inputs
	--signal 		seed_text : std_logic_vector(23 downto 0):= x"012345";
	--signal 		seed_key : std_logic_vector(23 downto 0):= x"abcdef";
	signal 		seed_text : std_logic_vector(23 downto 0) := (others => '0');
	signal 		seed_key : std_logic_vector(23 downto 0) := (others => '0');

	signal 		unshared_plaintext : std_logic_vector(7 downto 0);
	signal 		unshared_key 		: std_logic_vector(7 downto 0);
	signal 		unshared_ciphertext : std_logic_vector(7 downto 0);
	
begin

	tb_plaintext(0) <= unshared_plaintext xor tb_plaintext(1) xor tb_plaintext(2) xor tb_plaintext(3);
	tb_plaintext(1) <= seed_text(7 downto 0);
	tb_plaintext(2) <= seed_text(15 downto 8);
	tb_plaintext(3) <= seed_text(23 downto 16);

	tb_key(0) <= unshared_key xor tb_key(1) xor tb_key(2) xor tb_key(3);
	tb_key(1) <= seed_key(7 downto 0);
	tb_key(2) <= seed_key(15 downto 8);
	tb_key(3) <= seed_key(23 downto 16);

	unshared_ciphertext <= tb_ciphertext(0) xor tb_ciphertext(1) xor tb_ciphertext(2) xor tb_ciphertext(3);

	--==instantiate DUT==--
		--instantiate DUT
	DUT: AES_128_shared
		port map (
			clk => clk,
			rst => rst,
			load => load,
			start => start,			
			plaintext => tb_plaintext,
			key => tb_key,
			ciphertext => tb_ciphertext,
			ready => tb_ready
			);
	
	--==clock generation==--
	clk_gen: process
	begin
		clk <= '1';
		wait for clk_period/2;
		clk <= '0';
		wait for clk_period/2;
	end process clk_gen;
	
	--===test process===--

	test: process 
	begin
		rst <= '1';
		wait for clk_period;
		rst <= '0';
	--plaintext = 3243f6a8885a308d313198a2e0370734
	--key 		= 2b7e151628aed2a6abf7158809cf4f3c		
	--ciphertext= 3925841d02dc09fbdc118597196a0b32	
		wait for clk_period;
		load <= '1';
		unshared_plaintext <= x"32";
		unshared_key <=  x"2b";
		wait for clk_period;
		unshared_plaintext <= x"43";
		unshared_key <=  x"7e";
		wait for clk_period;
		unshared_plaintext <= x"f6";
		unshared_key <=  x"15";
		wait for clk_period;
		unshared_plaintext <= x"a8";
		unshared_key <=  x"16";
		wait for clk_period;
		unshared_plaintext <= x"88";
		unshared_key <=  x"28";
		wait for clk_period;
		unshared_plaintext <= x"5a";
		unshared_key <=  x"ae";
		wait for clk_period;
		unshared_plaintext <= x"30";
		unshared_key <=  x"d2";
		wait for clk_period;
		unshared_plaintext <= x"8d";
		unshared_key <=  x"a6";
		wait for clk_period;
		unshared_plaintext <= x"31";
		unshared_key <=  x"ab";
		wait for clk_period;
		unshared_plaintext <= x"31";
		unshared_key <=  x"f7";
		wait for clk_period;
		unshared_plaintext <= x"98";
		unshared_key <=  x"15";
		wait for clk_period;
		unshared_plaintext <= x"a2";
		unshared_key <=  x"88";
		wait for clk_period;
		unshared_plaintext <= x"e0";
		unshared_key <=  x"09";
		wait for clk_period;
		unshared_plaintext <= x"37";
		unshared_key <=  x"cf";
		wait for clk_period;
		unshared_plaintext <= x"07";
		unshared_key <=  x"4f";
		wait for clk_period;
		unshared_plaintext <= x"34";
		unshared_key <=  x"3c";
		wait for clk_period;
		load <= '0';
		start <= '1';
		wait until tb_ready <= '1';
		ex_ciphertext <= x"3925841d02dc09fbdc118597196a0b32";
		wait for clk_period*16;
		start <= '0';	


		seed_text <= x"012345";
		seed_key <= x"abcdef";
		

		wait for clk_period;
		load <= '1';
		unshared_plaintext <= x"32";
		unshared_key <=  x"2b";
		wait for clk_period;
		unshared_plaintext <= x"43";
		unshared_key <=  x"7e";
		wait for clk_period;
		unshared_plaintext <= x"f6";
		unshared_key <=  x"15";
		wait for clk_period;
		unshared_plaintext <= x"a8";
		unshared_key <=  x"16";
		wait for clk_period;
		unshared_plaintext <= x"88";
		unshared_key <=  x"28";
		wait for clk_period;
		unshared_plaintext <= x"5a";
		unshared_key <=  x"ae";
		wait for clk_period;
		unshared_plaintext <= x"30";
		unshared_key <=  x"d2";
		wait for clk_period;
		unshared_plaintext <= x"8d";
		unshared_key <=  x"a6";
		wait for clk_period;
		unshared_plaintext <= x"31";
		unshared_key <=  x"ab";
		wait for clk_period;
		unshared_plaintext <= x"31";
		unshared_key <=  x"f7";
		wait for clk_period;
		unshared_plaintext <= x"98";
		unshared_key <=  x"15";
		wait for clk_period;
		unshared_plaintext <= x"a2";
		unshared_key <=  x"88";
		wait for clk_period;
		unshared_plaintext <= x"e0";
		unshared_key <=  x"09";
		wait for clk_period;
		unshared_plaintext <= x"37";
		unshared_key <=  x"cf";
		wait for clk_period;
		unshared_plaintext <= x"07";
		unshared_key <=  x"4f";
		wait for clk_period;
		unshared_plaintext <= x"34";
		unshared_key <=  x"3c";
		wait for clk_period;
		load <= '0';
		start <= '1';
		wait until tb_ready <= '1';
		ex_ciphertext <= x"3925841d02dc09fbdc118597196a0b32";
		wait for clk_period*16;
		start <= '0';	
	
		wait;
	end process test;
	
	   -- A start counter
   PROCESS (clk)
      VARIABLE   cnt         : INTEGER RANGE 0 TO 255;
   BEGIN
      IF (rising_edge(clk)) THEN
         IF (load = '1' or tb_ready = '1')THEN
            cnt := 0;
         ELSE
               IF start = '1' THEN
                  cnt := cnt + 1;
               END IF;
         END IF;
      END IF;			          
     o_cnt_start <= cnt;
   END PROCESS;
end architecture;