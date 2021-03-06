----------------------------------------------------------------------------------
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.ALL;

library work;
 use work.globals.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity AES_control_empty is 
	port (
	      clk 			: in std_logic;
	      rst 			: in std_logic; 	
	      load 			: in std_logic; -- control signal that indicates state and key bytes need to be loaded
	      start 		: in std_logic; -- control signal that enables encryption 
	      done_enc 		: out std_logic; 
	      o_Rcon 		: out std_logic_vector(7 downto 0);
	      en_state 		: out std_logic;
	      en_shift 		: out std_logic;
	      en_mix 		: out std_logic;
	      en_key 		: out std_logic;
	      en_rotate		: out std_logic;
	      en_RC			: out std_logic;
	      en_SB_state 	: out std_logic;
	      round0 		: out std_logic
	);
end AES_control_empty;

architecture Behavioral of AES_control_empty is 


	-- The AES round constant can be computed with an LFSR, see https://en.wikipedia.org/wiki/AES_key_schedule#Round_constants 
	component RConst
  		 port(	clk 	: in std_logic;
				rst 	: in std_logic;
				en	 	: in  std_logic; 
				o_Rcon 	: out std_logic_vector(7 downto 0)
		); 
	end component;
	
	-- We use a normal counter to count the cycles and keep track of where in an encryption round we are 
	component control_counter
		 Port ( clk 	: in  std_logic;
				en 		: in  std_logic;
				rst 	: in  std_logic;
				o_count : out  unsigned (4 downto 0)
			);
	end component;

	-- signals in Round_constants block
	signal r_RC			: std_logic_vector (7 downto 0);		-- the round constants	
	signal done_round	: std_logic; 							-- control signal that is 1 when one round complete (ie in the last cycle of each round)	
	signal rst_RC 		: std_logic;							-- control signal that is 1 when the round constant LFSR should be reset for a new encryption
	signal nonzero_RC	: std_logic;							-- control signal that is 0 when the round constant is not used
	
	--signals in Counter block
	signal en_counter	: std_logic;							-- control signal that enables the cycle counter
	signal rst_counter	: std_logic;							-- control signal that resets the cycle counter
	signal cycle_counter: unsigned(4 downto 0);					-- cycle counter
	
	signal skip_mix_col : std_logic; 							-- control signal that is 1 when we should skip mixcolumns 
	signal skip_shift	: std_logic;							-- control signal that is 1 when we should skip shiftrows
	
	signal r_done_load 	: std_logic; 							-- control signal that indicates the end of loading (after 16 cycles)
	signal r_round0 	: std_logic;							-- control signal that is 1 in the first round of encryption	
	signal r_round10 	: std_logic;							-- control signal that is 1 in the last round of encryption
  	signal r_done_enc 	: std_logic;							-- control signal that is 1 when encryption is done and ciphertext bytes are available
	  	
	signal ctrl_bits    : std_logic_vector (0 to 7);			-- a vector of control bits that we will set in each cycle
begin 


	-- ========= Components Instantiation ===========-
    RC: RConst
		 Port map( 
			clk => clk,
      		rst => rst_RC,
      		en => done_round, --when each round is completed
			o_Rcon => r_RC
		  );
		  
	Control: control_counter 
		 Port map(
			clk => clk,
			en => en_counter,
			rst => rst_counter,
			o_count => cycle_counter
		  );

	-- ========= Control Signals per Round ===========-

	-- We don't need a counter to know what round we are in. We can use the round constants (an LFSR is also like a counter anyway)
	r_round10 <= (r_RC(2) and r_RC(1)); 		-- when round constant = 0x36
	
	r_round0 <= (r_RC(3) and r_RC(2)); 			-- when round constant = 0x8d (when rst_RC = '1' is an input control signal of a subblock => const...=>r_round0...)
	round0 <= r_round0;							-- we need the dummy variable because round0 is an output so we can't use it inside the module

	-- the ciphertext bytes come out in the last round of encryption
	r_done_enc <= r_round10 and (not load);  
	done_enc <= r_done_enc;

	-- There are three cases where we shouldn't do the mixcolumns operation on the first column of the state:
	skip_mix_col <= load or r_round10 or r_round0;
	skip_shift <= load;-- or r_round0;
	-- ========= Enables and Resets ===========-

	-- Enable the key array 
	en_key 	<= load or start;							-- enabled the whole round 

	-- Enable the state array
	en_state <= (load or start) and ctrl_bits(0);			-- in some cycles, the state array shouldn't move
	
	-- Enable the cycle counter
	en_counter <= load or start; -- count for cycles of both state and key operations in Sbox

	-- Reset the cycle counter in four cases
	rst_counter <= rst 						 or 			-- global reset or
				(r_done_enc and (not start)) or  			-- end of encryption	
				done_round 					 or 			-- end of round 
				(r_done_load and load);						-- end of loading (=>rst_counter=>r_round0..)

	-- Reset the round constant at global reset and at before of encryption
	rst_RC <= rst or load;


	-- ========= Control Signals per Cycle ===========- (we use the ctrl_bits vector here and fill in the values later on line 124...)

	en_shift <= ctrl_bits(1) and (not skip_shift); 		-- only once per round!
	en_mix <= ctrl_bits(2) and (not skip_mix_col); 		-- four times per round, once for each column, but not in every round!

	en_rotate <= ctrl_bits(3);							-- 4 cycles per round, the key bytes go to the s-box 
	en_SB_state <= not ctrl_bits(3); 					-- 16 cycles per round, when the s-box bytes go to the s-box, before Key bytes go to Sbox
	en_RC <= ctrl_bits(4);								-- 4 cycles per round, for the first column of key bytes
	
	-- Remember from the youtube animation that the round constant consists of 1 changing byte and 3 bytes 0
	-- in AES_128.vhd, we xor key_out with o_Rcon. That rcon should be nonzero in only 1 cycle. 
	nonzero_RC <= ctrl_bits(5); 							-- only 1 cycle (when key xor nonzero rcon)
	o_Rcon <= r_RC and (7 downto 0 => nonzero_RC);	-- set Rcon to 0 when required


	
	r_done_load <= ctrl_bits(6); 							-- the last cycle of loading
	done_round <= ctrl_bits(7); 								-- the last cycle
	-- ========= LUTs for counter ===========-
	-- Simple put the value of each ctrl_bits signal for each cycle. You can use "-" which means don't care.
	
	lut : process(cycle_counter) -- (0 to 7)
	--0: en_state, 1: shift,2: mix,3: en_rotate,4: en_RC,5: nonzero_RC, 6:r_done_load, 7: done_round
	 --key 		= 2A 7e1516-28aed2a6-abf71588-09 CF 4f3c
	begin 
		case to_integer(cycle_counter) is 	 		 		-- SBOX in:			--both 			--key_array
			when 0 	=> ctrl_bits <= "10101100";		 				-- s0, mix, 				key_imm + RC#0 =XX +01=a0(round 1)
			when 1 	=> ctrl_bits <= "10001000";		 				-- s1, 						key_imm + 0
			when 2 	=> ctrl_bits <= "10001000";		 				-- s2, 						key_imm + 0
			when 3 	=> ctrl_bits <= "10001000";		 				-- s3, 						key_imm + 0
			when 4 	=> ctrl_bits <= "10100-00";		 				-- s4, mix, 				xor K30
			when 5 	=> ctrl_bits <= "10000-00";		 				-- s5						xor K30
			when 6 	=> ctrl_bits <= "10000-00";		 				-- s6						xor K30
			when 7 	=> ctrl_bits <= "10000-00";		 				-- s7						xor K30
			when 8 	=> ctrl_bits <= "10100-00";		 				-- s8, mix					xor K30
			when 9 	=> ctrl_bits <= "10000-00";		 				-- s9						xor K30
			when 10 => ctrl_bits <= "10000-00";		 				-- s10						xor K30
			when 11 => ctrl_bits <= "10000-00";		 				-- s11						xor K30
			when 12 => ctrl_bits <= "10100-00";		 				-- s12, mix					xor K30
			when 13 => ctrl_bits <= "10000-00";		 				-- s13						xor K30
			when 14 => ctrl_bits <= "10000-00";		 				-- s14						xor K30
			when 15 => ctrl_bits <= "11000-10";		 				-- s15, shift, r_done_load	xor K30	
			when 16 => ctrl_bits <= "0--1---0";		 				-- k13, 					rotate key, k03 = k00+ i_SB_out (2b+(cf->8a)= XX), key_imm =k00= 1st master key byte
			when 17 => ctrl_bits <= "0--1---0";		 				-- k14, 					rotate key, key_imm = 2nd master key byte
			when 18 => ctrl_bits <= "0--1---0";		 				-- k15, 					rotate key, key_imm = 3rd master key byte
			when 19 => ctrl_bits <= "0--1---1";		 				-- k12, 	, last cycle	rotate key, key_imm = XX
			when others => ctrl_bits <= "--------";
		end case;
	end process;
	
end Behavioral;