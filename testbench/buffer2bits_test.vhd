library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity buffer2bits_test is
end buffer2bits_test;

architecture buffer2bits_test_Arch of buffer2bits_test is

    component buffer2bits is
        port (
            e1 : in std_logic;
            reset : in std_logic;
            preset : in std_logic;
            clock : in std_logic;
            s1 : out std_logic_vector (1 downto 0)
        );
    end component;

    signal e1_t : std_logic;
    signal reset : std_logic;
    signal preset : std_logic;
    signal clock : std_logic;
    signal s1 : std_logic_vector (1 downto 0);

begin
    
    buffer2bits_test_comp : buffer2bits
        port map (
            e1 => e1_t,
            reset => reset,
            preset => preset,
            clock => clock,
            s1 => s1
        );

    process
    begin
        e1_t <= '0';
        reset <= '0';
        preset <= '0';
        clock <= '0';
        wait for 1 ns;
        clock <= '1';
        wait for 1 ns;
        clock <= '0';
        report "entrée retenu " & integer'image(to_integer(unsigned(s1)));
        wait;
    end process;

end buffer2bits_test_Arch;
