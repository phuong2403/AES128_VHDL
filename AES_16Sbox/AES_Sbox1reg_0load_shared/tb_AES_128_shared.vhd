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
		reset			: in std_logic; 
		start 		: in std_logic; 
		plaintext 	: in  shared_state;
		key			: in  shared_state;
		ciphertext 	: out shared_state;
    	ready 		: out std_logic
		);
	end component;
	
	--input signals
	signal		clk			:  std_logic :='0';
	signal		reset			:  std_logic :='0';
	signal		start 		:  std_logic :='0'; 
	signal		tb_plaintext:  shared_state:=(others =>(others =>'0'));
	signal		tb_key		:  shared_state:=(others =>(others =>'0'));
	--output signals
	signal		tb_ciphertext:  shared_state:=(others =>(others =>'0'));
	signal		tb_ready 	 : std_logic :='0';
			
	-- expect results
	signal 		ex_ciphertext : std_logic_vector(127 downto 0):= (others => '0');
	
	--clock definition
	constant	clk_period	: time := 10 ns;

	
	signal 		o_cnt_start : INTEGER RANGE 0 TO 25;
	--other share inputs
	--signal 		seed_text : std_logic_vector(23 downto 0):= x"012345";
	--signal 		seed_key : std_logic_vector(23 downto 0):= x"abcdef";
	signal 		seed_text : std_logic_vector(383 downto 0) := (others => '0');
	signal 		seed_key : std_logic_vector(383 downto 0) := (others => '0');

	signal 		unshared_plaintext : std_logic_vector(127 downto 0);
	signal 		unshared_key 		: std_logic_vector(127 downto 0);
	signal 		unshared_ciphertext : std_logic_vector(127 downto 0);
	
begin

	tb_plaintext(0) <= unshared_plaintext xor tb_plaintext(1) xor tb_plaintext(2) xor tb_plaintext(3);
	tb_plaintext(1) <= seed_text(127 downto 0);
	tb_plaintext(2) <= seed_text(255 downto 128);
	tb_plaintext(3) <= seed_text(383 downto 256);

	tb_key(0) <= unshared_key xor tb_key(1) xor tb_key(2) xor tb_key(3);
	tb_key(1) <= seed_key(127 downto 0);
	tb_key(2) <= seed_key(255 downto 128);
	tb_key(3) <= seed_key(383 downto 256);

	unshared_ciphertext <= tb_ciphertext(0) xor tb_ciphertext(1) xor tb_ciphertext(2) xor tb_ciphertext(3);

	--==instantiate DUT==--
		--instantiate DUT
	DUT: AES_128_shared
		port map (
			clk => clk,
			reset => reset,
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
		reset <= '1';
		wait for clk_period;
		reset <= '0';
	--plaintext = 3243f6a8885a308d313198a2e0370734
	--key 		= 2b7e151628aed2a6abf7158809cf4f3c		
	--ciphertext= 3925841d02dc09fbdc118597196a0b32	
		wait for clk_period;
		start <= '0';
		unshared_plaintext <= x"3243f6a8885a308d313198a2e0370734";
		unshared_key <=  x"2b7e151628aed2a6abf7158809cf4f3c";
		
		wait for clk_period*6;
		start <= '1';
		wait until tb_ready <= '1';
		ex_ciphertext <= x"3925841d02dc09fbdc118597196a0b32";
		
		wait for clk_period*6;
		start <= '0';	

		unshared_plaintext <= x"3243f6a8885a308d313198a2e0370734";
		unshared_key <=  x"2b7e151628aed2a6abf7158809cf4f3c";
		
		seed_text <= x"012345678901234567890123456789ab012345678901234567890123456789ab012345678901234567890123456789ab";
		seed_key  <= x"abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789";
		
		wait for clk_period*6;
		start <= '1';
		wait until tb_ready <= '1';
		ex_ciphertext <= x"3925841d02dc09fbdc118597196a0b32";
		wait for clk_period*16;
		start <= '0';	
		
		unshared_plaintext <= x"54776F204F6E65204E696E652054776F";
		unshared_key <=  x"5468617473206D79204B756E67204675";
		
		seed_text <= x"012345678901234567890123456789ab012345678901234567890123456789ab012345678901234567890123456789ab";
		seed_key  <= x"012345678901234567890123456789ab012345678901234567890123456789ab012345678901234567890123456789ab";
		
		wait for clk_period*6;
		start <= '1';
		wait until tb_ready <= '1';
		ex_ciphertext <= x"29C3505F571420F6402299B31A02D73A";
		wait for clk_period*16;
		start <= '0';
		wait;
	end process test;
	
	   -- A start counter
   PROCESS (clk)
      VARIABLE   cnt         : INTEGER RANGE 0 TO 25;
   BEGIN
      IF (rising_edge(clk)) THEN
         IF (start = '0') THEN
            cnt := 0;
         ELSE
            cnt := cnt + 1;
         END IF;
      END IF;			          
     o_cnt_start <= cnt;
   END PROCESS;
end architecture;