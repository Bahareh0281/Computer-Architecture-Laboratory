----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:53:21 11/08/2023 
-- Design Name: 
-- Module Name:    RS232SerialCommunication - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RS232SerialCommunication is
    Port ( GCLK : in  STD_LOGIC;
           TX : out  STD_LOGIC;
           DIP : in  STD_LOGIC_VECTOR (7 downto 0));
end RS232SerialCommunication;

architecture Behavioral of RS232SerialCommunication is
	signal CLOCK174 : STD_LOGIC := '0';
begin

process(GCLK)
	variable CounterClock174 : integer range 0 to 100000 := 0;
	begin 
		if(rising_edge(GCLK)) then
			if(CounterClock174 < 174) then 
				CounterClock174 := CounterClock174  + 1;
			else
				CounterClock174  := 0;
				CLOCK174 <= not CLOCK174;
			end if;
		end if;
end process;

process (CLOCK174)
variable DipSwitchingBits : integer range 0 to 7 := 0;
-- 1 start(=0) + 8 bit + 2 stop(=01) => 11 bits
variable BitCounter : integer range 0 to 10 := 1;
-- For each 11 bits reading 
variable ClockCycle : integer range 0 to 80000 := 0;
begin
	if (rising_edge(CLOCK174)) then
		if(ClockCycle = 80000) then 
			-- first bit = start
			if (BitCounter = 0) then
				TX <= '0';
			-- One before last bit
			elsif (BitCounter = 9) then
				TX <= '0';
			-- Last bit
			elsif (BitCounter = 10) then
				TX <= '1';
				ClockCycle := 0;
			-- Data
			else 
				TX <= DIP(DipSwitchingBits);
				-- Increment the data index 
				if(DipSwitchingBits < 8) then 
					DipSwitchingBits := DipSwitchingBits + 1;
				-- Data finished
				else 
					DipSwitchingBits := 0;
				end if;
			end if;
				-- Checking the state of 11 bits
				if (BitCounter < 11) then
					BitCounter := BitCounter + 1;
				else 
					BitCounter := 0;	
			end if;
		else 
			ClockCycle := ClockCycle + 1;
		end if;
	end if;
end process;

end Behavioral;

