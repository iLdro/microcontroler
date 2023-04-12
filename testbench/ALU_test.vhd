library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ALU_test is
end ALU_test;

architecture ALU_test_Arch of ALU_test is

    component ALU is
        port(
            CLK : in std_logic;
            RESET : in std_logic;
            -- Inputs
            SR_IN_L_R : in std_logic_vector(1 downto 0);
            A_in : in std_logic_vector(3 downto 0);
            B_in : in std_logic_vector(3 downto 0);
            SEL_FCT_mem : in std_logic_vector(3 downto 0);
            -- Outputs
            SR_OUT_L_R_out: out std_logic_vector(1 downto 0);
            S_out : out std_logic_vector(7 downto 0)
        );
    end component;

    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal SR_IN_L_R : std_logic_vector(1 downto 0) := "00";
    signal a : std_logic_vector(3 downto 0) := "0000";
    signal b : std_logic_vector(3 downto 0) := "0000";
    signal SEL_FCT_ALU : std_logic_vector(3 downto 0) := "0000";
    signal result : std_logic_vector(7 downto 0);
    signal SR_OUT_L_R : std_logic_vector(1 downto 0);
    signal S : std_logic_vector(7 downto 0);
    signal Slow : std_logic_vector(3 downto 0);

begin

    MyAluTest : ALU
        port map(
            CLK => clk,
            RESET => reset,
            SR_IN_L_R => SR_IN_L_R,
            A_in => a,
            B_in => b,
            SEL_FCT_mem => SEL_FCT_ALU,
            SR_OUT_L_R_out => SR_OUT_L_R,
            S_out => S
        );
    a <= "0001";	
    b <= "1010";
    SEL_FCT_ALU <= "1011";
    SR_IN_L_R <= "10";

   
        SimProc : process
          begin
              wait for 10 ns;
              clk <= '1';
              wait for 10 ns;
              clk <= '0';
              wait for 10 ns;
              report "entrée retenu " & integer'image(to_integer(unsigned(SR_IN_L_R)));
              report "Result: " & integer'image(to_integer(unsigned(S)));
              report "Sortie decalage " & integer'image(to_integer(unsigned(SR_OUT_L_R)));
              wait;
          end process;
    end ALU_test_Arch;
