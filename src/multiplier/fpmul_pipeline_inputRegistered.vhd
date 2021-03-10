LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY FPmul_REGISTERED IS
   PORT( 
      FP_A : IN     std_logic_vector (31 DOWNTO 0);
      FP_B : IN     std_logic_vector (31 DOWNTO 0);
      clk,RST_n  : IN     std_logic;
      FP_Z : OUT    std_logic_vector (31 DOWNTO 0)
   );



END FPmul_REGISTERED ;


ARCHITECTURE registered_pipeline OF FPmul_REGISTERED IS
	COMPONENT FPmul IS
	   PORT( 
	      FP_A : IN     std_logic_vector (31 DOWNTO 0);
	      FP_B : IN     std_logic_vector (31 DOWNTO 0);
	      clk  : IN     std_logic;
	      FP_Z : OUT    std_logic_vector (31 DOWNTO 0)
	   );
	END COMPONENT;

	COMPONENT REGN_EN_FP IS
		GENERIC ( N : INTEGER:=8);
		PORT (R : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				ENABLE, CLOCK, RESETN : IN STD_LOGIC;
				Q :	OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END COMPONENT;
	
	signal FP_A_tmp,FP_B_tmp : std_logic_vector(31 downto 0);
	
BEGIN 
	INPUT_REG1: REGN_EN_FP  GENERIC MAP (N =>32)
				PORT MAP(R=>FP_A,ENABLE=>'1',CLOCK=>CLK,RESETN=>RST_n, Q=>FP_A_tmp);
	INPUT_REG2: REGN_EN_FP  GENERIC MAP (N =>32)
				PORT MAP(R=>FP_B,ENABLE=>'1',CLOCK=>CLK,RESETN=>RST_n, Q=>FP_B_tmp);

	MULT: FPmul PORT MAP( 
	      FP_A =>FP_A_tmp,
	      FP_B =>FP_B_tmp,
	      clk  =>clk,
	      FP_Z => FP_Z
	   );
END registered_pipeline;
