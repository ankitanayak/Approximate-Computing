library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
 
entity mult is
   port
   (
	num1 : in std_logic_vector (4 downto 0);
	num2 : in std_logic_vector (4 downto 0);
      	approx_mul_flag : in std_logic;
	prod_num : out std_logic_vector (19 downto 0)
   );
end entity mult;

architecture mult_arch of mult is


function mult2x2( num2x2_1 : std_logic_vector; num2x2_2 : std_logic_vector; approx_mul2x2_flag : std_logic) return std_logic_vector is
variable numf2x2_1 : std_logic_vector(1 downto 0):=(others => '0');
variable numf2x2_2 : std_logic_vector(1 downto 0):=(others => '0');
variable approx_mulf2x2_flag : std_logic:='0';
variable prod2x2_numf : std_logic_vector(7 downto 0):=(others => '0');

begin
	numf2x2_1 := num2x2_1;
	numf2x2_2 := num2x2_2;
	approx_mulf2x2_flag := approx_mul2x2_flag;

	if numf2x2_1 = "00" or numf2x2_2 = "00" then
		prod2x2_numf := "00000000";
	elsif numf2x2_1 = "01" then
		prod2x2_numf := '0' & '0' & '0' & '0' & '0' & '0' & numf2x2_2;
	elsif numf2x2_2 = "01" then
		prod2x2_numf := '0' & '0' & '0' & '0' & '0' & '0' & numf2x2_1;
	elsif (numf2x2_1 = "11" and numf2x2_2 = "10") or (numf2x2_1 = "10" and numf2x2_2 = "11") then
		prod2x2_numf := "00000110";
	elsif numf2x2_1 = "10" and numf2x2_2 = "10" then
		prod2x2_numf := "00000100";
	elsif numf2x2_1 = "11" and numf2x2_2 = "11" and approx_mulf2x2_flag = '0' then
		prod2x2_numf := "00001001";
	elsif numf2x2_1 = "11" and numf2x2_2 = "11" and approx_mulf2x2_flag = '1' then
		prod2x2_numf := "00000111";
	end if;

return prod2x2_numf;

end mult2x2;



function mult_fun( num1 : std_logic_vector; num2 : std_logic_vector; approx_mul_flag : std_logic) return std_logic_vector is
variable numf1 : std_logic_vector(num1'length-1 downto 0):=(others => '0');
variable numf2 : std_logic_vector(num2'length-1 downto 0):=(others => '0');
variable approx_mulf_flag : std_logic:='0';
variable Af : std_logic_vector(num1'length downto 0):=(others => '0');
variable Xf : std_logic_vector(num2'length downto 0):=(others => '0');
variable AfH : std_logic_vector(((num1'length+1)/2)-1 downto 0):=(others => '0');
variable AfL : std_logic_vector(((num1'length+1)/2)-1 downto 0):=(others => '0');
variable XfH : std_logic_vector(((num2'length+1)/2)-1 downto 0):=(others => '0');
variable XfL : std_logic_vector(((num2'length+1)/2)-1 downto 0):=(others => '0');
variable out1 : std_logic_vector(19 downto 0):=(others => '0');
variable out2 : std_logic_vector(19 downto 0):=(others => '0');
variable out3 : std_logic_vector(19 downto 0):=(others => '0');
variable out4 : std_logic_vector(19 downto 0):=(others => '0');
variable out2x2_1 : std_logic_vector(7 downto 0):=(others => '0');
variable out2x2_2 : std_logic_vector(7 downto 0):=(others => '0');
variable out2x2_3 : std_logic_vector(7 downto 0):=(others => '0');
variable out2x2_4 : std_logic_vector(7 downto 0):=(others => '0');
variable prod_2x2_numf : std_logic_vector(19 downto 0):=(others => '0');
variable prod_numf : std_logic_vector(19 downto 0):=(others => '0');

begin
	numf1 := num1;
	numf2 := num2;
	approx_mulf_flag := approx_mul_flag;

	if(num1'length > 4)then
		if((num1'length mod 2)=1)then
			Af(num1'length) := '0';
			Xf(num1'length) := '0';
			n1:for i in 0 to num1'length-1 loop
				Af(i) := numf1(i);
				Xf(i) := numf2(i);
			end loop n1;
		end if;

		n2:for j in 0 to ((num1'length+1)/2)-1 loop
			if((num1'length mod 2)=1)then
				AfL(j) := Af(j);
				XfL(j) := Xf(j);
			else
				AfL(j) := numf1(j);
				XfL(j) := numf2(j);
			end if;
		end loop n2;

		if((num1'length mod 2)=1)then
			n3:for k in ((num1'length+1)/2) to num1'length loop
				AfH(k-((num1'length+1)/2)) := Af(k);
				XfH(k-((num1'length+1)/2)) := Xf(k);
			end loop n3;
		else
			n4:for l in ((num1'length+1)/2) to num1'length-1 loop
				AfH(l-((num1'length+1)/2)) := numf1(l);
				XfH(l-((num1'length+1)/2)) := numf2(l);
			end loop n4;
		end if;

		out1 := mult_fun(AfL, XfL, approx_mulf_flag);
		out2 := mult_fun(AfH, XfL, approx_mulf_flag);
		out3 := mult_fun(AfL, XfH, approx_mulf_flag);
		out4 := mult_fun(AfH, XfH, approx_mulf_flag);
	
		prod_numf := out1+std_logic_vector(unsigned(out2) sll ((num1'length+1)/2))+std_logic_vector(unsigned(out3) sll ((num1'length+1)/2))+std_logic_vector(unsigned(out4) sll (2*((num1'length+1)/2)));
		
		return prod_numf;
	
	else

		if((num1'length mod 2)=1)then
			Af(num1'length) := '0';
			Xf(num1'length) := '0';
			o1:for i in 0 to num1'length-1 loop
				Af(i) := numf1(i);
				Xf(i) := numf2(i);
			end loop o1;
		end if;

		o2:for j in 0 to ((num1'length+1)/2)-1 loop
			if((num1'length mod 2)=1)then
				AfL(j) := Af(j);
				XfL(j) := Xf(j);
			else
				AfL(j) := numf1(j);
				XfL(j) := numf2(j);
			end if;
		end loop o2;

		if((num1'length mod 2)=1)then
			o3:for k in ((num1'length+1)/2) to num1'length loop
				AfH(k-((num1'length+1)/2)) := Af(k);
				XfH(k-((num1'length+1)/2)) := Xf(k);
			end loop o3;
		else
			o4:for l in ((num1'length+1)/2) to num1'length-1 loop
				AfH(l-((num1'length+1)/2)) := numf1(l);
				XfH(l-((num1'length+1)/2)) := numf2(l);
			end loop o4;
		end if;

		out2x2_1 := mult2x2(AfL,XfL,approx_mulf_flag);
		out2x2_2 := mult2x2(AfH,XfL,approx_mulf_flag);
		out2x2_3 := mult2x2(AfL,XfH,approx_mulf_flag);
		out2x2_4 := mult2x2(AfH,XfH,approx_mulf_flag);

		prod_2x2_numf := "000000000000" & (out2x2_1+std_logic_vector(unsigned(out2x2_2) sll 2)+std_logic_vector(unsigned(out2x2_3) sll 2)+std_logic_vector(unsigned(out2x2_4) sll 4));
		
		return prod_2x2_numf;
	end if;
	
end mult_fun;


begin
	prod_num <= mult_fun(num1, num2, approx_mul_flag);
end architecture mult_arch;
	