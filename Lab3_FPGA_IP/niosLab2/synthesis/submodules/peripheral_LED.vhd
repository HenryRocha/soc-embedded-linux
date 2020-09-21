LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.numeric_std.ALL;
USE work.ALL;

ENTITY peripheral_LED IS
    GENERIC (
        LEN : NATURAL := 4
    );
    PORT (
        -- Gloabals
        clk : IN std_logic := '0';
        reset : IN std_logic := '0';

        -- I/Os
        LEDs : OUT std_logic_vector(LEN - 1 DOWNTO 0) := (OTHERS => '0');

        -- Avalion Memmory Mapped Slave
        avs_address : IN std_logic_vector(3 DOWNTO 0) := (OTHERS => '0');
        avs_read : IN std_logic := '0';
        avs_readdata : OUT std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
        avs_write : IN std_logic := '0';
        avs_writedata : IN std_logic_vector(31 DOWNTO 0) := (OTHERS => '0')
    );
END ENTITY peripheral_LED;

ARCHITECTURE rtl OF peripheral_LED IS
BEGIN
    PROCESS (clk)
    BEGIN
        IF (reset = '1') THEN
            LEDs <= (OTHERS => '0');
        ELSIF (rising_edge(clk)) THEN
            IF (avs_address = "0001") THEN -- REG_DATA
                IF (avs_write = '1') THEN
                    LEDs <= avs_writedata(LEN - 1 DOWNTO 0);
                END IF;
            END IF;
        END IF;
    END PROCESS;
END rtl;