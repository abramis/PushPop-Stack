--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:09:27 04/17/2015
-- Design Name:   
-- Module Name:   C:/Users/cst/lab4proxw/systest.vhd
-- Project Name:  lab4proxw
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: toplvl
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY systest IS
END systest;
 
ARCHITECTURE behavior OF systest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT toplvl
    PORT(
         Push : IN  std_logic;
         Pop : IN  std_logic;
         Add : IN  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         Num_In : IN  std_logic_vector(7 downto 0);
         Num_Out : OUT  std_logic_vector(7 downto 0);
         SSD_En : OUT  std_logic_vector(3 downto 0);
         Empty : OUT  std_logic;
         Full : OUT  std_logic;
         Almost_Empty : OUT  std_logic;
         Almost_Full : OUT  std_logic;
         Stack_Ovf : OUT  std_logic;
         Addition_Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Push : std_logic := '0';
   signal Pop : std_logic := '0';
   signal Add : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';
   signal Num_In : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal Num_Out : std_logic_vector(7 downto 0);
   signal SSD_En : std_logic_vector(3 downto 0);
   signal Empty : std_logic;
   signal Full : std_logic;
   signal Almost_Empty : std_logic;
   signal Almost_Full : std_logic;
   signal Stack_Ovf : std_logic;
   signal Addition_Ovf : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: toplvl PORT MAP (
          Push => Push,
          Pop => Pop,
          Add => Add,
          Reset => Reset,
          Clk => Clk,
          Num_In => Num_In,
          Num_Out => Num_Out,
          SSD_En => SSD_En,
          Empty => Empty,
          Full => Full,
          Almost_Empty => Almost_Empty,
          Almost_Full => Almost_Full,
          Stack_Ovf => Stack_Ovf,
          Addition_Ovf => Addition_Ovf
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin	
--		Reset<='1';
--      wait for Clk_period;
--		Reset<='0';
		wait for 650ns;
      Num_In<="00000001";
		Push<='1';
		wait for Clk_period;
		Push<='0';
		wait for Clk_period*4;
		Push<='1';
		Num_In<="00000010";
		wait for Clk_period;
		Push<='0';
		Reset<='1';
      wait for Clk_period;
		Reset<='0';
		wait for 630ns;
		wait for Clk_period*4;
		Num_In<="00000011";
		Push<='1';
		wait for Clk_period*4*28;
		Push<='0';
		wait for Clk_period*4;
		Num_In<="00001001";
		Push<='1';
		wait for Clk_period;
		Push<='0';
		wait for Clk_period*4;
		Push<='1';
		Num_In<="00001010";
		wait for Clk_period*4*3;
		Push<='0';
		wait for Clk_period*4;	--gemise i mnimi
		
		Pop<='1';		--2 pop
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
		Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*5;
		
		
		Push<='1';
		Num_In<="01001010";		--edw thesi 30
		wait for Clk_period;
		Push<='0';
		wait for Clk_period*4;
				Push<='1';			--apo dw kai pera fullarei, proairetika, valto sxolia alliws
		Num_In<="01001010";
		wait for Clk_period;
		Push<='0';
		wait for Clk_period*4;
				Push<='1';
		Num_In<="01001010";
		wait for Clk_period;
		Push<='0';
		wait for Clk_period*4;
				Push<='1';
		Num_In<="01001010";
		wait for Clk_period;
		Push<='0';
		wait for Clk_period*4;
		
		--33pop
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
				Pop<='1';
		wait for Clk_period;
		Pop<='0';
		wait for Clk_period*4;
		
						Push<='1';
		Num_In<="01111110";		--prepei na mpei sti thesi 0 tis mnimis
		wait for Clk_period;
		Push<='0';
		wait for Clk_period*4;

--				Push<='1';
--		Num_In<="11101010";
--		wait for Clk_period;
--		Push<='0';
--		wait for Clk_period*4;
--				Push<='1';
--		Num_In<="11111010";
--		wait for Clk_period;
--		Push<='0';
--		wait for Clk_period*4;


--		Push<='0';
--		wait for Clk_period*4;
--      Num_In<="00000010";
--		Push<='1';
--		wait for Clk_period*4;
--      Num_In<="00000011";
--		Push<='1';
--		wait for Clk_period*4;
--      Num_In<="00000100";
--		Push<='1';
--		wait for Clk_period*4;
--      Num_In<="00000101";
--		Push<='1';
--		wait for Clk_period*36;
--		Num_In<="00000110";
--		wait for Clk_period*4;
--		Push<='0';
		wait for Clk_period*5;
      Add<='1';
		wait for Clk_period;
		Add<='0';
		--wait for Clk_period*200;
      Num_In<="00000111";
--		Push<='1';
		wait for Clk_period*8;
		Push<='0';
--		Reset<='1';
--		wait for Clk_period;
--		Reset<='0';
--		wait for Clk_period*3*5;
--		Pop<='0';
      wait;
   end process;

END;
