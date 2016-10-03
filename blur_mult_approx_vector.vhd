library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use IEEE.MATH_REAL.all;

entity blur_mult_approx_vector_calc is
port
   (
	blur_mult_a:in std_logic_vector(12 downto 0);
	blur_mult_synth_sel : out std_logic_vector(23 downto 0)
   );

end blur_mult_approx_vector_calc; 
architecture Behavioral_blur_mult_approx_vector_calc of blur_mult_approx_vector_calc is

constant key_width: integer:=13;
constant operand_width: integer:=24;
constant whole_number_width: integer:=operand_width-11;
constant float_width: integer:=operand_width-whole_number_width;
constant real_key_width: real:=13.00;
constant real_operand_width: real:=24.00;

--signal c,c2: integer;

begin

	process(blur_mult_a)
	variable blur_mult_c,blur_mult_c2: integer;
	begin
		blur_mult_c := 0;
		blur_mult_c2 := 0;
		blur_mult_a1:for i in 0 to key_width-1 loop
			if(blur_mult_a(i)='1')then
				blur_mult_c := blur_mult_c+1;
			end if; 
		end loop blur_mult_a1;

		--blur_mult_c2:=(blur_mult_c*operand_width)/key_width;

		--blur_mult_a2:for j in 0 to operand_width-1 loop
			--if(j < blur_mult_c2)then
				--blur_mult_synth_sel(j) <= '1';
			--elsif(j >= blur_mult_c2)then
				--blur_mult_synth_sel(j) <= '0';
			--end if;
		--end loop blur_mult_a2;

		blur_mult_a2:for j in 0 to operand_width-1 loop
			if(j < float_width)then
				blur_mult_synth_sel(j) <= '0';
			elsif((j >= float_width) and (j < (float_width+blur_mult_c)))then
				blur_mult_synth_sel(j) <= '1';
			elsif(j >= (float_width+blur_mult_c))then
				blur_mult_synth_sel(j) <= '0';
			end if;
		end loop blur_mult_a2;

		--blur_mult_a2:for j in 0 to blur_mult_c-1 loop
			--blur_mult_synth_sel(j) <= '1';
		--end loop blur_mult_a2;

		--blur_mult_a3:for j in blur_mult_c to operand_width-1 loop
			--blur_mult_synth_sel(j) <= '0';
		--end loop blur_mult_a3;

	end process;
end Behavioral_blur_mult_approx_vector_calc;
