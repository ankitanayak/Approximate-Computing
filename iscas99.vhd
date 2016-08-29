library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity b01 is 
port(
   line1: in std_logic; 
   line2: in std_logic;
   reset: in std_logic;
   k: in std_logic;
   count_out: out std_logic_vector (2 downto 0);
   outp  : out std_logic;
   overflw : out std_logic;
   clock : in std_logic );
end b01;

architecture BEHAV of b01 is
	
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

	constant a:integer:=0;
	constant b:integer:=1;
	constant c:integer:=2;
	constant e:integer:=3;
	constant f:integer:=4;
	constant g:integer:=5;
	constant wf0:integer:=6;
	constant wf1:integer:=7;

begin
	
	V1 : logob2 port map (
		clk_out => clock, 
      		k => k,
		st_sel => st_sel,
		count_out => count_out);
	
	
        process(clock,reset,k)
        
	variable stato: integer range 7 downto 0;

        begin
        if reset='1' then 
		stato:=a;
		outp<='0';
		overflw<='0';
        elsif clock'event and clock='1' then 
		case stato is
		when a => 
			if st_sel = '0' then
				stato:=a;
			elsif st_sel = '1' then 
				if line1='1' and line2='1' then
					stato:=f;
				else
					stato:=b ;
				end if;
			end if;
			outp <= line1 xor line2;
			overflw <= '0' ;
		when e => 
			if line1='1' and line2='1' then
				stato:=f;
			else
				stato:=b ;
			end if;
			outp <= line1 xor line2;
			overflw <= '1';
               when b   =>
                           if line1='1' and line2='1' then 
                                          stato:=g ;
                           else 
                                          stato:=c;
                           end if;
			outp <= line1 xor line2;
			overflw <= '0' ;
               when f   =>
                           if line1='1' or line2='1' then
                                          stato:=g;
                           else
                                          stato:=c;
                           end if;
			outp <= not(line1 xor line2);
			overflw <= '0' ;
               when c  =>
                           if line1='1' and line2='1' then 
                                          stato:=wf1;
                           else
                                          stato:=wf0;
                           end if;
			outp <= line1 xor line2;
			overflw <= '0' ;
               when g  =>
                           if line1='1' or line2='1' then 
                                          stato:=wf1;
                           else
                                          stato:=wf0;
                           end if;
			outp <= not(line1 xor line2);
			overflw <= '0' ;
               when wf0 => 
                           if line1='1' and line2='1' then 
                                          stato:=e;
                           else
                                          stato:=a;
                           end if;
			outp <= line1 xor line2;
			overflw <= '0' ;
               when wf1 => 
                           if line1='1' or line2='1' then 
                                          stato:=e;
                           else             
                                          stato:=a;
                           end if;
			outp <= not(line1 xor line2);
			overflw <= '0' ;
              end case;
        end if;

	end process;
end BEHAV;







