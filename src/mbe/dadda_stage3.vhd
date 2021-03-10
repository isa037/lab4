LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity dadda_stage3 is
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
end entity;

architecture behavioral of dadda_stage3 is

	type ha_outputs is array (9 downto 1) of std_logic_vector(1 downto 0);
	signal ha_out : ha_outputs;
	
	type fa_outputs is array (120 downto 1) of std_logic_vector (1 downto 0);
	signal fa_out : fa_outputs;

	component FA is
		port ( a, b, cin: in std_logic;
				cout, s: out std_logic
			);
	end component;
	
	component HA is
		port ( a, b: in std_logic;
				cout, s: out std_logic
			);
	end component;

begin
	
	HA_1_6: for I in 1 to 6 generate
	begin
		block1_HA: HA
			port map ( a=> s2_o0(9+I) , b=>s2_o1(9+I) , s=>ha_out(I)(0) , cout=>ha_out(I)(1) );
	end generate;

	FA_1_3: for I in 1 to 3 generate
	begin
		block1_FA: FA
			port map ( a=> s2_o2(11+I) , b=>s2_o3(11+I), cin=>s2_o4(11+I) , s=>fa_out(I)(0) , cout=>fa_out(I)(1) );
	end generate;
	
	FA_4: FA
		port map (a=> s2_o5(14), b=>s2_o6(14), cin=>s2_o7(14), s=>fa_out(4)(0), cout=>fa_out(4)(1));
	
	FA_5: FA
		port map (a=> s2_o2(15), b=>s2_o3(15), cin=>s2_o4(15), s=>fa_out(5)(0), cout=>fa_out(5)(1));
		
	FA_6: FA
		port map (a=> s2_o5(15), b=>s2_o6(15), cin=>s2_o7(15), s=>fa_out(6)(0), cout=>fa_out(6)(1));
	
	FA_7_112: for I in 0 to 35 generate
	begin
		block2_FA: FA
			port map ( a=> s2_o0(16+I) , b=>s2_o1(16+I), cin=>s2_o2(16+I) , s=>fa_out(7+3*I)(0) , cout=>fa_out(7+3*I)(1) );	
	end generate;

	FA_8_113: for I in 0 to 35 generate
	begin
		block3_FA: FA
			port map ( a=> s2_o3(16+I) , b=>s2_o4(16+I), cin=>s2_o5(16+I) , s=>fa_out(8+3*I)(0) , cout=>fa_out(8+3*I)(1) );	
	end generate;

	FA_9_114: for I in 0 to 35 generate
		begin
			block2_FA: FA
			port map ( a=> s2_o6(16+I) , b=>s2_o7(16+I), cin=>s2_o8(16+I) , s=>fa_out(9+3*I)(0) , cout=>fa_out(9+3*I)(1) );	
	end generate;

	FA_115: FA
		port map (a=> s2_o3(52), b=>s2_o4(52), cin=>s2_o5(52), s=>fa_out(115)(0), cout=>fa_out(115)(1));
	
	FA_116: FA
		port map (a=> s2_o6(52), b=>s2_o7(52), cin=>s2_o8(52), s=>fa_out(116)(0), cout=>fa_out(116)(1));

	FA_117: FA
		port map (a=> s2_o2(53), b=>s2_o3(53), cin=>s2_o4(53), s=>fa_out(117)(0), cout=>fa_out(117)(1));
		
	FA_118: FA
		port map (a=> s2_o5(53), b=>s2_o6(53), cin=>s2_o7(53), s=>fa_out(118)(0), cout=>fa_out(118)(1));
	
	FA_119: FA
		port map (a=> s2_o4(54), b=>s2_o5(54), cin=>s2_o6(54), s=>fa_out(119)(0), cout=>fa_out(119)(1));
	
	FA_120: FA
		port map (a=> s2_o3(55), b=>s2_o4(55), cin=>s2_o5(55), s=>fa_out(120)(0), cout=>fa_out(120)(1));
	
	HA_7: HA
		port map(a=>s2_o1(52), b=>s2_o2(52), s=>ha_out(7)(0), cout=>ha_out(7)(1));
	
	HA_8: HA
		port map(a=>s2_o2(54), b=>s2_o3(54), s=>ha_out(8)(0), cout=>ha_out(8)(1));
	
	HA_9: HA
		port map (a=> s2_o3(56), b=>s2_o4(56),  s=>ha_out(9)(0), cout=>ha_out(9)(1));
	
	--OUTPUT GENERATION
		--OUTPUT 0
	s3_o0(9 downto 0)<=s2_o0(9 downto 0);
	s3_o0(11 downto 10)<=ha_out(1);
	s3_o0(13 downto 12)<=ha_out(3);
	s3_o0(15 downto 14)<=ha_out(5);
	output0_fa: for I in 0 to 18 generate
	begin
		s3_o0(17+2*I downto 16+2*I)<=fa_out(7+6*I);
	end generate;
	s3_o0(55 downto 54)<=ha_out(8);
	s3_o0(57 downto 56)<=ha_out(9);
	
	--OUTPUT 1
	s3_o1(9 downto 1)<=s2_o1(9 downto 1);
	s3_o1(10)<=s2_o3(10);
	output1_ha: for I in 0 to 2 generate
	begin
		s3_o1(12+2*I downto 11+2*I)<=ha_out(2+2*I);
	end generate;
	output1_fa: for I in 0 to 17 generate
	begin
		s3_o1(18+2*I downto 17+2*I)<=fa_out(10+6*I);
	end generate;
	s3_o1(54 downto 53)<=fa_out(117);
	s3_o1(56 downto 55)<=fa_out(120);
	s3_o1(58 downto 57)<=s2_o4(58 downto 57);
	
	--OUTPUT 2
	s3_o2(11 downto 3)<=s2_o2(11 downto 3);
	s3_o2(13 downto 12)<=fa_out(1);
	s3_o2(15 downto 14)<=fa_out(3);
	output2_fa: for I in 0 to 18 generate
	begin
		s3_o2(17+2*I downto 16+2*I)<=fa_out(8+6*I);
	end generate;
	s3_o2(55 downto 54)<=fa_out(119);
	s3_o2(60 downto 56)<=s2_o5(60 downto 56);
	
	--OUTPUT 3
	s3_o3(9 downto 5)<=s2_o3(9 downto 5);
	s3_o3(10)<=s2_o4(10);
	s3_o3(11)<=s2_o3(11);
	s3_o3(12)<=s2_o5(12);
	s3_o3(14 downto 13)<=fa_out(2);
	s3_o3(16 downto 15)<=fa_out(5);
	output3_fa: for I in 0 to 17 generate
	begin
		s3_o3(18+2*I downto 17+2*I)<=fa_out(11+6*I);
	end generate;
	s3_o3(54 downto 53)<=fa_out(118);
	s3_o3(62 downto 55)<=s2_o6(62 downto 55);

	--OUTPUT 4
	s3_o4(9 downto 7)<=s2_o4(9 downto 7);
	s3_o4(10)<=s2_o5(10);
	s3_o4(11)<=s2_o4(11);
	s3_o4(12)<=s2_o6(12);
	s3_o4(13)<=s2_o5(13);
	s3_o4(15 downto 14)<=fa_out(4);
	output4_fa: for I in 0 to 17 generate
	begin
		s3_o4(17+2*I downto 16+2*I)<=fa_out(9+6*I);
	end generate;
	s3_o4(53 downto 52)<=ha_out(7);
	s3_o4(63 downto 54)<=s2_o7(63 downto 54);
	
	--OUTPUT 5
	s3_o5(9)<=s2_o5(9);
	s3_o5(10)<=s2_o6(11);
	s3_o5(11)<=s2_o5(11);
	s3_o5(12)<=s2_o7(13);
	s3_o5(13)<=s2_o6(13);
	s3_o5(14)<=s2_o8(15);
	output5_fa: for I in 0 to 18 generate
	begin
		s3_o5(16+2*I downto 15+2*I)<=fa_out(6+6*I);
	end generate;
	s3_o5(63 downto 53)<=s2_o8(63 downto 53);
end architecture;