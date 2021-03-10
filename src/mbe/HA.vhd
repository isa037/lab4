LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity HA is
	port ( a, b: in std_logic;
			cout, s: out std_logic
		);
end entity;

architecture behavioral of HA is

begin

	s<=(a XOR b);
	cout<=(a AND b); 

end behavioral;