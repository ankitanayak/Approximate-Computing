library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.math_real.all;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;

entity tb_recursive_mult is
end tb_recursive_mult;


architecture tb_recursive_mult_behav of tb_recursive_mult is

component app_mult
   port
   (
	mxnor_value : in std_logic_vector (19 downto 0);
	mop1 : in std_logic_vector (9 downto 0);
      	mop2 : in std_logic_vector (9 downto 0);
	mres : out std_logic_vector (19 downto 0)
   );
end component;
  
signal t_mxnor_value : std_logic_vector (19 downto 0);
signal t_mop1, t_mop2 : std_logic_vector (9 downto 0);
signal t_mres : std_logic_vector (19 downto 0);
signal rand_num1 : integer := 0;
signal rand_num2 : integer := 0;


begin

	U1 : app_mult port map (t_mxnor_value, t_mop1, t_mop2, t_mres);
	test_process : process
	variable seed1, seed2: positive;
	variable seed3, seed4: positive;
    	variable rand1: real;
	variable rand2: real;
    	variable range_of_rand1 : real := 1000.0;
	variable range_of_rand2 : real := 500.0;
	variable l,m,n: line;
	file outfile: text open write_mode is "C:\Modeltech_pe_edu_10.4a\examples\output.txt";
	file op1file: text open write_mode is "C:\Modeltech_pe_edu_10.4a\examples\op1.txt";
	file op2file: text open write_mode is "C:\Modeltech_pe_edu_10.4a\examples\op2.txt";
	begin
		t_mxnor_value <= "11111111111111111111";
		uniform(seed1, seed2, rand1);
    		rand_num1 <= integer(rand1*range_of_rand1);
		t_mop1 <= conv_std_logic_vector(rand_num1, 10);
		uniform(seed3, seed4, rand2);
    		rand_num2 <= integer(rand2*range_of_rand2);
		t_mop2 <= conv_std_logic_vector(rand_num2, 10);
		write(l, t_mres);
		writeline(outfile, l);
		--write(m, t_regop1);
		--writeline(op1file, m);
		--write(n, t_regop2);
		--writeline(op2file, n);
    		wait for 10 ns;
	end process;

end tb_recursive_mult_behav;

configuration CFG_TB_top of tb_recursive_mult is
for tb_recursive_mult_behav
end for;
end CFG_TB_top;
