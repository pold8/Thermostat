library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_env is
    Port ( clk: in std_logic;
           sw : in std_logic_vector(2 downto 0);
           btn : in std_logic_vector(4 downto 0);
           led : out std_logic_vector(1 downto 0);
           an : out std_logic_vector(7 downto 0);
           cat : out std_logic_vector(6 downto 0) );
end test_env;

architecture Behavioral of test_env is
signal clk_1Hz, min_clock, hour_clock : std_logic;
signal clock_display : std_logic_vector(31 downto 0);

signal inc_temp : std_logic;
signal dec_temp : std_logic;

signal inc_hour : std_logic;

signal temp_min_to_display : std_logic_vector (4 downto 0);
signal temp_max_to_display : std_logic_vector (4 downto 0);

signal current_temp : std_logic_vector (4 downto 0) := "10000";

signal hour_ADR : std_logic_vector (4 downto 0);
signal ADR_R : std_logic_vector (4 downto 0);

signal t_limit_max: std_logic_vector(4 downto 0);
signal t_limit_min: std_logic_vector(4 downto 0);

signal mod_temp: std_logic_vector(4 downto 0) :="10000";

signal current_time : std_logic_vector(15 downto 0);

signal en_count_hour : std_logic;


component freq_devider is
    Port ( clk_in : in std_logic;
           clk_out : out std_logic );
end component freq_devider;

component MPG is
    Port ( btn : in std_logic;
           clk : in std_logic;
           enable : out std_logic );
end component MPG;

component HEX_TO_7_SEG_DCD is
    Port ( digit : in std_logic_vector(31 downto 0);
           clk : in std_logic;
           cat : out std_logic_vector(6 downto 0);
           an : out std_logic_vector(7 downto 0) );
end component HEX_TO_7_SEG_DCD;

component DIGITAL_CLOCK is
    Port ( clk : in std_logic;
           set_en : in std_logic;
           clk_min : in std_logic;
           clk_hour : in std_logic;
           display : out std_logic_vector(15 downto 0);
           current_hour : out std_logic_vector(4 downto 0) );
end component DIGITAL_CLOCK;

component RAM_TMAX is
    Port (  ADDR_W: in std_logic_vector (4 downto 0);
            ADDR_R: in std_logic_vector (4 downto 0);
            DATA_IN_U: in std_logic;
            DATA_IN_D: in std_logic;
            RAM_RW: in std_logic;
            clk: in std_logic;
            DATA_OUT_W: out std_logic_vector (4 downto 0);
            DATA_OUT_R: out std_logic_vector (4 downto 0)
          );
end component RAM_TMAX;

component RAM_TMIN is
    Port (  ADDR_W: in std_logic_vector (4 downto 0);
            ADDR_R: in std_logic_vector (4 downto 0);
            DATA_IN_U: in std_logic;
            DATA_IN_D: in std_logic;
            RAM_RW: in std_logic;
            clk: in std_logic;
            DATA_OUT_W: out std_logic_vector (4 downto 0);
            DATA_OUT_R: out std_logic_vector (4 downto 0)
          );
end component RAM_TMIN;

component SIMULATION_UNIT is
    Port ( clk : in STD_LOGIC;
           current_temp : in STD_LOGIC_VECTOR (4 downto 0);
           min_temp : in STD_LOGIC_VECTOR (4 downto 0);
           max_temp : in STD_LOGIC_VECTOR (4 downto 0);
           temp_out : out STD_LOGIC_VECTOR (4 downto 0);
           heating : out STD_LOGIC;
           cooling : out STD_LOGIC);
end component SIMULATION_UNIT;

component SET_TEMPS is
        Port (  count_en : in std_logic;
                inc_hour : std_logic;
                hour: out std_logic_vector (4 downto 0)
             );
end component SET_TEMPS;

component SSD_DIS is
    Port ( setmin : in STD_LOGIC;
           setmax : in STD_LOGIC;
           ctime : in STD_LOGIC_VECTOR (15 downto 0);
           hour : in STD_LOGIC_VECTOR (4 downto 0);
           tempmin : in STD_LOGIC_VECTOR (4 downto 0);
           tempmax : in STD_LOGIC_VECTOR (4 downto 0);
           ctemp : in STD_LOGIC_VECTOR (4 downto 0);
           ssdvec : out STD_LOGIC_VECTOR (31 downto 0));
end component SSD_DIS;

begin

current_temp<=mod_temp;
FREQUENCY_DIVIDER : freq_devider port map (clk_in => clk, clk_out => clk_1Hz);

DEBOUNCE_MIN : MPG port map (btn => btn(1), clk => clk, enable => min_clock);
DEBOUNCE_HOUR : MPG port map (btn => btn(4), clk => clk, enable => hour_clock);

DEBOUNCE_INC_TEMP : MPG port map (btn => btn(3), clk => clk, enable => inc_temp);
DEBOUNCE_DEC_TEMP : MPG port map (btn => btn(2), clk => clk, enable => dec_temp);

DEBOUNCE_INC_HOUR : MPG port map (btn => btn(0), clk => clk, enable => inc_hour);

SSD_DISPLAY : HEX_TO_7_SEG_DCD port map (digit => clock_display, clk => clk, cat => cat, an => an);

CEAS : DIGITAL_CLOCK port map (clk => clk_1Hz, set_en => sw(0), clk_min => min_clock, clk_hour => hour_clock, display => current_time, current_hour => ADR_R);

SD_DIS : SSD_DIS port map(setmin => sw(1), setmax => sw(2), ctime => current_time, hour => hour_ADR, tempmin => temp_min_to_display, tempmax => temp_max_to_display, ctemp => mod_temp, ssdvec => clock_display);

en_count_hour <= sw(1) or sw(2);
SET_TEMP : SET_TEMPS port map(count_en => en_count_hour, inc_hour => inc_hour, hour => hour_ADR);


MEM_TMIN: RAM_TMIN port map (ADDR_W=>hour_ADR , ADDR_R => ADR_R , DATA_IN_U=>inc_temp, DATA_IN_D=>dec_temp, RAM_RW=>sw(1), clk=>clk, DATA_OUT_W=>temp_min_to_display,DATA_OUT_R => t_limit_min);
MEM_TMAX: RAM_TMAX port map (ADDR_W=>hour_ADR , ADDR_R => ADR_R , DATA_IN_U=>inc_temp, DATA_IN_D=>dec_temp, RAM_RW=>sw(2), clk=>clk, DATA_OUT_W=>temp_max_to_display,DATA_OUT_R => t_limit_max);

SIM_UNIT : SIMULATION_UNIT port map (clk => clk_1hz, current_temp => current_temp, min_temp => t_limit_min, max_temp => t_limit_max, temp_out =>mod_temp, heating => led(0), cooling => led(1));


end Behavioral;
