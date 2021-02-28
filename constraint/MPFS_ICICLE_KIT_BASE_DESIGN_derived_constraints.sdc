# Microsemi Corp.
# Date: 2021-Feb-28 12:49:23
# This file was generated based on the following SDC source files:
#   /home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/AXI4INTERCONNECT/AXI4INTERCONNECT_0/AXI4INTERCONNECT.sdc
#   /home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/ICICLE_MSS/ICICLE_MSS.sdc
#   /home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PCIE_AXI_0/PCIE_AXI_0_0/PCIE_AXI_0.sdc
#   /home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PCIE_AXI_1/PCIE_AXI_1_0/PCIE_AXI_1.sdc
#   /home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PF_CLK_DIV_C0/PF_CLK_DIV_C0_0/PF_CLK_DIV_C0_PF_CLK_DIV_C0_0_PF_CLK_DIV.sdc
#   /home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PF_PCIE_C0/PF_PCIE_C0_0/PF_PCIE_C0_PF_PCIE_C0_0_PF_PCIE.sdc
#   /home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PF_TX_PLL_C0/PF_TX_PLL_C0_0/PF_TX_PLL_C0_PF_TX_PLL_C0_0_PF_TX_PLL.sdc
#   /home/gui/.local/microsemi/Libero_SoC_v12.6/Libero/data/aPA5M/cores/constraints/osc_rc160mhz.sdc
#

create_clock -name {REF_CLK_PAD_P} -period 10 [ get_ports { REF_CLK_PAD_P } ]
create_clock -name {PCIE_BASE_0/PF_TX_PLL_C0_0/PF_TX_PLL_C0_0/txpll_isnt_0/DIV_CLK} -period 8 [ get_pins { PCIE_BASE_0/PF_TX_PLL_C0_0/PF_TX_PLL_C0_0/txpll_isnt_0/DIV_CLK } ]
create_clock -name {PCIE_BASE_0/PF_OSC_C0_0/PF_OSC_C0_0/I_OSC_160/CLK} -period 6.25 [ get_pins { PCIE_BASE_0/PF_OSC_C0_0/PF_OSC_C0_0/I_OSC_160/CLK } ]
create_generated_clock -name {PCIE_BASE_0/PF_CLK_DIV_C0_0/PF_CLK_DIV_C0_0/I_CD/Y_DIV} -divide_by 2 -source [ get_pins { PCIE_BASE_0/PF_CLK_DIV_C0_0/PF_CLK_DIV_C0_0/I_CD/A } ] [ get_pins { PCIE_BASE_0/PF_CLK_DIV_C0_0/PF_CLK_DIV_C0_0/I_CD/Y_DIV } ]
create_generated_clock -name {PCIE_BASE_0/PF_CLK_DIV_C0_1/PF_CLK_DIV_C0_0/I_CD/Y_DIV} -divide_by 2 -source [ get_pins { PCIE_BASE_0/PF_CLK_DIV_C0_1/PF_CLK_DIV_C0_0/I_CD/A } ] [ get_pins { PCIE_BASE_0/PF_CLK_DIV_C0_1/PF_CLK_DIV_C0_0/I_CD/Y_DIV } ]
set_false_path -through [ get_nets { COREAXI4INTERCONNECT_0/ARESETN* } ]
set_false_path -through [ get_nets { PCIE_AXI_0_0/ARESETN* } ]
set_false_path -through [ get_nets { PCIE_AXI_1_0/ARESETN* } ]
set_false_path -to [ get_pins { PCIE_BASE_0/PF_PCIE_C0_0/PF_PCIE_C0_0/PCIE_1/INTERRUPT[0] PCIE_BASE_0/PF_PCIE_C0_0/PF_PCIE_C0_0/PCIE_1/INTERRUPT[1] PCIE_BASE_0/PF_PCIE_C0_0/PF_PCIE_C0_0/PCIE_1/INTERRUPT[2] PCIE_BASE_0/PF_PCIE_C0_0/PF_PCIE_C0_0/PCIE_1/INTERRUPT[3] PCIE_BASE_0/PF_PCIE_C0_0/PF_PCIE_C0_0/PCIE_1/INTERRUPT[4] PCIE_BASE_0/PF_PCIE_C0_0/PF_PCIE_C0_0/PCIE_1/INTERRUPT[5] PCIE_BASE_0/PF_PCIE_C0_0/PF_PCIE_C0_0/PCIE_1/INTERRUPT[6] PCIE_BASE_0/PF_PCIE_C0_0/PF_PCIE_C0_0/PCIE_1/INTERRUPT[7] PCIE_BASE_0/PF_PCIE_C0_0/PF_PCIE_C0_0/PCIE_1/WAKEREQ PCIE_BASE_0/PF_PCIE_C0_0/PF_PCIE_C0_0/PCIE_1/MPERST_N } ]
set_false_path -from [ get_pins { PCIE_BASE_0/PF_PCIE_C0_0/PF_PCIE_C0_0/PCIE_1/TL_CLK } ]
