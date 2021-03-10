-- VHDL Entity HAVOC.FPmul_stage2.interface
--
-- Created by
-- Guillermo Marcus, gmarcus@ieee.org
-- using Mentor Graphics FPGA Advantage tools.
--
-- Visit "http://fpga.mty.itesm.mx" for more info.
--
-- 2003-2004. V1.0
--

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

library work;
use work.my_pkg.all;

ENTITY FPmul_stage2 IS
   PORT( 
      A_EXP           : IN     std_logic_vector (7 DOWNTO 0);
      A_SIG           : IN     std_logic_vector (31 DOWNTO 0);
      B_EXP           : IN     std_logic_vector (7 DOWNTO 0);
      B_SIG           : IN     std_logic_vector (31 DOWNTO 0);
      SIGN_out_stage1 : IN     std_logic;
      clk             : IN     std_logic;
      isINF_stage1    : IN     std_logic;--
      isNaN_stage1    : IN     std_logic;--
      isZ_tab_stage1  : IN     std_logic;--
      EXP_in          : OUT    std_logic_vector (7 DOWNTO 0);
      EXP_neg_stage2  : OUT    std_logic;
      EXP_pos_stage2  : OUT    std_logic;
      SIGN_out_stage2 : OUT    std_logic;
      SIG_in          : OUT    std_logic_vector (27 DOWNTO 0);
      isINF_stage2    : OUT    std_logic;
      isNaN_stage2    : OUT    std_logic;
      isZ_tab_stage2  : OUT    std_logic
   );

-- Declarations

END FPmul_stage2 ;

--
-- VHDL Architecture HAVOC.FPmul_stage2.struct
--
-- Created by
-- Guillermo Marcus, gmarcus@ieee.org
-- using Mentor Graphics FPGA Advantage tools.
--
-- Visit "http://fpga.mty.itesm.mx" for more info.
--
-- Copyright 2003-2004. V1.0
--


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ARCHITECTURE struct OF FPmul_stage2 IS

   -- Architecture declarations

   COMPONENT REGN_EN_FP IS
	GENERIC ( N : INTEGER:=8);
	PORT (R : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			ENABLE, CLOCK, RESETN : IN STD_LOGIC;
			Q :	OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
   END COMPONENT;

   COMPONENT FFN_EN_FP IS
	PORT (R : IN STD_LOGIC;
			ENABLE, CLOCK, RESETN : IN STD_LOGIC;
			Q :	OUT STD_LOGIC);
   END COMPONENT;

   component mbe is
	port (  mbe_multiplier: in std_logic_vector(31 downto 0);
			mbe_multiplicand: in std_logic_vector(31 downto 0);
			mbe_out: out std_logic_vector (63 downto 0)
	);
   end component;

   -- Internal signal declarations
   SIGNAL EXP_in_int  : std_logic_vector(7 DOWNTO 0);
   SIGNAL EXP_neg_int : std_logic;
   SIGNAL EXP_pos_int : std_logic;
   SIGNAL SIG_in_int  : std_logic_vector(27 DOWNTO 0);
   SIGNAL dout        : std_logic;
   SIGNAL dout1       : std_logic_vector(7 DOWNTO 0);--
   SIGNAL prod, prod_tmp        : std_logic_vector(63 DOWNTO 0);
   SIGNAL SIGN_out_stage1_int: std_logic;
   SIGNAL middle_vector, middle_vector_int: std_logic_vector (12 downto 0);



BEGIN
   -- Architecture concurrent statements
   -- HDL Embedded Text Block 1 sig
   -- eb1 1
   SIG_in_int <= prod(47 DOWNTO 20);

   -- HDL Embedded Text Block 2 inv
   -- eb5 5
   EXP_in_int <= (NOT middle_vector_int(7)) & middle_vector_int(6 DOWNTO 0);

   -- HDL Embedded Text Block 3 latch
   -- eb2 2
   
   PROCESS(clk)
   BEGIN
      IF RISING_EDGE(clk) THEN
         EXP_in <= EXP_in_int;
         SIG_in <= SIG_in_int;
         EXP_pos_stage2 <= middle_vector_int(9);
         EXP_neg_stage2 <= middle_vector_int(8);
      END IF;
   END PROCESS;

   --SIGN_out_stage1_FF
   SIGN_stage1: FFN_EN_FP
       port map(R=>SIGN_out_stage1,Q=>SIGN_out_stage1_int, ENABLE=>'1', RESETN=>'1', CLOCK=>clk);


   -- HDL Embedded Text Block 4 latch2
   -- latch2 4
   PROCESS(clk)
   BEGIN
      IF RISING_EDGE(clk) THEN
         isINF_stage2 <= middle_vector_int(12);
         isNaN_stage2 <= middle_vector_int(11);
         isZ_tab_stage2 <= middle_vector_int(10);
         SIGN_out_stage2 <= SIGN_out_stage1_int;
      END IF;
   END PROCESS;

   -- HDL Embedded Text Block 5 eb1
   -- exp_pos 5
   EXP_pos_int <= A_EXP(7) AND B_EXP(7);--
--   EXP_neg_int <= NOT(A_EXP(7) OR B_EXP(7));
   EXP_neg_int <= '1' WHEN ( (A_EXP(7)='0' AND NOT (A_EXP=X"7F")) AND (B_EXP(7)='0' AND NOT (B_EXP=X"7F")) ) ELSE '0';--


   -- ModuleWare code(v1.1) for instance 'I4' of 'add'
   I4combo: PROCESS (A_EXP, B_EXP, dout)
   VARIABLE mw_I4t0 : std_logic_vector(8 DOWNTO 0);
   VARIABLE mw_I4t1 : std_logic_vector(8 DOWNTO 0);
   VARIABLE mw_I4sum : unsigned(8 DOWNTO 0);
   VARIABLE mw_I4carry : std_logic;
   BEGIN
      mw_I4t0 := '0' & A_EXP;
      mw_I4t1 := '0' & B_EXP;
      mw_I4carry := dout;
      mw_I4sum := unsigned(mw_I4t0) + unsigned(mw_I4t1) + mw_I4carry;
      dout1 <= conv_std_logic_vector(mw_I4sum(7 DOWNTO 0),8);
   END PROCESS I4combo;

   -- ModuleWare code(v1.1) for instance 'I2' of 'mult'
--   I2combo : PROCESS (A_SIG, B_SIG)
--   VARIABLE dtemp : unsigned(63 DOWNTO 0);
--   BEGIN
--      dtemp := (unsigned(A_SIG) * unsigned(B_SIG));
--      prod_tmp <= std_logic_vector(dtemp);
--   END PROCESS I2combo;

   I2combo: mbe
	port map (mbe_multiplier=>A_SIG, mbe_multiplicand=>B_SIG, mbe_out=>prod_tmp);
	

   --Multiplier output register
   mult_out_reg: REGN_EN_FP
       generic map (N=>64)
       port map( R=>prod_tmp, Q=>prod, ENABLE=>'1', RESETN=>'1',  CLOCK=>clk );

   -- ModuleWare code(v1.1) for instance 'I6' of 'vdd'
   dout <= '1';

   --Middle vector register
   middle_vector<= isINF_stage1 & isNaN_stage1 & isZ_tab_stage1 & EXP_pos_int  & EXP_neg_int & dout1 ;

   middle_vector_reg: REGN_EN_FP
       generic map (N=>13)
       port map(R=>middle_vector, Q=>middle_vector_int, ENABLE=>'1', RESETN=>'1', CLOCK=>clk); 

   -- Instance port mappings.

END struct;
