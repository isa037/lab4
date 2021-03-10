LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

library work;
use work.my_pkg.all;

entity dadda_stage1 is
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
end entity;

architecture behavioral of dadda_stage1 is
	
	type ha_outputs is array (12 downto 1) of std_logic_vector(1 downto 0);
	signal ha_out : ha_outputs;
	
	type fa_outputs is array (40 downto 1) of std_logic_vector (1 downto 0);
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
	
	HA_1_8: for I in 1 to 8 generate
	begin
		block1_ha: HA
			port map ( a=> pp_in(0)(23+I) , b=>pp_in(1)(22+I) , s=>ha_out(I)(0) , cout=>ha_out(I)(1) );
	end generate;
	
	FA_1_2: for I in 1 to 2 generate
	begin
		block1_fa: FA
			port map (a=> pp_in(2)(22+I) , b=> pp_in(3)(20+I) , cin=> pp_in(4)(18+I) , s=> fa_out(I)(0), cout=> fa_out(I)(1)  );
	end generate;

	FA_3_6: for I in 0 to 3 generate
	begin
		FA_3_4: if I<2 generate	--colonna 1
		begin
			block2_fa: FA
			port map (a=> pp_in(2+3*(I mod 2))(25-6*I) , b=> pp_in(3+3*(I mod 2))(23-6*I) ,
			cin=> pp_in(4+3*(I mod 2))(21-6*I) , s=> fa_out(I+3)(0), cout=> fa_out(I+3)(1)  );
		end generate;
		
		FA_5_6: if I>1 generate --colonna 2
		begin
			block2_fa: FA
			port map (a=> pp_in(2+3*(I mod 2))(26-6*(I mod 2)) , b=> pp_in(3+3*(I mod 2))(24-6*(I mod 2)) ,
			cin=> pp_in(4+3*(I mod 2))(22-6*(I mod 2)) , s=> fa_out(I+3)(0), cout=> fa_out(I+3)(1)  );
		end generate;

	end generate;
	
	FA_7_12: for I in 0 to 5 generate
	begin
		FA_7_9: if I<3 generate
		begin
			block3_fa: FA
			port map (a=> pp_in(2+3*(I mod 3))(27-6*I) , b=> pp_in(3+3*(I mod 3))(25-6*I) ,
			cin=> pp_in(4+3*(I mod 3))(23-6*I) , s=> fa_out(I+7)(0), cout=> fa_out(I+7)(1)  );
		end generate;
		
		FA_10_12: if I>2 generate
		begin
			block3_fa: FA
			port map (a=> pp_in(2+3*(I mod 3))(28-6*(I mod 3)) , b=> pp_in(3+3*(I mod 3))(26-6*(I mod 3)) ,
			cin=> pp_in(4+3*(I mod 3))(24-6*(I mod 3)) , s=> fa_out(I+7)(0), cout=> fa_out(I+7)(1)  );
		end generate;
	end generate;
	
	FA_13_25_part_case: for I in 0 to 3 generate --caso particolare 13_17_21_25
		block4_fa: FA
		port map ( a=> pp_in(0)(32+I), b=> pp_in(1)(31+I), cin=> pp_in(2)(29+I), s=> fa_out(13+4*I)(0), cout=> fa_out(13+4*I)(1)  );
	end generate;
	
	FA_14_28: for I in 0 to 11 generate
	begin
		FA_14_16: if I<3 generate
		begin
			block5_fa: FA
			port map (a=> pp_in(3+3*(I mod 3))(27-6*I) , b=> pp_in(4+3*(I mod 3))(25-6*I) ,
			cin=> pp_in(5+3*(I mod 3))(23-6*I) , s=> fa_out(I+14)(0), cout=> fa_out(I+14)(1)  );
		end generate;

		FA_18_20: if I>2 and I<6 generate
		begin
			block5_fa: FA
			port map (a=> pp_in(3+3*(I mod 3))(28-6*(I mod 3)) , b=> pp_in(4+3*(I mod 3))(26-6*(I mod 3)) ,
			cin=> pp_in(5+3*(I mod 3))(24-6*(I mod 3)) , s=> fa_out(I+15)(0), cout=> fa_out(I+15)(1)  );
		end generate;
		
		FA_22_24: if I>5 and I<9 generate
		begin
			block5_fa: FA
			port map (a=> pp_in(3+3*(I mod 3))(29-6*(I mod 3)) , b=> pp_in(4+3*(I mod 3))(27-6*(I mod 3)) ,
			cin=> pp_in(5+3*(I mod 3))(25-6*(I mod 3)) , s=> fa_out(I+16)(0), cout=> fa_out(I+16)(1)  );
		end generate;
		
		FA_26_28: if I>8 generate
		begin
			block5_fa: FA
			port map (a=> pp_in(3+3*(I mod 3))(30-6*(I mod 3)) , b=> pp_in(4+3*(I mod 3))(28-6*(I mod 3)) ,
			cin=> pp_in(5+3*(I mod 3))(26-6*(I mod 3)) , s=> fa_out(I+17)(0), cout=> fa_out(I+17)(1)  );
		end generate;
	
	end generate;

	FA_29_31: for I in 0 to 2 generate
	begin
			block6_fa: FA
			port map (a=> pp_in(3+3*I)(31-6*I) , b=> pp_in(4+3*I)(29-6*I) ,
			cin=> pp_in(5+3*I)(27-6*I) , s=> fa_out(I+29)(0), cout=> fa_out(I+29)(1)  );
	end generate;
	
	FA_32_34: for I in 0 to 2 generate
	begin
			block7_fa: FA
			port map (a=> pp_in(2+3*I)(34-6*I) , b=> pp_in(3+3*I)(32-6*I) ,
			cin=> pp_in(4+3*I)(30-6*I) , s=> fa_out(I+32)(0), cout=> fa_out(I+32)(1)  );
	end generate;
	
	FA_35_36: for I in 0 to 1 generate
	begin
			block8_fa: FA
			port map (a=> pp_in(4+3*I)(31-6*I) , b=> pp_in(5+3*I)(29-6*I) ,
			cin=> pp_in(6+3*I)(27-6*I) , s=> fa_out(I+35)(0), cout=> fa_out(I+35)(1)  );
	end generate;
	
	FA_37_38: for I in 0 to 1 generate
	begin
			block9_fa: FA
			port map (a=> pp_in(3+3*I)(34-6*I) , b=> pp_in(4+3*I)(32-6*I) ,
			cin=> pp_in(5+3*I)(30-6*I) , s=> fa_out(I+37)(0), cout=> fa_out(I+37)(1)  );
	end generate;
	
	FA_39: FA
		port map(a=> pp_in(5)(31), b=>pp_in(6)(29), cin=>pp_in(7)(27), s=> fa_out(39)(0), cout=> fa_out(39)(1));
	
	FA_40: FA
		port map(a=> pp_in(4)(34), b=>pp_in(5)(32), cin=>pp_in(6)(30), s=> fa_out(40)(0), cout=> fa_out(40)(1));
	
	HA_9_12: for I in 0 to 3 generate
	begin
		block2_ha: HA
			port map ( a=> pp_in(1+I)(35) , b=>pp_in(2+I)(33) , s=>ha_out(I+9)(0) , cout=>ha_out(I+9)(1) );
	end generate;
	
	--ASSEGNAZIONE USCITE
	
	s1_o0(23 downto 0)<=pp_in(0)(23 downto 0);
	s1_o0(25 downto 24)<=ha_out(1);
	s1_o0(26)<=pp_in(5)(17);
	s1_o0(28 downto 27)<=ha_out(4);
	s1_o0(30 downto 29)<=ha_out(6);
	s1_o0(32 downto 31)<=ha_out(8);
	s1_o0(34 downto 33)<=fa_out(17);
	s1_o0(36 downto 35)<=fa_out(25);
	s1_o0(38 downto 37)<=fa_out(32);
	s1_o0(40 downto 39)<=fa_out(37);
	s1_o0(42 downto 41)<=fa_out(40);
	s1_o0(43)<=pp_in(5)(34);
	
	s1_o1(23 downto 1)<=pp_in(1)(22 downto 0);
	s1_o1(24)<=pp_in(2)(21);
	s1_o1(26 downto 25)<=ha_out(2);
	s1_o1(28 downto 27)<=fa_out(2);
	s1_o1(30 downto 29)<=fa_out(5);
	s1_o1(32 downto 31)<=fa_out(10);
	s1_o1(34 downto 33)<=fa_out(18);
	s1_o1(36 downto 35)<=fa_out(26);
	s1_o1(38 downto 37)<=fa_out(33);
	s1_o1(40 downto 39)<=fa_out(38);
	s1_o1(41)<=pp_in(7)(28);
	s1_o1(43 downto 42)<=ha_out(12);
	s1_o1(44)<=pp_in(5)(35);
	
	s1_o2(23 downto 3)<=pp_in(2)(20 downto 0);
	s1_o2(24)<=pp_in(3)(19);
	s1_o2(25)<=pp_in(2)(22);
	s1_o2(27 downto 26)<=ha_out(3);
	s1_o2(29 downto 28)<=ha_out(5);
	s1_o2(31 downto 30)<=ha_out(7);
	s1_o2(33 downto 32)<=fa_out(13);
	s1_o2(35 downto 34)<=fa_out(21);
	s1_o2(37 downto 36)<=ha_out(9);
	s1_o2(39 downto 38)<=ha_out(10);
	s1_o2(41 downto 40)<=ha_out(11);
	s1_o2(46 downto 42)<=pp_in(6)(35 downto 31);
	
	s1_o3(23 downto 5)<=pp_in(3)(18 downto 0);
	s1_o3(24)<=pp_in(4)(17);
	s1_o3(25)<=pp_in(3)(20);
	s1_o3(27 downto 26)<=fa_out(1);
	s1_o3(29 downto 28)<=fa_out(3);
	s1_o3(31 downto 30)<=fa_out(7);
	s1_o3(33 downto 32)<=fa_out(14);
	s1_o3(35 downto 34)<=fa_out(22);
	s1_o3(37 downto 36)<=fa_out(29);
	s1_o3(39 downto 38)<=fa_out(35);
	s1_o3(41 downto 40)<=fa_out(39);
	s1_o3(48 downto 42)<=pp_in(7)(35 downto 29);
	
	s1_o4(23 downto 7)<=pp_in(4)(16 downto 0);
	s1_o4(24)<=pp_in(5)(15);
	s1_o4(25)<=pp_in(4)(18);
	s1_o4(26)<=pp_in(6)(15);
	s1_o4(27)<=pp_in(5)(18);
	s1_o4(29 downto 28)<=fa_out(4);
	s1_o4(31 downto 30)<=fa_out(8);
	s1_o4(33 downto 32)<=fa_out(15);
	s1_o4(35 downto 34)<=fa_out(23);
	s1_o4(37 downto 36)<=fa_out(30);
	s1_o4(39 downto 38)<=fa_out(36);
	s1_o4(50 downto 40)<=pp_in(8)(35 downto 25);
	
	s1_o5(23 downto 9)<=pp_in(5)(14 downto 0);
	s1_o5(24)<=pp_in(6)(13);
	s1_o5(25)<=pp_in(5)(16);
	s1_o5(26)<=pp_in(7)(13);
	s1_o5(27)<=pp_in(6)(16);
	s1_o5(28)<=pp_in(8)(13);
	s1_o5(30 downto 29)<=fa_out(6);
	s1_o5(32 downto 31)<=fa_out(11);
	s1_o5(34 downto 33)<=fa_out(19);
	s1_o5(36 downto 35)<=fa_out(27);
	s1_o5(38 downto 37)<=fa_out(34);
	s1_o5(52 downto 39)<=pp_in(9)(35 downto 22);
	
	s1_o6(23 downto 11)<=pp_in(6)(12 downto 0);
	s1_o6(24)<=pp_in(7)(11);
	s1_o6(25)<=pp_in(6)(14);
	s1_o6(26)<=pp_in(8)(11);
	s1_o6(27)<=pp_in(7)(14);
	s1_o6(28)<=pp_in(9)(11);
	s1_o6(29)<=pp_in(8)(14);
	s1_o6(31 downto 30)<=fa_out(9);
	s1_o6(33 downto 32)<=fa_out(16);
	s1_o6(35 downto 34)<=fa_out(24);
	s1_o6(37 downto 36)<=fa_out(31);
	s1_o6(54 downto 38)<=pp_in(10)(35 downto 19);
	
	s1_o7(23 downto 13)<=pp_in(7)(10 downto 0);
	s1_o7(24)<=pp_in(8)(9);
	s1_o7(25)<=pp_in(7)(12);
	s1_o7(26)<=pp_in(9)(9);
	s1_o7(27)<=pp_in(8)(12);
	s1_o7(28)<=pp_in(10)(9);
	s1_o7(29)<=pp_in(9)(12);
	s1_o7(30)<=pp_in(11)(9);
	s1_o7(32 downto 31)<=fa_out(12);
	s1_o7(34 downto 33)<=fa_out(20);
	s1_o7(36 downto 35)<=fa_out(28);
	s1_o7(56 downto 37)<=pp_in(11)(35 downto 16);
	
	s1_o8(23 downto 15)<=pp_in(8)(8 downto 0);
	s1_o8(24)<=pp_in(9)(7);
	s1_o8(25)<=pp_in(8)(10);
	s1_o8(26)<=pp_in(10)(7);
	s1_o8(27)<=pp_in(9)(10);
	s1_o8(28)<=pp_in(11)(7);
	s1_o8(29)<=pp_in(10)(10);
	s1_o8(30)<=pp_in(12)(7);
	s1_o8(31)<=pp_in(11)(10);
	s1_o8(58 downto 32)<=pp_in(12)(35 downto 9);
	
	s1_o9(23 downto 17)<=pp_in(9)(6 downto 0);
	s1_o9(24)<=pp_in(10)(5);
	s1_o9(25)<=pp_in(9)(8);
	s1_o9(26)<=pp_in(11)(5);
	s1_o9(27)<=pp_in(10)(8);
	s1_o9(28)<=pp_in(12)(5);
	s1_o9(29)<=pp_in(11)(8);
	s1_o9(30)<=pp_in(13)(5);
	s1_o9(31)<=pp_in(12)(8);
	s1_o9(60 downto 32)<=pp_in(13)(35 downto 7);
	
	s1_o10(23 downto 19)<=pp_in(10)(4 downto 0);
	s1_o10(24)<=pp_in(11)(3);
	s1_o10(25)<=pp_in(10)(6);
	s1_o10(26)<=pp_in(12)(3);
	s1_o10(27)<=pp_in(11)(6);
	s1_o10(28)<=pp_in(13)(3);
	s1_o10(29)<=pp_in(12)(6);
	s1_o10(30)<=pp_in(14)(3);
	s1_o10(31)<=pp_in(13)(6);
	s1_o10(62 downto 32)<=pp_in(14)(35 downto 5);
	
	s1_o11(23 downto 21)<=pp_in(11)(2 downto 0);
	s1_o11(24)<=pp_in(12)(1);
	s1_o11(25)<=pp_in(11)(4);
	s1_o11(26)<=pp_in(13)(1);
	s1_o11(27)<=pp_in(12)(4);
	s1_o11(28)<=pp_in(14)(1);
	s1_o11(29)<=pp_in(13)(4);
	s1_o11(30)<=pp_in(15)(1);
	s1_o11(31)<=pp_in(14)(4);
	s1_o11(63 downto 32)<=pp_in(15)(34 downto 3);
	
	s1_o12(23)<=pp_in(12)(0);
	s1_o12(24)<=pp_in(13)(0);
	s1_o12(25)<=pp_in(12)(2);
	s1_o12(26)<=pp_in(14)(0);
	s1_o12(27)<=pp_in(13)(2);
	s1_o12(28)<=pp_in(15)(0);
	s1_o12(29)<=pp_in(14)(2);
	s1_o12(30)<=pp_in(16)(0);
	s1_o12(31)<=pp_in(15)(2);
	s1_o12(63 downto 32)<=pp_in(16)(32 downto 1);
	
	

end architecture;
	
	