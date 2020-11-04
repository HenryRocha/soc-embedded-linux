LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.numeric_std.ALL;
USE work.ALL;

ENTITY peripheral_motor IS
    GENERIC (
        LEN : NATURAL := 4
    );
    PORT (
        -- Globals
        clk   : IN STD_LOGIC := '0';
        reset : IN STD_LOGIC := '0';

        -- I/Os
        stepmotor_pio : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);

        -- Avalion Memmory Mapped Slave
        avs_address   : IN STD_LOGIC_VECTOR(3 DOWNTO 0)   := (OTHERS => '0');
        avs_read      : IN STD_LOGIC                      := '0';
        avs_readdata  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
        avs_write     : IN STD_LOGIC                      := '0';
        avs_writedata : IN STD_LOGIC_VECTOR(31 DOWNTO 0)  := (OTHERS => '0')
    );
END ENTITY peripheral_motor;

ARCHITECTURE rtl OF peripheral_motor IS
    -- Declarando o stepmotor, o mesmo usado na entrega 01.
    COMPONENT stepmotor IS
        PORT (
            -- Gloabals
            clk : IN STD_LOGIC;

            -- controls
            en     : IN STD_LOGIC;                    -- 1 on / 0 off
            dir    : IN STD_LOGIC;                    -- 1 clock wise
            vel    : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- 00: low / 11: fast
            phases : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    -- Sinais intermediarios.
    SIGNAL en  : STD_LOGIC;
    SIGNAL dir : STD_LOGIC;
    SIGNAL vel : STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN
    -- Fazendo o port map do motor.
    u0 : stepmotor PORT MAP(
        clk,
        en,
        dir,
        vel,
        stepmotor_pio(3 DOWNTO 0)
    );

    PROCESS (clk)
    BEGIN
        IF (rising_edge(clk)) THEN
            IF (avs_address = "0000") THEN
                IF (avs_write = '1') THEN
                    en <= avs_writedata(0);
                ELSIF (avs_read = '1') THEN
                    avs_readdata(0) <= en;
                END IF;
            ELSIF (avs_address = "0001") THEN
                IF (avs_write = '1') THEN
                    dir <= avs_writedata(0);
                ELSIF (avs_read = '1') THEN
                    avs_readdata(0) <= dir;
                END IF;
            ELSIF (avs_address = "0010") THEN
                IF (avs_write = '1') THEN
                    vel <= avs_writedata(1 DOWNTO 0);
                ELSIF (avs_read = '1') THEN
                    avs_readdata(1 DOWNTO 0) <= vel;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END rtl;