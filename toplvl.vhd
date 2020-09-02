----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:03:22 04/16/2015 
-- Design Name: 
-- Module Name:    memoper - Behavioral 
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

entity toplvl is
    Port ( Push : in  STD_LOGIC;
           Pop : in  STD_LOGIC;
           Add : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Num_In : in  STD_LOGIC_VECTOR (7 downto 0);
           Num_Out : out  STD_LOGIC_VECTOR (7 downto 0);
           SSD_En : out  STD_LOGIC_VECTOR (3 downto 0);
           Empty : out  STD_LOGIC;
           Full : out  STD_LOGIC;
           Almost_Empty : out  STD_LOGIC;
           Almost_Full : out  STD_LOGIC;
           Stack_Ovf : out  STD_LOGIC;
           Addition_Ovf : out  STD_LOGIC);
end toplvl;

architecture Behavioral of toplvl is

signal wen: std_logic_vector(0 to 0);
signal stack_add: std_logic_vector(1 downto 0);
signal t: std_logic_vector(2 downto 0):="000";
signal adr: std_logic_vector(4 downto 0);
signal mem_din, num, datin, sigadda, result: std_logic_vector(9 downto 0):=(others=>'0');

--dokimi me signal gia to port map Num_in, din, gia na kanw push 
--to apotelesma tis pros8esis sti mnimi
-- H MLKIA DE GRAFEI TO 11 ALLA GRAFEI THN PROHGOUMENH GAMHMENH TIMH

	COMPONENT memop
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		push : IN std_logic;
		pop : IN std_logic;
		add : IN std_logic;
		Din : IN std_logic_vector(9 downto 0);          
		full : OUT std_logic;
		empty : OUT std_logic;
		almost_full : OUT std_logic;
		almost_empty : OUT std_logic;
		ovf : OUT std_logic;
		WrEn : OUT std_logic_vector(0 to 0);
		stadd : OUT  STD_LOGIC_VECTOR (1 downto 0);
		addr : OUT std_logic_vector(4 downto 0);
		Dout : OUT std_logic_vector(9 downto 0)
		);
	END COMPONENT;

	COMPONENT datmem
	  PORT (
		 clka : IN STD_LOGIC;
		 wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 addra : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 dina : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 douta : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	  );
	END COMPONENT;


begin

--xreiazomaste 1 poluplekti pou 8a epilegei tin eksodo
--an 8a einai dld i eksodos tis stoibas i tou a8roisti

--sto module tou SSD 8a bei mia epipleon eisodos to empty
--kai an einai empty i anodos 8a einai "1111"

	mem_operations: memop PORT MAP(
		clk => Clk,
		rst => Reset,
		push => Push,
		pop => Pop,
		add => Add,
		full => Full,
		empty => Empty,
		almost_full => Almost_Full,
		almost_empty => Almost_Empty,
		ovf => Stack_Ovf,
		Din => datin,
		WrEn => wen,
		stadd => stack_add,
		addr => adr,
		Dout => mem_din
	);
	
	memory: datmem PORT MAP (
    clka => Clk,
    wea => wen,
    addra => adr,
    dina => mem_din,
    douta => num
  );
  
  
  ------------CHECK--------------------
--  process  --(stack_add, sigadda, result, datin)
--  begin
--	wait until Clk'event and Clk='1';
--	case stack_add is
--		when "01" =>
--			result<=num;
--		when "10" => --cycle 0
--			sigadda<=num;
--			case t is
--				when "000" => --cycle 1
--					t<="001";
--				when "001" => --cycle 2
--					t<="010";
--				when "010" => --cycle 3
--					t<="011";
--					result<=num+sigadda;
--				when "011" => --cycle 4
--					t<="100";
--					datin<=result;
--				when "100" => --cycle 5
--					t<="101";
--				when "101" =>
--					t<="000";
--					--datin<=result;
--				when others =>
--			end case;
--		when "11" =>	
----			datin<="00" & Num_in;
--		when others =>	
--	end case;
	
	
--	if stack_add="001" then    --almost_empty='1'
--		result<=num;
--	elsif stack_add="010" then --regular addition step 1 (fetch 1st operand)
--		sigadda<=num;
--	elsif stack_add="011" then --regular addition step 2 (fetch 2nd operand)
--		result<=num+sigadda;   
--				  --add and store result to 'result'
--	else
--		datin<="00" & Num_in;
--	end if; 
--	if result>999 then
--		Addition_Ovf<='1';
--	else
--		Addition_Ovf<='0';
--	end if;
--  end process;
  ------------CHECK--------------------
  
 Num_Out<=(others=>'1');
 datin<="00" & Num_in;

end Behavioral;

