----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:55:05 10/28/2023 
-- Design Name: 
-- Module Name:    AdvancedSevenSegment - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL ;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity AdvancedSevenSegment is
    Port ( SEG_DATA : out  STD_LOGIC_VECTOR (7 downto 0);
           SEG_SEL : out  	STD_LOGIC_VECTOR (4 downto 0);
           GCLK  : in  STD_LOGIC;
           START : in  STD_LOGIC;
			  STOP  : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
--			  ALARM : out STD_LOGIC;
-- NET "ALARM" LOC = P13;
           OUTPUTBCD1 : out  STD_LOGIC_VECTOR (3 downto 0);
           OUTPUTBCD2 : out  STD_LOGIC_VECTOR (3 downto 0);
           OUTPUTBCD3 : out  STD_LOGIC_VECTOR (3 downto 0);
           OUTPUTBCD4 : out  STD_LOGIC_VECTOR (3 downto 0));
end AdvancedSevenSegment;

architecture Behavioral of AdvancedSevenSegment is
	shared variable STARTSTOPTOGGLE : STD_LOGIC ;
	signal CLOCK10MS,CLOCK1S : STD_LOGIC;
	signal SEGDATABCD1 , SEGDATABCD2,SEGDATABCD3 , SEGDATABCD4 , SEGDATABCD5 : STD_LOGIC_VECTOR ( 3 downto 0 ) ; 
	signal SEGDATAREG1 , SEGDATAREG2 ,SEGDATAREG3,SEGDATAREG4 , SEGDATAREG5  : STD_LOGIC_VECTOR( 7 downto 0 ) ; 
begin

--------- CLOCK 10MS --------------
process(GCLK)
	variable COUNTERDIVISION10MS : integer range 0 to 100000 := 0 ;
begin
	if rising_edge(GCLK) then
		if COUNTERDIVISION10MS < 80000 then
			 COUNTERDIVISION10MS := COUNTERDIVISION10MS + 1;
		else
			COUNTERDIVISION10MS := 0;
			CLOCK10MS <= not CLOCK10MS;
		end if;
	end if;
	
end process;


--------- CLOCK 1S WITH CLOCK10MS --------------
process(CLOCK10MS)
	variable COUNTERDIVISION1S : integer range 0 to 50 := 0 ;
begin
	if rising_edge(CLOCK10MS) then
		if COUNTERDIVISION1S < 50  then
			COUNTERDIVISION1S := COUNTERDIVISION1S + 1;
		else
			COUNTERDIVISION1S := 0;
			CLOCK1S <= not CLOCK1S;
		end if;
	end if;
end process;


-- SEGDATAREG5 ;


with SEGDATABCD1 select 
	SEGDATAREG1 <= "00111111" when "0000" ,
						"00000110" when "0001" ,
						"01011011" when "0010" , 
						"01001111" when "0011" ,
						"01100110" when "0100" ,
						"01101101" when "0101" ,
						"01111101" when "0110",
						"00000111" when "0111",
						"01111111" when "1000",
		 				"01101111" when "1001",
						"00000000" when others ; 
with SEGDATABCD2 select 
	SEGDATAREG2 <= "00111111" when "0000" ,
						"00000110" when "0001" ,
						"01011011" when "0010" , 
						"01001111" when "0011",
						"01100110" when "0100",
						"01101101" when "0101" ,
						"01111101" when "0110",
						"00000111" when "0111",
						"01111111" when "1000",
						"01101111" when "1001",
						"00000000" when others ;  
with SEGDATABCD3 select 
	SEGDATAREG3 <= "00111111" when "0000" ,
						"00000110" when "0001" ,
						"01011011" when "0010" , 
						"01001111" when "0011",
						"01100110" when "0100",
						"01101101" when "0101" ,
						"01111101" when "0110",
						"00000111" when "0111",
						"01111111" when "1000",
						"01101111" when "1001",
						"00000000" when others ; 
with SEGDATABCD4 select 
	SEGDATAREG4 <= "00111111" when "0000" ,
						"00000110" when "0001" ,
						"01011011" when "0010" , 
						"01001111" when "0011",
						"01100110" when "0100",
						"01101101" when "0101" ,
						"01111101" when "0110",
						"00000111" when "0111",
						"01111111" when "1000",
						"01101111" when "1001",
						"00000000" when others ; 
          
OUTPUTBCD1 <= SEGDATABCD1;
OUTPUTBCD2 <= SEGDATABCD2;
OUTPUTBCD3 <= SEGDATABCD3;
OUTPUTBCD4 <= SEGDATABCD4;



-- process payini chon 1 s inam byad 1s bashe dige ? 
process(CLOCK1S)
begin
if(rising_edge(CLOCK1S)) then
	if(START = '0') then 
		STARTSTOPTOGGLE := '0';
	end if;
	if(STOP = '0') then
		STARTSTOPTOGGLE := '1';
	end if;
end if;
end process;
-- NET "RESET" CLOCK_DEDICATED_ROUTE = FALSE;		
	

process(CLOCK1S)
variable NUMBERCOUNTER : integer range 0 to 9999 := 0 ;
variable vsegdataBCD1 ,vsegdataBCD2 , vsegdataBCD3 , vsegdataBCD4 ,vsegdataBCD5 : std_logic_vector ( 3 downto 0 ) := "0000" ; 
begin
	--STARTSTOPTOGGLE := '1';
	if(rising_edge(CLOCK1S)) then 
		--SEGDATAREG5(6 downto 5) <= "11" xor SEGDATAREG5(6 downto 5);
		if(RESET = '0') then
			vsegdataBCD1 := "0000";
			vsegdataBCD2 := "0000";
			vsegdataBCD3 := "0000";
			vsegdataBCD4 := "0000";
			vsegdataBCD5 := "0000";
		else	
			if(STARTSTOPTOGGLE = '0') then 
				--if(NUMBERCOUNTER < 9999) then 
					SEGDATAREG5 <= SEGDATAREG5 (7 downto 0) and "11011111" and "00110000";
					if(vsegdataBCD1 <"1001" ) then
						vsegdataBCD1 :=(std_logic_vector(vsegdataBCD1) + 1);
						--SEGDATAREG5 <= SEGDATAREG5(7 downto 2) & vsegdataBCD1(1) & vsegdataBCD1(0);
						--SEGDATAREG5(7) <= vsegdataBCD1(0);
					else	
						vsegdataBCD1 := "0000";
						if ((vsegdataBCD2 < "0101")) then 
							vsegdataBCD2 := (std_logic_vector(vsegdataBCD2) + 1); 
						else
							vsegdataBCD2 := "0000";
							if(vsegdataBCD3 < "1001") then 
								vsegdataBCD3 := (std_logic_vector(vsegdataBCD3) + 1);
							else 
								vsegdataBCD3 := "0000";
								if(vsegdataBCD4 < "1001") then 
									vsegdataBCD4 := (std_logic_vector(vsegdataBCD4) + 1);  
								else
									vsegdataBCD4 := "0000" ; 
								end if ; 
							end if; 	
						end if ; 
					end if ;
				--end if ;
			else
			end if;	
		end if;
				NUMBERCOUNTER := NUMBERCOUNTER +1 ; 
				vsegdataBCD5 := not vsegdataBCD5 ; 
		end if ;
			SEGDATABCD1 <= vsegdataBCD1;
			SEGDATABCD2 <= vsegdataBCD2;
			SEGDATABCD3 <= vsegdataBCD3;
			SEGDATABCD4 <= vsegdataBCD4;
			SEGDATABCD5 <= vsegdataBCD5 ; 
end process;


process(CLOCK10MS)
variable RefreshSEG : integer range 0 to 4 :=0 ;
	begin
		if rising_edge(CLOCK10MS) then
			if RefreshSEG < 4 then
				RefreshSEG := RefreshSEG + 1;
			else RefreshSEG :=0;
		end if ;
		case RefreshSEG is
			when 0 => 
				SEG_SEL(4) <='0';
				SEG_SEL(0) <='1';
				SEG_DATA <= SEGDATAREG1;
			when 1 =>
				SEG_SEL(0) <='0';
				SEG_SEL(1) <='1';
				SEG_DATA <= SEGDATAREG2;
			when 2 =>
				SEG_SEL(1) <='0';
				SEG_SEL(2) <='1';
				SEG_DATA <= SEGDATAREG3;
			when 3 =>
				SEG_SEL(2) <='0';
				SEG_SEL(3) <='1';
				SEG_DATA <= SEGDATAREG4;
			when 4 => 
				SEG_SEL(3) <= '0';
				SEG_SEL(4) <= '1';
				SEG_DATA <= SEGDATAREG5;
		when others => null ;
	end case ;
	end if ;
end process; 
end Behavioral;
