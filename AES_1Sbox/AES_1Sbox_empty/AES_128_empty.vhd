----------------------------------------------------------------------------------
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
	use work.globals.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity AES_128_empty is
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
end AES_128_empty;

architecture Behavioral of AES_128_empty is

	--========= Components Used ===========-
	component State_array
		 Port ( 
			clk 		  	: in  std_logic;
			en 				: in  std_logic; 
        	en_shift 		: in  std_logic; 
        	en_mix			: in  std_logic; 
			i_state 		: in std_logic_vector(7 downto 0);
			o_state			: out std_logic_vector(7 downto 0)
	  	);
	end component;
	
	component Key_array
		Port ( 
			clk 			: in  std_logic;
			en 				: in  std_logic; 
        	en_rotate		: in  std_logic; 
			i_key	 		: in  std_logic_vector(7 downto 0);
			i_SB_out 		: in  std_logic_vector(7 downto 0); 
			o_in_SB 		: out std_logic_vector(7 downto 0);
			o_final_K00 	: out std_logic_vector(7 downto 0);
			o_K30 	 		: out std_logic_vector(7 downto 0)
	  	);
	end component;

	component Sbox 
    	port(
			i_Sbox	:	in  std_logic_vector(7 downto 0); 
			o_Sbox	:	out std_logic_vector(7 downto 0)  
		);
	end component;
	
	component AES_control_empty 
		port (
	      clk 			: in std_logic;
	      rst 			: in std_logic;
	      load 			: in std_logic;
	      start 		: in std_logic;
	      done_enc		: out std_logic;
	      o_Rcon 		: out std_logic_vector(7 downto 0);
	      en_state		: out std_logic;
	      en_shift 		: out std_logic;
	      en_mix 		: out std_logic;
	      en_key 		: out std_logic;
	      en_rotate 	: out std_logic;
	      en_RC 		: out std_logic;
	      en_SB_state 	: out std_logic;
	      round0 		: out std_logic
		);
	end component;
	
	--========= Data Path Signals ===========
	--state array
	signal ri_state 	: std_logic_vector(7 downto 0);
	signal ro_state		: std_logic_vector(7 downto 0);
	--signal state_xor	: std_logic_vector(7 downto 0);
	
	--key array
	signal ri_key		: std_logic_vector(7 downto 0);
	signal ro_key		: std_logic_vector(7 downto 0);
	signal r_in_SB		: std_logic_vector(7 downto 0);
	signal r_key30 		: std_logic_vector(7 downto 0);
	signal r_Rkey 		: std_logic_vector(7 downto 0);
	signal r_Rcon		: std_logic_vector(7 downto 0);
	
	--Sbox block
	signal ri_Sbox		: std_logic_vector(7 downto 0); 
	signal ro_Sbox		: std_logic_vector(7 downto 0);
	
	--Addroundkey	
	signal r_Add_Rkey	: std_logic_vector(7 downto 0);

	--========= Control Signals ===========-
	--key schedule	
	signal en_key 			: std_logic;					--  enables the key state
	signal en_rotate		: std_logic;					--  indicates that the key state has to en_rotate
	signal en_RC			: std_logic;					--  indicates when the round key is computed for column 1 (i.e with round constant)
	
	--encryption schedule
	signal en_shift			: std_logic;					--  indicates when the state array does shiftrows
	signal en_mix			: std_logic;					--  indicates when the state array does mixcolumns
	signal en_SB_state		: std_logic;					--  indicates when the state uses the S-box (1) or when the key uses the S-box (0)
  	signal en_state 		: std_logic;					--  enables the state array 

  	signal r_round0 		: std_logic;					--  is 1 in the first round
  	signal done_enc			: std_logic;					--  says when the ciphertext is coming out (round 10) 

begin
  
	--========= Components Instantiation ===========-
	State_ar: State_array
		 Port map( 
				  clk => clk,
				  en => en_state,
				  en_shift => en_shift,
				  en_mix => en_mix,
				  i_state => ri_state,
				  o_state => ro_state
				);
		  
	Key_ar:	Key_array
		 Port map( 
				  clk => clk,
				  en => en_key, 
				  en_rotate => en_rotate,
				  i_key => ri_key,
				  i_SB_out => ro_Sbox,
				  o_in_SB => r_in_SB,
				  o_final_K00 => ro_key,
				  o_K30 => r_key30
				);
		  
 	-- ** Instantiate your AES S-box here ** -- 
 	AES_Sbox: Sbox 
 		Port map(
				i_Sbox => ri_Sbox,
				o_Sbox => ro_Sbox
				);
		  
	Control : AES_control_empty 
		Port map(
				clk => clk,
				rst => rst,
				load => load,
				start => start,
				done_enc => done_enc,
				o_Rcon => r_Rcon,
				en_state => en_state,
				en_shift => en_shift,
				en_mix => en_mix,
				en_key => en_key,
				en_rotate => en_rotate,
				en_RC => en_RC,
				en_SB_state => en_SB_state,
				round0 => r_round0
				);
	
	--========= Wiring ===========-

	-- ** Round Key: In the first round, the round key is already in the state => we don't do any other operations.
	-- Otherwise, ro_key still needs to be xored with something
	-- Key type 1 (first column): ro_key xor round constant
	-- Key type 2 (others columns): xor ro_key with key30 (= key byte from previous column) ** --
	r_Rkey <= 	ro_key 				when (r_round0 ='1') else 				-- the first round key is the master key
				ro_key xor r_Rcon 	when (en_RC ='1') else 					-- key byte in first column
				ro_key xor r_key30;											-- key byte in other columns

	-- ** Choose the input to the the key array. We need to be able to load the key array with the input key bytes.
	-- Otherwise, we just feed the round key back into the state ** --
	ri_key <= 	key 		when (load ='1') else 					-- to load the key state
				r_Rkey;												-- round key is fed back


	-- ** AddRoundKey ** --
	r_Add_Rkey <= r_Rkey xor ro_state;

	-- ** Sbox input: The S-box input can come from the state array (state xor roundkey) or from the key array ** --
	ri_Sbox <= r_Add_Rkey		when (en_SB_state ='1') else r_in_SB;

	-- ** State input: we either load the state array with the input data bytes, or we feed the output of the S-box in ** --
	ri_state <= plaintext		when (load ='1') else ro_Sbox;



	--========= Outputs ===========-
	ready <= done_enc;

	-- ** Only output the ciphertext when it is available ** --
  	ciphertext <= r_Add_Rkey 		when (done_enc ='1') else (others => '0');

end Behavioral;

