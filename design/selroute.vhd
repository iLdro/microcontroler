
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

        signal ce_Buf_A : STD_LOGIC;
        signal ce_Buf_B : STD_LOGIC;
        signal ce_Mem_1 : STD_LOGIC;
        signal ce_Mem_2 : STD_LOGIC;

        signal Buf_A_in : STD_LOGIC_VECTOR (3 downto 0);
        signal Buf_B_in : STD_LOGIC_VECTOR (3 downto 0);
        signal Mem_1_In : STD_LOGIC_VECTOR (7 downto 0);
        signal Mem_2_In : STD_LOGIC_VECTOR (7 downto 0);
		
        signal Mem_1_out_temp : STD_LOGIC_VECTOR (3 downto 0);
        signal Mem_2_out_temp : STD_LOGIC_VECTOR (3 downto 0);
        

        component buffer2bits 
        port (-- Chip enabler on the rising edge of the clock
                e1 : in std_logic;
                e2 : in std_logic;
                reset : in std_logic;
                preset : in std_logic;
                clock : in std_logic;
                s1 : out std_logic_vector (1 downto 0)
        ); 
        end component;

        component buffer4bits
        port (
                e : in std_logic_vector (3 downto 0);
                reset : in std_logic;
                preset : in std_logic;
                ce : in std_logic;
                clock : in std_logic;
                s1 : out std_logic_vector (3 downto 0)
        );
        end component;
        signal Buffer4Bits_s1 : std_logic_vector (3 downto 0);

        component mem8bits
        port (
                e : in std_logic_vector (7 downto 0);
                reset : in std_logic;
                preset : in std_logic;
                clock : in std_logic;
                ce : in std_logic;
                s1 : out std_logic_vector (7 downto 0)
        );
        end component;
        signal mem8bits_s1 : std_logic_vector (7 downto 0);

        component mem4bits
        port (
                e : in std_logic_vector (3 downto 0);
            reset : in std_logic;
            preset : in std_logic;
            clock : in std_logic;
            ce : in std_logic;
            s1 : out std_logic_vector (3 downto 0)
    
        ); 
        end component;
        signal mem4bits_s1 : std_logic_vector (3 downto 0);
       

begin	
	

		
        BufferSR_IN : Buffer2bits
        port map (
            e1 => SR_IN_L,
            e2 =>  SR_IN_R,
            reset => RESET,
            preset => PRESET,
            clock => CLK,
            s1 => SR_IN_L_R -- Récupère dans le process SEL_FCT_mem
        );

        BufferA : Buffer4bits 
        port map(
                e => Buf_A_in,
                reset => RESET,
                preset => PRESET,
                ce => CE_Buf_A,
                clock => CLK,
                s1 => BufferA_out
        );

        BufferB : Buffer4Bits
        port map(
                e => Buf_B_in,
                reset => RESET,
                preset => PRESET,
                ce => CE_Buf_B,
                clock => CLK,
                s1 => BufferB_out
        );

        Mem_1 : mem8bits
        port map(
                e => Mem_1_In,
                reset => RESET,
                preset => PRESET,
                ce => CE_Mem_1,
                clock => CLK,
                s1 => Mem_1_out
        );

        Mem_2 : mem8bits
       port map(
                e => Mem_2_In,
                reset => RESET,
                preset => PRESET,
                ce => CE_Mem_2,
                clock => CLK,
                s1 => Mem_2_out
        );
        
       
        process(CLK, RESET, SEL_ROUTE)
        begin
                if(RESET = '1') then
                        CE_Buf_A <= '0';
                        CE_Buf_B <= '0';
                        CE_Mem_1 <= '0';
                        CE_Mem_2 <= '0';

                elsif (CLK'event and CLK = '1') then
                        Mem_1_out_temp <= Mem_1_out_temp;
                        Mem_2_out_temp <= Mem_2_out_temp;
                
                        case SEL_ROUTE is
                                when "0000" => -- Stockage de S dans MEM_CACHE_1
                                        CE_Mem_1 <= '1';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '0';
                                        CE_Buf_B <= '0';
                                        mem_1_in <= S;
                                when "0001" => -- Stockage de MEM_CACHE_2 dans le buffer_A (4 bits de poids faibles)
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '1';
                                        CE_Buf_B <= '0';
                                        Buf_A_in <= Mem_2_out_temp(3 downto 0);
                                when "0010" => -- Stockage de MEM_CACHE_2 dans le buffer_A (4 bits de poids fort)
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '1';
                                        CE_Buf_B <= '0';
                                        Buf_A_in <= Mem_2_out_temp(7 downto 4);
                                when "0011" => -- Stockage de MEM_CACHE_1 dans le buffer_A (4 bits de poids faibles)
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '1';
                                        CE_Buf_B <= '0';
                                        Buf_A_in <= Mem_1_out_temp(3 downto 0);
                                when "0100" => -- Stockage de MEM_CACHE_1 dans le buffer_A (4 bits de poids forts)
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '1';
                                        CE_Buf_B <= '0';
                                        Buf_A_in <= Mem_1_out_temp(7 downto 4);
                                when "0101" => -- Stockage de S dans le buffer_A (4 bits de poids faibles)
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '1';
                                        CE_Buf_B <= '0';
                                        Buf_A_in <= S(3 downto 0);
                                when "0110" => -- Stockage de S dans le buffer_A (4 bits de poids forts)
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '1';
                                        CE_Buf_B <= '0';
                                        Buf_A_in <= S(7 downto 4);
                                when "0111" => -- Stockage de l'entrée A_IN dans le buffer_A
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '1';
                                        CE_Buf_B <= '0';
                                        Buf_A_in <= A_IN;
                                when "1000" => -- Stockage de S dans MEM_CACHE_2
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '1';
                                        CE_Buf_A <= '0';
                                        CE_Buf_B <= '0';
                                        mem_2_in <= S;
                                when "1001" => -- Stockage de MEM_CACHE_2 dans Buffer_B(4 bits de poids faibles)
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '0';
                                        CE_Buf_B <= '1';
                                        Buf_B_in <= Mem_2_out_temp(3 downto 0);
                                when "1010" => -- Stockage de MEM_CACHE_2 dans Buffer_B(4 bits de poids forts)
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '0';
                                        CE_Buf_B <= '1';
                                        Buf_B_in <= Mem_2_out_temp(7 downto 4);
                                when "1011" => -- Stockage de MEM_CACHE_1 dans Buffer_B(4 bits de poids faibles)
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '0';
                                        CE_Buf_B <= '1';
                                        Buf_B_in <= Mem_1_out_temp(3 downto 0);
                                when "1100" => -- Stockage de MEM_CACHE_1 dans Buffer_B(4 bits de poids forts)
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '0';
                                        CE_Buf_B <= '1';
                                        Buf_B_in <= Mem_1_out_temp(7 downto 4);
                                when "1101" => -- Stockage de S dans Buffer_B(4 bits de poids faibles)
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '0';
                                        CE_Buf_B <= '1';
                                        Buf_B_in <= S(3 downto 0);
                                when "1110" => -- Stockage de S dans Buffer_B(4 bits de poids forts)
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '0';
                                        CE_Buf_B <= '1';
                                        Buf_B_in <= S(7 downto 4);
                                when "1111" => -- Stockage de l'entrée B_IN dans Buffer_B
                                        CE_Mem_1 <= '0';
                                        CE_Mem_2 <= '0';
                                        CE_Buf_A <= '0';
                                        CE_Buf_B <= '1';
                                        Buf_B_in <= B_IN;
                                when others =>

                        end case;
                end if;
        end process;

end selroute_Arch;