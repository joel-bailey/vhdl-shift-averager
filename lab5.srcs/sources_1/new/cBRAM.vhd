library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.MATH_REAL.ALL;
entity cbram is
generic( width: integer := 16;
         depth: integer := 1024);
 port(
 clk : in std_logic;
 ena : in std_logic;
 enb : in std_logic;
 wea : in std_logic;
 addra : in std_logic_vector(integer(ceil(log2(real(DEPTH)))) - 1 downto 0);
 addrb : in std_logic_vector(integer(ceil(log2(real(DEPTH)))) - 1 downto 0);
 dia : in std_logic_vector(width - 1 downto 0);
 dob : out std_logic_vector(width - 1 downto 0)
 );
end cbram;
architecture syn of cbram is
 type ram_type is array (depth - 1 downto 0) of std_logic_vector(width - 1 downto 0);
 shared variable RAM : ram_type;
begin
 process(clk)
 begin
 if clk'event and clk = '1' then
 if ena = '1' then
 if wea = '1' then
 RAM(conv_integer(addra)) := dia;
 end if;
 end if;
 end if;
 end process;
 process(clk)
 begin
 if clk'event and clk = '1' then
 if enb = '1' then
 dob <= RAM(conv_integer(addrb));
 end if;
 end if;
 end process;
end syn;
