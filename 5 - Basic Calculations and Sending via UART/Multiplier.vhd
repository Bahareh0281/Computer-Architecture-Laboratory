----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:54:33 11/05/2023 
-- Design Name: 
-- Module Name:    main - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.all;
use ieee.std_logic_unsigned.all;
use ieee. numeric_std;

entity FA is
 Port ( A : in STD_LOGIC;
    B : in STD_LOGIC;
    Cin : in STD_LOGIC;
    S : out STD_LOGIC;
    Cout : out STD_LOGIC);
end FA;

architecture gate_level of FA is

begin

 S <= A XOR B XOR Cin ;
 Cout <= (A AND B) OR (Cin AND A) OR (Cin AND B) ;

end gate_level;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee. numeric_std;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Ripple_Adder is
Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
B : in STD_LOGIC_VECTOR (3 downto 0);
Cin : in STD_LOGIC;
S : out STD_LOGIC_VECTOR (3 downto 0);
Cout : out STD_LOGIC);
end Ripple_Adder;

architecture Behavioral of Ripple_Adder is

-- Full Adder VHDL Code Component Decalaration
component FA
Port (  A : in STD_LOGIC;
    B : in STD_LOGIC;
    Cin : in STD_LOGIC;
    S : out STD_LOGIC;
    Cout : out STD_LOGIC);
end component;

-- Intermediate Carry declaration
signal c1,c2,c3: STD_LOGIC;

begin

-- Port Mapping Full Adder 4 times
FA1: FA port map( A(0), B(0), Cin, S(0), c1);
FA2: FA port map( A(1), B(1), c1, S(1), c2);
FA3: FA port map( A(2), B(2), c2, S(2), c3);
FA4: FA port map( A(3), B(3), c3, S(3), Cout);

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee. numeric_std;

entity multy is 
    port (
        x: in  std_logic_vector (3 downto 0);
        y: in  std_logic_vector (3 downto 0);
        p: out std_logic_vector (7 downto 0)
    );
end entity multy;

architecture rtl of multy is
    component Ripple_Adder
        port ( 
            A:      in  std_logic_vector (3 downto 0);
            B:      in  std_logic_vector (3 downto 0);
            Cin:    in  std_logic;
            S:      out std_logic_vector (3 downto 0);
           Cout:    out std_logic
        );
    end component;
-- AND Product terms:
    signal G0, G1, G2:  std_logic_vector (3 downto 0);
-- B Inputs (B0 has three bits of AND product)
    signal B0, B1, B2:  std_logic_vector (3 downto 0);

begin

    -- y(1) thru y (3) AND products, assigned aggregates:
    G0 <= (x(3) and y(1), x(2) and y(1), x(1) and y(1), x(0) and y(1));
    G1 <= (x(3) and y(2), x(2) and y(2), x(1) and y(2), x(0) and y(2));
    G2 <= (x(3) and y(3), x(2) and y(3), x(1) and y(3), x(0) and y(3));
    -- y(0) AND products (and y0(3) '0'):
    B0 <=  ('0',          x(3) and y(0), x(2) and y(0), x(1) and y(0));

-- named association:
cell_1: 
    Ripple_Adder 
        port map (
            a => G0,
            b => B0,
            cin => '0',
            cout => B1(3), -- named association can be in any order
            S(3) => B1(2), -- individual elements of S, all are associated
            S(2) => B1(1), -- all formal members must be provide contiguously
            S(1) => B1(0),
            S(0) => p(1)
        );
cell_2: 
    Ripple_Adder 
        port map (
            a => G1,
            b => B1,
            cin => '0',
            cout => B2(3),
            S(3) => B2(2),
            S(2) => B2(1),
            S(1) => B2(0),
            S(0) => p(2)
        );
cell_3: 
    Ripple_Adder 
        port map (
            a => G2,
            b => B2,
            cin => '0',
            cout => p(7),
            S => p(6 downto 3)  -- matching elements for formal
        );
    p(0) <= x(0) and y(0); 
end architecture rtl;

-----------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bin8bcd is
    port (
        bin:    in  std_logic_vector (7 downto 0);
        bcd:    out std_logic_vector (11 downto 0)
    );
end entity;

architecture struct of bin8bcd is
    procedure add3 (signal bin: in  std_logic_vector (3 downto 0); 
                    signal bcd: out std_logic_vector (3 downto 0)) is
    variable is_gt_4:  std_logic;
    begin
        is_gt_4 := bin(3) or (bin(2) and (bin(1) or bin(0)));

        if is_gt_4 = '1' then
        -- if to_integer(unsigned (bin)) > 4 then
            bcd <= std_logic_vector(unsigned(bin) + "0011");
        else
            bcd <= bin;
        end if;
    end procedure;

    signal U0bin,U1bin,U2bin,U3bin,U4bin,U5bin,U6bin:
                std_logic_vector (3 downto 0);

    signal U0bcd,U1bcd,U2bcd,U3bcd,U4bcd,U5bcd,U6bcd:
                std_logic_vector (3 downto 0);       
begin
    U0bin <= '0' & bin (7 downto 5);
    U1bin <= U0bcd(2 downto 0) & bin(4);
    U2bin <= U1bcd(2 downto 0) & bin(3);
    U3bin <= U2bcd(2 downto 0) & bin(2);
    U4bin <= U3bcd(2 downto 0) & bin(1);

    U5bin <= '0' & U0bcd(3) & U1bcd(3) & U2bcd(3);
    U6bin <= U5bcd(2 downto 0) & U3bcd(3);

U0: add3(U0bin,U0bcd);

U1: add3(U1bin,U1bcd);

U2: add3(U2bin,U2bcd);

U3: add3(U3bin,U3bcd);

U4: add3(U4bin,U4bcd);

U5: add3(U5bin,U5bcd);

U6: add3(U6bin,U6bcd);

OUTP:
    bcd <= '0' & '0' & U5bcd(3) & U6bcd & U4bcd & bin(0);

end architecture;

------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rs232 is
    Port ( gclk : in  STD_LOGIC;
           TX : out  STD_LOGIC;
           D1 : in STD_LOGIC_VECTOR (3 downto 0);
			  D2 : in STD_LOGIC_VECTOR (3 downto 0));
end rs232;

architecture Behavioral of rs232 is

component multy
        port ( 
            x:      in  std_logic_vector (3 downto 0);
            y:      in  std_logic_vector (3 downto 0);
            p:      out std_logic_vector (7 downto 0)
        );
end component;

component bin8bcd
		port (
				bin: in std_logic_vector (7 downto 0);
				bcd: out std_logic_vector (11 downto 0)
			);
end component;

signal clock : std_logic := '0';

signal XY : std_logic_vector(7 downto 0);
signal bcd_xy : std_logic_vector(11 downto 0);

begin

multiplier: 
    multy 
        port map (
            x => D1,
				y => D2,
				p => XY
        );
		  
converter:
	bin8bcd
		port map (
				bin => XY,
				bcd => bcd_xy
			);

process (gclk)
variable count_div : integer range 0 to 173 := 0;
begin
	if (rising_edge(gclk)) then
		if (count_div < 173) then
			count_div := count_div + 1;
		else
			count_div := 0;
			clock <= not clock;
		end if;
	end if;
end process;

process (clock)
variable counter : integer range 1 to 12 := 1;
variable dip_c : integer range 0 to 8 := 0;
variable flag_c : integer range 0 to 80000 := 0;
variable flag : integer range 1 to 3 := 1;
variable out_tx : std_logic_vector(7 downto 0);
variable completed : std_logic := '1';
begin
	
	if (rising_edge(clock)) then		
		if (completed = '1') then
		out_tx(7 downto 4) := "0000";
		if (flag = 1) then
			out_tx(3 downto 0) := bcd_xy(3 downto 0);
			out_tx := std_logic_vector(unsigned(out_tx) + "00110000");
			flag := 2;
		elsif (flag = 2) then
			out_tx(3 downto 0) := bcd_xy(7 downto 4);
			out_tx := std_logic_vector(unsigned(out_tx) + "00110000");
			flag := 3;
		elsif (flag = 3) then
			out_tx(3 downto 0) := "1010";
			flag := 1;
		end if;
		completed := '0';
		end if;
		
		if (flag_c = 80000) then
			if (counter = 1) then
				TX <= '0';
			elsif (counter = 10) then
				TX <= '0';
			elsif (counter = 11) then
				TX <= '1';
				flag_c := 0;
				completed := '1';
			else
				TX <= bcd_xy(dip_c);
			
				if (dip_c < 8) then
					dip_c := dip_c + 1;
				else
					dip_c := 0;
				end if;

			end if;
		
			if (counter < 12) then
				counter := counter + 1;
			else
				counter := 1;
			end if;
		else
			flag_c := flag_c + 1;
		end if;
	end if;

end process;

end Behavioral;

