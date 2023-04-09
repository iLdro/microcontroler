library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity buffer2bits is
    port (-- Chip enabler on the rising edge of the clock
        e1 : in std_logic;
        e2 : in std_logic;
        reset : in std_logic;
        preset : in std_logic;
        clock : in std_logic;
        s1 : out std_logic_vector (1 downto 0)
    );
end buffer2bits;

architecture buffer2bits_Arch of buffer2bits is

    begin
        -- process explicite - instructions séquentielle
        MyBufferNbitsProc : process (reset, clock)
        begin 
            if (reset = '1') then
                s1 <= (others => '0');
            elsif (rising_edge(clock)) then
                if (preset = '1') then
                    s1 <= (others => '1');
                else
                    s1(1) <= e1;
                    s1(0) <= e2;
                end if;
            end if;
        end process;

end buffer2bits_Arch;