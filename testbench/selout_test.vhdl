library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity selout_test is
end selout_test;

architecture selout_test_Arch of selout_test is

    component selout is
        port(
            clk: in std_logic;
            rst: in std_logic;
            SEL_ROUTE: in std_logic_vector(1 downto 0);
            MEM1_out: in std_logic_vector(3 downto 0);
            MEM2_out: in std_logic_vector(3 downto 0);
            S_OUT: out std_logic_vector(3 downto 0);
            RES_out: out std_logic_vector(3 downto 0)
        );
    end component selout;

    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal SEL_ROUTE_t : std_logic_vector(1 downto 0) ;
    signal MEM1_out_t : std_logic_vector(3 downto 0) ;
    signal MEM2_out_t : std_logic_vector(3 downto 0) ;
    signal S_OUT_t : std_logic_vector(3 downto 0) ;

begin

    selout_test: selout port map(
        clk => clk,
        rst => reset,
        SEL_ROUTE => SEL_ROUTE_t,
        MEM1_out => MEM1_out_t,
        MEM2_out => MEM2_out_t,
        S_OUT => S_OUT_t
    );

    process 
    begin
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        wait for 10 ns;
        SEL_ROUTE_t <= "01";
        MEM1_out_t <= "0000";
        MEM2_out_t <= "0001";
        wait for 10 ns;
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
        report "entrée retenu " & integer'image(to_integer(unsigned(S_OUT_t)));
    end process;
    