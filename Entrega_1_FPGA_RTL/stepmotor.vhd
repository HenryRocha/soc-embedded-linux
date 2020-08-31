--
-- Rafael C.
-- ref:
--   - https://www.intel.com/content/www/us/en/programmable/quartushelp/13.0/mergedProjects/hdl/vhdl/vhdl_pro_state_machines.htm
--   - https://www.allaboutcircuits.com/technical-articles/implementing-a-finite-state-machine-in-vhdl/
--   - https://www.digikey.com/eewiki/pages/viewpage.action?pageId=4096117

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY stepmotor IS
    PORT (
        -- Globals
        clk : IN std_logic;

        -- Controls
        -- 1 on/ 0 off
        en : IN std_logic;
        -- 1 clock wise/ 0 coutner clock wise
        dir : IN std_logic;
        -- 00: low / 11: fast
        vel : IN std_logic_vector(1 DOWNTO 0);

        -- I/Os
        phases : OUT std_logic_vector(3 DOWNTO 0)
    );
END ENTITY stepmotor;

ARCHITECTURE rtl OF stepmotor IS
    TYPE STATE_TYPE IS (s0, s1, s2, s3);
    SIGNAL state : STATE_TYPE := s0;
    SIGNAL timeCounter : std_logic := '0';
    SIGNAL topCounter : INTEGER RANGE 0 TO 50000000;
    SIGNAL stepCounter : INTEGER RANGE 0 TO 50000000 := 0;
    SIGNAL steps : INTEGER RANGE 0 TO 50000000 := 2000;

BEGIN
    PROCESS (clk)
    BEGIN
        IF (rising_edge(clk) AND timeCounter = '1' AND stepCounter < steps - 1) THEN
            CASE state IS
                WHEN s0 =>
                    state <= s1;
                WHEN s1 =>
                    state <= s2;
                WHEN s2 =>
                    state <= s3;
                WHEN s3 =>
                    state <= s0;
                WHEN OTHERS =>
                    state <= s0;
            END CASE;

            stepCounter <= stepCounter + 1;
        END IF;
    END PROCESS;

    PROCESS (state)
    BEGIN
        IF (dir = '1') THEN
            CASE state IS
                WHEN s0 =>
                    phases <= "0001";
                WHEN s1 =>
                    phases <= "0010";
                WHEN s2 =>
                    phases <= "0100";
                WHEN s3 =>
                    phases <= "1000";
                WHEN OTHERS =>
                    phases <= "0000";
            END CASE;
        ELSE
            CASE state IS
                WHEN s3 =>
                    phases <= "0001";
                WHEN s2 =>
                    phases <= "0010";
                WHEN s1 =>
                    phases <= "0100";
                WHEN s0 =>
                    phases <= "1000";
                WHEN OTHERS =>
                    phases <= "0000";
            END CASE;
        END IF;
    END PROCESS;

    PROCESS (vel)
    BEGIN
        CASE vel IS
            WHEN "00" =>
                topCounter <= 160000;
            WHEN "01" =>
                topCounter <= 140000;
            WHEN "10" =>
                topCounter <= 120000;
            WHEN "11" =>
                -- Creates a delta time of 2ms between each phase change,
                -- the minimium for the motor to work. This means that at this
                -- speed, the motor is at it's fastest.
                topCounter <= 100000;
            WHEN OTHERS =>
                topCounter <= 1000000;
        END CASE;
    END PROCESS;

    PROCESS (clk)
        VARIABLE counter : INTEGER RANGE 0 TO 50000000 := 0;
    BEGIN
        IF (rising_edge(clk)) THEN
            IF (en = '1') THEN
                IF (counter < topCounter) THEN
                    counter := counter + 1;
                    timeCounter <= '0';
                ELSE
                    counter := 0;
                    timeCounter <= '1';
                END IF;
            END IF;
        END IF;
    END PROCESS;
END rtl;