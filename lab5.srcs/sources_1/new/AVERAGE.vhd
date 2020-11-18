----------------------------------------------------------------------------------
-- Lab 5 - Averager
-- ECE 524/L
-- Engineer: Joel Bailey 
-- 
-- Create Date:   20201017
-- Modified Last: 20201026
-- Module Name: AVERAGER.vhd

-- Description: Component that inputs the accumulated value and shifts it by
--      log2(DEPTH) which is log2 of the delay. Result is truncated average of 
--      m-delays when m = 2^n.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

entity AVERAGE is
    Generic ( WIDTH : integer := 8;
              DEPTH : integer := 32);
    Port ( ACC : in STD_LOGIC_VECTOR (WIDTH + 5 downto 0);
           AVG : out STD_LOGIC_VECTOR (WIDTH - 1 downto 0));
end AVERAGE;

architecture Behavioral of AVERAGE is

function lg2(LOGME : integer) return integer is
begin
    return integer(ceil(log2(real(LOGME))));
end function;

begin

process(ACC)
variable SHIFT : integer := lg2(DEPTH);
variable TEMP : unsigned(WIDTH + 5 downto 0);
begin
    TEMP := unsigned(ACC) srl SHIFT;
    AVG <= std_logic_vector(TEMP(WIDTH-1 downto 0 ));
end process;

end Behavioral;
