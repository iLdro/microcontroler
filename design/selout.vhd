library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity selout is 
port(
    clk        : in  std_logic;
    rst        : in  std_logic;
    SEL_ROUTE  : in  std_logic_vector(1 downto 0);
    MEM1_out   : in  std_logic_vector(3 downto 0);
    MEM2_out   : in  std_logic_vector(3 downto 0);
    S_OUT      : in  std_logic_vector(3 downto 0);
   	SR_IN_LR: in std_logic_vector(1 downto 0);
    RES_out    : out std_logic_vector(3 downto 0);
    SR_OUT_L: out std_logic ;
    SR_OUT_R: out std_logic 
);

end entity selout;

architecture selt_out_arch of selout is

begin 

 MySelRouteProc : process (clk, rst)

begin 
    if rst = '1' then
        RES_out <= "0000";
    elsif falling_edge(clk) then
        case SEL_ROUTE is
            when "00" => RES_out <= "0000";
            when "01" => RES_out <= MEM1_out;
            when "10" => RES_out <= MEM2_out;
            when "11" => RES_out <= S_OUT;
            when others => null;
        end case;
        SR_OUT_L <= SR_IN_LR(1);
        SR_OUT_R <= SR_IN_LR(0);
    end if;
end process MySelRouteProc;

end architecture selt_out_arch;
