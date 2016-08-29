library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity logob is
   port
   (
      	clk_out : in std_logic; 
      	k : in std_logic; 
	inp : in std_logic;
	reset : in std_logic;
	s_out: out std_logic;
	st_sel_out: out std_logic;
	count_out : out std_logic_vector (2 downto 0);
      	outp : out std_logic
   );
end entity logob;
 
architecture logob_Behav of logob is

component Counter_3bit
port
   (
	CLK : in  STD_LOGIC;
        Count : out  STD_LOGIC_VECTOR (2 downto 0)
   );
end component;

signal d, q, prev_state, st_sel, s, const_1  : std_logic;
signal count_wire : std_logic_vector (2 downto 0);
begin

	U1 : Counter_3bit port map (
		CLK => clk_out,
		Count => count_wire);

	count_out <= count_wire;

	const_1 <= '1';

	s <= count_wire(2) and count_wire(1) and count_wire(0);
	s_out <= s;

	process (clk_out, k, inp, reset) is
	begin
	
		if k = '1' then
			st_sel <= const_1;
			st_sel_out <= st_sel;
		elsif k = '0' then
			st_sel <= s;
			st_sel_out <= st_sel;
		end if;
	
		if clk_out' event and clk_out = '1' then
			if (reset = '1') then
         			q <= '0';
	   		else 
				q <= d;
			end if;
		end if;

		if st_sel = '1' then
			d <= not q;
			--d <= q or clk_out;
		elsif st_sel = '0' then
			d <= q;
		end if;

		outp <= q;


	end process;
		
	
end architecture logob_Behav;
