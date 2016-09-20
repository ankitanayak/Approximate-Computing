library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
 
entity dct_adder1 is
   port
   (
	dct_adder1_xnor_value : in std_logic_vector (15 downto 0);
	dct_adder1_op1 : in std_logic_vector (15 downto 0);
      	dct_adder1_op2 : in std_logic_vector (15 downto 0);
	dct_adder1_cin : in std_logic;
	dct_adder1_res : out std_logic_vector (15 downto 0);
	dct_adder1_cout : out std_logic
   );
end entity dct_adder1;

architecture dct_adder1_arch of dct_adder1 is

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

component dct_adder_approx_vector_calc
port
   (dct_adder_a:in std_logic_vector(15 downto 0);
    dct_adder_synth_sel : out std_logic_vector(15 downto 0)
   );
end component; 

constant key_width: integer:=16;
constant operand_width: integer:=16;

signal dct_adder1_c : std_logic_vector (operand_width downto 0);
signal dct_adder1_approx_vector : std_logic_vector (operand_width-1 downto 0);

begin
	dct_adder1_c(0) <= dct_adder1_cin;
	dct_adder1_C1 : dct_adder_approx_vector_calc port map (dct_adder_a => dct_adder1_xnor_value, dct_adder_synth_sel => dct_adder1_approx_vector);
	
	dct_adder1_g1: for m in 0 to operand_width-1 generate
		dct_adder1_lsb_m : onebit_approxadder port map (onebit_approx_flag => dct_adder1_approx_vector(m), onebit_op1 => dct_adder1_op1(m), onebit_op2 => dct_adder1_op2(m), onebit_cin => dct_adder1_c(m), onebit_sum => dct_adder1_res(m), onebit_cout => dct_adder1_c(m+1));
    	end generate dct_adder1_g1;

	dct_adder1_cout <= dct_adder1_c(operand_width);
	--res(operand_width) <= c(operand_width);

end dct_adder1_arch;