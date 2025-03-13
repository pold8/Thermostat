library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SET_TEMPS is
        Port (  count_en : in STD_LOGIC;
                inc_hour : in STD_LOGIC;
                hour : out STD_LOGIC_VECTOR(4 downto 0)
             );
end SET_TEMPS;

architecture Behavioral of SET_TEMPS is

begin

process(inc_hour, count_en)
variable current : std_logic_vector(4 downto 0) := "00000";
begin
    if count_en = '1' then
        if rising_edge(inc_hour) then 
            if current = "10111" then 
                current := "00000";
            else current := current + 1;
            end if;
        end if;
    end if;
hour <= current;
end process;

end Behavioral;
