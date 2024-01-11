----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:45:23 11/29/2023 
-- Design Name: 
-- Module Name:    RXSerialRead - Behavioral 
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

entity RXSerialRead is
    Port ( LED : out  STD_LOGIC_VECTOR (7 downto 0);
           GCLK : in  STD_LOGIC;
           RX : in  STD_LOGIC);
end RXSerialRead;

architecture Behavioral of RXSerialRead is
signal CLOCK87 : STD_LOGIC := '0';
signal started : bit := '0';
--signal started : STD_LOGIC := '0';
begin

process(GCLK)
	variable CounterClock87 : integer range 0 to 100000 := 0;
	begin 
		if(falling_edge(GCLK)) then
			if(CounterClock87 < 87) then 
				CounterClock87 := CounterClock87  + 1;
			else
				CounterClock87  := 0;
				CLOCK87 <= not CLOCK87;
			end if;
		end if;
end process;



process(CLOCK87)
variable DataBits : integer range 0 to 7 := 0;
-- 1 start(=0) + 8 bit + 2 stop(=01) => 11 bits
variable BitCounter : integer range 0 to 10 := 1;
variable ClockCycle : integer range 0 to 80000 := 0;
--variable result : STD_LOGIC_VECTOR(7 downto 0); -- 8 data bit
begin
	if(falling_edge(RX)) then
			started <= '1';
	end if;
	if (falling_edge(ClOCK87)) then
	  if(ClockCycle = 8000) then
		if(started = '1') then
			if(BitCounter = 0) then
				ClockCycle := ClockCycle + 1;
			else
				if (BitCounter < 9) then 
					LED(BitCounter - 1) <= RX;
				end if;
				if(DataBits < 8) then 
					DataBits := DataBits + 1;
				else 
					DataBits := 0;
				end if;
				ClockCycle := ClockCycle + 2;
			if (BitCounter < 10) then
				BitCounter := BitCounter + 1;
			else 
				BitCounter := 0;
				started <= '0';
			 end if;
		  end if;
		 end if; 
		end if;
	end if;
	if (ClockCycle < 8000) then
		ClockCycle := ClockCycle + 1;
	end if;
	if (started = '1' and ClockCycle = 8000 and falling_edge(CLOCK87)) then
		if (BitCounter = 0) then
			ClockCycle := ClockCycle + 1;
		else
			if (BitCounter < 9) then
				LED(BitCounter - 1) <= RX;
			end if;
			if(DataBits < 8) then 
				DataBits := DataBits + 1;
			else 
				DataBits := 0;
			end if;
			ClockCycle := ClockCycle + 2;
		end if;
	end if;
end process;
	
	


end Behavioral;

