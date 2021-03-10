LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

--library work;
--use work.pkg.all;

entity dadda_stage6 is
	port ( s5_o0: in std_logic_vector (63 downto 0);
		   s5_o1: in std_logic_vector (63 downto 1);
		   s5_o2: in std_logic_vector (63 downto 3);
		   
		   s6_o0: out std_logic_vector (63 downto 1);
		   s6_o1: out std_logic_vector (63 downto 0)
	);
end entity;

architecture behavioral of dadda_stage6 is

	type ha_outputs is array (3 downto 1) of std_logic_vector(1 downto 0);
	signal ha_out : ha_outputs;
	
	type fa_outputs is array (60 downto 1) of std_logic_vector (1 downto 0);
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

	HA_1: HA
		port map(a=>s5_o0(0), b=>s5_o1(1), s=>ha_out(1)(0), cout=>ha_out(1)(1) );
	
	HA_2_3: for I in 2 to 3 generate
	begin
		block1_ha: HA
			port map (a=>s5_o0(I), b=>s5_o1(I), s=>ha_out(I)(0), cout=>ha_out(I)(1) );
	end generate;
	
	FA_1_60: for I in 1 to 60 generate
	begin
		block1_fa: FA
			port map (a=>s5_o0(I+3) , b=>s5_o1(I+3) , cin=>s5_o2(I+3) , s=>fa_out(I)(0), cout=>fa_out(I)(1) );
	end generate;
	
	--OUTPUT GENERATION
	
	--OUTPUT 0
	
	s6_o0(1)<=s5_o0(1);
	s6_o0(3 downto 2)<=ha_out(2);
	output0_fa: for I in 0 to 29 generate
	begin
		s6_o0(5+2*I downto 4+2*I)<=fa_out(1+2*I);
	end generate;
	
	--OUTPUT 1
	
	s6_o1(1 downto 0)<=ha_out(1);
	s6_o1(2)<=s5_o2(3);
	s6_o1(4 downto 3)<=ha_out(3);
	output1_fa: for I in 0 to 28 generate
	begin
		s6_o1(6+2*I downto 5+2*I)<=fa_out(2+2*I);
	end generate;
	s6_o1(63)<=fa_out(60)(0); --Il cout dell'ultimo fa finisce fuori dai 64 bit necessari per una mult a 32 bit

end architecture;