library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
 
entity dct1d_mult is
   port
   (
	dct1dxnor_value : in std_logic_vector (15 downto 0);
	dct1dop1 : in std_logic_vector (7 downto 0);
      	dct1dop2 : in std_logic_vector (7 downto 0);
	dct1dres : out std_logic_vector (15 downto 0)
   );
end entity dct1d_mult;

architecture dct1d_mult_arch of dct1d_mult is

component chaosadder
port
   (
	chaosadder_xnor_value : in std_logic_vector (15 downto 0);
	chaosadder_op1 : in std_logic_vector (13 downto 0);
      	chaosadder_op2 : in std_logic_vector (13 downto 0);
	chaosadder_cin : in std_logic;
	chaosadder_res : out std_logic_vector (13 downto 0);
	chaosadder_cout : out std_logic
   );
end component;

component twos_complement
port
   (
	input_value : in std_logic_vector (14 downto 0);
	tsign_bit : in std_logic;
	twos_complement_value : out std_logic_vector (14 downto 0)
   );
end component;

constant key_width: integer:=16;
constant operand_width: integer:=7;
constant result_width: integer:=operand_width*2;

type dct1dres_array is array (0 to operand_width-1) of std_logic_vector(result_width-1 downto 0);
type dct1dres_temp_array is array (0 to operand_width-2) of std_logic_vector(result_width-1 downto 0);
signal dct1d_res : dct1dres_array;
signal dct1dres_var : dct1dres_array;
signal dct1dres_temp : dct1dres_temp_array;
signal dct1dcout_junk : std_logic;
signal sign_bit: std_logic;
signal dct1dres_twos_complement: std_logic_vector(result_width downto 0);
signal dct1dres_intermediate: std_logic_vector(result_width downto 0);

begin
	
	process(dct1dop1, dct1dop2, dct1d_res, dct1dres_var)
	begin
		p1:for i in 0 to operand_width-1 loop
			if(dct1dop2(i)='1')then
				p3:for k in 0 to operand_width-1 loop
					dct1d_res(i)(k) <= dct1dop1(k);
					dct1d_res(i)(k+operand_width) <= '0';
				end loop p3;
			else
				p5:for n in 0 to result_width-1 loop
					dct1d_res(i)(n) <= '0';
				end loop p5;
			end if;
		end loop p1;


		p4:for j in 0 to operand_width-1 loop
			dct1dres_var(j) <= std_logic_vector(unsigned(dct1d_res(j)) sll j);
		end loop p4;

		
		sign_bit <= dct1dop1(operand_width) xor dct1dop2(operand_width);
	
		if(dct1dop1 = "00000000" or dct1dop2 = "00000000")then
			sign_bit <= '0';
		end if;

	end process;

	dct1d0: chaosadder port map (chaosadder_xnor_value => dct1dxnor_value,
					chaosadder_op1 => dct1dres_var(0),
      					chaosadder_op2 => dct1dres_var(1),
					chaosadder_cin => '0',
					chaosadder_res => dct1dres_temp(0),
					chaosadder_cout => dct1dcout_junk);
	dct1d1: for m in 0 to operand_width-3 generate
		dct1d_m : chaosadder port map (chaosadder_xnor_value => dct1dxnor_value,
					chaosadder_op1 => dct1dres_temp(m),
      					chaosadder_op2 => dct1dres_var(m+2),
					chaosadder_cin => '0',
					chaosadder_res => dct1dres_temp(m+1),
					chaosadder_cout => dct1dcout_junk);
    	end generate dct1d1;
	
	--dct1dres <= sign_bit & '0' & dct1dres_temp(operand_width-2);
	dct1dres_intermediate <= '0' & dct1dres_temp(operand_width-2);
	
	dct1d2: twos_complement port map (input_value => dct1dres_intermediate,
					tsign_bit => sign_bit,
					twos_complement_value => dct1dres_twos_complement);

	dct1dres <= sign_bit & dct1dres_twos_complement;
					
	
end dct1d_mult_arch;