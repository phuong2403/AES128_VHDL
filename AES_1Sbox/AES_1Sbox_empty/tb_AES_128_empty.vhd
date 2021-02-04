library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity tb_AES_128_empty is
end tb_AES_128_empty;

architecture Behavioral of tb_AES_128_empty is

	--Design under test
	component AES_128_empty
		port(
			clk			: in std_logic;
			rst			: in std_logic;
			load		: in std_logic; 
			start 		: in std_logic; 
			plaintext 	: in  std_logic_vector(7 downto 0);
			key			: in  std_logic_vector(7 downto 0);
			ciphertext 	: out std_logic_vector(7 downto 0);
			ready 		: out std_logic
			);
	end component;
	
	--input signals
	signal		clk			:  std_logic :='0';
	signal		rst			:  std_logic :='0';
	signal		load		:  std_logic :='0'; 
	signal		start 		:  std_logic :='0'; 
	signal		tb_plaintext:  std_logic_vector(7 downto 0):=(others =>'0');
	signal		tb_key		:  std_logic_vector(7 downto 0):=(others =>'0');
	--output signals
	signal		tb_ciphertext:  std_logic_vector(7 downto 0):=(others =>'0');
	signal		tb_ready 	 : std_logic :='0';
			
	-- expect results
	signal ex_ciphertext : std_logic_vector(127 downto 0):= (others => '0');
	
	--clock definition
	constant	clk_period	: time := 10 ns;

	--counter
	--signal		cnt  : INTEGER RANGE 0 TO 255;
	signal 		o_cnt_start : INTEGER RANGE 0 TO 255;
	
begin
	--==instantiate DUT==--
		--instantiate DUT
	DUT: AES_128_empty
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
		tb_plaintext <= x"00";
		tb_key 	  	 <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key 	  	 <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key   	 <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key  	 <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key 	     <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key 	     <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key   	 <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key  	 <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key 	     <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key   	 <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key  	 <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key 	     <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key 	     <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key   	 <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key  	 <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key  	 <= x"00";
		wait for clk_period;
		load <= '0';
		start <= '1';
		wait until tb_ready <= '1';
		ex_ciphertext <= x"66E94BD4EF8A2C3B884CFA59CA342B2E";
		wait for clk_period*16;
		start<='0';
		
		wait for clk_period*6;
		load <= '1';
		tb_plaintext <= x"32";
		tb_key 	  	 <= x"2b";
		wait for clk_period;
		tb_plaintext <= x"43";
		tb_key 	  	 <= x"7e";
		wait for clk_period;
		tb_plaintext <= x"f6";
		tb_key   	 <= x"15";
		wait for clk_period;
		tb_plaintext <= x"a8";
		tb_key  	 <= x"16";
		wait for clk_period;
		tb_plaintext <= x"88";
		tb_key 	     <= x"28";
		wait for clk_period;
		tb_plaintext <= x"5a";
		tb_key 	     <= x"ae";
		wait for clk_period;
		tb_plaintext <= x"30";
		tb_key   	 <= x"d2";
		wait for clk_period;
		tb_plaintext <= x"8d";
		tb_key  	 <= x"a6";
		wait for clk_period;
		tb_plaintext <= x"31";
		tb_key 	     <= x"ab";
		wait for clk_period;
		tb_plaintext <= x"31";
		tb_key   	 <= x"f7";
		wait for clk_period;
		tb_plaintext <= x"98";
		tb_key  	 <= x"15";
		wait for clk_period;
		tb_plaintext <= x"a2";
		tb_key 	     <= x"88";
		wait for clk_period;
		tb_plaintext <= x"e0";
		tb_key 	     <= x"09";
		wait for clk_period;
		tb_plaintext <= x"37";
		tb_key   	 <= x"cf";
		wait for clk_period;
		tb_plaintext <= x"07";
		tb_key  	 <= x"4f";
		wait for clk_period;
		tb_plaintext <= x"34";
		tb_key  	 <= x"3c";
		wait for clk_period;
		load <= '0';
		wait for 6* clk_period;
		start <= '1';
		wait until tb_ready <= '1';
		ex_ciphertext <= x"3925841d02dc09fbdc118597196a0b32";
		wait for clk_period*16;				
		start <= '0';
		
		wait for clk_period*6;		
	----------------------------------------------
	--plaintext = 00000000000000000000000000000000
	--key 		= 00000000000000000000000000000000		
	--ciphertext= 66E94BD4EF8A2C3B884CFA59CA342B2E	
		--wait for clk_period;		
		load <= '1';
		tb_plaintext <= x"00";
		tb_key 	  	 <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key 	  	 <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key   	 <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key  	 <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key 	     <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key 	     <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key   	 <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key  	 <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key 	     <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key   	 <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key  	 <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key 	     <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key 	     <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key   	 <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key  	 <= x"00";
		wait for clk_period;
		tb_plaintext <= x"00";
		tb_key  	 <= x"00";
		wait for clk_period;
		load <= '0';
		start <= '1';
		wait until tb_ready <= '1';
		ex_ciphertext <= x"66E94BD4EF8A2C3B884CFA59CA342B2E";
		wait for clk_period*14;
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