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

entity MPG is
    Port ( btn : in std_logic;
           clk : in std_logic;
           enable : out std_logic );
end MPG;

architecture Behavioral of MPG is
signal en, Q1, Q2, Q3 : STD_LOGIC;
begin
P1 : process (clk)
variable var : std_logic_vector (15 downto 0) := x"0000";
begin
    if rising_edge(clk) then var := var + 1;
    end if;
   
    if var = x"1111" then en <= '1';
    else  en <= '0';
    end if;
end process P1;

P2 : process (clk, en)
begin
    if rising_edge(clk) then  
        Q3 <= Q2;
        Q2 <= Q1;
       
        if en = '1' then Q1 <= btn;
        end if;  
    end if;
end process P2;
       
enable <= Q2 and (not Q3);

end Behavioral;
