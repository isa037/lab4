LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

library work;
use work.my_pkg.all;

entity mbe is
	port (  mbe_multiplier: in std_logic_vector(31 downto 0);	--X
			mbe_multiplicand: in std_logic_vector(31 downto 0); --A
			mbe_out: out std_logic_vector (63 downto 0) --OUT
	);
end entity;

architecture rtl of mbe is

component 	ppg is
port(			x : in std_logic_vector (2 downto 0);	-- x2j+1 (MSB), x2j, x2j-1(LSB)
			A: in std_logic_vector (31 downto 0);
			pj: out std_logic_vector (32 downto 0) );
end component;


component s_padder is
   port(	pp: in array33(16 downto 0);
			x: in std_logic_vector (31 downto 0);
			pp_out: out array36(16 downto 0));
end component;

component dadda_tree is
	port ( 	dadda_in: in array36(16 downto 0);
			dadda_out1: out std_logic_vector (63 downto 1);
			dadda_out2: out std_logic_vector (63 downto 0)
	);
end component;

component rca63 is
	port ( a: in std_logic_vector (62 downto 0);
		   b: in std_logic_vector (62 downto 0);
		   
		   s: out std_logic_vector (62 downto 0);
		   cout: out std_logic
	);
end component;

signal ppg_x0, ppg_x16 : std_logic_vector (2 downto 0);
signal padder_in : array33(16 downto 0);
signal dadda_in_int : array36(16 downto 0);
signal dadda_out1_int:  std_logic_vector (63 downto 1);
signal dadda_out2_int:  std_logic_vector (63 downto 0);


signal rca_out: std_logic_vector (62 downto 0);
signal rca_cout : std_logic;

begin
ppg_x0 <= mbe_multiplier(1 downto 0) & '0';
ppg0: ppg port map (x => ppg_x0 , A=>mbe_multiplicand, pj=>padder_in(0));

partial_product: for i in 1 to 15 generate
		ppgx: ppg port map (x => mbe_multiplier(2*i+1 downto 2*i-1), A=>mbe_multiplicand, pj=>padder_in(i));
end generate;
		
ppg_x16<= '0' & '0' & mbe_multiplier(31);
ppg16: ppg port map (x => ppg_x16 , A=>mbe_multiplicand, pj=>padder_in(16));


padder: s_padder 
   port map(	pp => padder_in,
				x  => mbe_multiplier,
				pp_out => dadda_in_int);


dadda : dadda_tree port map (dadda_in => dadda_in_int, 	dadda_out1 => dadda_out1_int,dadda_out2 => dadda_out2_int);

final_rca: rca63 port map ( a=>dadda_out1_int(63 downto 1),b=>dadda_out2_int(63 downto 1), s => rca_out,  cout =>rca_cout);

mbe_out<= rca_out & dadda_out2_int(0);

end architecture rtl;