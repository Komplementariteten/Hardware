# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: /home/me/Workspace/Hardware/Vitis/RT_Interrupts/xrtcpsu_periodic_alarm_interrupt_example_1_system/_ide/scripts/debugger_xrtcpsu_periodic_alarm_interrupt_example_1-default.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source /home/me/Workspace/Hardware/Vitis/RT_Interrupts/xrtcpsu_periodic_alarm_interrupt_example_1_system/_ide/scripts/debugger_xrtcpsu_periodic_alarm_interrupt_example_1-default.tcl
# 
connect -url tcp:127.0.0.1:3121
source /tools/Xilinx/Vitis/2021.2/scripts/vitis/util/zynqmp_utils.tcl
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw /home/me/Workspace/Hardware/Vitis/RT_Interrupts/design_1_wrapper/export/design_1_wrapper/hw/design_1_wrapper.xsa -mem-ranges [list {0x80000000 0xbfffffff} {0x400000000 0x5ffffffff} {0x1000000000 0x7fffffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
set mode [expr [mrd -value 0xFF5E0200] & 0xf]
targets -set -nocase -filter {name =~ "*A53*#0"}
rst -processor
dow /home/me/Workspace/Hardware/Vitis/RT_Interrupts/design_1_wrapper/export/design_1_wrapper/sw/design_1_wrapper/boot/fsbl.elf
set bp_13_58_fsbl_bp [bpadd -addr &XFsbl_Exit]
con -block -timeout 60
bpremove $bp_13_58_fsbl_bp
targets -set -nocase -filter {name =~ "*A53*#0"}
rst -processor
dow /home/me/Workspace/Hardware/Vitis/RT_Interrupts/xrtcpsu_periodic_alarm_interrupt_example_1/Debug/xrtcpsu_periodic_alarm_interrupt_example_1.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A53*#0"}
con
