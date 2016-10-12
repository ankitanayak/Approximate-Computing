library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.math_real.all;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;

entity tb_app_comp is
end tb_app_comp;


architecture tb_app_comp_behav of tb_app_comp is

component app_comp is
port
   (
	xnor_value : in std_logic_vector (9 downto 0);
	op1 : in std_logic_vector (9 downto 0);
      	op2 : in std_logic_vector (9 downto 0);
	cin : in std_logic;
	res : out std_logic_vector (9 downto 0);
	cout : out std_logic
   );
end component;
  
signal t_xnor_value : std_logic_vector (9 downto 0);
signal t_op1, t_op2 : std_logic_vector (9 downto 0);
signal t_cin, t_cout : std_logic;
signal t_res : std_logic_vector (9 downto 0);
signal rand_num1 : integer := 0;
signal rand_num2 : integer := 0;

begin

	v1 : app_comp port map (t_xnor_value, t_op1, t_op2, t_cin, t_res, t_cout);
	test_process : process
	variable seed1, seed2: positive;
	variable seed3, seed4: positive;
    	variable rand1: real;
	variable rand2: real;
    	variable range_of_rand1 : real := 500.0;
	variable range_of_rand2 : real := 250.0;
	variable l,m,n: line;
	file outfile: text open write_mode is "C:\Modeltech_pe_edu_10.4a\examples\output.txt";
	file op1file: text open write_mode is "C:\Modeltech_pe_edu_10.4a\examples\op1.txt";
	file op2file: text open write_mode is "C:\Modeltech_pe_edu_10.4a\examples\op2.txt";
	begin
		t_xnor_value <= "1111111111";
		t_cin <= '0';
		uniform(seed1, seed2, rand1);
    		rand_num1 <= integer(rand1*range_of_rand1);
		t_op1 <= conv_std_logic_vector(rand_num1, 10);
		uniform(seed3, seed4, rand2);
    		rand_num2 <= integer(rand2*range_of_rand2);
		t_op2 <= conv_std_logic_vector(rand_num2, 10);
		write(l, t_res);
		writeline(outfile, l);
		write(m, t_op1);
		writeline(op1file, m);
		write(n, t_op2);
		writeline(op2file, n);
    		wait for 10 ns;
	end process;

end tb_app_comp_behav;

configuration CFG_TB_top of tb_app_comp is
for tb_app_comp_behav
end for;
end CFG_TB_top;
