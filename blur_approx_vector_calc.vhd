library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use IEEE.MATH_REAL.all;

entity blur_approx_vector_calc is
port
   (
	blur_a:in std_logic_vector(9 downto 0);
	blur_synth_sel : out std_logic_vector(9 downto 0)
   );

end blur_approx_vector_calc; 
architecture Behavioral_blur_approx_vector_calc of blur_approx_vector_calc is

constant key_width: integer:=10;
constant operand_width: integer:=10;
constant real_key_width: real:=10.00;
constant real_operand_width: real:=10.00;

--signal c,c2: integer;

begin

	process(blur_a)
	variable blur_c,blur_c2: integer;
	begin
		blur_c := 0;
		blur_c2 := 0;
		blur_a1:for i in 0 to key_width-1 loop
			if(blur_a(i)='1')then
				blur_c := blur_c+1;
			end if; 
		end loop blur_a1;

		--blur_mult_c2:=(blur_mult_c*operand_width)/key_width;

		--blur_mult_a2:for j in 0 to operand_width-1 loop
			--if(j < blur_mult_c2)then
				--blur_mult_synth_sel(j) <= '1';
			--elsif(j >= blur_mult_c2)then
				--blur_mult_synth_sel(j) <= '0';
			--end if;
		--end loop blur_mult_a2;

		--blur_mult_a2:for j in 0 to operand_width-1 loop
			--if(j < float_width)then
				--blur_mult_synth_sel(j) <= '0';
			--elsif((j >= float_width) and (j < (float_width+blur_mult_c)))then
				--blur_mult_synth_sel(j) <= '1';
			--elsif(j >= (float_width+blur_mult_c))then
				--blur_mult_synth_sel(j) <= '0';
			--end if;
		--end loop blur_mult_a2;

		blur_a2:for j in 0 to blur_c-1 loop
			blur_synth_sel(j) <= '1';
		end loop blur_a2;

		blur_a3:for j in blur_c to operand_width-1 loop
			blur_synth_sel(j) <= '0';
		end loop blur_a3;

	end process;
end Behavioral_blur_approx_vector_calc;
