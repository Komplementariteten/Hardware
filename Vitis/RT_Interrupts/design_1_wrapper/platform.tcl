# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/me/Workspace/Hardware/Vitis/RT_Interrupts/design_1_wrapper/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/me/Workspace/Hardware/Vitis/RT_Interrupts/design_1_wrapper/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {design_1_wrapper}\
-hw {/home/me/Workspace/Hardware/Verilog/AXU2CGA_Board/design_1_wrapper.xsa}\
-proc {psu_cortexa53_0} -os {standalone} -arch {64-bit} -fsbl-target {psu_cortexa53_0} -out {/home/me/Workspace/Hardware/Vitis/RT_Interrupts}

platform write
platform generate -domains 
platform active {design_1_wrapper}
bsp reload
platform generate
