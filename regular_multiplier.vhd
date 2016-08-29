library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
 
entity reg_mult is
   port
   (
	regxnor_value : in std_logic_vector (7 downto 0);
	regop1 : in std_logic_vector (9 downto 0);
      	regop2 : in std_logic_vector (9 downto 0);
	regres : out std_logic_vector (19 downto 0)
   );
end entity reg_mult;

architecture reg_mult_arch of reg_mult is

component app_comp
port
   (
	xnor_value : in std_logic_vector (7 downto 0);
	op1 : in std_logic_vector (19 downto 0);
      	op2 : in std_logic_vector (19 downto 0);
	cin : in std_logic;
	res : out std_logic_vector (19 downto 0);
	cout : out std_logic
   );
end component;

constant key_width: integer:=8;
constant operand_width: integer:=10;
constant result_width: integer:=operand_width*2;

type regres_array is array (0 to operand_width-1) of std_logic_vector(result_width-1 downto 0);
type regres_temp_array is array (0 to operand_width-2) of std_logic_vector(result_width-1 downto 0);
signal reg_res : regres_array;
signal regres_var : regres_array;
signal regres_temp : regres_temp_array;
signal cout_junk : std_logic;

begin
	
	process(regop1, regop2, reg_res, regres_var)
	begin
		p1:for i in 0 to operand_width-1 loop
			if(regop2(i)='1')then
				p3:for k in 0 to operand_width-1 loop
					reg_res(i)(k) <= regop1(k);
					reg_res(i)(k+operand_width) <= '0';
				end loop p3;
			else
				p5:for n in 0 to result_width-1 loop
					reg_res(i)(n) <= '0';
				end loop p5;
			end if;
		end loop p1;

		--regres_var(0) <= reg_res(0);

		p4:for j in 0 to operand_width-1 loop
			regres_var(j) <= std_logic_vector(unsigned(reg_res(j)) sll j);
		end loop p4;

		--p2:for j in 1 to operand_width-1 loop
			--regres_var(j) <= regres_var(j-1)+std_logic_vector(unsigned(reg_res(j)) sll j);
		--end loop p2;
		
		--regres <= regres_var(operand_width-1);

	end process;

	W0: app_comp port map (xnor_value => regxnor_value,
					op1 => regres_var(0),
      					op2 => regres_var(1),
					cin => '0',
					res => regres_temp(0),
					cout => cout_junk);
	W1: for m in 0 to operand_width-3 generate
		W_m : app_comp port map (xnor_value => regxnor_value,
					op1 => regres_temp(m),
      					op2 => regres_var(m+2),
					cin => '0',
					res => regres_temp(m+1),
					cout => cout_junk);
    	end generate W1;
	
	regres <= regres_temp(operand_width-2);

end reg_mult_arch;