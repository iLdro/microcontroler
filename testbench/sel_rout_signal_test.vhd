library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity selroute_test_l is
end selroute_test_l;

architecture selroute_test_arch of selroute_test_l is

    component selroute_signal 
     Port ( 
        -- Clock et reset
        CLK : in STD_LOGIC;
        RESET : in STD_LOGIC;
        PRESET : in STD_LOGIC;
        
        SR_IN_L : in STD_LOGIC;
        SR_IN_R : in STD_LOGIC;
        A_IN : in STD_LOGIC_VECTOR (3 downto 0);
        B_IN : in STD_LOGIC_VECTOR (3 downto 0);
        S : in STD_LOGIC_VECTOR (7 downto 0);
        SEL_ROUTE : in STD_LOGIC_VECTOR (3 downto 0);
        mem_1_in : in STD_LOGIC_VECTOR(7 downto 0);
        mem_2_in : in STD_LOGIC_VECTOR(7 downto 0);

        -- Sorties
        SR_IN_L_R : out STD_LOGIC_VECTOR (1 downto 0);
        bufferA_out : out STD_LOGIC_VECTOR (3 downto 0);
        bufferB_out : out STD_LOGIC_VECTOR (3 downto 0);

        -- Sorties des mémoires
        mem_1_out : out STD_LOGIC_VECTOR (7 downto 0);
        mem_2_out : out STD_LOGIC_VECTOR (7 downto 0)


    );
    end component;
    
    signal CLK_t : STD_LOGIC := '0';
    signal RESET_t : STD_LOGIC := '0';
    signal PRESET_t : STD_LOGIC := '0';

    signal SR_IN_L_t : STD_LOGIC := '0';
    signal SR_IN_R_t : STD_LOGIC := '0';
    signal A_IN_t : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal B_IN_t : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal S_t : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal SEL_ROUTE_t : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal mem_1_in_t : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal mem_2_in_t : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');


    signal SR_IN_L_R_t : STD_LOGIC_VECTOR (1 downto 0);
    signal bufferA_out_t : STD_LOGIC_VECTOR (3 downto 0);
    signal bufferB_out_t : STD_LOGIC_VECTOR (3 downto 0);

    signal mem_1_out_t : STD_LOGIC_VECTOR (7 downto 0);
    signal mem_2_out_t : STD_LOGIC_VECTOR (7 downto 0);

begin
    
        selroute_inst : selroute_signal
        port map(
            CLK => CLK_t,
            RESET => RESET_t,
            PRESET => PRESET_t,
            SR_IN_L => SR_IN_L_t,
            SR_IN_R => SR_IN_R_t,
            A_IN => A_IN_t,
            B_IN => B_IN_t,
            S => S_t,
            SEL_ROUTE => SEL_ROUTE_t,
            mem_1_in => mem_1_in_t,
            mem_2_in => mem_2_in_t,
            SR_IN_L_R => SR_IN_L_R_t,
            bufferA_out => bufferA_out_t,
            bufferB_out => bufferB_out_t,
            mem_1_out => mem_1_out_t,
            mem_2_out => mem_2_out_t
        );
    
        process
        begin
            SR_IN_L_t <= '0';
            SR_IN_R_t <= '0';
            A_IN_t <= (others => '0');
            B_IN_t <= (others => '0');
            S_t <= (others => '0');
            SEL_ROUTE_t <= (others => '0');
             CLK_t <= '0';
            wait for 10 ns;
            CLK_t <= '1';
            SR_IN_L_t <= '1';
            SR_IN_R_t <= '1';
            A_IN_t <= "0001";
            mem_1_in_t <= "00101000";
            mem_2_in_t <="00101000";
            B_IN_t <= "0010";
            S_t <= "00010011";
            SEL_ROUTE_t <= "0101";
            wait for 10 ns;
            report "entrée retenu " & integer'image(to_integer(unsigned(bufferA_out_t)));
            wait;
        end process;
    
end selroute_test_arch;