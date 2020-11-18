----------------------------------------------------------------------------------
-- Lab 5 - Averager
-- ECE 524/L
-- Engineer: Joel Bailey 
-- 
-- Create Date:   20201017
-- Modified Last: 20201026
-- Module Name: SHIFTREG.vhd

-- Description: Infered SRL component, modified to input variable widths 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SHIFTREG is
    Generic (WIDTH : integer := 8; 
             DEPTH : integer := 32);
    
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           SI : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           SO : out STD_LOGIC_VECTOR (WIDTH - 1 downto 0));
end SHIFTREG;

architecture Behavioral of SHIFTREG is
    type SRL_ARRAY is array (DEPTH - 1 downto 0) of STD_LOGIC_VECTOR (WIDTH - 1 downto 0 );
    signal SHREG : SRL_ARRAY;
begin

process(clk)
begin
    if (RST = '1') then
        SHREG <= (others=>(others=>'0'));
    elsif rising_edge(clk) then
        SHREG <= SHREG(DEPTH - 2 downto 0) & SI;
    end if;
end process;

SO <= SHREG(DEPTH - 1);

end Behavioral;
