----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:51:31 01/08/2024 
-- Design Name: 
-- Module Name:    LEDControlButton_Final - Behavioral 
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
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port ( gclk : in  STD_LOGIC;
           plus : in  STD_LOGIC;
			  minus : in std_logic;
			  selseg : out std_logic_vector(2 downto 0);
			  output : out std_logic_vector(6 downto 0);
           led : out  STD_LOGIC);
end main;

architecture Behavioral of main is
signal clk : std_logic := '0';
signal clk10 : std_logic := '0';
signal num : std_logic_vector(7 downto 0) := (others => '0');

signal d1, d2, d3 : integer range 0 to 10;

signal digit1, digit2, digit3 : std_logic_vector(6 downto 0);

begin

with d1 select
	digit1 <= "0111111" when 0,
	"0000110" when 1,
	"1011011" when 2,
	"1001111" when 3,
	"1100110" when 4,
	"1101101" when 5,
	"1111101" when 6,
	"0000111" when 7,
	"1111111" when 8,
	"1101111" when 9,
	"0000000" when others;

with d2 select
	digit2 <= "0111111" when 0,
	"0000110" when 1,
	"1011011" when 2,
	"1001111" when 3,
	"1100110" when 4,
	"1101101" when 5,
	"1111101" when 6,
	"0000111" when 7,
	"1111111" when 8,
	"1101111" when 9,
	"0000000" when others;
	
with d3 select
	digit3 <= "0111111" when 0,
	"0000110" when 1,
	"1011011" when 2,
	"1001111" when 3,
	"1100110" when 4,
	"1101101" when 5,
	"1111101" when 6,
	"0000111" when 7,
	"1111111" when 8,
	"1101111" when 9,
	"0000000" when others;

process(gclk)
variable counter : integer range 0 to 50000 := 0;
variable c : std_logic_vector(7 downto 0) := "00000000";
begin
	if (rising_edge(gclk)) then
	
		if (c = "11111111") then
			c := (others => '0');
		elsif (c < num) then
			led <= '1';
			c := c + 1;
		else
			led <= '0';
			c := c + 1;
		end if;		
		
		if (counter < 50000) then
			counter := counter + 1;
		else
			counter := 0;
			clk10 <= not clk10;
		end if;
	end if;
end process;

process(clk10)
variable counter : integer range 0 to 50 := 0;
begin
	if (rising_edge(clk10)) then
		if (counter < 50) then
			counter := counter + 1;
		else
			counter := 0;
			clk <= not clk;
		end if;
	end if;
end process;

process(clk10)
variable refresh : integer range 0 to 5 := 0;
begin
if (rising_edge(clk10)) then
	if (refresh < 3) then
		refresh := refresh + 1;
	else
		refresh := 0;
	end if;
	
	case refresh is
		when 0 =>
			selseg(2) <= '0';
			selseg(0) <= '1';
			output <= digit1;
		when 1 =>
			selseg(0) <= '0';
			selseg(1) <= '1';
			output <= digit2;
		when 2 =>
			selseg(1) <= '0';
			selseg(2) <= '1';
			output <= digit3;
		when others => null;
	end case;
end if;
end process;

process(clk)
variable temp : std_logic_vector(7 downto 0);
variable IsPlusPressed : std_logic := '0';
variable IsMinusPressed : std_logic := '0';
begin
if (rising_edge(clk)) then
	if (plus = '0' and IsPlusPressed = '0') then
			IsPlusPressed  := '1';
			if (num >= "11110000") then
				num <= (others => '1');
			else
				num <= num + 20;
			end if;
	elsif (minus = '0' and IsMinusPressed = '0') then
			IsMinusPressed  := '1';
			if (num <= "00010001") then
				num <= (others => '0');
			else
				num <= num - 20;
			end if;
	end if;
	
	if (plus = '1') then
		IsPlusPressed  := '0';
	end if;
	if (minus = '1') then
		IsMinusPressed  := '0';
	end if;
	
	
	temp := num;
	
	if (temp >= 200) then
		d3 <= 2;
		temp := temp - 200;
	elsif (num >= 100) then
		d3 <= 1;
		temp := temp - 100;
	else
		d3 <= 0;
	end if;
	
	if (temp >= 90) then
		d2 <= 9;
		temp := temp - 90;
	elsif (temp >= 80) then
		d2 <= 8;
		temp := temp - 80;
	elsif (temp >= 70) then
		d2 <= 7;
		temp := temp - 70;
	elsif (temp >= 60) then
		d2 <= 6;
		temp := temp - 60;
	elsif (temp >= 50) then
		d2 <= 5;
		temp := temp - 50;
	elsif (temp >= 40) then
		d2 <= 4;
		temp := temp - 40;
	elsif (temp >= 30) then
		d2 <= 3;
		temp := temp - 30;
	elsif (temp >= 20) then
		d2 <= 2;
		temp := temp - 20;
	elsif (temp >= 10) then
		d2 <= 1;
		temp := temp - 10;
	else 
		d2 <= 0;
	end if;
	
	if (temp = 9) then
		d1 <= 9;
	elsif (temp = 8) then
		d1 <= 8;
	elsif (temp = 7) then
		d1 <= 7;
	elsif (temp = 6) then
		d1 <= 6;
	elsif (temp = 5) then
		d1 <= 5;
	elsif (temp = 4) then
		d1 <= 4;
	elsif (temp = 3) then
		d1 <= 3;
	elsif (temp = 2) then
		d1 <= 2;
	elsif (temp = 1) then
		d1 <= 1;
	else
		d1 <= 0;
	end if;
	
end if;

end process;

end Behavioral;


