library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity microprocessor_tb is
end microprocessor_tb;

architecture tb_arch of microprocessor_tb is

    -- Constantes pour la simulation
    constant CLOCK_PERIOD : time := 10 ns;

    -- Signaux pour les ports de l'entité microprocessor
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal m_A_in : std_logic_vector(3 downto 0) := (others => '0');
    signal m_B_in : std_logic_vector(3 downto 0) := (others => '0');
    signal m_SR_in_L : std_logic := '0';
    signal m_SR_in_R : std_logic := '0';
    signal m_SR_out_L : std_logic;
    signal m_SR_out_R : std_logic;
    signal m_RES_out : std_logic_vector(3 downto 0);

    -- Variable compteur
    variable counter : natural := 0;

begin

    -- Instanciation de l'entité microprocessor
    UUT : entity work.microprocessor
    port map(
        clk => clk,
        reset => reset,
        m_A_in => m_A_in,
        m_B_in => m_B_in,
        m_SR_in_L => m_SR_in_L,
        m_SR_in_R => m_SR_in_R,
        m_SR_out_L => m_SR_out_L,
        m_SR_out_R => m_SR_out_R,
        m_RES_out => m_RES_out
    );

    -- Processus pour générer l'horloge
    process
    begin
        for i in 0 to 127 loop
            if(i = 15) then(
                m_B_in <= "0011";
            )
            elsif(i = 17)then(
                m_A_in <= "1000";
            )
            else then(
                m_A_in <= "0101";
                m_B_in <= "0001";
            )
            end if;
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end loop;
        wait;
    end process;

    -- Processus pour effectuer les changements de valeurs
end tb_arch;
