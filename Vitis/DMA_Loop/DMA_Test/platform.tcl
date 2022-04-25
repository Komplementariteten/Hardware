# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/me/Workspace/Hardware/Vitis/DMA_Loop/DMA_Test/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/me/Workspace/Hardware/Vitis/DMA_Loop/DMA_Test/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {DMA_Test}\
-hw {/home/me/Workspace/Hardware/Verilog/DMA_Loop/design_1_wrapper.xsa}\
-proc {psu_cortexa53_0} -os {standalone} -arch {64-bit} -fsbl-target {psu_cortexa53_0} -out {/home/me/Workspace/Hardware/Vitis/DMA_Loop}

platform write
platform generate -domains 
platform active {DMA_Test}
bsp reload
platform generate
