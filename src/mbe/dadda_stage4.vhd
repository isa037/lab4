LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

--library work;
--use work.pkg.all;

entity dadda_stage4 is
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
end entity;

architecture behavioral of dadda_stage4 is

	type ha_outputs is array (6 downto 1) of std_logic_vector(1 downto 0);
	signal ha_out : ha_outputs;
	
	type fa_outputs is array (100 downto 1) of std_logic_vector (1 downto 0);
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
	
	HA_1_4: for I in 1 to 4 generate
	begin
		block1_ha: HA
			port map ( a=> s3_o0(5+I) , b=>s3_o1(5+I) , s=>ha_out(I)(0) , cout=>ha_out(I)(1) );
	end generate;

	FA_1_2: for I in 1 to 2 generate
	begin
		block1_FA: FA
			port map ( a=> s3_o2(7+I) , b=>s3_o3(7+I), cin=>s3_o4(7+I) , s=>fa_out(I)(0) , cout=>fa_out(I)(1) );
	end generate;
	
	FA_3_97: for I in 0 to 47 generate
	begin
		block2_FA: FA
			port map ( a=> s3_o0(10+I) , b=>s3_o1(10+I), cin=>s3_o2(10+I) , s=>fa_out(3+2*I)(0) , cout=>fa_out(3+2*I)(1) );	
	end generate;

	FA_4_98: for I in 0 to 47 generate
	begin
		block3_FA: FA
			port map ( a=> s3_o3(10+I) , b=>s3_o4(10+I), cin=>s3_o5(10+I) , s=>fa_out(4+2*I)(0) , cout=>fa_out(4+2*I)(1) );	
	end generate;

	FA_99: FA
		port map (a=> s3_o3(58), b=>s3_o4(58), cin=>s3_o5(58), s=>fa_out(99)(0), cout=>fa_out(99)(1));
	
	FA_100: FA
		port map (a=> s3_o2(59), b=>s3_o3(59), cin=>s3_o4(59), s=>fa_out(100)(0), cout=>fa_out(100)(1));

	HA_5: HA
		port map(a=>s3_o1(58), b=>s3_o2(58), s=>ha_out(5)(0), cout=>ha_out(5)(1));
	
	HA_6: HA
		port map(a=>s3_o2(60), b=>s3_o3(60), s=>ha_out(6)(0), cout=>ha_out(6)(1));
	

	--OUTPUT GENERATION
	
	--OUTPUT 0
	s4_o0(5 downto 0)<=s3_o0(5 downto 0);
	s4_o0(7 downto 6)<=ha_out(1);
	s4_o0(9 downto 8)<=ha_out(3);
	output0_fa: for I in 0 to 24 generate
	begin
		s4_o0(11+2*I downto 10+2*I)<=fa_out(3+4*I);
	end generate;
	s4_o0(61 downto 60)<=ha_out(6);
	
	--OUTPUT 1
	s4_o1(5 downto 1)<=s3_o1(5 downto 1);
	s4_o1(6)<=s3_o3(6);
	s4_o1(8 downto 7)<=ha_out(2);
	s4_o1(10 downto 9)<=ha_out(4);
	output1_fa: for I in 0 to 23 generate
	begin
		s4_o1(12+2*I downto 11+2*I)<=fa_out(5+4*I);
	end generate;
	s4_o1(60 downto 59)<=fa_out(100);
	s4_o1(62 downto 61)<=s3_o3(62 downto 61);
	
	--OUTPUT 2
	s4_o2(7 downto 3)<=s3_o2(7 downto 3);
	s4_o2(9 downto 8)<=fa_out(1);
	output2_fa: for I in 0 to 23 generate
	begin
		s4_o2(11+2*I downto 10+2*I)<=fa_out(4+4*I);
	end generate;
	s4_o2(59 downto 58)<=ha_out(5);
	s4_o2(63 downto 60)<=s3_o4(63 downto 60);
	
	--OUTPUT 3
	s4_o3(5)<=s3_o3(5);
	s4_o3(6)<=s3_o4(7);
	s4_o3(7)<=s3_o3(7);
	s4_o3(8)<=s3_o5(9);
	output3_fa: for I in 0 to 24 generate
	begin
		s4_o3(10+2*I downto 9+2*I)<=fa_out(2+4*I);
	end generate;
	s4_o3(63 downto 59)<=s3_o5(63 downto 59);



end architecture;