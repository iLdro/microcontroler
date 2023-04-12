library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity memintruction_test is
end memintruction_test;

architecture memintruction_test_arch of memintruction_test is
    component meminstruction is
            port(
                clock : in std_logic;
                reset: in std_logic;

                sel_fct : out std_logic_vector (3 downto 0);
                sel_route : out std_logic_vector (3 downto 0);
                sel_out : out std_logic_vector (1 downto 0)
            );
        end meminstruc
            
    end component;
    signal clock : std_logic;
    signal reset : std_logic;
    signal sel_fct : std_logic_vector (3 downto 0);
    signal sel_route : std_logic_vector (3 downto 0);
    signal sel_out : std_logic_vector (1 downto 0);

    begin
        meminstruction_inst : meminstruction
            port map(
                clock_ => clock,
                reset => reset,
                sel_fct => sel_fct,
                sel_route => sel_route,
                sel_out => sel_out
            );
    end memintruction_test_arch;

    process
    begin

        clock <= '0';
        reset <= '0';
        wait for 10 ns;
        clock <= '1';
        wait for 10 ns;
        report "Sortie sel_fct " & integer'image(to_integer(unsigned(sel_fct)));
        report "Sortie sel_route " & integer'image(to_integer(unsigned(sel_route)));
        report "Sortie sel_out " & integer'image(to_integer(unsigned(sel_out)));
        wait;
    end process;

end memintruction_test;



