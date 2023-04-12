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
        ("0001111001"),
        ("0000000000"),
        ("0000000000")


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
    