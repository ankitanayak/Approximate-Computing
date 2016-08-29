library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity D_FF is
   port
   (
      	clk : in std_logic; 
      	d : in std_logic; 
	reset : in std_logic;
      	q : out std_logic
   );
end entity D_FF;
 
architecture DD_FF_Behav of D_FF is
begin
   process (clk) is
   begin
      	if clk' event and clk = '1' then
		if (reset = '1') then
         		q <= '0';
	   	else 
            	q <= d;
      		end if;
	end if;
   end process;
end architecture DD_FF_Behav;
