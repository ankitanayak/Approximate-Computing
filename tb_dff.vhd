library ieee;
use ieee.std_logic_1164.all;

entity tb_dff is
end tb_dff;


architecture tb_dff_behav of tb_dff is

  component D_FF is
   port
   (
	clk : in std_logic; 
      	d : in std_logic; 
	reset : in std_logic;
      	q : out std_logic
   );
  end component;
  
  signal t_clk, t_d, t_reset, t_q : std_logic;


  begin

    U1 : D_FF
      port map (t_clk, t_d, t_reset, t_q);

    test_process : process
    begin
     
      	t_clk <= '0';
	t_d <= '0';
	wait for 5 ns;
	t_clk <= '1'; 
	wait for 5 ns;

	t_clk <= '0';
	t_d <= '0';
	wait for 5 ns;
	t_clk <= '1'; 
	wait for 5 ns;

	t_clk <= '0';
	t_d <= '1';
	wait for 5 ns;
	t_clk <= '1'; 
	wait for 5 ns;
	t_reset <= '1';

	t_clk <= '0';
	t_d <= '1';
	wait for 5 ns;
	t_clk <= '1'; 
	wait for 5 ns;
	t_reset <= '0';

	t_clk <= '0';
	t_d <= '0';
	wait for 5 ns;
	t_clk <= '1'; 
	wait for 5 ns;

	t_clk <= '0';
	t_d <= '0';
	wait for 5 ns;
	t_clk <= '1'; 
	wait for 5 ns;
	

	t_clk <= '0';
	t_d <= '1';
	wait for 5 ns;
	t_clk <= '1'; 
	wait for 5 ns;

	t_clk <= '0';
	t_d <= '1';
	wait for 5 ns;
	t_clk <= '1'; 
	wait for 5 ns;

	t_clk <= '0';
	t_d <= '0';
	wait for 5 ns;
	t_clk <= '1'; 
	wait for 5 ns;

	t_clk <= '0';
	t_d <= '0';
	wait for 5 ns;
	t_clk <= '1'; 
	wait for 5 ns;
	
t_clk <= '0'; 
wait for 5 ns;
t_clk <= '1';
wait for 5 ns;

t_clk <= '0'; 
wait for 5 ns;
t_clk <= '1';
wait for 5 ns;

t_clk <= '0'; 
wait for 5 ns;
t_clk <= '1';
wait for 5 ns;

t_clk <= '0'; 
wait for 5 ns;
t_clk <= '1';
wait for 5 ns;

t_clk <= '0'; 
wait for 5 ns;
t_clk <= '1';
wait for 5 ns;

t_clk <= '0'; 
wait for 5 ns;
t_clk <= '1';
wait for 5 ns;

t_clk <= '0'; 
wait for 5 ns;
t_clk <= '1';
wait for 5 ns;

      wait;

    end process;

end tb_dff_behav;

configuration CFG_TB_top of tb_dff is
for tb_dff_behav
end for;
end CFG_TB_top;
