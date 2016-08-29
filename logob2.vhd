library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity logob2 is
   port
   (
      	clk_out : in std_logic; 
      	k : in std_logic; 
	st_sel : out std_logic;
	count_out : out std_logic_vector (2 downto 0)
   );
end entity logob2;
 
architecture logob2_Behav of logob2 is

component Counter_3bit
port
   (
	CLK : in  std_logic;
        Count : out  std_logic_vector (2 downto 0)
   );
end component;

signal s, const_1  : std_logic;
signal count_wire : std_logic_vector (2 downto 0);
begin

	U1 : Counter_3bit port map (
		CLK => clk_out,
		Count => count_wire);

	count_out <= count_wire;

	const_1 <= '1';

	s <= count_wire(2) and count_wire(1) and count_wire(0);

	process (clk_out, k) is
	begin
	
		if k = '1' then
			st_sel <= const_1;
		elsif k = '0' then
			st_sel <= s;
		end if;


	end process;
		
	
end architecture logob2_Behav;
