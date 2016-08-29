library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity gate_level_adder_approxadder is
   port
   (
	approx_flag : in std_logic;
	bit_op1 : in std_logic;
      	bit_op2 : in std_logic;
	bit_cin : in std_logic;
	bit_sum : out std_logic;
	bit_cout : out std_logic
   );
end entity gate_level_adder_approxadder;

architecture behav_gate_level_adder_approxadder of gate_level_adder_approxadder is

begin
   	process (bit_op1, bit_op2, bit_cin, approx_flag) is
   	begin
		if approx_flag = '0' then
			bit_sum <= bit_op1 xor bit_op2 xor bit_cin;
			bit_cout <= (bit_op1 and bit_op2) or (bit_cin and (bit_op1 xor bit_op2));
		elsif approx_flag = '1' then
			bit_sum <= bit_op2;
			bit_cout <= bit_op1;
		end if;
	end process;
end architecture behav_gate_level_adder_approxadder;
