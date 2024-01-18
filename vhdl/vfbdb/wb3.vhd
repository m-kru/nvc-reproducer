library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;

library ltypes;
   use ltypes.types.all;


package wb3 is

-- Packages constants
type main_pkg_t is record
   WIDTH : int64;
end record;
constant main_pkg : main_pkg_t := (
   WIDTH => signed'(x"0000000000000064")
);


end package;
