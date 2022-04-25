# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/me/Workspace/Hardware/Vitis/HelloWorld/design_1_wrapper_1/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/me/Workspace/Hardware/Vitis/HelloWorld/design_1_wrapper_1/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {design_1_wrapper_1}\
-hw {/home/me/Workspace/Hardware/Vitis/HelloWorld/design_1_wrapper.xsa}\
-arch {64-bit} -fsbl-target {psu_cortexa53_0} -out {/home/me/Workspace/Hardware/Vitis/HelloWorld}

platform write
domain create -name {standalone_psu_cortexa53_0} -display-name {standalone_psu_cortexa53_0} -os {standalone} -proc {psu_cortexa53_0} -runtime {cpp} -arch {64-bit} -support-app {hello_world}
platform generate -domains 
platform active {design_1_wrapper_1}
domain active {zynqmp_fsbl}
domain active {zynqmp_pmufw}
domain active {standalone_psu_cortexa53_0}
platform generate -quick
bsp reload
platform generate
platform generate -domains zynqmp_fsbl 
platform clean
platform clean
platform generate
platform clean
platform generate
platform generate -domains zynqmp_fsbl 
platform generate -domains zynqmp_fsbl 
