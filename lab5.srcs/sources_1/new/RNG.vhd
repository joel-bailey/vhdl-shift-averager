----------------------------------------------------------------------------------
-- Lab 5 - Averager
-- ECE 524/L
-- Engineer: Joel Bailey 
-- 
-- Create Date:   20201017
-- Modified Last: 20201026
-- Module Name: RNG.vhd

-- Description: 32-bit RNG component where seed is given in test bench. Bits 3, 7
--      10 and 31 are XOR'd
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RNG is
    Generic ( WIDTH : integer := 32);
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           SEED : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           RAND : out INTEGER);
end RNG;

architecture Behavioral of RNG is

signal TRAND : STD_LOGIC_VECTOR (WIDTH - 1 downto 0);

begin

process(CLK, RST)
variable RBIT : STD_LOGIC;
begin
    if (RST = '1') then
        TRAND <= SEED;
    elsif rising_edge(CLK) then
        RBIT := TRAND(3) xor TRAND(7) xor TRAND(10) xor TRAND(31);
        TRAND <= RBIT & TRAND(WIDTH - 1 downto 1);
    end if;
end process;

RAND <= to_integer(unsigned(TRAND));

end Behavioral;
