library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
 
entity blur is
   port
   (
	blur_xnor_value : in std_logic_vector (12 downto 0);
	blur_out_flag : out std_logic
   );
end entity blur;

architecture blur_arch of blur is

component blur_mult
port
   (
	blur_mult_regxnor_value : in std_logic_vector (12 downto 0);
	blur_mult_regop1 : in std_logic_vector (11 downto 0);
      	blur_mult_regop2 : in std_logic_vector (11 downto 0);
	blur_mult_regres : out std_logic_vector (23 downto 0)
   );
end component;

constant key_width: integer:=13;
constant matrix_size: integer:=8;
constant operand_width: integer:=12;
constant result_width: integer:=operand_width*2;

type blur_matrix_row_type is array (0 to matrix_size-1) of std_logic_vector(operand_width-1 downto 0);
type blur_matrix_type is array (0 to matrix_size-1) of blur_matrix_row_type;

type blur_res_matrix_row_type is array (0 to matrix_size-1) of std_logic_vector(result_width-1 downto 0);
type blur_res_matrix_type is array (0 to matrix_size-1) of blur_res_matrix_row_type;

signal blur_matrix : blur_matrix_type;
signal blur_sum_matrix : blur_matrix_type;
signal blur_res_matrix : blur_res_matrix_type;

begin

	blur_matrix(0)(0) <= "000010011010";
	blur_matrix(0)(1) <= "000001111011";
	blur_matrix(0)(2) <= "000001111011";
	blur_matrix(0)(3) <= "000001111011";
	blur_matrix(0)(4) <= "000001111011";
	blur_matrix(0)(5) <= "000001111011";
	blur_matrix(0)(6) <= "000001111011";
	blur_matrix(0)(7) <= "000010001000";

	blur_matrix(1)(0) <= "000011000000";
	blur_matrix(1)(1) <= "000010110100";
	blur_matrix(1)(2) <= "000010001000";
	blur_matrix(1)(3) <= "000010011010";
	blur_matrix(1)(4) <= "000010011010";
	blur_matrix(1)(5) <= "000010011010";
	blur_matrix(1)(6) <= "000010001000";
	blur_matrix(1)(7) <= "000001101110";

	blur_matrix(2)(0) <= "000011111110";
	blur_matrix(2)(1) <= "000011000110";
	blur_matrix(2)(2) <= "000010011010";
	blur_matrix(2)(3) <= "000010011010";
	blur_matrix(2)(4) <= "000010110100";
	blur_matrix(2)(5) <= "000010011010";
	blur_matrix(2)(6) <= "000001111011";
	blur_matrix(2)(7) <= "000001111011";

	blur_matrix(3)(0) <= "000011101111";
	blur_matrix(3)(1) <= "000010110100";
	blur_matrix(3)(2) <= "000010001000";
	blur_matrix(3)(3) <= "000010110100";
	blur_matrix(3)(4) <= "000010110100";
	blur_matrix(3)(5) <= "000010100110";
	blur_matrix(3)(6) <= "000001111011";
	blur_matrix(3)(7) <= "000001111011";

	blur_matrix(4)(0) <= "000010110100";
	blur_matrix(4)(1) <= "000010011010";
	blur_matrix(4)(2) <= "000010001000";
	blur_matrix(4)(3) <= "000010100111";
	blur_matrix(4)(4) <= "000010100110";
	blur_matrix(4)(5) <= "000010010101";
	blur_matrix(4)(6) <= "000010001000";
	blur_matrix(4)(7) <= "000010001000";

	blur_matrix(5)(0) <= "000010000000";
	blur_matrix(5)(1) <= "000010001000";
	blur_matrix(5)(2) <= "000001111011";
	blur_matrix(5)(3) <= "000010001000";
	blur_matrix(5)(4) <= "000010011010";
	blur_matrix(5)(5) <= "000010110100";
	blur_matrix(5)(6) <= "000011000110";
	blur_matrix(5)(7) <= "000010011010";

	blur_matrix(6)(0) <= "000001111011";
	blur_matrix(6)(1) <= "000001101001";
	blur_matrix(6)(2) <= "000001101110";
	blur_matrix(6)(3) <= "000010010101";
	blur_matrix(6)(4) <= "000010001000";
	blur_matrix(6)(5) <= "000010001000";
	blur_matrix(6)(6) <= "000010110100";
	blur_matrix(6)(7) <= "000010100110";

	blur_matrix(7)(0) <= "000001101110";
	blur_matrix(7)(1) <= "000010001000";
	blur_matrix(7)(2) <= "000001111011";
	blur_matrix(7)(3) <= "000001111011";
	blur_matrix(7)(4) <= "000001111011";
	blur_matrix(7)(5) <= "000010001000";
	blur_matrix(7)(6) <= "000010011010";
	blur_matrix(7)(7) <= "000010001000";


	process(blur_matrix)
	begin
		blur_comp10:for i in 1 to matrix_size-2 loop
			blur_comp11:for j in 1 to matrix_size-2 loop
				blur_sum_matrix(i)(j) <= std_logic_vector(unsigned(blur_matrix(i-1)(j-1))+unsigned(blur_matrix(i-1)(j))+unsigned(blur_matrix(i-1)(j+1))+unsigned(blur_matrix(i)(j-1))+unsigned(blur_matrix(i)(j))+unsigned(blur_matrix(i)(j+1))+unsigned(blur_matrix(i+1)(j-1))+unsigned(blur_matrix(i+1)(j))+unsigned(blur_matrix(i+1)(j+1)));
			end loop blur_comp11;
		end loop blur_comp10;
	
		blur_sum_matrix(0)(0) <= std_logic_vector(unsigned(blur_matrix(0)(0))+unsigned(blur_matrix(0)(1))+unsigned(blur_matrix(1)(0))+unsigned(blur_matrix(1)(1)));
		blur_sum_matrix(0)(matrix_size-1) <= std_logic_vector(unsigned(blur_matrix(0)(matrix_size-2))+unsigned(blur_matrix(0)(matrix_size-1))+unsigned(blur_matrix(1)(matrix_size-2))+unsigned(blur_matrix(1)(matrix_size-1)));
		blur_sum_matrix(matrix_size-1)(0) <= std_logic_vector(unsigned(blur_matrix(matrix_size-2)(0))+unsigned(blur_matrix(matrix_size-2)(1))+unsigned(blur_matrix(matrix_size-1)(0))+unsigned(blur_matrix(matrix_size-1)(1)));
		blur_sum_matrix(matrix_size-1)(matrix_size-1) <= std_logic_vector(unsigned(blur_matrix(matrix_size-2)(matrix_size-2))+unsigned(blur_matrix(matrix_size-2)(matrix_size-1))+unsigned(blur_matrix(matrix_size-1)(matrix_size-2))+unsigned(blur_matrix(matrix_size-1)(matrix_size-1)));

		blur_comp12:for k in 1 to matrix_size-2 loop
			blur_sum_matrix(0)(k) <= std_logic_vector(unsigned(blur_matrix(0)(k-1))+unsigned(blur_matrix(0)(k))+unsigned(blur_matrix(0)(k+1))+unsigned(blur_matrix(1)(k-1))+unsigned(blur_matrix(1)(k))+unsigned(blur_matrix(1)(k+1)));
			blur_sum_matrix(k)(0) <= std_logic_vector(unsigned(blur_matrix(k-1)(0))+unsigned(blur_matrix(k-1)(1))+unsigned(blur_matrix(k)(0))+unsigned(blur_matrix(k)(1))+unsigned(blur_matrix(k+1)(0))+unsigned(blur_matrix(k+1)(1)));
			blur_sum_matrix(matrix_size-1)(k) <= std_logic_vector(unsigned(blur_matrix(matrix_size-2)(k-1))+unsigned(blur_matrix(matrix_size-2)(k))+unsigned(blur_matrix(matrix_size-2)(k+1))+unsigned(blur_matrix(matrix_size-1)(k-1))+unsigned(blur_matrix(matrix_size-1)(k))+unsigned(blur_matrix(matrix_size-1)(k+1)));
			blur_sum_matrix(k)(matrix_size-1) <= std_logic_vector(unsigned(blur_matrix(k-1)(matrix_size-2))+unsigned(blur_matrix(k-1)(matrix_size-1))+unsigned(blur_matrix(k)(matrix_size-2))+unsigned(blur_matrix(k)(matrix_size-1))+unsigned(blur_matrix(k+1)(matrix_size-2))+unsigned(blur_matrix(k+1)(matrix_size-1)));
		end loop blur_comp12;
	end process;
	
	blur_comp0: blur_mult port map (blur_mult_regxnor_value => blur_xnor_value,
							blur_mult_regop1 => blur_sum_matrix(0)(0),
      							blur_mult_regop2 => "001000000000",
							blur_mult_regres => blur_res_matrix(0)(0));

	blur_comp1: blur_mult port map (blur_mult_regxnor_value => blur_xnor_value,
							blur_mult_regop1 => blur_sum_matrix(0)(matrix_size-1),
      							blur_mult_regop2 => "001000000000",
							blur_mult_regres => blur_res_matrix(0)(matrix_size-1));
	
	blur_comp2: blur_mult port map (blur_mult_regxnor_value => blur_xnor_value,
							blur_mult_regop1 => blur_sum_matrix(matrix_size-1)(0),
      							blur_mult_regop2 => "001000000000",
							blur_mult_regres => blur_res_matrix(matrix_size-1)(0));

	blur_comp3: blur_mult port map (blur_mult_regxnor_value => blur_xnor_value,
							blur_mult_regop1 => blur_sum_matrix(matrix_size-1)(matrix_size-1),
      							blur_mult_regop2 => "001000000000",
							blur_mult_regres => blur_res_matrix(matrix_size-1)(matrix_size-1));
 
	blur_comp4: for m in 1 to matrix_size-2 generate
		blur_comp4_m : blur_mult port map (blur_mult_regxnor_value => blur_xnor_value,
							blur_mult_regop1 => blur_sum_matrix(0)(m),
      							blur_mult_regop2 => "000101000111",
							blur_mult_regres => blur_res_matrix(0)(m));
	end generate blur_comp4;

	blur_comp5: for m in 1 to matrix_size-2 generate
		blur_comp5_m : blur_mult port map (blur_mult_regxnor_value => blur_xnor_value,
							blur_mult_regop1 => blur_sum_matrix(m)(0),
      							blur_mult_regop2 => "000101000111",
							blur_mult_regres => blur_res_matrix(m)(0));
	end generate blur_comp5;
	
	blur_comp6: for m in 1 to matrix_size-2 generate
		blur_comp6_m : blur_mult port map (blur_mult_regxnor_value => blur_xnor_value,
							blur_mult_regop1 => blur_sum_matrix(matrix_size-1)(m),
      							blur_mult_regop2 => "000101000111",
							blur_mult_regres => blur_res_matrix(matrix_size-1)(m));
	end generate blur_comp6;

	blur_comp7: for m in 1 to matrix_size-2 generate
		blur_comp7_m : blur_mult port map (blur_mult_regxnor_value => blur_xnor_value,
							blur_mult_regop1 => blur_sum_matrix(m)(matrix_size-1),
      							blur_mult_regop2 => "000101000111",
							blur_mult_regres => blur_res_matrix(m)(matrix_size-1));
	end generate blur_comp7;

	blur_comp8: for m in 1 to matrix_size-2 generate
		blur_comp9: for n in 1 to matrix_size-2 generate
			blur_com9_m : blur_mult port map (blur_mult_regxnor_value => blur_xnor_value,
							blur_mult_regop1 => blur_sum_matrix(m)(n),
      							blur_mult_regop2 => "000011100001",
							blur_mult_regres => blur_res_matrix(m)(n));
		end generate blur_comp9;
	end generate blur_comp8;
	
end blur_arch;

