
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity selroute is
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
end selroute;

architecture selroute_Arch of selroute is

    signal CE_Mem_1 : STD_LOGIC;
    signal CE_Mem_2 : STD_LOGIC;
    signal CE_Buf_A : STD_LOGIC;
    signal CE_Buf_B : STD_LOGIC;
    

	begin
 
        process(CLK, RESET, SEL_ROUTE)
        begin
                if(RESET = '1') then
                        CE_Buf_A <= '0';
                        CE_Buf_B <= '0';
                        CE_Mem_1 <= '0';
                        CE_Mem_2 <= '0';

                elsif (CLK'event and CLK = '1') then
                
                        case SEL_ROUTE is
                                when "0000" => -- Stockage de S dans MEM_CACHE_1
                                        CE_Mem_1 <= '1';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '1';
                                        CE_Buf_B <= '0';
                                        mem_1_out <= S;
                                when "0001" => -- Stockage de MEM_CACHE_2 dans le buffer_A (4 bits de poids faibles)
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '1';
                                        CE_Buf_A <= '1';
                                        CE_Buf_B <= '0';
                                        bufferA_out <= Mem_2_in(3 downto 0);
                                when "0010" => -- Stockage de MEM_CACHE_2 dans le buffer_A (4 bits de poids fort)
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '1';
                                        CE_Buf_A <= '1';
                                        CE_Buf_B <= '0';
                                        bufferA_out<= Mem_2_in(7 downto 4);
                                when "0011" => -- Stockage de MEM_CACHE_1 dans le buffer_A (4 bits de poids faibles)
                                        CE_Mem_1 <= '1';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '1';
                                        CE_Buf_B <= '0';
                                        bufferA_out <= Mem_1_out(3 downto 0);
                                when "0100" => -- Stockage de MEM_CACHE_1 dans le buffer_A (4 bits de poids forts)
                                        CE_Mem_1 <= '1';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '1';
                                        CE_Buf_B <= '0';
                                        bufferA_out <= Mem_1_in(7 downto 4);
                                when "0101" => -- Stockage de S dans le buffer_A (4 bits de poids faibles)
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '1';
                                        CE_Buf_B <= '0';
                                        bufferA_out <= S(3 downto 0);
                                when "0110" => -- Stockage de S dans le buffer_A (4 bits de poids forts)
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '1';
                                        CE_Buf_B <= '0';
                                        bufferA_out <= S(7 downto 4);
                                when "0111" => -- Stockage de l'entrée A_IN dans le buffer_A
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '1';
                                        CE_Buf_B <= '0';
                                        bufferA_out <= A_IN;
                                when "1000" => -- Stockage de S dans MEM_CACHE_2
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '1';
                                        CE_Buf_A <= '0';
                                        CE_Buf_B <= '0';
                                        mem_2_out <= S;
                                when "1001" => -- Stockage de MEM_CACHE_2 dans Buffer_B(4 bits de poids faibles)
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '1';
                                        CE_Buf_A <= '0';
                                        CE_Buf_B <= '1';
                                        bufferB_out <= Mem_2_in(3 downto 0);
                                when "1010" => -- Stockage de MEM_CACHE_2 dans Buffer_B(4 bits de poids forts)
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '1';
                                        CE_Buf_A <= '0';
                                        CE_Buf_B <= '1';
                                        bufferB_out <= Mem_2_out(7 downto 4);
                                when "1011" => -- Stockage de MEM_CACHE_1 dans Buffer_B(4 bits de poids faibles)
                                        CE_Mem_1 <= '1';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '0';
                                        CE_Buf_B <= '1';
                                        BufferB_out <= Mem_1_in(3 downto 0);
                                when "1100" => -- Stockage de MEM_CACHE_1 dans Buffer_B(4 bits de poids forts)
                                        CE_Mem_1 <= '1';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '0';
                                        CE_Buf_B <= '1';
                                        BufferB_out <= Mem_1_in(7 downto 4);
                                when "1101" => -- Stockage de S dans Buffer_B(4 bits de poids faibles)
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '0';
                                        CE_Buf_B <= '1';
                                        BufferB_out <= S(3 downto 0);
                                when "1110" => -- Stockage de S dans Buffer_B(4 bits de poids forts)
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '0';
                                        CE_Buf_B <= '1';
                                        BufferB_out <= S(7 downto 4);
                                when "1111" => -- Stockage de l'entrée B_IN dans Buffer_B
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '0';
                                        CE_Buf_B <= '1';
                                        BufferB_out <= B_IN;
                                when others =>

                        end case;
                end if;
        end process;

end selroute_Arch;