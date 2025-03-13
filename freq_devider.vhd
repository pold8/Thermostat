library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity freq_devider is
    Port ( clk_in : in std_logic;
           clk_out : out std_logic );
end freq_devider;

architecture Behavioral of freq_devider is

signal count : integer :=0;
signal b : std_logic :='0';
begin


process(clk_in) 

begin
    if(clk_in'event and clk_in='1') then
        count <=count+1;
    if(count = 50000000) then
        b <= not b;
        count <=0;

    end if;
    end if;

    clk_out<=b;

end process;

end Behavioral;
