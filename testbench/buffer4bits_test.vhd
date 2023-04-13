library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity buffer4bits_test is
end buffer4bits_test;

architecture buffer4bits_test_Arch of buffer4bits_test is

    component buffer4bits is
        port (
            e : in std_logic_vector (3 downto 0);
            reset : in std_logic;
            preset : in std_logic;
            clock : in std_logic;
            ce : in std_logic;
            s1 : out std_logic_vector (3 downto 0)
        );
    end component;

    signal e_t : std_logic_vector (3 downto 0);
    signal reset : std_logic;
    signal preset : std_logic;
    signal clock : std_logic;
    signal ce_t : std_logic;
    signal s1 : std_logic_vector (3 downto 0);

begin
    
    mem4bits_test_comp : buffer4bits
        port map (
            e => e_t,
            reset => reset,
            preset => preset,
            clock => clock,
            ce => ce_t,
            s1 => s1
        );
        
    process
    begin   
    	e_t <= "0110";
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

end buffer4bits_test_Arch;
