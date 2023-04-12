-- Only for testing

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity meminstruction is
    port(
        clock : in std_logic;
        reset: in std_logic;

        sel_fct : out std_logic_vector (3 downto 0);
        sel_route : out std_logic_vector (3 downto 0);
        sel_out : out std_logic_vector (1 downto 0)
    );
end meminstruction;

architecture meminstruction_Arch of meminstruction is

    -- memoire
    type memory is array (0 to 12) of std_logic_vector (9 downto 0);
    signal pointeur : integer range 0 to 127 := 0;

    constant MemInstruction_arr : memory := (
        ("0000011100"),-- On charge A dans buff A
        ("1101111111"),-- On charge B dans buff B, on multiplie et sors S
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000011100"),-- On charge A dans buff A
        ("1100111100"),-- On charge B dans buff B et on multiplie A par B
        ("0000110100"),-- On charge S dans le BUff B 
        ("1001011100"),-- On charge A dans buff A, on fait le xor
        ("0101010111"),-- On charge S dans A on effectue un notre dessus et on le sors
        ("0000000000"),
        ("0000000000"),
        ("0000000000"),
        ("0000011100"),-- On charge A0 dans buff A, 
        ("0100111110"),--On charge B0 dans buff B, on le sors et le copie dans MEM_CACHE2
        ("0111111101"),-- On charge B1 dans Buff B on fait le AND et on le copie dans MEM_CACHE1
        ("0000100100"),-- On copie les bits de points faible de MEM_CACHE2 dans buffer_B, soit B0 dans le buffer B
        ("0111011110"),-- On charge A1 dans buff A, on fait le and et on le copie dans MEM_CACHE2
        ("0000001100")-- On charge 4 bits de points faible de MEM_CACHE1 dans buffer_A, 
        ("1000100101")-- On charge les 4 bits de points faible de MEM_CACHE2 dans buffer_B soit ,on fait le or et sors le résultat

    );

begin

    process (clock)
    begin
        if (rising_edge(clock)) then
            if (reset = '1') then
                pointeur <= 0;
            else
                pointeur <= pointeur + 1;
            end if;
        end if;
    sel_fct <= MemInstruction_arr(pointeur)(9 downto 6);
    sel_route <= MemInstruction_arr(pointeur)(5 downto 2);
    sel_out <= MemInstruction_arr(pointeur)(1 downto 0);

    end process;

   
end meminstruction_Arch;
    