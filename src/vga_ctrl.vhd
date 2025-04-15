
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_ctrl is
Port (
    clk, en : in std_logic;
    hcount, vcount: out std_logic_vector(9 downto 0);
    vid, hs, vs: out std_logic
 );
 
end vga_ctrl;

architecture Behavioral of vga_ctrl is
    signal h_counter, v_counter : std_logic_vector(9 downto 0) := (others => '0');

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if en = '1' then
                if unsigned(h_counter) = 799 then
                    h_counter <= (others => '0');
                    if unsigned(v_counter) = 524 then
                        v_counter <= (others => '0');
                    else
                        v_counter <= std_logic_vector(unsigned(v_counter) + 1);
                    end if;
                else
                   h_counter <= std_logic_vector(unsigned(h_counter) + 1);
                end if;
            end if;

            if (unsigned(h_counter) < 640 and unsigned(v_counter) < 480) then
                vid <= '1';
            else
                vid <= '0';
            end if;

            
            if (unsigned(h_counter) >= 656 and unsigned(h_counter) <= 751) then
                hs <= '0';
            else
                hs <= '1';
            end if;

      
            if (unsigned(v_counter) >= 490 and unsigned(v_counter) <= 491) then
                vs <= '0';
            else
                vs <= '1';
            end if;

        end if;
    end process;

    hcount <= h_counter;
    vcount <= v_counter;

end Behavioral;