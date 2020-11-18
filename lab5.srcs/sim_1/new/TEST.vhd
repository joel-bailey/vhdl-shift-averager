----------------------------------------------------------------------------------
-- Lab 5 - Averager
-- ECE 524/L
-- Engineer: Joel Bailey 
-- 
-- Create Date:   20201017
-- Modified Last: 20201026
-- Module Name: TEST.vhd

-- Description: Test bench for the averager circuit. RNG element is instantiated
--      and used as the data input for the averager. Seed was randomly chosen.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TEST is
    Generic( WIDTH : integer := 8;
             DEPTH : integer := 4;
             RNGWIDTH : integer := 32);
end TEST;

architecture Behavioral of TEST is

function n(NUM : integer) return STD_LOGIC_VECTOR is
begin
    return std_logic_vector(to_unsigned(NUM, WIDTH));
end function;

signal CLK, RST : STD_LOGIC;
signal DATA, AVG : STD_LOGIC_VECTOR( WIDTH - 1 downto 0 );
signal SEED : STD_LOGIC_VECTOR (RNGWIDTH - 1 downto 0);
signal RAND : INTEGER;
signal CP : time := 10 ns;


begin
    --instantiate design under test
    --generic map when override of defaults is needed
    DUT: entity work.TOP(Behavioral)
        generic map(WIDTH=>WIDTH, DEPTH=>DEPTH)
        port map(CLK=>CLK, RST=>RST, AVG=>AVG, DATA=>DATA);
    
    RANDOM: entity work.RNG(Behavioral)
        generic map(WIDTH=>RNGWIDTH)
        port map(CLK=>CLK, RST=>RST, SEED=>SEED, RAND=>RAND);

    --begin clock process
    clock: process 
    begin
        CLK <= '0';
        wait for CP/2;
        CLK <= '1';
        wait for CP/2;
    end process;
    
    reset: process 
    begin
        SEED <= std_logic_vector(to_unsigned(325745896, RNGWIDTH));
        RST <= '1';
        wait for CP;
        RST <= '0';
        wait;
    end process;
    
    input: process(RAND)
    begin
        DATA<=n(RAND mod 2**WIDTH);
    end process;

end Behavioral;
