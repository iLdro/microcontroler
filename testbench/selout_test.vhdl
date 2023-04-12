library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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
            S_OUT: in std_logic_vector(3 downto 0);
            SR_IN_LR: in std_logic_vector(1 downto 0);
            RES_out: out std_logic_vector(3 downto 0);
            SR_OUT_L: out std_logic ;
            SR_OUT_R: out std_logic 
        );
    end component selout;

    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal SEL_ROUTE_t : std_logic_vector(1 downto 0) ;
    signal MEM1_out_t : std_logic_vector(3 downto 0) ;
    signal MEM2_out_t : std_logic_vector(3 downto 0) ;
    signal S_OUT_t : std_logic_vector(3 downto 0) ;
    signal RES_out_t : std_logic_vector(3 downto 0) ;
    signal SR_IN_LR_t : std_logic ;
    signal SR_OUT_L_t : std_logic ;
    signal SR_OUT_R_t : std_logic ;

begin

    selout_test_inst: selout port map(
        clk => clk,
        rst => reset,
        SEL_ROUTE => SEL_ROUTE_t,
        MEM1_out => MEM1_out_t,
        MEM2_out => MEM2_out_t,
        S_OUT => S_OUT_t,
        SR_IN_LR => SR_IN_LR_t,
        RES_out => RES_out_t,
        SR_OUT_L => SR_OUT_L_t,
        SR_OUT_R => SR_OUT_R_t
    );

    process 
    begin

        SEL_ROUTE_t <= "01";
        MEM1_out_t <= "0010";
        MEM2_out_t <= "0001";
        S_OUT_t <= "0100";
        SR_IN_LR_t <= '00';
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
        report "Sortie " & integer'image(to_integer(unsigned(RES_out_t)));
        wait;
    end process;
end selout_test_Arch;
