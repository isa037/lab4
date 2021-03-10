LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY DADDA_STAGE2 IS 
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
END ENTITY;

ARCHITECTURE STRUCT OF DADDA_STAGE2 IS 

-- COMPONENT DECLARATIONS
COMPONENT FA IS 
	port ( a, b, cin: in std_logic;
				cout, s: out std_logic
			);
END COMPONENT;
		
COMPONENT HA IS
	port ( a, b: in std_logic;
				cout, s: out std_logic
			);
END COMPONENT;

BEGIN
HA_1 : HA port map( 	a	=>stage2_in0(16),b	=>stage2_in1(16),cout=>stage2_out0(17),s	=>stage2_out0(16));
HA_2 : HA port map( 	a	=>stage2_in0(17),b	=>stage2_in1(17),cout=>stage2_out0(18),s	=>stage2_out1(17));
			
-- LINE 1 OF FA --------------------------------------------------
	LINE1_FA_GENERATION: 
	   for I in 18 to 43 generate
		  INTERNAL_FA : FA port map( 	a	=>stage2_in0(I),b	=>stage2_in1(I),cin	=>stage2_in2(I),cout=>stage2_out0(I+1),	s	=>stage2_out1(I));
	   end generate;
-----------------------------------------------------------------

HA_3 : HA port map( 	a	=>stage2_in3(18),b	=>stage2_in4(18),cout=>stage2_out2(19),	s	=>stage2_out2(18));	 
HA_4 : HA port map( 	a	=>stage2_in3(19),b	=>stage2_in4(19),cout=>stage2_out2(20),	s	=>stage2_out3(19));	   
-- LINE 2 OF FA --------------------------------------------------
	LINE2_FA_GENERATION: 
	   for I in 20 to 43 generate
		  INTERNAL_FA : FA port map	( 	a	=>stage2_in3(I),b	=>stage2_in4(I),cin	=>stage2_in5(I),cout=>stage2_out2(I+1),	s	=>stage2_out3(I)
				);
	   end generate;
	   
HA_5 : HA port map( 	a	=>stage2_in6(20),b	=>stage2_in7(20),cout=>stage2_out4(21),	s	=>stage2_out4(20));	 
HA_6 : HA port map( 	a	=>stage2_in6(21),b	=>stage2_in7(21),cout=>stage2_out4(22),	s	=>stage2_out5(21));	   	   
-- LINE 3 OF FA --------------------------------------------------
	LINE3_FA_GENERATION: 
	   for I in 22 to 43 generate
		  INTERNAL_FA : FA port map( 	a	=>stage2_in6(I),b	=>stage2_in7(I),cin	=>stage2_in8(I),cout=>stage2_out4(I+1),	s	=>stage2_out5(I));
	   end generate;
	   
HA_7 : HA port map( 	a	=>stage2_in9(22),b	=>stage2_in10(22),cout=>stage2_out6(23),	s	=>stage2_out6(22));	 
HA_8 : HA port map( 	a	=>stage2_in9(23),b	=>stage2_in10(23),cout=>stage2_out6(24),	s	=>stage2_out7(23));	   	    
-- LINE 4 OF FA --------------------------------------------------
	LINE4_FA_GENERATION: 
	   for I in 24 to 43 generate
		  INTERNAL_FA : FA port map( 	a	=>stage2_in9(I),b	=>stage2_in10(I),cin	=>stage2_in11(I),cout=>stage2_out6(I+1),s	=>stage2_out7(I));
	   end generate;
------------------------------------------------------------------

last_assegnation:for I in 24 to 43 generate
	stage2_out8(I)<=stage2_in12(I);
end generate last_assegnation;

--initial assignements
stage2_out0(15 downto 0)  <= stage2_in0(15 downto 0);
stage2_out1(16 downto 1)  <=stage2_in9(17) & stage2_in1(15 downto 1);
stage2_out2(17 downto 3)  <= stage2_in2(17 downto 3);
stage2_out3(17 downto 5)  <= stage2_in3(17 downto 5);
stage2_out4(17 downto 7)  <= stage2_in4(17 downto 7);
stage2_out5(19 downto 9)  <= stage2_in5(19 downto 9);
stage2_out6(19 downto 11) <= stage2_in6(19 downto 11);
stage2_out7(19 downto 13) <= stage2_in7(19 downto 13);
stage2_out8(21 downto 15) <= stage2_in8(21 downto 15);

stage2_out3(18) <= stage2_in9(18);
stage2_out4(18) <= stage2_in10(19);

stage2_out4(19) <= stage2_in9(19);

stage2_out5(20) <= stage2_in9(20);
stage2_out6(20) <= stage2_in10(20);
stage2_out7(20) <= stage2_in11(21);

stage2_out6(21) <= stage2_in9(21);
stage2_out7(21) <= stage2_in10(21);


stage2_out7(22) <= stage2_in11(22);
stage2_out8(22) <= stage2_in12(23);

stage2_out8(23) <= stage2_in11(23);


	   
-- LINE 4 OF FA --------------------------------------------------
FA44_1 : FA port map ( 	a	=>stage2_in1(44),b	=>stage2_in2(44),cin	=>stage2_in3(44),cout=>stage2_out0(45),s	=>stage2_out1(44));
FA44_2 : FA port map ( 	a	=>stage2_in4(44),b	=>stage2_in5(44),cin	=>stage2_in6(44),cout=>stage2_out1(45),s	=>stage2_out3(44));
FA44_3 : FA port map ( 	a	=>stage2_in7(44),b	=>stage2_in8(44),cin	=>stage2_in9(44),cout=>stage2_out2(45),s	=>stage2_out5(44));
HA_44 : HA port map	( 	a	=>stage2_in10(44),b	=>stage2_in11(44),						 cout=>stage2_out3(45),s	=>stage2_out7(44));
stage2_out8(44) <=stage2_in12(44);

FA45_1 : FA port map ( 	a	=>stage2_in2(45),b	=>stage2_in3(45),cin	=>stage2_in4(45),cout=>stage2_out0(46),s	=>stage2_out4(45));
FA45_2 : FA port map ( 	a	=>stage2_in5(45),b	=>stage2_in6(45),cin	=>stage2_in7(45),cout=>stage2_out1(46),s	=>stage2_out5(45));
FA45_3 : FA port map ( 	a	=>stage2_in8(45),b	=>stage2_in9(45),cin	=>stage2_in10(45),cout=>stage2_out2(46),s	=>stage2_out6(45));
stage2_out7(45) <=stage2_in11(45);
stage2_out8(45) <=stage2_in12(45);

FA46_1 : FA port map ( 	a	=>stage2_in2(46),b	=>stage2_in3(46),cin	=>stage2_in4(46),cout=>stage2_out0(47),s	=>stage2_out3(46));
FA46_2 : FA port map ( 	a	=>stage2_in5(46),b	=>stage2_in6(46),cin	=>stage2_in7(46),cout=>stage2_out1(47),s	=>stage2_out4(46));
HA_46 : HA port map	( 	a	=>stage2_in8(46),b	=>stage2_in9(46),						 cout=>stage2_out2(47),s	=>stage2_out5(46));
stage2_out6(46) <=stage2_in10(46);
stage2_out7(46) <=stage2_in11(46);
stage2_out8(46) <=stage2_in12(46);

FA47_1 : FA port map ( 	a	=>stage2_in3(47),b	=>stage2_in4(47),cin	=>stage2_in5(47),cout=>stage2_out0(48),s	=>stage2_out3(47));
FA47_2 : FA port map ( 	a	=>stage2_in6(47),b	=>stage2_in7(47),cin	=>stage2_in8(47),cout=>stage2_out1(48),s	=>stage2_out4(47));
stage2_out5(47) <=stage2_in9(47);
stage2_out6(47) <=stage2_in10(47);
stage2_out7(47) <=stage2_in11(47);
stage2_out8(47) <=stage2_in12(47);

FA48_1 : FA port map ( 	a	=>stage2_in3(48),b	=>stage2_in4(48),cin	=>stage2_in5(48),cout=>stage2_out0(49),s	=>stage2_out2(48));
HA_48 : HA port map	( 	a	=>stage2_in6(48),b	=>stage2_in7(48),						 cout=>stage2_out1(49),s	=>stage2_out3(48));
stage2_out4(48) <=stage2_in8(48);
stage2_out5(48) <=stage2_in9(48);
stage2_out6(48) <=stage2_in10(48);
stage2_out7(48) <=stage2_in11(48);
stage2_out8(48) <=stage2_in12(48);


FA49_1 : FA port map ( 	a	=>stage2_in4(49),b	=>stage2_in5(49),cin	=>stage2_in6(49),cout=>stage2_out0(50),s	=>stage2_out2(49));
stage2_out3(49) <=stage2_in7(49);
stage2_out4(49) <=stage2_in8(49);
stage2_out5(49) <=stage2_in9(49);
stage2_out6(49) <=stage2_in10(49);
stage2_out7(49) <=stage2_in11(49);
stage2_out8(49) <=stage2_in12(49);

HA_50 : HA port map	( 	a	=>stage2_in4(50),b	=>stage2_in5(50),						 cout=>stage2_out0(51),s	=>stage2_out1(50));
stage2_out2(50) <=stage2_in6(50);
stage2_out3(50) <=stage2_in7(50);
stage2_out4(50) <=stage2_in8(50);
stage2_out5(50) <=stage2_in9(50);
stage2_out6(50) <=stage2_in10(50);
stage2_out7(50) <=stage2_in11(50);
stage2_out8(50) <=stage2_in12(50);

stage2_out1(52 downto 51) <=stage2_in5(52 downto 51);
stage2_out2(54 downto 51) <= stage2_in6(54 downto 51);
stage2_out3(56 downto 51) <= stage2_in7(56 downto 51);
stage2_out4(58 downto 51) <= stage2_in8(58 downto 51);
stage2_out5(60 downto 51) <= stage2_in9(60 downto 51);
stage2_out6(62 downto 51) <= stage2_in10(62 downto 51);
stage2_out7(63 downto 51) <=stage2_in11(63 downto 51);
stage2_out8(63 downto 51) <= stage2_in12(63 downto 51);


END STRUCT;
