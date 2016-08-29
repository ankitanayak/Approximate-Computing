library ieee;
use ieee.std_logic_1164.all;


entity tb_Counter_3bit is
end tb_Counter_3bit;


architecture tb_Counter_3bit_behav of tb_Counter_3bit is

  component Counter_3bit is
   port
   (
	CLK : in  STD_LOGIC;
        Count : out  STD_LOGIC_VECTOR (2 downto 0)
   );
  end component;
  
  signal t_clk: std_logic;
  signal t_count: std_logic_vector (2 downto 0);


  begin

    U1 : Counter_3bit
      port map (t_clk, t_count);

    test_process : process
    begin
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

end tb_Counter_3bit_behav;

configuration CFG_TB_top of tb_Counter_3bit is
for tb_Counter_3bit_behav
end for;
end CFG_TB_top;
