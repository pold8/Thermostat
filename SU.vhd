library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SU is
    Port(   clk: in std_logic;
             min_temp: in std_logic;
             max_temp: in std_logic;
             cur_temp: in std_logic;
             temp_out: out std_logic );
end SU;

architecture Behavioral of SU is

begin

process(clk)


begin

end process;


end Behavioral;
