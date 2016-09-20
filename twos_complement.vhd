library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity twos_complement is
   port
   (
	input_value : in std_logic_vector (14 downto 0);
	tsign_bit : in std_logic;
	twos_complement_value : out std_logic_vector (14 downto 0)
   );
end entity twos_complement;

architecture twos_complement_arch of twos_complement is
begin
	process(input_value, tsign_bit)
	begin
		twos_complement_value <= input_value;
		if(tsign_bit='1')then
			twos_complement_value <= not(input_value) +1;
		end if;
	end process;
end twos_complement_arch;