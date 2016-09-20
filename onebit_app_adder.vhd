library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity onebit_approxadder is
   port
   (
	onebit_approx_flag : in std_logic;
	onebit_op1 : in std_logic;
      	onebit_op2 : in std_logic;
	onebit_cin : in std_logic;
	onebit_sum : out std_logic;
	onebit_cout : out std_logic
   );
end entity onebit_approxadder;

architecture behav_onebit_approxadder of onebit_approxadder is

begin
   	process (onebit_op1, onebit_op2, onebit_cin, onebit_approx_flag) is
   	begin
		if onebit_approx_flag = '0' then
			onebit_sum <= onebit_op1 xor onebit_op2 xor onebit_cin;
			onebit_cout <= (onebit_op1 and onebit_op2) or (onebit_cin and (onebit_op1 xor onebit_op2));
		elsif onebit_approx_flag = '1' then
			onebit_sum <= not (onebit_op1 xor onebit_op2 xor onebit_cin);
			onebit_cout <= not ((onebit_op1 and onebit_op2) or (onebit_cin and (onebit_op1 xor onebit_op2)));
		end if;
	end process;
end architecture behav_onebit_approxadder;
