----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:52:50 04/16/2015 
-- Design Name: 
-- Module Name:    memop - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memop is
    Port ( clk : in  STD_LOGIC;
			  rst : in STD_LOGIC;			  
           push : in  STD_LOGIC;
           pop : in  STD_LOGIC;
			  add : in  STD_LOGIC;
			  full : out STD_LOGIC;
			  empty : out STD_LOGIC;
			  almost_full : out STD_LOGIC;
			  almost_empty : out STD_LOGIC;
			  ovf: out STD_LOGIC;
           Din : in  STD_LOGIC_VECTOR (9 downto 0);
           WrEn : out  STD_LOGIC_VECTOR (0 downto 0);
           stadd : out  STD_LOGIC_VECTOR (1 downto 0);			  
           addr : out  STD_LOGIC_VECTOR (4 downto 0);
           Dout : out  STD_LOGIC_VECTOR (9 downto 0));
end memop;

architecture Behavioral of memop is

signal tmp, tmp2: STD_LOGIC_VECTOR(4 downto 0);
signal ad: STD_LOGIC_VECTOR(4 downto 0):="11111";
signal data: STD_LOGIC_VECTOR (9 downto 0);
signal we:STD_LOGIC_VECTOR (0 downto 0);
signal st_add:STD_LOGIC_VECTOR (1 downto 0):="11";
signal f, af, ae, ov: STD_LOGIC:='0';
signal e: STD_LOGIC:='1';
type state is (nul, rest, rest2, rest3, a, b, c, ca, d, dd, adda, addb, addc, addd, adde, addf, addg, addh);
signal st, nx_st: state:=nul;

-- 00000 -> 11111
-- 100000 ->

--prepei na ftiaxw add
--o stack pointer deixnei panta sto TOS
-- problem: an to add energopoieitai gia 1 kuklo, den proxwraei stin pros8esi

begin
process
begin
wait until clk'event and clk='1';
if (rst='1' or st=nul) then
	st<=rest;
else 
	st<=nx_st;
end if;
end process;

process(st, nx_st, push, pop, we)
begin
--st_add<="11";
case st is
	when rest =>
		data<=(others=>'0');		
		if ad>"00000" then
			we<="1";
			tmp<=ad;
			nx_st<=rest2;
		else
			nx_st<=rest3;
		end if;
	when rest2 =>
		ad<=tmp-'1';
		nx_st<=rest;
	when rest3 =>
		ad<="00000";
		we<="0";
		e<='1';
		nx_st<=a;
	when a =>
		case ad is 
			when "00000" =>
				e<='1';
				f<='0';
				ae<='0';
				af<='0';
			when others =>
				e<='0';
				f<='0';
				ae<='0';
				af<='0';

		end case;
		case tmp is
			when "00000" =>
				e<='0';
				f<='0';
				ae<='1';
				af<='0';
				ov<='0';
			when "11110" =>
				e<='0';
				f<='0';
				ae<='0';
				af<='1';
				ov<='0';
			when "11111" =>
				e<='0';
				f<='1';
				ae<='0';
				af<='0';
			when others =>
				e<='0';
				f<='0';
				ae<='0';
				af<='0';
				ov<='0';
		end case;
		if (push='1' and pop='0' and add='0') then
			if (ad<="11111" and f='0') then
				ov<='0';
				tmp<=ad;
				data<=Din; -->to memory
				nx_st<=b;
			else
				ov<='1';
				we<="0";
				nx_st<=a;
			end if;
		end if;
		if (pop='1' and push='0' and add='0') then
			if (tmp>="00001" and e='0') then
				tmp2<=tmp;
				nx_st<=d;
			else
				nx_st<=a;
			end if;
		end if;
		if (add='1' and push='0' and pop='0') then --cycle 0
			if e='1' then
				nx_st<=a;
			elsif ae='1' then
				st_add<="01"; --almost empty
				nx_st<=adda;
			else
				st_add<="10"; --not almost empty
				tmp<=ad;
				nx_st<=addb;
			end if;
		end if;
	when b =>
		if ad<"11111" then
			ad<=tmp+'1';		
		else
			ad<=ad;
		end if;
		nx_st<=c;
	when c =>
		we<="1";
		nx_st<=ca;
	when ca =>
		we<="0";
		nx_st<=a;
	when d =>
		tmp<=tmp2-'1';
		nx_st<=dd;
	when dd =>
	if tmp>"00000" then
		ad<=tmp2;
	else
		ad<=tmp;
	end if;
		nx_st<=a;
	when adda =>
		st_add<="11";
		nx_st<=a;
	when addb => --cycle 1
		st_add<="10"; 
		ad<=tmp-'1';
		nx_st<=addc;
	when addc => --cycle 2	
		if ad<="11110" then
			tmp<=ad;
			nx_st<=addd;
		else
			ov<='1';
			we<="0";
			nx_st<=a;
		end if;
	when addd => --cycle 3
		ad<=tmp+2;
		nx_st<=adde;
	when adde => --cycle 4
		data<=Din; -->to memory
		nx_st<=addf;
	when addf => --cycle 5
		nx_st<=addg;
	when addg => --cycle 6
		we<="1";
		nx_st<=addh;
	when addh =>
		we<="0";
		st_add<="11";
		nx_st<=a;
	when others =>
	end case;
end process;

full<=f;
empty<=e;
almost_full<=af;
almost_empty<=ae;
Dout<=data; --> to memory
ovf<=ov;
WrEn<=we;
addr<=tmp;
stadd<=st_add;

end Behavioral;

