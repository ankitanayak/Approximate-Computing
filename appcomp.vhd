library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
 
entity app_comp is
   port
   (
	xnor_value : in std_logic_vector (15 downto 0);
	op1 : in std_logic_vector (13 downto 0);
      	op2 : in std_logic_vector (13 downto 0);
	cin : in std_logic;
	res : out std_logic_vector (13 downto 0);
	cout : out std_logic
   );
end entity app_comp;

architecture app_comp_arch of app_comp is

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

component approx_vector_calc
port
   (a:in std_logic_vector(15 downto 0);
    synth_sel : out std_logic_vector(13 downto 0)
   );
end component; 

constant key_width: integer:=16;
constant operand_width: integer:=14;

signal c : std_logic_vector (operand_width downto 0);
signal approx_vector : std_logic_vector (operand_width-1 downto 0);

begin
	c(0) <= cin;
	C1 : approx_vector_calc port map (a => xnor_value, synth_sel => approx_vector);
	
	g1: for m in 0 to operand_width-1 generate
		lsb_m : gate_level_adder_approxadder port map (approx_flag => approx_vector(m), bit_op1 => op1(m), bit_op2 => op2(m), bit_cin => c(m), bit_sum => res(m), bit_cout => c(m+1));
    	end generate g1;

	cout <= c(operand_width);
	--res(operand_width) <= c(operand_width);

end app_comp_arch;