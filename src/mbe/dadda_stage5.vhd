LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

--library work;
--use work.pkg.all;

entity dadda_stage5 is
	port ( s4_o0: in std_logic_vector (61 downto 0);
		   s4_o1: in std_logic_vector (62 downto 1);
		   s4_o2: in std_logic_vector (63 downto 3);
		   s4_o3: in std_logic_vector (63 downto 5);
		   
		   s5_o0: out std_logic_vector (63 downto 0);
		   s5_o1: out std_logic_vector (63 downto 1);
		   s5_o2: out std_logic_vector (63 downto 3)
	);
end entity;

architecture behavioral of dadda_stage5 is

	type ha_outputs is array (3 downto 1) of std_logic_vector(1 downto 0);
	signal ha_out : ha_outputs;
	
	type fa_outputs is array (56 downto 1) of std_logic_vector (1 downto 0);
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

	HA_1_2 : for I in 1 to 2 generate
	begin
		block1_ha: HA
			port map (a=>s4_o0(3+I), b=>s4_o1(3+I), s=>ha_out(I)(0), cout=>ha_out(I)(1) );
	end generate;

	FA_1_56: for I in 1 to 56 generate
	begin
		block1_fa: FA
			port map (a=>s4_o0(5+I), b=>s4_o1(5+I), cin=>s4_o2(5+I), s=>fa_out(I)(0), cout=>fa_out(I)(1));
	end generate;
	
	HA_3: HA
		port map(a=>s4_o1(62), b=>s4_o2(62), s=>ha_out(3)(0), cout=>ha_out(3)(1));
		
	--OUTPUT GENERATION
	
	--OUTPUT 0
	
	s5_o0(3 downto 0)<=s4_o0(3 downto 0);
	s5_o0(5 downto 4)<=ha_out(1);
	output0_fa: for I in 0 to 27 generate
	begin
		s5_o0(7+2*I downto 6+2*I)<=fa_out(1+2*I);
	end generate;
	s5_o0(63 downto 62)<=ha_out(3);
	
	
	--OUTPUT 1
	s5_o1(3 downto 1)<=s4_o1(3 downto 1);
	s5_o1(4)<=s4_o3(5);
	s5_o1(6 downto 5)<=ha_out(2);
	output1_fa: for I in 0 to 27 generate
	begin
		s5_o1(8+2*I downto 7+2*I)<=fa_out(2+2*I);
	end generate;
	s5_o1(63)<=s4_o2(63);

	--OUTPUT 2
	s5_o2(5 downto 3)<=s4_o2(5 downto 3);
	s5_o2(63 downto 6)<=s4_o3(63 downto 6);

end architecture;