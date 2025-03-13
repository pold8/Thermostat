library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SSD_DIS is
    Port (
           setmin : in STD_LOGIC;
           setmax : in STD_LOGIC;
           ctime : in STD_LOGIC_VECTOR (15 downto 0);
           hour : in STD_LOGIC_VECTOR (4 downto 0);
           tempmin : in STD_LOGIC_VECTOR (4 downto 0);
           tempmax : in STD_LOGIC_VECTOR (4 downto 0);
           ctemp : in STD_LOGIC_VECTOR (4 downto 0);
           ssdvec : out STD_LOGIC_VECTOR (31 downto 0));
end SSD_DIS;

architecture Behavioral of SSD_DIS is

signal temp: integer;
signal d0_temp : integer;
signal d1_temp : integer;

signal chour:integer;
signal chour_i:integer;
signal d0_hour : integer;
signal d1_hour : integer;
signal d0_hour_i : integer;
signal d1_hour_i : integer;

signal tmin:integer;
signal d0_tmin:integer;
signal d1_tmin:integer;

signal tmax:integer;
signal d0_tmax:integer;
signal d1_tmax:integer;


begin

temp <=TO_INTEGER(unsigned(ctemp));
d0_temp<=temp mod 10;
d1_temp<=temp/10;

chour <= TO_INTEGER(unsigned (hour));
d0_hour <= chour mod 10;
d1_hour <= chour/10;
chour_i<= chour+1;
d0_hour_i <= chour_i mod 10;
d1_hour_i <= chour_i/10;

tmin <= TO_INTEGER(unsigned(tempmin));
d0_tmin<=tmin mod 10;
d1_tmin<=tmin/10;

tmax <= TO_INTEGER(unsigned(tempmax));
d0_tmax<=tmax mod 10;
d1_tmax<=tmax/10;


process
begin
    
    if(setmin='0' and setmax='0') then
        ssdvec(31 downto 16)<=ctime;
        ssdvec(15 downto 8) <= "11111111";
        ssdvec(7 downto 4) <= std_logic_vector(TO_UNSIGNED(d1_temp, 4));
        ssdvec(3 downto 0) <= std_logic_vector(TO_UNSIGNED(d0_temp, 4));
    elsif(setmin='1') then
        ssdvec(31 downto 28) <= std_logic_vector(TO_UNSIGNED(d1_hour, 4));
        ssdvec(27 downto 24) <= std_logic_vector(TO_UNSIGNED(d0_hour, 4));
        ssdvec(23 downto 20) <= std_logic_vector(TO_UNSIGNED(d1_hour_i, 4));
        ssdvec(19 downto 16) <= std_logic_vector(TO_UNSIGNED(d0_hour_i, 4));
        ssdvec(15 downto 12) <= "1110";
        ssdvec(11 downto 8) <= "1111";
        ssdvec(7 downto 4) <= std_logic_vector(TO_UNSIGNED(d1_tmin, 4));
        ssdvec(3 downto 0) <= std_logic_vector(TO_UNSIGNED(d0_tmin, 4));
    elsif(setmax='1') then
        ssdvec(31 downto 28) <= std_logic_vector(TO_UNSIGNED(d1_hour, 4));
        ssdvec(27 downto 24) <= std_logic_vector(TO_UNSIGNED(d0_hour, 4));
        ssdvec(23 downto 20) <= std_logic_vector(TO_UNSIGNED(d1_hour_i, 4));
        ssdvec(19 downto 16) <= std_logic_vector(TO_UNSIGNED(d0_hour_i, 4));
        ssdvec(15 downto 12) <= "1101";
        ssdvec(11 downto 8) <= "1111";
        ssdvec(7 downto 4) <= std_logic_vector(TO_UNSIGNED(d1_tmax, 4));
        ssdvec(3 downto 0) <= std_logic_vector(TO_UNSIGNED(d0_tmax, 4));          
    end if;
    
end process;

end Behavioral;
