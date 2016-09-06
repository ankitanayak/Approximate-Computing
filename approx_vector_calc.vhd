library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use IEEE.MATH_REAL.all;

entity approx_vector_calc is
port
   (
	a:in std_logic_vector(7 downto 0);
	synth_sel : out std_logic_vector(19 downto 0)
   );

end approx_vector_calc; 
architecture Behavioral_approx_vector_calc of approx_vector_calc is

constant key_width: integer:=8;
constant operand_width: integer:=20;
constant real_key_width: real:=8.00;
constant real_operand_width: real:=20.00;

--signal c,c2: integer;

begin

	process(a)
	variable c,c2: integer;
	begin
		c := 0;
		c2 := 0;
		a1:for i in 0 to key_width-1 loop
			if(a(i)='1')then
				c := c+1;
			end if; 
		end loop a1;

		--c2 <= integer((real(c)/real_key_width)*real_operand_width);
		c2:=(c*operand_width)/key_width;

		a2:for j in 0 to operand_width-1 loop
			if(j < c2)then
				synth_sel(j) <= '1';
			elsif(j >= c2)then
				synth_sel(j) <= '0';
			end if;
		end loop a2;

	end process;
end Behavioral_approx_vector_calc;
