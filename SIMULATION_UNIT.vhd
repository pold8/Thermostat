library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SIMULATION_UNIT is
    Port ( clk : in STD_LOGIC;
           current_temp : in STD_LOGIC_VECTOR (4 downto 0);
           min_temp : in STD_LOGIC_VECTOR (4 downto 0);
           max_temp : in STD_LOGIC_VECTOR (4 downto 0);
           temp_out : out STD_LOGIC_VECTOR (4 downto 0);
           heating : out STD_LOGIC;
           cooling : out STD_LOGIC);
end SIMULATION_UNIT;

architecture Behavioral of SIMULATION_UNIT is
    signal temp_reg : STD_LOGIC_VECTOR (4 downto 0):="10000";
    signal counter : integer := 0;
begin

process(clk)
begin
    if rising_edge(clk) then
        temp_reg <= current_temp;

        counter <= counter + 1;

        if counter = 2 then
            counter <= 0;

            if temp_reg < min_temp then
                temp_reg <= temp_reg + 1;
                heating <= '1';
                cooling <= '0';
            elsif temp_reg > max_temp then
                temp_reg <= temp_reg - 1;
                heating <= '0';
                cooling <= '1';
            else
                heating <= '0';
                cooling <= '0';
            end if;
        end if;
    end if;
end process;

-- Output the current temperature
temp_out <= temp_reg;

end Behavioral;
