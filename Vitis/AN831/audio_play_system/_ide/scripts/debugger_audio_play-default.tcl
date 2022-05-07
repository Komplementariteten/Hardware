# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: /home/me/Workspace/Hardware/Vitis/AN831/audio_play_system/_ide/scripts/debugger_audio_play-default.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source /home/me/Workspace/Hardware/Vitis/AN831/audio_play_system/_ide/scripts/debugger_audio_play-default.tcl
# 
connect -url tcp:127.0.0.1:3121
source /tools/Xilinx/Vitis/2021.2/scripts/vitis/util/zynqmp_utils.tcl
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent JTAG-HS1 210512180081" && level==0 && jtag_device_ctx=="jsn-JTAG-HS1-210512180081-14711093-0"}
fpga -file /home/me/Workspace/Hardware/Vitis/AN831/audio_play/_ide/bitstream/audio_wrapper.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw /home/me/Workspace/Hardware/Vitis/AN831/audio_wrapper/export/audio_wrapper/hw/audio_wrapper.xsa -mem-ranges [list {0x80000000 0xbfffffff} {0x400000000 0x5ffffffff} {0x1000000000 0x7fffffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
set mode [expr [mrd -value 0xFF5E0200] & 0xf]
targets -set -nocase -filter {name =~ "*A53*#0"}
rst -processor
dow /home/me/Workspace/Hardware/Vitis/AN831/audio_wrapper/export/audio_wrapper/sw/audio_wrapper/boot/fsbl.elf
set bp_3_1_fsbl_bp [bpadd -addr &XFsbl_Exit]
con -block -timeout 60
bpremove $bp_3_1_fsbl_bp
targets -set -nocase -filter {name =~ "*A53*#0"}
rst -processor
dow /home/me/Workspace/Hardware/Vitis/AN831/audio_play/Debug/audio_play.elf
configparams force-mem-access 0
bpadd -addr &main
