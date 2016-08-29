library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity b02 is
port(reset : in std_logic;
	clock : in std_logic;
	linea : in std_logic;
	k: in std_logic;
   	count_out: out std_logic_vector (2 downto 0);
	u     : out std_logic
    );
end b02;

Architecture BEHAV_b02 of b02 is

	component logob2
	port
   	(
      		clk_out : in std_logic; 
      		k : in std_logic; 
		st_sel : out std_logic;
		count_out : out std_logic_vector (2 downto 0)
   	);
	end component;
	
	signal st_sel: std_logic;

	constant A:integer:=0;
	constant B:integer:=1;
	constant C:integer:=2;
	constant D:integer:=3;
	constant E:integer:=4;
	constant F:integer:=5;
	constant G:integer:=6;

begin

	V1 : logob2 port map (
		clk_out => clock, 
      		k => k,
		st_sel => st_sel,
		count_out => count_out);

    process(reset,clock,k)
        
	variable stato:integer range 6 downto 0;
    
    begin
        
        if reset='1' then 
           stato:=A;
           u<='0';
        elsif clock'event and clock='1' then
           case stato is
                
                when A => 
                     stato:=B; 
                     u<='0';
                when B =>  
			if st_sel = '0' then
				stato:=B;
			elsif st_sel = '1' then    
                     		if linea='0' then
                        		stato:=C;
                     		else
                        		stato:=F;
                     		end if;
			end if;
                     u<='0';
                when C =>     
                     if linea='0' then
                        stato:=D;
                     else
                        stato:=G;
                     end if;
                     u<='0';
                when D => 
                     stato:=E; 
                     u<='0';
                when E =>
                     stato:=B;
                     u<='1';
                when F =>
                     stato:=G;
                     u<='0';
                when G =>     
                     if linea='0' then
                        stato:=E;
                     else
                        stato:=A;
                     end if;
                     u<='0';

           end case;
        end if;

    end process;
end BEHAV_b02;
