----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:33:20 12/06/2023 
-- Design Name: 
-- Module Name:    PWM_RXSerial - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PWM_RXSerial is
    Port ( GCLK : in  STD_LOGIC;
           RX : in  STD_LOGIC;
           LED : out  STD_LOGIC
			  );
           --OUTPUT : out  STD_LOGIC_VECTOR (7 downto 0));
end PWM_RXSerial;

architecture Behavioral of PWM_RXSerial is
signal second_process_clock : std_logic := '0'; -- second process should start after setting this 
signal is_started : std_logic := '0'; -- 8 bit digit should be read after start
signal rx_temp : std_logic_vector(7 downto 0); -- 8 digit to read 
begin

process(GCLK)
variable counter_clock : integer range 0 to 88 := 0;-- half a clock 
variable duty_cycle : std_logic_vector(7 downto 0) := (others => '0');
begin
	if (rising_edge(GCLK)) then
		if (RX = '0') then -- should start reading 8 digit 
			is_started <= '1';
		end if;
		--if (duty_cycle = "11111111") then -- each 255 times 
		if (duty_cycle = "11111111") then 
				duty_cycle := (others => '0');	
		elsif ( duty_cycle < rx_temp) then 
				LED <= '1';
				duty_cycle := duty_cycle + 1;
		else
				LED <= '0';
				duty_cycle := duty_cycle + 1;
		end if;		
		-- half clock needed duty_cycle = "11111111"
		if (counter_clock < 87) then -- counter_clock < 88 
			counter_clock := counter_clock + 1;
		else
			counter_clock := 0;
			second_process_clock <= not second_process_clock;
		end if;
	end if;
end process;

--process(GCLK)
--begin
--	if (rising_edge(NewClock)) then
--		if (has_started = '1') then
--			if (falling_edge(NewClock)) then
--				if (has_finished = '0') then
--					if (RX_Counter < 9) then
--						RX_Counter = RX_Counter + 1;
--					end if;
--					if (RX_Counter = 0) then
--						Result(RX_Counter - 2) <= RX;
--					end if;
--					if (RX_Counter = 9) then
--						RX_Counter := 0;
--						has_finished := '1';
--					end if;
--				end if;
--			end if;
--			Cycle := Cycle + 1;
--		end if;
--	end if;
--end process;

-- second clock set
process(second_process_clock)
variable rx_digit_counter : integer range 0 to 10 := 0; -- 11 digit read (8 bit data - 1 bit start - 2 bit stop)
variable cycle : integer range 0 to 8 := 0;
variable is_finished : std_logic := '0';
begin
	if (rising_edge(second_process_clock)) then
		if (is_started = '1') then
			if (cycle rem 2 = 1) then -- falling edge
				if(is_finished = '0') then 
					if (rx_digit_counter = 0) then
						rx_digit_counter := rx_digit_counter + 1;
					elsif (rx_digit_counter < 9) then
						rx_temp(rx_digit_counter - 1) <= RX;
						--OUTPUT(rx_digit_counter - 1) <= RX; -- other leds should show the hole number
						rx_digit_counter := rx_digit_counter + 1;
					elsif (rx_digit_counter = 9) then
						rx_digit_counter := 0;
						is_finished := '1';
					end if;
				end if;
			end if;
			cycle := cycle + 1;
		end if;
	end if;
	
	--if (finish = '1' and rx = '0') then
	if (is_finished = '1') then
		if ( RX = '0' ) then -- should be started again
			is_finished := '0';
		end if;
	end if;
end process;

end Behavioral;

