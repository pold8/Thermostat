library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DIGITAL_CLOCK is
    Port ( clk : in std_logic;
           set_en : in std_logic;
           clk_min : in std_logic;
           clk_hour : in std_logic;
           display : out std_logic_vector(15 downto 0);
           current_hour : out std_logic_vector(4 downto 0) );
end DIGITAL_CLOCK;

architecture Behavioral of DIGITAL_CLOCK is
signal min_clock, hour_clock: std_logic;
signal intern_min_clock, intern_hour_clock : std_logic;

begin

min_clock <= clk_min when set_en = '1' else intern_min_clock;
hour_clock <= clk_hour when set_en = '1' else intern_hour_clock;

SECONDS : process (clk)
variable sec : integer range 0 to 59 := 0;
begin
if rising_edge(clk) then
    if sec = 59 then sec := 0; intern_min_clock <= '1';
    else sec := sec + 1; intern_min_clock <= '0';
    end if;
end if;
end process SECONDS;

MINUTES : process (min_clock)
variable min : integer range 0 to 59 := 0;
variable d1, d0 : integer range 0 to 9 := 0;

begin
if rising_edge(min_clock) then
    if min = 59 then min := 0; intern_hour_clock <= '1';
    else min := min + 1; intern_hour_clock <= '0';
    end if;
end if;



d1 := min / 10;
d0 := min mod 10;

display(3 downto 0) <= std_logic_vector(TO_UNSIGNED(d0, 4));
display(7 downto 4) <= std_logic_vector(TO_UNSIGNED(d1, 4));

end process MINUTES;

HOURS : process (hour_clock)
variable hour : integer range 0 to 23 := 0;
variable d1, d0 : integer range 0 to 9 := 0;

begin
if rising_edge(hour_clock) then 
    if hour = 23 then hour := 0;
    else hour := hour + 1;
    end if;
end if;

current_hour <= std_logic_vector(TO_UNSIGNED(hour,5));

d1 := hour / 10;
d0 := hour mod 10;

display(11 downto 8) <= std_logic_vector(TO_UNSIGNED(d0, 4));
display(15 downto 12) <= std_logic_vector(TO_UNSIGNED(d1, 4));

end process HOURS;
end Behavioral;
