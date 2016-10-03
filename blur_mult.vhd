library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
 
entity blur_mult is
   port
   (
	blur_mult_regxnor_value : in std_logic_vector (12 downto 0);
	blur_mult_regop1 : in std_logic_vector (11 downto 0);
      	blur_mult_regop2 : in std_logic_vector (11 downto 0);
	blur_mult_regres : out std_logic_vector (23 downto 0)
   );
end entity blur_mult;

architecture blur_mult_arch of blur_mult is

component blur_mult_adder
port
   (
	blur_mult_adder_xnor_value : in std_logic_vector (12 downto 0);
	blur_mult_adder_op1 : in std_logic_vector (23 downto 0);
      	blur_mult_adder_op2 : in std_logic_vector (23 downto 0);
	blur_mult_adder_cin : in std_logic;
	blur_mult_adder_res : out std_logic_vector (23 downto 0);
	blur_mult_adder_cout : out std_logic
   );
end component;

constant key_width: integer:=13;
constant operand_width: integer:=12;
constant result_width: integer:=operand_width*2;

type blur_mult_regres_array is array (0 to operand_width-1) of std_logic_vector(result_width-1 downto 0);
type blur_mult_regres_temp_array is array (0 to operand_width-2) of std_logic_vector(result_width-1 downto 0);
signal blur_mult_reg_res : blur_mult_regres_array;
signal blur_mult_regres_var : blur_mult_regres_array;
signal blur_mult_regres_temp : blur_mult_regres_temp_array;
signal blur_mult_cout_junk : std_logic;

begin
	
	process(blur_mult_regop1, blur_mult_regop2, blur_mult_reg_res, blur_mult_regres_var)
	begin
		blur_mult_p1:for i in 0 to operand_width-1 loop
			if(blur_mult_regop2(i)='1')then
				blur_mult_p3:for k in 0 to operand_width-1 loop
					blur_mult_reg_res(i)(k) <= blur_mult_regop1(k);
					blur_mult_reg_res(i)(k+operand_width) <= '0';
				end loop blur_mult_p3;
			else
				blur_mult_p5:for n in 0 to result_width-1 loop
					blur_mult_reg_res(i)(n) <= '0';
				end loop blur_mult_p5;
			end if;
		end loop blur_mult_p1;

		--regres_var(0) <= reg_res(0);

		blur_mult_p4:for j in 0 to operand_width-1 loop
			blur_mult_regres_var(j) <= std_logic_vector(unsigned(blur_mult_reg_res(j)) sll j);
		end loop blur_mult_p4;

		--p2:for j in 1 to operand_width-1 loop
			--regres_var(j) <= regres_var(j-1)+std_logic_vector(unsigned(reg_res(j)) sll j);
		--end loop p2;
		
		--regres <= regres_var(operand_width-1);

	end process;

	blur_mult_W0: blur_mult_adder port map (blur_mult_adder_xnor_value => blur_mult_regxnor_value,
					blur_mult_adder_op1 => blur_mult_regres_var(0),
      					blur_mult_adder_op2 => blur_mult_regres_var(1),
					blur_mult_adder_cin => '0',
					blur_mult_adder_res => blur_mult_regres_temp(0),
					blur_mult_adder_cout => blur_mult_cout_junk);
	blur_mult_W1: for m in 0 to operand_width-3 generate
		blur_mult_W_m : blur_mult_adder port map (blur_mult_adder_xnor_value => blur_mult_regxnor_value,
					blur_mult_adder_op1 => blur_mult_regres_temp(m),
      					blur_mult_adder_op2 => blur_mult_regres_var(m+2),
					blur_mult_adder_cin => '0',
					blur_mult_adder_res => blur_mult_regres_temp(m+1),
					blur_mult_adder_cout => blur_mult_cout_junk);
    	end generate blur_mult_W1;

	--W2: app_comp port map (xnor_value => regxnor_value,
					--op1 => regres_temp(7),
      					--op2 => regres_var(9),
					--cin => '0',
					--res => regres_temp(8),
					--cout => cout_junk);
	
	blur_mult_regres <= blur_mult_regres_temp(operand_width-2);

end blur_mult_arch;
