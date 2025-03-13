library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity HEX_TO_7_SEG_DCD is
    Port ( digit : in std_logic_vector(31 downto 0);
           clk : in std_logic;
           cat : out std_logic_vector(6 downto 0);
           an : out std_logic_vector(7 downto 0) );
end HEX_TO_7_SEG_DCD;

architecture Behavioral of HEX_TO_7_SEG_DCD is

signal count : std_logic_vector(15 downto 0);
signal mux_out : std_logic_vector(3 downto 0);

begin
COUNTER : process (clk)
variable var : std_logic_vector(15 downto 0) := x"0000";
begin
    if rising_edge(clk) then
        var := var + 1;
    end if;
   
    count <= var;
end process COUNTER;

MUX : process (count, digit)
begin
    case count(15 downto 13) is
        when "000" => mux_out <= digit(3 downto 0); an <= "11111110";
        when "001" => mux_out <= digit(7 downto 4); an <= "11111101";
        when "010" => mux_out <= digit(11 downto 8); an <= "11111011";
        when "011" => mux_out <= digit(15 downto 12); an <= "11110111";
        when "100" => mux_out <= digit(19 downto 16); an <= "11101111";
        when "101" => mux_out <= digit(23 downto 20); an <= "11011111";
        when "110" => mux_out <= digit(27 downto 24); an <= "10111111";
        when others => mux_out <= digit(31 downto 28); an <= "01111111";
    end case;
end process MUX;

-- SSD DCD
with mux_out select
   cat<= "1111001" when "0001",   --1
         "0100100" when "0010",   --2
         "0110000" when "0011",   --3
         "0011001" when "0100",   --4
         "0010010" when "0101",   --5
         "0000010" when "0110",   --6
         "1111000" when "0111",   --7
         "0000000" when "1000",   --8
         "0010000" when "1001",   --9
         "0001000" when "1010",   --A
         "0000011" when "1011",   --b
         "1000110" when "1100",   --C
         "1001000" when "1101",   --M
         "0101011" when "1110",   --m
         "1111111" when "1111",   --empty
         "1000000" when others;   --0
end Behavioral;
