library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ALU is
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
    SR_OUT_R_L : out std_logic_vector(1 downto 0);
    S : out std_logic_vector(7 downto 0)
);
end ALU;

architecture arch_ALU of ALU is
 
    begin      


    process(CLK, RESET)
    variable A , B : std_logic_vector(3 downto 0);
    variable S_temp, A_temp, B_temp : std_logic_vector(7 downto 0);

    begin
        A (3 downto 0):= A_in; 
        B (3 downto 0):= B_in;
        if RESET = '1' then
        SR_OUT_R_L(0) <= '0';
        SR_OUT_R_L(1)<= '0';
        S <= (others => '0');
        S <= (others => '0');
        elsif rising_edge(CLK) then
            case SEL_FCT_mem is
            when "0000" => -- no op
            S(7 downto 0) <= (others => '0');
            SR_OUT_R_L(0) <= '0';
            SR_OUT_R_L(1) <= '0';
            when "0001" => -- shift right B
                S(7 downto 4) <= (others => '0');   
                S(2 downto 0) <= B_in(3 downto 1);
                S(3) <= SR_IN_L_R(0);
                SR_OUT_R_L(1) <= B_in(0);
                SR_OUT_R_L(0) <= '0';
                
            when "0010" => -- shift left B
                S(7 downto 4) <= (others => '0');
                S(3 downto 1) <= B_in(2 downto 0);
                S(0) <= SR_IN_L_R(1);
                SR_OUT_R_L(0) <= B_in(3);
                SR_OUT_R_L(1) <= '0';

            when "0011" => -- A 
                S(7 downto 4) <= (others => '0');
                S(3 downto 0) <= A_in;
                SR_OUT_R_L(0) <= '0';
                SR_OUT_R_L(1) <= '0';
            
            when "0100" => -- B
                S(7 downto 4) <= (others => '0');
                S(3 downto 0) <= B_in;
                SR_OUT_R_L(0) <= '0';
                SR_OUT_R_L(1) <= '0';
            
            when "0101" => -- not A
                S(7 downto 4) <= (others => '0');
                S(3 downto 0) <= not A_in;
                SR_OUT_R_L(0) <= '0';
                SR_OUT_R_L(1) <= '0';
            
            when "0110" => -- not B
                S(7 downto 4) <= (others => '0');
                S(3 downto 0) <= not B_in;
                SR_OUT_R_L(0) <= '0';
                SR_OUT_R_L(1) <= '0';
            
            when "0111" => -- A and B
                S(7 downto 4) <= (others => '0');
                S(3 downto 0) <= A_in and B_in;
                SR_OUT_R_L(0) <= '0';
                SR_OUT_R_L(1) <= '0';
            
            when "1000" => -- A or B
                S(7 downto 4) <= (others => '0');
                S(3 downto 0) <= A_in or B_in;
                SR_OUT_R_L(0) <= '0';
                SR_OUT_R_L(1) <= '0';
            
            when "1001" => -- A xor B
                S(7 downto 4) <= (others => '0');
                S(3 downto 0) <= A_in xor B_in;
                SR_OUT_R_L(0) <= '0';
                SR_OUT_R_L(1) <= '0';
            
            when "1010"=> -- A + B with carry in
                A_temp(3 downto 0) := A_in;
                A_temp(7 downto 4) := (others => A(3));
                B_temp(3 downto 0) := B_in;
                B_temp(7 downto 4) := (others => B(3));
                A_temp(7 downto 4) := (others => '0');
                S <= A_temp + B_temp + SR_IN_L_R(0);
                SR_OUT_R_L(0) <= S_temp(4);
                SR_OUT_R_L(1) <= '0';
            
            when "1011" => -- addition binaire sans retenue dâ€™entrÃ©e
                A_temp(3 downto 0) := A_in;
                A_temp(7 downto 4) := (others => A(3));
                B_temp(3 downto 0) := B_in;
                B_temp(7 downto 4) := (others => B(3));
                A_temp(7 downto 4) := (others => '0');
                S <= A_temp + B_temp;
                SR_OUT_R_L(0) <= '0';
                SR_OUT_R_L(1) <= '0';
                
            when "1100"=> -- soustraction binaire
                A_temp(3 downto 0) := A_in;
                A_temp(7 downto 4) := (others => A(3));
                B_temp(3 downto 0) := B_in;
                B_temp(7 downto 4) := (others => B(3));
                A_temp(7 downto 4) := (others => '0');
                S <= A_temp - B_temp;
                SR_OUT_R_L(0) <= '0';
                SR_OUT_R_L(1) <= '0';

            when "1101" => -- multiplication binaire
                A_temp(3 downto 0) := A_in;
                A_temp(7 downto 4) := (others => A(3));
                B_temp(3 downto 0) := B_in;
                B_temp(7 downto 4) := (others => B(3));
                A_temp(7 downto 4) := (others => '0');
                S <= A_temp * B_temp;
                SR_OUT_R_L(0) <= '0';
                SR_OUT_R_L(1) <= '0';
            
            when "1110"=> -- DÃ©c. droite A sur 4 bits(avec SR_IN_L_R(0))
                S(7 downto 4) <= (others => '0');
                SR_OUT_R_L(1) <= A_in(0);
                S(2 downto 0) <= A_in(3 downto 1);
                S(3) <= SR_IN_L_R(0);
                SR_OUT_R_L(0) <= '0';

            when "1111"=> -- DÃ©c. gauche A sur 4 bits (avec SR_IN_R)
                S(7 downto 4) <= (others => '0');
                SR_OUT_R_L(0) <= A_in(3);
                S(3 downto 1) <= A_in(2 downto 0);
                S(0) <= SR_IN_L_R(1);
                SR_OUT_R_L(1) <= '0';
            end case;
        end if;

    end process;
end arch_ALU;