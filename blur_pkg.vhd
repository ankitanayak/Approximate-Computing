library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
package blur_pkg is

	constant matrix_size: integer:=8;
	constant operand_width: integer:=12;
	constant result_width: integer:=operand_width*2;

	type blur_matrix_int_type is array (0 to (matrix_size*matrix_size)-1) of integer;
	type blur_neighbor_row_type is array (0 to matrix_size+1) of integer;
	type blur_neighbor_column_type is array (0 to matrix_size-1) of integer;
 
 	type blur_res_matrix_row_type is array (0 to matrix_size-1) of std_logic_vector(result_width-1 downto 0);
	type blur_res_matrix_type is array (0 to matrix_size-1) of blur_res_matrix_row_type;
 
 
end package blur_pkg;