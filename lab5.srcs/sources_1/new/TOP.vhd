----------------------------------------------------------------------------------
-- Lab 5 - Averager
-- ECE 524/L
-- Engineer: Joel Bailey 
-- 
-- Create Date:   20201017
-- Modified Last: 20201026
-- Module Name: TOP.vhd

-- Description: Top level design that connects the shifting component with 
--      an accumultor and averager
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

entity TOP is
    Generic( WIDTH : integer := 8;
             DEPTH: integer := 4);
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           AVG : out STD_LOGIC_VECTOR (WIDTH - 1 downto 0));
end TOP;

architecture Behavioral of TOP is
    signal SOUT : STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
    signal AOUT : STD_LOGIC_VECTOR (WIDTH + 5 downto 0);
    signal COUNT : integer;
    signal ADDR : STD_LOGIC_VECTOR ( integer(ceil(log2(real(DEPTH)))) - 1 downto 0);
begin
    SHFT: entity work.SHIFTREG(Behavioral)
        generic map(WIDTH=>WIDTH, DEPTH=>DEPTH)
        port map(CLK=>CLK, RST=>RST, SI=>DATA, SO=>SOUT);

--    BRAMSHFT: entity work.BRAM(Behavioral)
--        generic map(WIDTH=>WIDTH, DEPTH=>DEPTH)
--        port map(CLK=>CLK, RST=>RST, WE=>'1', RE=>'1', DATAIN=>DATA, DATAOUT=>SOUT);
    
    ACCUM: entity work.ACCUMULATE(Behavioral)
        generic map(WIDTH=>WIDTH, DEPTH=>DEPTH)
        port map(CLK=>CLK, RST=>RST, DIN=>DATA, SHIFTIN=>SOUT, ACC=>AOUT);
    
    AVGOUT: entity work.AVERAGE(Behavioral)
        generic map(WIDTH=>WIDTH, DEPTH=>DEPTH)
        port map(ACC=>AOUT, AVG=>AVG); 

end Behavioral;
