----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:11:27 10/18/2023 
-- Design Name: 
-- Module Name:    SevenSegCounter - Behavioral 
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

entity SevenSegCounter is
    Port ( GCLK : in  STD_LOGIC;
			  seg_data : out std_logic_vector (7 downto 0);
			  seg_sel : out std_logic_vector(4 downto 0) 
			  );
end SevenSegCounter;

architecture Behavioral of SevenSegCounter is
	signal CLK10MS,CLK1S : STD_LOGIC;
	signal segdataBCD1 , segdataBCD2,segdataBCD3 , segdataBCD4 : std_logic_vector ( 3 downto 0 ) ; 
	signal SEG_DATA_reg1 , SEG_DATA_reg2 ,SEG_DATA_reg3,SEG_DATA_reg4 : std_logic_vector ( 7 downto 0 ) ; 
begin

process(GCLK)
	variable count_div : integer range 0 to 100000 :=0 ;
begin
	if(rising_edge(GCLK)) then
		if count_div<80000 then
			count_div := count_div+1;
		else
			count_div:=0;
			CLK10MS<= not CLK10MS;
		end if;
	end if;

end process;



with segdataBCD1 select 
	SEG_DATA_reg1 <= "00111111" when "0000" ,
        "01011011" when "0010" , 
        "00000110" when "0001" ,
        "01001111" when "0011",
        "01100110" when "0100",
		  "01101101" when "0101" ,
		  "01111101" when "0110",
		  "00000111" when "0111",
		  "01111111" when "1000",
		  "01101111" when "1001",
		  "00000000" when others ; 
with segdataBCD2 select 
	SEG_DATA_reg2 <= "00111111" when "0000" ,
        "01011011" when "0010" , 
        "00000110" when "0001" ,
        "01001111" when "0011",
        "01100110" when "0100",
		  "01101101" when "0101" ,
		  "01111101" when "0110",
		  "00000111" when "0111",
		  "01111111" when "1000",
		  "01101111" when "1001",
		  "00000000" when others ;  
with segdataBCD3 select 
	SEG_DATA_reg3 <= "00111111" when "0000" ,
		  "01011011" when "0010" , 
        "00000110" when "0001" ,
        "01001111" when "0011",
        "01100110" when "0100",
        "01101101" when "0101" ,
		  "01111101" when "0110",
		  "00000111" when "0111",
		  "01111111" when "1000",
		  "01101111" when "1001",
		  "00000000" when others ; 
with segdataBCD4 select 
	SEG_DATA_reg4 <= "00111111" when "0000" ,
        "01011011" when "0010" , 
        "00000110" when "0001" ,
        "01001111" when "0011",
        "01100110" when "0100",
        "01101101" when "0101" ,
		  "01111101" when "0110",
		  "00000111" when "0111",
		  "01111111" when "1000",
		  "01101111" when "1001",
		  "00000000" when others ; 
          
	
process(CLK10MS)
variable count_div1S : integer range 0 to 50 :=0 ;
begin
	if(rising_edge(CLK10MS)) then
		if count_div1S< 50 then
			count_div1S := count_div1S+1;
		else
			count_div1S :=0;
			CLK1S<= not CLK1S;
		end if;
	end if;
end process;
process(CLK1S)
variable counter : integer range 0 to 9999 :=0 ;
variable vsegdataBCD1 ,vsegdataBCD2 , vsegdataBCD3 , vsegdataBCD4 : std_logic_vector ( 3 downto 0 ) := "0000" ;  
begin
	if ( counter < 9999 and rising_edge(CLK1S ) ) then 
		if(vsegdataBCD1 <"1001" ) then
			vsegdataBCD1 :=(std_logic_vector(vsegdataBCD1) + 1);  
			else	
			vsegdataBCD1 := "0000";
			if ( vsegdataBCD2 < "1001" ) then 
				vsegdataBCD2 := (std_logic_vector(vsegdataBCD2) + 1); 
			else
				vsegdataBCD2 := "0000";
				if ( vsegdataBCD3 < "1001" ) then 
					vsegdataBCD3 := (std_logic_vector(vsegdataBCD3) + 1);  
				else
					vsegdataBCD3 := "0000" ; 
					if( vsegdataBCD4 < "1001" ) then 
						vsegdataBCD4 := (std_logic_vector(vsegdataBCD4) + 1);  
					else
						vsegdataBCD4 := "0000" ; 
					end if ; 
				end if; 	
			end if ; 
		end if ;
			counter := counter +1 ; 
			
	end if ; 
			segdataBCD1 <=vsegdataBCD1;
			segdataBCD2 <=vsegdataBCD2;
			segdataBCD3 <=vsegdataBCD3;
			segdataBCD4<= vsegdataBCD4;
end process;



process(CLK10MS)
	variable RefreshSEG : integer range 0 to 4 :=0 ;
	begin
		if(rising_edge(CLK10MS)) then
			if RefreshSEG < 4 then
				RefreshSEG := RefreshSEG + 1;
			else RefreshSEG :=0;
			end if ;
			
		case RefreshSEG is
		when 0 => 
			SEG_SEL(4) <='0';
			SEG_SEL(0) <='1';
			SEG_DATA <= SEG_DATA_reg1;
		when 1 =>
			SEG_SEL(0) <='0';
			SEG_SEL(1) <='1';
			SEG_DATA <= SEG_DATA_reg2;
		when 2 =>
			SEG_SEL(1) <='0';
			SEG_SEL(2) <='1';
			SEG_DATA <= SEG_DATA_reg3;
		when 3 =>
			SEG_SEL(2) <='0';
			SEG_SEL(3) <='1';
			SEG_DATA <= SEG_DATA_reg4;
		when others => null ;
	end case ;
	end if ;
end process; 
end Behavioral;

