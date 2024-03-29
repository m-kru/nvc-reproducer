-- This file has been automatically generated by the vfbdb tool.
-- Do not edit it manually, unless you really know what you do.
-- https://github.com/Functional-Bus-Description-Language/go-vfbdb

library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;

library ltypes;
   use ltypes.types.all;

library work;
   use work.wb3.all;


package Main_pkg is

-- Constants

-- Proc types

-- Stream types

end package;


library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;

library general_cores;
   use general_cores.wishbone_pkg.all;

library ltypes;
   use ltypes.types.all;

library work;
   use work.wb3.all;
   use work.Main_pkg.all;


entity Main is
generic (
   G_REGISTERED : boolean := true
);
port (
   clk_i : in std_logic;
   rst_i : in std_logic;
   slave_i : in  t_wishbone_slave_in_array (1 - 1 downto 0);
   slave_o : out t_wishbone_slave_out_array(1 - 1 downto 0);
   ID_o : out std_logic_vector(31 downto 0) := x"39310398";
   Cfg_o : buffer std_logic_vector(99 downto 0) := x"0000000000000000000000000"
);
end entity;


architecture rtl of Main is

constant C_ADDRESSES : t_wishbone_address_array(0 downto 0) := (0 => "00000000000000000000000000000000");
constant C_MASKS     : t_wishbone_address_array(0 downto 0) := (0 => "00000000000000000000000000000000");

signal master_out : t_wishbone_master_out;
signal master_in  : t_wishbone_master_in;

signal Cfg_atomic : std_logic_vector(95 downto 0);

begin

crossbar: entity general_cores.xwb_crossbar
generic map (
   G_NUM_MASTERS => 1,
   G_NUM_SLAVES  => 0 + 1,
   G_REGISTERED  => G_REGISTERED,
   G_ADDRESS     => C_ADDRESSES,
   G_MASK        => C_MASKS
)
port map (
   clk_sys_i   => clk_i,
   rst_n_i     => not rst_i,
   slave_i     => slave_i,
   slave_o     => slave_o,
   master_i(0) => master_in,
   master_o(0) => master_out
);


register_access : process (clk_i) is

variable addr : natural range 0 to 5 - 1;

begin

if rising_edge(clk_i) then

-- Normal operation.
master_in.rty <= '0';
master_in.ack <= '0';
master_in.err <= '0';

-- Procs Calls Clear
-- Procs Exits Clear
-- Stream Strobes Clear

transfer : if
   master_out.cyc = '1'
   and master_out.stb = '1'
   and master_in.err = '0'
   and master_in.rty = '0'
   and master_in.ack = '0'
then
   addr := to_integer(unsigned(master_out.adr(3 - 1 downto 0)));

   -- First assume there is some kind of error.
   -- For example internal address is invalid or there is a try to write status.
   master_in.err <= '1';
   -- '0' for security reasons, '-' can lead to the information leak.
   master_in.dat <= (others => '0');
   master_in.ack <= '0';

   -- Registers Access
   if 0 <= addr and addr <= 0 then
      master_in.dat(31 downto 0) <= x"39310398"; -- ID


      master_in.ack <= '1';
      master_in.err <= '0';
   end if;

   if 1 <= addr and addr <= 3 then

      if master_out.we = '1' then
         Cfg_atomic(32 * (addr - 1 + 1) - 1 downto 32 * (addr - 1)) <= master_out.dat(31 downto 0);
      end if;
      master_in.dat(31 downto 0) <= Cfg_o(32 * (addr - 1 + 1) - 1 downto 32 * (addr - 1));


      master_in.ack <= '1';
      master_in.err <= '0';
   end if;

   if 4 <= addr and addr <= 4 then

      if master_out.we = '1' then
         Cfg_o(99 downto 96) <= master_out.dat(3 downto 0);
         Cfg_o(95 downto 0) <= Cfg_atomic(95 downto 0);
      end if;
      master_in.dat(3 downto 0) <= Cfg_o(99 downto 96);

      master_in.ack <= '1';
      master_in.err <= '0';
   end if;


   -- Proc Calls Set
   -- Proc Exits Set
   -- Stream Strobes Set

end if transfer;

if rst_i = '1' then
   master_in <= C_DUMMY_WB_MASTER_IN;
end if;
end if;
end process register_access;


-- Combinational processes


end architecture;
