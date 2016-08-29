library ieee;
use ieee.std_logic_1164.all;

entity inverter is
  port(
    inp : in std_logic;
    outp       : out std_logic
  );
end entity inverter;

architecture inverter_behav of inverter is
begin 

  inverter_process: process (inp)
  begin
    
    outp <= not inp;
    
  end process inverter_process;

end inverter_behav;
