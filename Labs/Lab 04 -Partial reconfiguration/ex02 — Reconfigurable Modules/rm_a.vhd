library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rm_a is
    port (
        clk  : in  STD_LOGIC;
        din  : in  STD_LOGIC_VECTOR(15 downto 0);
        dout : out STD_LOGIC_VECTOR(15 downto 0)
    );
end entity rm_a;

architecture rtl of rm_a is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            dout <= din;
        end if;
    end process;
end architecture rtl;
