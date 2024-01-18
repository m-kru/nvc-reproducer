#!/bin/bash

# Analysis
nvc  --std=2019 -L. --work=ltypes -a vhdl/ltypes/types.vhd
nvc  --std=2019 -L. --work=general_cores -a vhdl/general_cores/gencores_pkg.vhd
nvc  --std=2019 -L. --work=general_cores -a vhdl/general_cores/genram_pkg.vhd
nvc  --std=2019 -L. --work=general_cores -a vhdl/general_cores/wishbone_pkg.vhd
nvc  --std=2019 -L. --work=general_cores -a vhdl/general_cores/xwb_crossbar.vhd
nvc  --std=2019 -L. --work=vfbdb -a vhdl/vfbdb/wb3.vhd
nvc  --std=2019 -L. --work=vfbdb -a vhdl/vfbdb/Main.vhd
nvc  --std=2019 -L. --work=work -a vhdl/work/cosim.vhd
nvc  --std=2019 -L. --work=work -a vhdl/work/cosim_context.vhd
nvc  --std=2019 -L. --work=work -a vhdl/work/tb.vhd

# Elaboration
nvc  --std=2019 -L. -e tb_cosim  -g G_SW_GW_FIFO_PATH=/tmp/python-to-vhdl-wb3 -g G_GW_SW_FIFO_PATH=/tmp/vhdl-wb3-to-python
