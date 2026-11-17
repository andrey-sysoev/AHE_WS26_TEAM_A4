
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    port (
        CLK100MHZ   : in  STD_LOGIC;
        CPU_RESETN  : in  STD_LOGIC;
        UART_TXD_IN : in  STD_LOGIC;
        UART_RXD_OUT: out STD_LOGIC;
        LED         : out STD_LOGIC_VECTOR(15 downto 0)
    );
end entity top;

architecture rtl of top is

    signal rm_clk : STD_LOGIC;
    signal din    : STD_LOGIC_VECTOR(15 downto 0);
    signal dout   : STD_LOGIC_VECTOR(15 downto 0);

component rm_a is
    port (
        clk  : in  STD_LOGIC;
        din  : in  STD_LOGIC_VECTOR(15 downto 0);
        dout : out STD_LOGIC_VECTOR(15 downto 0)
    );
end component;

begin

    u_sys : entity work.design_1_wrapper
        port map (
            clk_in        => CLK100MHZ,
            resetn        => CPU_RESETN,
            uart_rxd      => UART_TXD_IN,
            uart_txd      => UART_RXD_OUT,
            rm_clk        => rm_clk,
            rm_din_tri_o  => din,
            rm_dout_tri_i => dout
        );

    u_rm : rm_a
        port map (
            clk  => rm_clk,
            din  => din,
            dout => dout
        );

    LED <= dout;

end architecture rtl;
