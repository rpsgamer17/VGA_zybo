library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vga_ctrl_tb is
end vga_ctrl_tb;

architecture tb of vga_ctrl_tb is

    -- Clock and enable signals
    signal clk    : std_logic := '0';
    signal en     : std_logic := '1';
    
    -- Output signals from vga_ctrl
    signal hcount : std_logic_vector(9 downto 0);
    signal vcount : std_logic_vector(9 downto 0);
    signal vid    : std_logic;
    signal hs     : std_logic;
    signal vs     : std_logic;

begin
    -- Instantiate the vga_ctrl unit
    uut: entity work.vga_ctrl
        port map (
            clk    => clk,
            en     => en,
            hcount => hcount,
            vcount => vcount,
            vid    => vid,
            hs     => hs,
            vs     => vs
        );

    -- Clock process: generating a clock with a 40 ns period (25 MHz)
    clk_process: process
    begin
        loop
            clk <= '0';
            wait for 20 ns;
            clk <= '1';
            wait for 20 ns;
        end loop;
    end process;

    -- Stop simulation after 5 ms
    end_sim: process
    begin
        wait for 5 ms;
        report "Simulation complete" severity failure;
    end process;

end tb;
