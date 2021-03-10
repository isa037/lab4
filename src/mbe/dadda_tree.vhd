LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

library work;
use work.my_pkg.all;

entity dadda_tree is
	port ( dadda_in: in array36(16 downto 0);
			dadda_out1: out std_logic_vector (63 downto 1);
			dadda_out2: out std_logic_vector (63 downto 0)
	);
end entity;

architecture rtl of dadda_tree is
	component dadda_stage1 is
		port ( pp_in: in array36(16 downto 0);
			   s1_o0: out std_logic_vector (43 downto 0);
			   s1_o1: out std_logic_vector (44 downto 1);
			   s1_o2: out std_logic_vector (46 downto 3);
			   s1_o3: out std_logic_vector (48 downto 5);
			   s1_o4: out std_logic_vector (50 downto 7);
			   s1_o5: out std_logic_vector (52 downto 9);
			   s1_o6: out std_logic_vector (54 downto 11);
			   s1_o7: out std_logic_vector (56 downto 13);
			   s1_o8: out std_logic_vector (58 downto 15);
			   s1_o9: out std_logic_vector (60 downto 17);
			   s1_o10: out std_logic_vector (62 downto 19);
			   s1_o11: out std_logic_vector (63 downto 21);
			   s1_o12: out std_logic_vector (63 downto 23)
		);
	end component;

	component DADDA_STAGE2 is 
	PORT (	stage2_in0 	: IN STD_LOGIC_VECTOR(43 DOWNTO 0);	
			stage2_in1 	: IN STD_LOGIC_VECTOR(44 DOWNTO 1);
			stage2_in2 	: IN STD_LOGIC_VECTOR(46 DOWNTO 3);
			stage2_in3 	: IN STD_LOGIC_VECTOR(48 DOWNTO 5);
			stage2_in4 	: IN STD_LOGIC_VECTOR(50 DOWNTO 7);
			stage2_in5 	: IN STD_LOGIC_VECTOR(52 DOWNTO 9);
			stage2_in6 	: IN STD_LOGIC_VECTOR(54 DOWNTO 11);
			stage2_in7 	: IN STD_LOGIC_VECTOR(56 DOWNTO 13);
			stage2_in8 	: IN STD_LOGIC_VECTOR(58 DOWNTO 15);
			stage2_in9 	: IN STD_LOGIC_VECTOR(60 DOWNTO 17);				
			stage2_in10 : IN STD_LOGIC_VECTOR(62 DOWNTO 19);
			stage2_in11 : IN STD_LOGIC_VECTOR(63 DOWNTO 21);
			stage2_in12 : IN STD_LOGIC_VECTOR(63 DOWNTO 23);
		
			stage2_out0 : OUT STD_LOGIC_VECTOR(51 DOWNTO 0);
			stage2_out1 : OUT STD_LOGIC_VECTOR(52 DOWNTO 1);
			stage2_out2 : OUT STD_LOGIC_VECTOR(54 DOWNTO 3);
			stage2_out3 : OUT STD_LOGIC_VECTOR(56 DOWNTO 5);
			stage2_out4 : OUT STD_LOGIC_VECTOR(58 DOWNTO 7);
			stage2_out5 : OUT STD_LOGIC_VECTOR(60 DOWNTO 9);
			stage2_out6 : OUT STD_LOGIC_VECTOR(62 DOWNTO 11);
			stage2_out7 : OUT STD_LOGIC_VECTOR(63 DOWNTO 13);
			stage2_out8 : OUT STD_LOGIC_VECTOR(63 DOWNTO 15));
	end component;

	component dadda_stage3 is
		port ( s2_o0: in std_logic_vector (51 downto 0);
			   s2_o1: in std_logic_vector (52 downto 1);
			   s2_o2: in std_logic_vector (54 downto 3);
			   s2_o3: in std_logic_vector (56 downto 5);
			   s2_o4: in std_logic_vector (58 downto 7);
			   s2_o5: in std_logic_vector (60 downto 9);
			   s2_o6: in std_logic_vector (62 downto 11);
			   s2_o7: in std_logic_vector (63 downto 13);
			   s2_o8: in std_logic_vector (63 downto 15);
			   
			   s3_o0: out std_logic_vector (57 downto 0);
			   s3_o1: out std_logic_vector (58 downto 1);
			   s3_o2: out std_logic_vector (60 downto 3);
			   s3_o3: out std_logic_vector (62 downto 5);
			   s3_o4: out std_logic_vector (63 downto 7);
			   s3_o5: out std_logic_vector (63 downto 9)
		);
	end component;

	component dadda_stage4 is
		port ( s3_o0: in std_logic_vector (57 downto 0);
			   s3_o1: in std_logic_vector (58 downto 1);
			   s3_o2: in std_logic_vector (60 downto 3);
			   s3_o3: in std_logic_vector (62 downto 5);
			   s3_o4: in std_logic_vector (63 downto 7);
			   s3_o5: in std_logic_vector (63 downto 9);
			   
			   s4_o0: out std_logic_vector (61 downto 0);
			   s4_o1: out std_logic_vector (62 downto 1);
			   s4_o2: out std_logic_vector (63 downto 3);
			   s4_o3: out std_logic_vector (63 downto 5)
		);
	end component;

	component dadda_stage5 is
		port ( s4_o0: in std_logic_vector (61 downto 0);
			   s4_o1: in std_logic_vector (62 downto 1);
			   s4_o2: in std_logic_vector (63 downto 3);
			   s4_o3: in std_logic_vector (63 downto 5);
			   
			   s5_o0: out std_logic_vector (63 downto 0);
			   s5_o1: out std_logic_vector (63 downto 1);
			   s5_o2: out std_logic_vector (63 downto 3)
		);
	end component;


	component dadda_stage6 is
		port ( s5_o0: in std_logic_vector (63 downto 0);
			   s5_o1: in std_logic_vector (63 downto 1);
			   s5_o2: in std_logic_vector (63 downto 3);
			   
			   s6_o0: out std_logic_vector (63 downto 1);
			   s6_o1: out std_logic_vector (63 downto 0)
		);
	end component;

signal s1_o0_int:  std_logic_vector (43 downto 0);
signal s1_o1_int:  std_logic_vector (44 downto 1);
signal s1_o2_int:  std_logic_vector (46 downto 3);
signal s1_o3_int:  std_logic_vector (48 downto 5);
signal s1_o4_int:  std_logic_vector (50 downto 7);
signal s1_o5_int:  std_logic_vector (52 downto 9);
signal s1_o6_int:  std_logic_vector (54 downto 11);
signal s1_o7_int:  std_logic_vector (56 downto 13);
signal s1_o8_int:  std_logic_vector (58 downto 15);
signal s1_o9_int:  std_logic_vector (60 downto 17);
signal s1_o10_int:  std_logic_vector (62 downto 19);
signal s1_o11_int:  std_logic_vector (63 downto 21);
signal s1_o12_int:  std_logic_vector (63 downto 23);

signal stage2_out0_int : STD_LOGIC_VECTOR(51 DOWNTO 0);
signal stage2_out1_int : STD_LOGIC_VECTOR(52 DOWNTO 1);
signal stage2_out2_int : STD_LOGIC_VECTOR(54 DOWNTO 3);
signal stage2_out3_int : STD_LOGIC_VECTOR(56 DOWNTO 5);
signal stage2_out4_int : STD_LOGIC_VECTOR(58 DOWNTO 7);
signal stage2_out5_int : STD_LOGIC_VECTOR(60 DOWNTO 9);
signal stage2_out6_int : STD_LOGIC_VECTOR(62 DOWNTO 11);
signal stage2_out7_int : STD_LOGIC_VECTOR(63 DOWNTO 13);
signal stage2_out8_int : STD_LOGIC_VECTOR(63 DOWNTO 15);

signal s3_o0_int:  std_logic_vector (57 downto 0);
signal s3_o1_int:  std_logic_vector (58 downto 1);
signal s3_o2_int:  std_logic_vector (60 downto 3);
signal s3_o3_int:  std_logic_vector (62 downto 5);
signal s3_o4_int:  std_logic_vector (63 downto 7);
signal s3_o5_int:  std_logic_vector (63 downto 9);

signal s4_o0_int: std_logic_vector (61 downto 0);
signal s4_o1_int: std_logic_vector (62 downto 1);
signal s4_o2_int: std_logic_vector (63 downto 3);
signal s4_o3_int: std_logic_vector (63 downto 5);
                                                

signal s5_o0_int : std_logic_vector (63 downto 0);
signal s5_o1_int : std_logic_vector (63 downto 1);
signal s5_o2_int : std_logic_vector (63 downto 3);


begin
stage1: dadda_stage1 
		port map ( pp_in 	=> dadda_in,
			   s1_o0 	=> s1_o0_int,
			   s1_o1 	=> s1_o1_int,
			   s1_o2 	=> s1_o2_int,
			   s1_o3 	=> s1_o3_int,
			   s1_o4 	=> s1_o4_int,
			   s1_o5 	=> s1_o5_int,
			   s1_o6	=> s1_o6_int,
			   s1_o7 	=> s1_o7_int,
			   s1_o8 	=> s1_o8_int,
			   s1_o9  	=> s1_o9_int,
			   s1_o10 	=> s1_o10_int,
			   s1_o11 	=> s1_o11_int,
			   s1_o12 	=> s1_o12_int
		);
	
	
stage2: DADDA_STAGE2  
	PORT map (	stage2_in0 	=> s1_o0_int,
				stage2_in1 	=> s1_o1_int,
				stage2_in2 	=> s1_o2_int,
				stage2_in3 	=> s1_o3_int,
				stage2_in4 	=> s1_o4_int,
				stage2_in5 	=> s1_o5_int,
				stage2_in6 	=> s1_o6_int,
				stage2_in7 	=> s1_o7_int,
				stage2_in8 	=> s1_o8_int,
				stage2_in9 	=> s1_o9_int,				
				stage2_in10 => s1_o10_int,
				stage2_in11 => s1_o11_int,
				stage2_in12 => s1_o12_int,
			
				stage2_out0 => stage2_out0_int,
				stage2_out1 => stage2_out1_int,
				stage2_out2 => stage2_out2_int,
				stage2_out3 => stage2_out3_int,
				stage2_out4 => stage2_out4_int,
				stage2_out5 => stage2_out5_int,
				stage2_out6 => stage2_out6_int,
				stage2_out7 => stage2_out7_int,
				stage2_out8 => stage2_out8_int);


	stage3: dadda_stage3 
		port map ( s2_o0 => stage2_out0_int,
				   s2_o1 => stage2_out1_int,
				   s2_o2 => stage2_out2_int,
				   s2_o3 => stage2_out3_int,
				   s2_o4 => stage2_out4_int,
				   s2_o5 => stage2_out5_int,
				   s2_o6 => stage2_out6_int,
				   s2_o7 => stage2_out7_int,
				   s2_o8 => stage2_out8_int,
				   
				   s3_o0 => s3_o0_int,
				   s3_o1 => s3_o1_int,
				   s3_o2 => s3_o2_int,
				   s3_o3 => s3_o3_int,
				   s3_o4 => s3_o4_int,
				   s3_o5 => s3_o5_int
		);                           


	stage4: dadda_stage4 
		port map ( s3_o0 => s3_o0_int,
				   s3_o1 => s3_o1_int,
				   s3_o2 => s3_o2_int,
				   s3_o3 => s3_o3_int,
				   s3_o4 => s3_o4_int,
				   s3_o5 => s3_o5_int,
				   
				   s4_o0 => s4_o0_int,
				   s4_o1 => s4_o1_int,
				   s4_o2 => s4_o2_int,
				   s4_o3 => s4_o3_int
		);                         

	stage5: dadda_stage5 
		port map( s4_o0 => s4_o0_int,
				   s4_o1 => s4_o1_int,
				   s4_o2 => s4_o2_int,
				   s4_o3 => s4_o3_int,
				   
				   s5_o0 => s5_o0_int,
				   s5_o1 => s5_o1_int,
				   s5_o2 => s5_o2_int
		);           


	stage6: dadda_stage6 
		port map ( s5_o0 => s5_o0_int,
				   s5_o1 => s5_o1_int,
				   s5_o2 => s5_o2_int,
				   
				   s6_o0 => dadda_out1,
				   s6_o1 => dadda_out2
		);
end architecture rtl;
