LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity ppg is
port(	x : in std_logic_vector (2 downto 0);	-- x2j+1 (MSB), x2j, x2j-1(LSB)
	A: in std_logic_vector (31 downto 0);
	pj: out std_logic_vector (32 downto 0) );
end entity;

architecture behavioral of ppg is

	signal A_int : std_logic_vector (32 downto 0);
	signal TwoA_int : std_logic_vector (32 downto 0);

begin

	A_int<= '0' & A;
	TwoA_int<= A & '0';

	mux: process (x, A_int, TwoA_int)
	begin
		case x is
			when "000" => pj <= (others =>'0');
			when "001" => pj<= A_int;
			when "010"=> pj<= A_int;
			when "011"=> pj<= TwoA_int;
			when "100"=> pj<= not(TwoA_int);
			when "101"=> pj<= not(A_int);
			when "110"=> pj<= not(A_int);
			when "111"=> pj<= (others => '1');
			when others => pj <= (others => '0');
		end case;
	end process;
	
	

end behavioral;
