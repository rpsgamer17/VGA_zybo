library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pixel_pusher is
    Port (
        clk     : in  std_logic;
        en      : in  std_logic;
        vs      : in  std_logic;
        pixel   : in  std_logic_vector(7 downto 0);
        hcount  : in  std_logic_vector(9 downto 0);
        vid     : in  std_logic;
        r       : out std_logic_vector(4 downto 0);
        g       : out std_logic_vector(5 downto 0);
        b       : out std_logic_vector(4 downto 0);
        addr_out    : out std_logic_vector(17 downto 0) -- 18 bit
    );
end pixel_pusher;

architecture Behavioral of pixel_pusher is
    signal addr  : std_logic_vector(17 downto 0) := (others => '0');
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if en = '1' then
                if vs = '0' then
                    addr  <= (others => '0');
                elsif vid = '1' and unsigned(hcount) < 480 then
                    addr  <= std_logic_vector(unsigned(addr)  + 1);
                end if;
            end if;
        end if;
    end process;

    process(clk)
    begin
        if rising_edge(clk) then
            if en = '1' and vid = '1' and unsigned(hcount) < 480 then
                r <= pixel(7 downto 5) & "00";
                g <= pixel(4 downto 2) & "000";
                b <= pixel(1 downto 0) & "000";
            else
                r <= (others => '0');
                g <= (others => '0');
                b <= (others => '0');
            end if;
        end if;
    end process;
    
    addr_out <= std_logic_vector(addr);


end Behavioral;

   