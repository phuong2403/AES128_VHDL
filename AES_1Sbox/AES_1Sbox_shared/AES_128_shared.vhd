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

entity AES_128_shared is
	port(
		clk			: in std_logic;
		rst			: in std_logic;
		load		: in std_logic; 
		start 		: in std_logic; 
		plaintext 	: in  shared_byte;
		key			: in  shared_byte;
		ciphertext 	: out shared_byte;
    	ready 		: out std_logic
		);
end AES_128_shared;

architecture Behavioral of AES_128_shared is

	--========= Components Used ===========-
	--state array
	component State_array_Dshare
		 Port ( 
			clk 		  	: in  std_logic;
			en 				: in  std_logic; 
        	en_shift 		: in  std_logic; 
        	en_mix			: in  std_logic; 
			i_state 		: in shared_byte;
			o_state			: out shared_byte
	  	);
	end component;
	
	--key array
	component Key_array_Dshare
		Port ( 
			clk 			: in  std_logic;
			en 				: in  std_logic; 
        	en_rotate		: in  std_logic;
			en_xor			: in  std_logic; 			
			i_key	 		: in  shared_byte;
			i_SB_out 		: in  shared_byte; 
			o_in_SB 		: out shared_byte;
			o_final_K00 	: out shared_byte;
			o_K30 	 		: out shared_byte
	  	);
	end component;
	
	--mux
	component Mux2_Dshare 	
		port (
			i_a : in shared_byte;
			i_b : in shared_byte;
			en 	: in std_logic;
			o_c : out shared_byte 
			);	
	end component;
	
	--xor
	component Xor_Dshare 	
		port (
			i_a : in shared_byte;
			i_b : in shared_byte;
			o_c : out shared_byte 
				);	
	end component;
	
	--===from Zhenda---
	component Sbox_shared
		port(X00, X0_1, X02, X03, X10, X11, X12, X13, X20, X21, X22, X23, X30, X31, X32, X33, X40, X41, X42, X43, X50, X51, X52, X53, X60, X61, X62, X63, X70, X71, X72, X73 : in std_logic;
			clock :in std_logic;
			F00, F01, F02, F03, F10, F11, F12, F13, F20, F21, F22, F23, F30, F31, F32, F33, F40, F41, F42, F43, F50, F51, F52, F53, F60, F61, F62, F63, F70, F71, F72, F73 : out std_logic);
	end component;
	
	component Controller 
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
		  en_xor		: out std_logic;
	      en_RC 		: out std_logic;
	      en_SB_state 	: out std_logic;
	      round0 		: out std_logic
		);
	end component;
	
	--========= Data Path Signals ===========
	--state array
	signal ri_state 	: shared_byte;
	signal ro_state		: shared_byte;
	--signal state_xor	: std_logic_vector(7 downto 0);
	
	--key array
	signal ri_key		: shared_byte;
	signal ro_key		: shared_byte;
	signal r_in_SB		: shared_byte;
	signal r_key30 		: shared_byte;
	signal r_Rkey 		: shared_byte;
	signal r_Rkey_xor0	: shared_byte;
	signal r_RkeyRC		: shared_byte;
	signal r_Rkey_xor	: shared_byte;
	signal r_Rcon		: std_logic_vector(7 downto 0);
	signal Rcon_Dshare	: shared_byte;
	--Sbox block
	signal ri_Sbox		: shared_byte; 
	signal ro_Sbox		: shared_byte;
	
	--Addroundkey	
	signal r_Add_Rkey	: shared_byte;

	--========= Control Signals ===========-
	--key schedule	
	signal en_key 			: std_logic;					--  enables the key state
	signal en_rotate		: std_logic;					--  indicates that the key state has to en_rotate
	signal en_xor			: std_logic;					--  indicates that the key byte has to xor i_SB_out
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
	State_ar: State_array_Dshare
		 Port map( 
				  clk => clk,
				  en => en_state,
				  en_shift => en_shift,
				  en_mix => en_mix,
				  i_state => ri_state,
				  o_state => ro_state
				);
		  
	Key_ar:	Key_array_Dshare
		 Port map( 
				  clk => clk,
				  en => en_key, 
				  en_rotate => en_rotate,
				  en_xor => en_xor,
				  i_key => ri_key,
				  i_SB_out => ro_Sbox,
				  o_in_SB => r_in_SB,
				  o_final_K00 => ro_key,
				  o_K30 => r_key30
				);
		  
 	-- ** Instantiate your AES S-box here ** -- 
 	AES_Sbox: sbox_shared 
 		Port map(
				-- type shared_byte is array(0 to D-1) of std_logic_vector(7 downto 0)
				-- X00, X0_1, X02, X03 least significant bits
				-- X70, X71, X72, X73 most significant bits
				clock => clk,
				--1st share input byte
				X00 => ri_Sbox(0)(0),
				X10 => ri_Sbox(0)(1),
				X20 => ri_Sbox(0)(2),
				X30 => ri_Sbox(0)(3),
				X40 => ri_Sbox(0)(4),
				X50 => ri_Sbox(0)(5),
				X60 => ri_Sbox(0)(6),
				X70 => ri_Sbox(0)(7),
				
				--2nd share input byte
				X0_1 => ri_Sbox(1)(0),
				X11 => ri_Sbox(1)(1),
				X21 => ri_Sbox(1)(2),
				X31 => ri_Sbox(1)(3),
				X41 => ri_Sbox(1)(4),
				X51 => ri_Sbox(1)(5),
				X61 => ri_Sbox(1)(6),
				X71 => ri_Sbox(1)(7),
				
				--3rd share input byte
				X02 => ri_Sbox(2)(0),
				X12 => ri_Sbox(2)(1),
				X22 => ri_Sbox(2)(2),
				X32 => ri_Sbox(2)(3),
				X42 => ri_Sbox(2)(4),
				X52 => ri_Sbox(2)(5),
				X62 => ri_Sbox(2)(6),
				X72 => ri_Sbox(2)(7),
				
				--4th share input byte
				X03 => ri_Sbox(3)(0),
				X13 => ri_Sbox(3)(1),
				X23 => ri_Sbox(3)(2),
				X33 => ri_Sbox(3)(3),
				X43 => ri_Sbox(3)(4),
				X53 => ri_Sbox(3)(5),
				X63 => ri_Sbox(3)(6),
				X73 => ri_Sbox(3)(7),
				
				--1st share output byte
				F00 => ro_Sbox(0)(0),
				F10 => ro_Sbox(0)(1),
				F20 => ro_Sbox(0)(2),
				F30 => ro_Sbox(0)(3),
				F40 => ro_Sbox(0)(4),
				F50 => ro_Sbox(0)(5),
				F60 => ro_Sbox(0)(6),
				F70 => ro_Sbox(0)(7),
				
				--2nd share output byte
				F01 => ro_Sbox(1)(0),
				F11 => ro_Sbox(1)(1),
				F21 => ro_Sbox(1)(2),
				F31 => ro_Sbox(1)(3),
				F41 => ro_Sbox(1)(4),
				F51 => ro_Sbox(1)(5),
				F61 => ro_Sbox(1)(6),
				F71 => ro_Sbox(1)(7),
				
				--3rd share output byte
				F02 => ro_Sbox(2)(0),
				F12 => ro_Sbox(2)(1),
				F22 => ro_Sbox(2)(2),
				F32 => ro_Sbox(2)(3),
				F42 => ro_Sbox(2)(4),
				F52 => ro_Sbox(2)(5),
				F62 => ro_Sbox(2)(6),
				F72 => ro_Sbox(2)(7),
				
				--4th share output byte
				F03 => ro_Sbox(3)(0),
				F13 => ro_Sbox(3)(1),
				F23 => ro_Sbox(3)(2),
				F33 => ro_Sbox(3)(3),
				F43 => ro_Sbox(3)(4),
				F53 => ro_Sbox(3)(5),
				F63 => ro_Sbox(3)(6),
				F73 => ro_Sbox(3)(7)
				);
		  
	Control : Controller 
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
				en_xor => en_xor,
				en_RC => en_RC,
				en_SB_state => en_SB_state,
				round0 => r_round0
				);
	
	--========= Wiring ===========-
	Rcon_Dshare(0) <= r_Rcon;
	gen: for i in 1 to D-1 generate
		Rcon_Dshare(i) <= (others =>'0');
	end generate;
	-- ** Round Key: In the first round, the round key is already in the state => we don't do any other operations.
	
	--r_Rkey <= ro_key 				when (r_round0 ='1') else 				-- the first round key is the master key
	--			ro_key xor r_Rcon 	when (en_RC ='1') else 					-- key byte in first column
	--			ro_key xor r_key30;											-- key byte in other columns
	xor_key30:		 Xor_Dshare port map(ro_key, r_key30, r_Rkey_xor0);
	xor_Rcon:		 Xor_Dshare port map(ro_key, Rcon_Dshare, r_RkeyRC);
	mux_Rkey_xor: 	Mux2_Dshare port map(r_Rkey_xor0, r_RkeyRC, en_RC, r_Rkey_xor);
	mux_Rkey: 		Mux2_Dshare port map(r_Rkey_xor, ro_key, r_round0, r_Rkey);
	
	-- ** Choose the input to the the key array. We need to be able to load the key array with the input key bytes.
	-- Otherwise, we just feed the round key back into the state ** --
	--ri_key <= 	key 		when (load ='1') else 					-- to load the key state
	--			r_Rkey;												-- round key is fed back
	mux_key: Mux2_Dshare port map(r_Rkey, key, load, ri_key);
	
	-- ** AddRoundKey ** --
	--r_Add_Rkey <= r_Rkey xor ro_state;
	xor_add: Xor_Dshare port map(r_Rkey, ro_state, r_Add_Rkey);
	
	-- ** Sbox input: The S-box input can come from the state array (state xor roundkey) or from the key array ** --
	--ri_Sbox <= r_Add_Rkey		when (en_SB_state ='1') else r_in_SB;
	mux_S: Mux2_Dshare port map(r_in_SB, r_Add_Rkey, en_SB_state, ri_Sbox);
	
	-- ** State input: we either load the state array with the input data bytes, or we feed the output of the S-box in ** --
	--ri_state <= plaintext		when (load ='1') else ro_Sbox;
	mux_state: Mux2_Dshare port map(ro_Sbox, plaintext, load, ri_state);


	--========= Outputs ===========-
	ready <= done_enc;

	-- ** Only output the ciphertext when it is available ** --
  	--ciphertext <= r_Add_Rkey 		when (done_enc ='1') else (others => '0');
	mux_cipher: Mux2_Dshare port map( i_a => (others => (others => '0')), i_b => r_Add_Rkey, en => done_enc, o_c => ciphertext);
	

	
end Behavioral;

