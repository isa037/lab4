LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity FA is
	port ( a, b, cin: in std_logic;
			cout, s: out std_logic
		);
end entity;

architecture behavioral of FA is

begin

	s<=(a XOR b XOR cin);
	cout<=(a AND b) OR (a AND cin) OR (b AND cin); 

end behavioral;