library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity approx_mirror_adder is
   port
   (
	bit_op1 : in std_logic;
      	bit_op2 : in std_logic;
	bit_cin : in std_logic;
	bit_sum : out std_logic;
	bit_cout : out std_logic
   );
end entity approx_mirror_adder;

architecture behav_approx_mirror_adder of approx_mirror_adder is

begin
   	process (bit_op1, bit_op2, bit_cin) is
   	begin
		if bit_op1 = '0' and bit_op2 = '0' and bit_cin = '0' then
			bit_sum <= '0';
			bit_cout <= '0';
		elsif bit_op1 = '0' and bit_op2 = '0' and bit_cin = '1' then
			bit_sum <= '0';
			bit_cout <= '0';
		elsif bit_op1 = '0' and bit_op2 = '1' and bit_cin = '0' then
			bit_sum <= '1';
			bit_cout <= '0';
		elsif bit_op1 = '0' and bit_op2 = '1' and bit_cin = '1' then
			bit_sum <= '1';
			bit_cout <= '0';
		elsif bit_op1 = '1' and bit_op2 = '0' and bit_cin = '0' then
			bit_sum <= '0';
			bit_cout <= '1';
		elsif bit_op1 = '1' and bit_op2 = '0' and bit_cin = '1' then
			bit_sum <= '0';
			bit_cout <= '1';
		elsif bit_op1 = '1' and bit_op2 = '1' and bit_cin = '0' then
			bit_sum <= '1';
			bit_cout <= '1';
		elsif bit_op1 = '1' and bit_op2 = '1' and bit_cin = '1' then
			bit_sum <= '1';
			bit_cout <= '1';
		end if;
	end process;
end architecture behav_approx_mirror_adder;
