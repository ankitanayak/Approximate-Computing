library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use IEEE.MATH_REAL.all;

entity dct_adder_approx_vector_calc is
port
   (
	dct_adder_a:in std_logic_vector(15 downto 0);
	dct_adder_synth_sel : out std_logic_vector(15 downto 0)
   );

end dct_adder_approx_vector_calc; 
architecture Behavioral_dct_adder_approx_vector_calc of dct_adder_approx_vector_calc is

constant key_width: integer:=16;
constant operand_width: integer:=16;
constant real_key_width: real:=16.00;
constant real_operand_width: real:=16.00;

--signal c,c2: integer;

begin

	process(dct_adder_a)
	variable dct_adder_c,dct_adder_c2: integer;
	begin
		dct_adder_c := 0;
		dct_adder_c2 := 0;
		dct_adder_a1:for i in 0 to key_width-1 loop
			if(dct_adder_a(i)='1')then
				dct_adder_c := dct_adder_c+1;
			end if; 
		end loop dct_adder_a1;

		--c2 <= integer((real(c)/real_key_width)*real_operand_width);
		dct_adder_c2:=(dct_adder_c*operand_width)/key_width;

		dct_adder_a2:for j in 0 to operand_width-1 loop
			if(j < dct_adder_c2)then
				dct_adder_synth_sel(j) <= '1';
			elsif(j >= dct_adder_c2)then
				dct_adder_synth_sel(j) <= '0';
			end if;
		end loop dct_adder_a2;

	end process;
end Behavioral_dct_adder_approx_vector_calc;