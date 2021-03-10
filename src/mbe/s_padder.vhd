LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

library work;
use work.my_pkg.all;

entity s_padder is
   port(	pp: in array33(16 downto 0);
	x: in std_logic_vector (31 downto 0);
	pp_out: out array36(16 downto 0));
end entity;

architecture behavioral of s_padder is

begin

	--pp_out(0)
	pp_out(0)(35)<= not(x(1));
	pp_out(0)(34)<= x(1);
	pp_out(0)(33)<= x(1);
	pp_out(0)(32 downto 0)<= pp(0);

	assignments: for I in 1 to 14 generate
	begin
		pp_out(I)(35)<= '1';
		pp_out(I)(34)<= not(x(2*I+1));
		pp_out(I)(33 downto 1)<= pp(I);
		pp_out(I)(0)<=x(2*I-1);
	end generate;

	--pp_out(15)
	pp_out(15)(35)<='0';
	pp_out(15)(34)<=not(x(31));
	pp_out(15)(33 downto 1)<=pp(15);
	pp_out(15)(0)<=x(29);
	
	--pp_out(16)
	pp_out(16)(35)<='0';
	pp_out(16)(34)<='0';
	pp_out(16)(33 downto 1)<=pp(16);
	pp_out(16)(0)<=x(31);

end architecture;
