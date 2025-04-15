library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity image_top is
    port (
        clk     : in  std_logic;                                -- 125 MHz clock input
        vga_r   : out std_logic_vector(4 downto 0);             -- Red channel (5 bits)
        vga_g   : out std_logic_vector(5 downto 0);             -- Green channel (6 bits)
        vga_b   : out std_logic_vector(4 downto 0);             -- Blue channel (5 bits)
        vga_hs  : out std_logic;                                -- Horizontal sync
        vga_vs  : out std_logic                                 -- Vertical sync
    );
end image_top;

architecture Behavioral of image_top is

   
    signal div_sig : std_logic;
    signal hcount_sig : std_logic_vector(9 downto 0);
    signal vcount_sig : std_logic_vector(9 downto 0);
    signal vid_sig : std_logic;
    signal hs_sig : std_logic;
    signal vs_sig : std_logic;
    signal pixel_sig : std_logic_vector(7 downto 0);
    signal addr_sig : std_logic_vector(17 downto 0);


    component clock_div is
        port (
            clk : in std_logic;
            div : out std_logic
        );
    end component;

    component vga_ctrl is
        port (
            clk : in std_logic;
            en : in std_logic;
            hcount : out std_logic_vector(9 downto 0);
            vcount : out std_logic_vector(9 downto 0);
            vid : out std_logic;
            hs : out std_logic;
            vs : out std_logic
        );
    end component;

    component pixel_pusher is
        port (
            clk : in std_logic;
            en : in std_logic;
            vs : in std_logic;
            pixel : in std_logic_vector(7 downto 0);
            hcount : in std_logic_vector(9 downto 0);
            vid : in std_logic;
            r : out std_logic_vector(4 downto 0);
            g : out std_logic_vector(5 downto 0);
            b : out std_logic_vector(4 downto 0);
            addr_out : out std_logic_vector(17 downto 0)
        );
    end component;

    component picture 
        port (
            clka : in std_logic;
            addra : in std_logic_vector(17 downto 0);
            douta : out std_logic_vector(7 downto 0)
        );
    end component;

begin


    u1: clock_div
        port map (
            clk => clk,
            div => div_sig
        );

   
    u2: vga_ctrl
        port map (
            clk => clk,
            en =>  div_sig,
            hcount => hcount_sig,
            vcount => vcount_sig,
            vid => vid_sig,
            hs => hs_sig,
            vs => vs_sig
        );

   
    u3: picture
        port map (
            clka => clk,
            addra => addr_sig,
            douta => pixel_sig
        );

    
    u4: pixel_pusher
        port map (
            clk => clk,
            en => div_sig,
            vs => vs_sig,
            pixel => pixel_sig,
            hcount => hcount_sig,
            vid => vid_sig,
            r => vga_r,
            g => vga_g,
            b => vga_b,
            addr_out => addr_sig
        );

    
    vga_hs <= hs_sig;
    vga_vs <= vs_sig;

end Behavioral;
