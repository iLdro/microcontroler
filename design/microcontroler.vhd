library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity microprocessor is
    port(
        clk: in std_logic;
        reset: in std_logic;
        m_A_in : in std_logic_vector(3 downto 0);
        m_B_in : in std_logic_vector(3 downto 0);
        m_SR_in_L : in std_logic;
        m_SR_in_R : in std_logic;

        m_SR_out_L : out std_logic;
        m_SR_out_R : out std_logic;
        m_RES_out : out std_logic_vector(3 downto 0)
        
    );
end microprocessor;


architecture microprocessor_Arch of microprocessor is

    

    --Signaux pour le controle de la memoire d'instruction
    signal meminstruction_select_fonction : std_logic_vector(3 downto 0);
    signal meminstruction_select_route : std_logic_vector(3 downto 0);
    signal meminstruction_select_out: std_logic_vector(1 downto 0);

    --Signaux pour la mémoire sel_fonction
    signal memfonction_e: std_logic_vector(3 downto 0);
    signal memfonction_ce: std_logic ;
    signal memfonction_s: std_logic_vector(3 downto 0);

    --Signaux pour la mémoire sel_out
    signal memout_e: std_logic;
    signal memout_ce: std_logic ;
    signal memout_s: std_logic_vector(1 downto 0);

    --Signaux pour la mémoire sel_route
    signal memroute_SR_in_L_R: std_logic_vector(1 downto 0);
    signal memroute_bufferA_out: std_logic_vector(3 downto 0);
    signal memroute_bufferB_out: std_logic_vector(3 downto 0);

    --Signaux pour la mémoire sel_route
    signal memroute_mem_1_out: std_logic_vector(7 downto 0);
    signal memroute_mem_2_out: std_logic_vector(7 downto 0);

    --Signaux pour l'ALU
    signal ALU_SR_OUT_L_R_out: std_logic_vector(1 downto 0);
    signal ALU_S_out: std_logic_vector(7 downto 0);

    --Signaux pour SEL_OUT 
    signal  SEL_OUT_RES_out: std_logic_vector(3 downto 0);
    signal  SEL_OUT_SR_OUT_L: std_logic;
    signal SEL_OUT_SR_OUT_R: std_logic;




    component meminstruction is
        port(
            clock : in std_logic;
            reset: in std_logic;
    
            sel_fct : out std_logic_vector (3 downto 0);
            sel_route : out std_logic_vector (3 downto 0);
            sel_out : out std_logic_vector (1 downto 0)
        );
    end component;

    component mem4bits is
        port (
            e : in std_logic_vector (3 downto 0);
            reset : in std_logic;
            preset : in std_logic;
            clock : in std_logic;
            ce : in std_logic;
            s1 : out std_logic_vector (3 downto 0)
    
        );
    end component;

    component mem2bits is
        port (
            e1 : in std_logic;
            reset : in std_logic;
            preset : in std_logic;
            clock : in std_logic;
            ce : in std_logic;
            s1 : out std_logic_vector (1 downto 0)
    
        );
    end component;

    component selroute is
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
    
            -- Sorties
            SR_IN_L_R : out STD_LOGIC_VECTOR (1 downto 0);
            bufferA_out : out STD_LOGIC_VECTOR (3 downto 0);
            bufferB_out : out STD_LOGIC_VECTOR (3 downto 0);
    
            -- Sorties des mémoires
            mem_1_out : out STD_LOGIC_VECTOR (7 downto 0);
            mem_2_out : out STD_LOGIC_VECTOR (7 downto 0)
    
    
        );
    end component;

    component ALU is
        port(
            -- Clock and reset
            CLK : in std_logic;
            RESET : in std_logic;
            -- Inputs
            SR_IN_L_R : in std_logic_vector(1 downto 0);
            A_in : in std_logic_vector(3 downto 0);
            B_in : in std_logic_vector(3 downto 0);
            SEL_FCT_mem : in std_logic_vector(3 downto 0);
            -- Outputs
            SR_OUT_L_R_out : out std_logic_vector(1 downto 0);
            S_out : out std_logic_vector(7 downto 0)
        );
    end component;

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
    end component ;
        

    begin

        meminstruction_f : meminstruction port map(
            clock => clk,
            reset => reset,
            sel_fct => meminstruction_select_fonction,
            sel_route => meminstruction_select_route,
            sel_out => meminstruction_select_out
        );

        memselfonction : mem4bits port map(
            e => meminstruction_select_fonction,
            reset => reset,
            preset => '0',
            clock => clk,
            ce => memfonction_ce,
            s1 => memfonction_s
        );

        memselout : mem2bits port map(
            e1 => meminstruction_select_out,
            reset => reset,
            preset => '0',
            clock => clk,
            ce => memout_ce,
            s1 => memout_s
        );

        selroute : selroute port map(
            CLK => clk,
            RESET => reset,
            PRESET => '0',
            SR_IN_L => SR_in_L,
            SR_IN_R => SR_in_R,
            A_IN => m_A_in,
            B_IN => m_B_in,
            S => ALU_S_out,
            SEL_ROUTE => meminstruction_select_route,
            SR_IN_L_R => memroute_SR_in_L_R,
            bufferA_out => memroute_bufferA_out,
            bufferB_out => memroute_bufferB_out,
            mem_1_out => memroute_mem_1_out,
            mem_2_out => memroute_mem_2_out
        );

        ALU : ALU port map(
            CLK => clk,
            RESET => reset,
            SR_IN_L_R => memroute_SR_in_L_R,
            A_in => memroute_bufferA_out,
            B_in => memroute_bufferB_out,
            SEL_FCT_mem => memfonction_s,
            SR_OUT_L_R_out => ALU_SR_OUT_L_R_out,
            S_out => ALU_S_out
        );

        selout : selout port map(
            clk => clk,
            rst => reset,
            SEL_ROUTE => meminstruction_select_route,
            MEM1_out => memroute_mem_1_out,
            MEM2_out => memroute_mem_2_out,
            S_OUT => ALU_S_out,
            SR_IN_LR => memroute_SR_in_L_R,
            RES_out => SEL_OUT_RES_out,
            SR_OUT_L => SEL_OUT_SR_OUT_L,
            SR_OUT_R => SEL_OUT_SR_OUT_R
        );

        process(clk, reset)
            begin
                if(clk = '1') then
                    memfonction_ce <= '1';
                    memout_ce <= '1';
                elsif (clk ='0') then 
                m_SR_OUT_L <=  SEL_OUT_SR_OUT_L;
                m_SR_OUT_R <=  SEL_OUT_SR_OUT_R;
                m_RES <=  Sel_OUT_RES_out;
                end if;
        end process;

    end architecture;