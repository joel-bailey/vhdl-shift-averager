----------------------------------------------------------------------------------
-- Lab 5 - Averager
-- ECE 524/L
-- Engineer: Joel Bailey 
-- 
-- Create Date:   20201017
-- Modified Last: 20201026
-- Module Name: ACCUMULATE.vhd

-- Description: Component to accumulate the data input and subtract out the delayed
--  value to keep a running average
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ACCUMULATE is
    Generic ( WIDTH : integer := 8;
              DEPTH : integer := 32);
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           DIN : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           SHIFTIN : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           ACC : out STD_LOGIC_VECTOR (WIDTH + 5 downto 0));
end ACCUMULATE;

architecture Behavioral of ACCUMULATE is

signal TACC : integer;

begin
process(CLK, RST) begin
    if (RST = '1') then
        TACC <= 0;
    elsif rising_edge(CLK) then
        TACC <= TACC + to_integer(unsigned(DIN)) - to_integer(unsigned(SHIFTIN));
    end if;
end process;

ACC <= std_logic_vector(to_unsigned(TACC, WIDTH + 6));

end Behavioral;
