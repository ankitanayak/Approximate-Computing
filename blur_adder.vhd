library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
 
entity blur_adder is
   port
   (
	blur_adder_xnor_value : in std_logic_vector (9 downto 0);
	blur_adder_op1 : in std_logic_vector (9 downto 0);
      	blur_adder_op2 : in std_logic_vector (9 downto 0);
	blur_adder_cin : in std_logic;
	blur_adder_res : out std_logic_vector (9 downto 0);
	blur_adder_cout : out std_logic
   );
end entity blur_adder;

architecture blur_adder_arch of blur_adder is

component gate_level_adder_approxadder
port
   (
	approx_flag : in std_logic;
	bit_op1 : in std_logic;
      	bit_op2 : in std_logic;
	bit_cin : in std_logic;
	bit_sum : out std_logic;
	bit_cout : out std_logic
   );
end component;

component blur_approx_vector_calc
port
   (blur_a:in std_logic_vector(9 downto 0);
    blur_synth_sel : out std_logic_vector(9 downto 0)
   );
end component; 

constant key_width: integer:=10;
constant operand_width: integer:=10;

signal blur_adder_c : std_logic_vector (operand_width downto 0);
signal blur_adder_approx_vector : std_logic_vector (operand_width-1 downto 0);

begin
	blur_adder_c(0) <= blur_adder_cin;
	blur_adder_C1 : blur_approx_vector_calc port map (blur_a => blur_adder_xnor_value, blur_synth_sel => blur_adder_approx_vector);
	
	blur_adder_g1: for m in 0 to operand_width-1 generate
		blur_adder_lsb_m : gate_level_adder_approxadder port map (approx_flag => blur_adder_approx_vector(m), bit_op1 => blur_adder_op1(m), bit_op2 => blur_adder_op2(m), bit_cin => blur_adder_c(m), bit_sum => blur_adder_res(m), bit_cout => blur_adder_c(m+1));
    	end generate blur_adder_g1;

	blur_adder_cout <= blur_adder_c(operand_width);
	--res(operand_width) <= c(operand_width);

end blur_adder_arch;
