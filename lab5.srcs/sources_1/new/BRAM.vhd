----------------------------------------------------------------------------------
-- Lab 5 - Averager
-- ECE 524/L
-- Engineer: Joel Bailey 
-- 
-- Create Date:   20201017
-- Modified Last: 20201026
-- Module Name: BRAM.vhd

-- Description: Infered simple dual port, single clock BRAM with We, Re, and Address 
--      counter.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use IEEE.std_logic_unsigned.all;

entity BRAM is
    Generic ( WIDTH : integer := 8;
              DEPTH : integer := 32);
    Port ( CLK, WE, RE : in STD_LOGIC;
           RST : in STD_LOGIC;
           DATAIN : in STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
           DATAOUT : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0));
end BRAM;

architecture Behavioral of BRAM is
    
    type RAMTYPE is array (DEPTH - 2 downto 0) of STD_LOGIC_VECTOR (WIDTH - 1 downto 0 );
    signal RAM : RAMTYPE;
    signal COUNT : integer;
    signal ADDR : STD_LOGIC_VECTOR(integer(ceil(log2(real(DEPTH - 1)))) - 1 downto 0);
    
begin

R: process (CLK, RST)
begin
    if (RST = '1') then
    elsif rising_edge(CLK) then
        if (RE = '1') then
            DATAOUT <= RAM(conv_integer(ADDR));
        end if;
    end if;
end process;

W: process (CLK, RST)
begin
    if (RST = '1') then
        
    elsif rising_edge(CLK) then
        if (WE = '1') then
            RAM(conv_integer(ADDR)) <= DATAIN;
        end if;
    end if;
end process;

C: process (CLK, RST)
begin
    if (RST = '1') then
        COUNT <= 0;
    elsif rising_edge(CLK) then
        if (COUNT = DEPTH - 2) then
            COUNT <= 0;
        else
            COUNT <= COUNT + 1;
        end if;
    end if;
end process;

ADDR <= std_logic_vector(to_unsigned(COUNT, integer(ceil(log2(real(DEPTH - 1)))) ));

end Behavioral;
