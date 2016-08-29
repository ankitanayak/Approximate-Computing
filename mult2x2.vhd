library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
 
entity mult_2x2 is
   port
   (
	A : in std_logic_vector (1 downto 0);
	X : in std_logic_vector (1 downto 0);
      	approx_mul_flag : in std_logic;
	prod : out std_logic_vector (3 downto 0)
   );
end entity mult_2x2;

architecture mult_2x2_arch of mult_2x2 is

begin

	process(A,X,approx_mul_flag)
	begin
		if A = "00" or X = "00" then
			prod <= "0000";
		elsif A = "01" then
			prod <= '0' & '0' & X;
		elsif X = "01" then
			prod <= '0' & '0' & A;
		elsif (A = "11" and X = "10") or (A = "10" and X = "11") then
			prod <= "0110";
		elsif A = "10" and X = "10" then
			prod <= "0100";
		elsif A = "11" and X = "11" and approx_mul_flag = '0' then
			prod <= "1001";
		elsif A = "11" and X = "11" and approx_mul_flag = '1' then
			prod <= "0111";
		end if;
	end process;
end architecture mult_2x2_arch;