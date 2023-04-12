library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity selroute_test is
end selroute_test;

architecture selroute_test_arch of selroute_test is

    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
   
    signal SR_IN_L_t : std_logic := '0';
    signal SR_IN_R_t : std_logic := '0';
    signal A_IN_t : std_logic_vector (3 downto 0) := (others => '0');
    signal B_IN_t : std_logic_vector (3 downto 0) := (others => '0');
    signal S_t : std_logic_vector (7 downto 0) := (others => '0');
    signal SEL_ROUTE_t : std_logic_vector (3 downto 0) := (others => '0');

    signal SR_IN_L_R_t : std_logic_vector (1 downto 0);
    signal bufferA_out_t : std_logic_vector (3 downto 0);
    signal bufferB_out_t : std_logic_vector (3 downto 0);

    signal mem_1_out_t : std_logic_vector (7 downto 0);
    signal mem_2_out_t : std_logic_vector (7 downto 0);

    component selroute 
    port(
        CLK : in STD_LOGIC;
        RESET : in STD_LOGIC;

        SR_IN_L : in STD_LOGIC;
        SR_IN_R : in STD_LOGIC;
        A_IN : in STD_LOGIC_VECTOR (3 downto 0);
        B_IN : in STD_LOGIC_VECTOR (3 downto 0);
        S : in STD_LOGIC_VECTOR (7 downto 0);
        SEL_ROUTE : in STD_LOGIC_VECTOR (3 downto 0);

        -- Sorties
        SR_IN_L_R : out STD_LOGIC_VECTOR (1 downto 0);
        bufferA_out : out STD_LOGIC_VECTOR (3 downto 0);
        bufferB_out : out STD_LOGIC_VECTOR (3 downto 0);

        -- Sorties des mémoires
        mem_1_out : out STD_LOGIC_VECTOR (7 downto 0);
        mem_2_out : out STD_LOGIC_VECTOR (7 downto 0)
    );
    end component;

    

begin

    selroute_test : selroute
    port map(
        CLK => clk,
        RESET => reset,

        SR_IN_L => SR_IN_L_t,
        SR_IN_R => SR_IN_R_t,
        A_IN => A_IN_t,
        B_IN => B_IN_t,
        S => S_t,
        SEL_ROUTE => SEL_ROUTE_t,

        SR_IN_L_R => SR_IN_L_R_t,
        bufferA_out => bufferA_out_t,
        bufferB_out => bufferB_out_t,

        mem_1_out => mem_1_out_t,
        mem_2_out => mem_2_out_t
    );

    process
    begin
        clk <= '0';
        SR_IN_L_t <= '0';
        SR_IN_R_t <= '0';
        A_IN_t <= '0001';
        B_IN_t <= (others => '0');
        S_t <= (others => '0');
        SEL_ROUTE_t <= '0111';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
        report "entrée retenu " & integer'image(to_integer(unsigned(bufferA_out_t)));
        wait;
    end process;
