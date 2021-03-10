LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

--library work;
--use work.pkg.all;

entity rca63 is
	port ( a: in std_logic_vector (62 downto 0);
		   b: in std_logic_vector (62 downto 0);
		   
		   s: out std_logic_vector (62 downto 0);
		   cout: out std_logic
	);
end entity;

architecture behavioral of rca63 is

	signal c_int: std_logic_vector  (62 downto 0);

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

	HA_0: HA
		port map (a=>a(0), b=>b(0), s=>s(0), cout=>c_int(0));
	
	FA_1_62: for I in 1 to 62 generate
	begin
		rca_FA: FA
			port map (a=>a(I), b=>b(I), cin=>c_int(I-1), s=>s(I), cout=>c_int(I));
	end generate;
	
	cout<=c_int(62);
	

end architecture;