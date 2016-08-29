library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity clk_div_behav is
   port
   (
      	clk : in std_logic;  
	reset : in std_logic;
      	q : out std_logic
   );
end entity clk_div_behav;
 
architecture clk_div_Behav of clk_div_behav is
signal dwire, qwire : std_logic;
begin
   	process (clk) is
   	begin
		dwire <= not qwire;
      		if clk' event and clk = '1' then
			--dwire <= not qwire;
			if (reset = '1') then
         			qwire <= '0';
	   		else 
            			qwire <= dwire;
      			end if;
		
			q <= qwire;
		end if;
		--q <= qwire;
   	end process;
end architecture clk_div_Behav;
