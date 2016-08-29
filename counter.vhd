library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Counter_3bit is
    Port ( CLK : in  std_logic;
           Count : out  std_logic_vector (2 downto 0));
end Counter_3bit;

architecture Behavioral of Counter_3bit is
    signal cin : std_logic_vector(2 downto 0) :="000";
begin
    process(CLK)
    begin
        if(rising_edge(CLK)) then
            if(cin = "111") then
                cin <= "000";
            else
                cin <= cin + 1;
            end if;
        end if;
        
        Count <= cin;
    end process;
end Behavioral;
