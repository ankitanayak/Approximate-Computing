library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
 
entity dct1d_comp is
   port
   (
	Mxnor_value : std_logic_vector (15 downto 0);
	tm_out_flag : out std_logic
   );
end entity dct1d_comp;

architecture dct1d_comp_arch of dct1d_comp is

component dct1d_mult
port
   (
	dct1dxnor_value : in std_logic_vector (15 downto 0);
	dct1dop1 : in std_logic_vector (7 downto 0);
      	dct1dop2 : in std_logic_vector (7 downto 0);
	dct1dres : out std_logic_vector (15 downto 0)
   );
end component;

component dct_adder1
port
   (
	dct_adder1_xnor_value : in std_logic_vector (15 downto 0);
	dct_adder1_op1 : in std_logic_vector (15 downto 0);
      	dct_adder1_op2 : in std_logic_vector (15 downto 0);
	dct_adder1_cin : in std_logic;
	dct_adder1_res : out std_logic_vector (15 downto 0);
	dct_adder1_cout : out std_logic
   );
end component;

constant key_width: integer:=16;
constant operand_width: integer:=8;
constant result_width: integer:=operand_width*2;

type t_matrix_row_type is array (0 to operand_width-1) of std_logic_vector(operand_width-1 downto 0);
type t_matrix_type is array (0 to operand_width-1) of t_matrix_row_type;

type res_matrix_row_type is array (0 to operand_width-1) of std_logic_vector(result_width-1 downto 0);
type res_matrix_type is array (0 to operand_width-1) of res_matrix_row_type;
type mult_matrix_type is array (0 to operand_width-1) of res_matrix_type;

type res_matrix_temp_array1 is array (0 to operand_width-2) of std_logic_vector(result_width-1 downto 0);
type res_matrix_temp_array2 is array (0 to operand_width-1) of res_matrix_temp_array1;
type res_matrix_temp_array is array (0 to operand_width-1) of res_matrix_temp_array2;

signal t_matrix : t_matrix_type;
signal min_matrix : t_matrix_type;

signal res_matrix : mult_matrix_type;
signal res_matrix_temp : res_matrix_temp_array;

signal tm_matrix : res_matrix_type;

signal res_cout_junk : std_logic;


begin
	t_matrix(0)(0) <= "00010110";
	t_matrix(0)(1) <= "00010110";
	t_matrix(0)(2) <= "00010110";
	t_matrix(0)(3) <= "00010110";
	t_matrix(0)(4) <= "00010110";
	t_matrix(0)(5) <= "00010110";
	t_matrix(0)(6) <= "00010110";
	t_matrix(0)(7) <= "00010110";

	t_matrix(1)(0) <= "00011111";
	t_matrix(1)(1) <= "00011010";
	t_matrix(1)(2) <= "00010001";
	t_matrix(1)(3) <= "00000110";
	t_matrix(1)(4) <= "10000110";
	t_matrix(1)(5) <= "10010001";
	t_matrix(1)(6) <= "10011010";
	t_matrix(1)(7) <= "10011111";

	t_matrix(2)(0) <= "00011101";
	t_matrix(2)(1) <= "00001100";
	t_matrix(2)(2) <= "10001100";
	t_matrix(2)(3) <= "10011101";
	t_matrix(2)(4) <= "10011101";
	t_matrix(2)(5) <= "10001100";
	t_matrix(2)(6) <= "00001100";
	t_matrix(2)(7) <= "00011101";

	t_matrix(3)(0) <= "00011010";
	t_matrix(3)(1) <= "10000110";
	t_matrix(3)(2) <= "10011111";
	t_matrix(3)(3) <= "10010001";
	t_matrix(3)(4) <= "00010001";
	t_matrix(3)(5) <= "00011111";
	t_matrix(3)(6) <= "00000110";
	t_matrix(3)(7) <= "10011010";

	t_matrix(4)(0) <= "00010110";
	t_matrix(4)(1) <= "10010110";
	t_matrix(4)(2) <= "10010110";
	t_matrix(4)(3) <= "00010110";
	t_matrix(4)(4) <= "00010110";
	t_matrix(4)(5) <= "10010110";
	t_matrix(4)(6) <= "10010110";
	t_matrix(4)(7) <= "00010110";

	t_matrix(5)(0) <= "00010001";
	t_matrix(5)(1) <= "10011111";
	t_matrix(5)(2) <= "00000110";
	t_matrix(5)(3) <= "00011010";
	t_matrix(5)(4) <= "10011010";
	t_matrix(5)(5) <= "10000110";
	t_matrix(5)(6) <= "00011111";
	t_matrix(5)(7) <= "10010001";

	t_matrix(6)(0) <= "00001100";
	t_matrix(6)(1) <= "10011101";
	t_matrix(6)(2) <= "00011101";
	t_matrix(6)(3) <= "10001100";
	t_matrix(6)(4) <= "10001100";
	t_matrix(6)(5) <= "00011101";
	t_matrix(6)(6) <= "10011101";
	t_matrix(6)(7) <= "00001100";

	t_matrix(7)(0) <= "00000110";
	t_matrix(7)(1) <= "10010001";
	t_matrix(7)(2) <= "00011010";
	t_matrix(7)(3) <= "10011111";
	t_matrix(7)(4) <= "00011111";
	t_matrix(7)(5) <= "10011010";
	t_matrix(7)(6) <= "00010001";
	t_matrix(7)(7) <= "10000110";

	
	min_matrix(0)(0) <= "00011010";
	min_matrix(0)(1) <= "10000101";
	min_matrix(0)(2) <= "10000101";
	min_matrix(0)(3) <= "10000101";
	min_matrix(0)(4) <= "10000101";
	min_matrix(0)(5) <= "10000101";
	min_matrix(0)(6) <= "10000101";
	min_matrix(0)(7) <= "00001000";

	min_matrix(1)(0) <= "01000000";
	min_matrix(1)(1) <= "00110100";
	min_matrix(1)(2) <= "00001000";
	min_matrix(1)(3) <= "00011010";
	min_matrix(1)(4) <= "00011010";
	min_matrix(1)(5) <= "00011010";
	min_matrix(1)(6) <= "00001000";
	min_matrix(1)(7) <= "10010010";

	min_matrix(2)(0) <= "01111110";
	min_matrix(2)(1) <= "01000110";
	min_matrix(2)(2) <= "00011010";
	min_matrix(2)(3) <= "00011010";
	min_matrix(2)(4) <= "00110100";
	min_matrix(2)(5) <= "00011010";
	min_matrix(2)(6) <= "10000101";
	min_matrix(2)(7) <= "10000101";

	min_matrix(3)(0) <= "01101111";
	min_matrix(3)(1) <= "00110100";
	min_matrix(3)(2) <= "00001000";
	min_matrix(3)(3) <= "00110100";
	min_matrix(3)(4) <= "00110100";
	min_matrix(3)(5) <= "00100110";
	min_matrix(3)(6) <= "10000101";
	min_matrix(3)(7) <= "10000101";

	min_matrix(4)(0) <= "00110100";
	min_matrix(4)(1) <= "00011010";
	min_matrix(4)(2) <= "00001000";
	min_matrix(4)(3) <= "00100111";
	min_matrix(4)(4) <= "00100110";
	min_matrix(4)(5) <= "00010101";
	min_matrix(4)(6) <= "00001000";
	min_matrix(4)(7) <= "00001000";

	min_matrix(5)(0) <= "00000000";
	min_matrix(5)(1) <= "00001000";
	min_matrix(5)(2) <= "10000101";
	min_matrix(5)(3) <= "00001000";
	min_matrix(5)(4) <= "00011010";
	min_matrix(5)(5) <= "00110100";
	min_matrix(5)(6) <= "01000110";
	min_matrix(5)(7) <= "00011010";

	min_matrix(6)(0) <= "10000101";
	min_matrix(6)(1) <= "10010111";
	min_matrix(6)(2) <= "10010010";
	min_matrix(6)(3) <= "00010101";
	min_matrix(6)(4) <= "00001000";
	min_matrix(6)(5) <= "00001000";
	min_matrix(6)(6) <= "00110100";
	min_matrix(6)(7) <= "00100110";

	min_matrix(7)(0) <= "10010010";
	min_matrix(7)(1) <= "00001000";
	min_matrix(7)(2) <= "10000101";
	min_matrix(7)(3) <= "10000101";
	min_matrix(7)(4) <= "10000101";
	min_matrix(7)(5) <= "00001000";
	min_matrix(7)(6) <= "00011010";
	min_matrix(7)(7) <= "00001000";

	dct1d_comp0: for m in 0 to operand_width-1 generate
		dct1d_comp1: for n in 0 to operand_width-1 generate
			dct1d_comp2: for p in 0 to operand_width-1 generate
				dct1d_comp_m : dct1d_mult port map (dct1dxnor_value => Mxnor_value,
								dct1dop1 => t_matrix(m)(p),
      								dct1dop2 => min_matrix(p)(n),
								dct1dres => res_matrix(m)(n)(p));
			end generate dct1d_comp2;
		end generate dct1d_comp1;
	end generate dct1d_comp0;


	dct1d_comp3: for m in 0 to operand_width-1 generate
		dct1d_comp4: for n in 0 to operand_width-1 generate
			dct1d_comp5: dct_adder1 port map (dct_adder1_xnor_value => Mxnor_value,
					dct_adder1_op1 => res_matrix(m)(n)(0),
      					dct_adder1_op2 => res_matrix(m)(n)(1),
					dct_adder1_cin => '0',
					dct_adder1_res => res_matrix_temp(m)(n)(0),
					dct_adder1_cout => res_cout_junk);
			dct1d_comp6: for q in 0 to operand_width-3 generate
				dct1d_comp_q : dct_adder1 port map (dct_adder1_xnor_value => Mxnor_value,
					dct_adder1_op1 => res_matrix_temp(m)(n)(q),
      					dct_adder1_op2 => res_matrix(m)(n)(q+2),
					dct_adder1_cin => '0',
					dct_adder1_res => res_matrix_temp(m)(n)(q+1),
					dct_adder1_cout => res_cout_junk);
    			end generate dct1d_comp6;

			tm_matrix(m)(n) <= res_matrix_temp(m)(n)(operand_width-2);

		end generate dct1d_comp4;
	end generate dct1d_comp3;
	
	tm_out_flag <= '1';

end dct1d_comp_arch;