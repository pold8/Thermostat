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

entity RAM_TMIN is
    Port (  ADDR_W: in std_logic_vector (4 downto 0);
            ADDR_R: in std_logic_vector (4 downto 0);
            DATA_IN_U: in std_logic;
            DATA_IN_D: in std_logic;
            RAM_RW: in std_logic;
            clk: in std_logic;
            DATA_OUT_W: out std_logic_vector (4 downto 0);
            DATA_OUT_R: out std_logic_vector (4 downto 0)
          );
end RAM_TMIN;

architecture Behavioral of RAM_TMIN is

type RAM_ARRAY is array (0 to 23 ) of std_logic_vector (4 downto 0);

signal RAM: RAM_ARRAY:=("01111",
                        "01111",
                        "01111",
                        "01111",
                        "01111",
                        "01111",
                        "01111",
                        "01111",
                        "01111",
                        "01111",
                        "01111",
                        "01111",
                        "01111",
                        "01111",
                        "01111",
                        "01111",
                        "01111",
                        "01111",
                        "01111",
                        "01111",
                        "01111",
                        "01111",
                        "01111",
                        "01111");

begin

process(clk)
begin
    
    if(rising_edge(clk))then
        if(RAM_RW='1') then
             if(DATA_IN_U='1') then
                RAM(to_integer(unsigned(ADDR_W)))<=RAM(to_integer(unsigned(ADDR_W)))+1;
            elsif(DATA_IN_D='1') then
                RAM(to_integer(unsigned(ADDR_W)))<=RAM(to_integer(unsigned(ADDR_W)))-1;
            end if;
        end if;
    end if;

end process;

    DATA_OUT_W <= RAM(to_integer(unsigned(ADDR_W)));
    DATA_OUT_R <= RAM(to_integer(unsigned(ADDR_R)));

end Behavioral;
