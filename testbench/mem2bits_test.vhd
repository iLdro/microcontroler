library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity mem2bits_test is
end mem2bits_test;

architecture mem2bits_test_Arch of mem2bits_test is

    component mem2bits is
        port (
            e1 : in std_logic;
            e2 : in std_logic;
            reset : in std_logic;
            preset : in std_logic;
            clock : in std_logic;
            ce : in std_logic;
            s1 : out std_logic_vector (1 downto 0)
        );
    end component;

    signal e1_t : std_logic;
    signal e2_t : std_logic;
    signal reset : std_logic;
    signal preset : std_logic;
    signal clock : std_logic;
    signal ce_t : std_logic;
    signal s1 : std_logic_vector (1 downto 0);

begin
    
    mem2bits_test_comp : mem2bits
        port map (
            e1 => e1_t,
            e2 => e2_t,
            reset => reset,
            preset => preset,
            clock => clock,
            ce => ce_t,
            s1 => s1
        );

    process
    begin
        e1_t <= '0';
        e2_t <= '1';
        ce_t <= '1';
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

end mem2bits_test_Arch;
