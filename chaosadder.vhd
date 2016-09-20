library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
 
entity chaosadder is
   port
   (
	chaosadder_xnor_value : in std_logic_vector (15 downto 0);
	chaosadder_op1 : in std_logic_vector (13 downto 0);
      	chaosadder_op2 : in std_logic_vector (13 downto 0);
	chaosadder_cin : in std_logic;
	chaosadder_res : out std_logic_vector (13 downto 0);
	chaosadder_cout : out std_logic
   );
end entity chaosadder;

architecture chaosadder_arch of chaosadder is

component onebit_approxadder
port
   (
	onebit_approx_flag : in std_logic;
	onebit_op1 : in std_logic;
      	onebit_op2 : in std_logic;
	onebit_cin : in std_logic;
	onebit_sum : out std_logic;
	onebit_cout : out std_logic
   );
end component;

component approx_vector_calc
port
   (a:in std_logic_vector(15 downto 0);
    synth_sel : out std_logic_vector(13 downto 0)
   );
end component; 

constant key_width: integer:=16;
constant operand_width: integer:=14;

signal chaosadder_c : std_logic_vector (operand_width downto 0);
signal chaosadder_approx_vector : std_logic_vector (operand_width-1 downto 0);

begin
	chaosadder_c(0) <= chaosadder_cin;
	chaosadder_C1 : approx_vector_calc port map (a => chaosadder_xnor_value, synth_sel => chaosadder_approx_vector);
	
	chaosadder_g1: for m in 0 to operand_width-1 generate
		chaosadder_lsb_m : onebit_approxadder port map (onebit_approx_flag => chaosadder_approx_vector(m), onebit_op1 => chaosadder_op1(m), onebit_op2 => chaosadder_op2(m), onebit_cin => chaosadder_c(m), onebit_sum => chaosadder_res(m), onebit_cout => chaosadder_c(m+1));
    	end generate chaosadder_g1;

	chaosadder_cout <= chaosadder_c(operand_width);
	--res(operand_width) <= c(operand_width);

end chaosadder_arch;
