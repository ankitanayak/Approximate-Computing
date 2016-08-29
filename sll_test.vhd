library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
 
entity sll_test is
   port
   (
	in_num : in unsigned (9 downto 0);
	out_num : out unsigned (9 downto 0)
   );
end entity sll_test;

architecture sll_test_arch of sll_test is

begin

	process(in_num)
	begin
		out_num <= in_num sll 2;
	end process;
end sll_test_arch;
