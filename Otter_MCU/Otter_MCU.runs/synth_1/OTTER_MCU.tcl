# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param synth.incrementalSynthesisCache C:/Users/alexp/AppData/Roaming/Xilinx/Vivado/.Xil/Vivado-19988-DESKTOP-27NSPQU/incrSyn
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/alexp/Desktop/CPE_233/Projects/Otter_MCU/Otter_MCU.cache/wt [current_project]
set_property parent.project_path C:/Users/alexp/Desktop/CPE_233/Projects/Otter_MCU/Otter_MCU.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo c:/Users/alexp/Desktop/CPE_233/Projects/Otter_MCU/Otter_MCU.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_mem C:/Users/alexp/Desktop/CPE_233/Projects/Otter_MCU/Otter_MCU.srcs/sources_1/new/otter_memory.mem
read_verilog -library xil_defaultlib -sv {
  C:/Users/alexp/Desktop/CPE_233/Projects/Otter_MCU/Otter_MCU.srcs/sources_1/new/ALU.sv
  C:/Users/alexp/Desktop/CPE_233/Projects/Otter_MCU/Otter_MCU.srcs/sources_1/new/BranchCondGen.sv
  C:/Users/alexp/Desktop/CPE_233/Projects/Otter_MCU/Otter_MCU.srcs/sources_1/new/CUDecoder.sv
  C:/Users/alexp/Desktop/CPE_233/Projects/Otter_MCU/Otter_MCU.srcs/sources_1/new/CU_FSM.sv
  C:/Users/alexp/Desktop/CPE_233/Projects/Otter_MCU/Otter_MCU.srcs/sources_1/imports/Lab/MUX_21/MUX_21.srcs/sources_1/new/MUX_21.sv
  C:/Users/alexp/Desktop/CPE_233/Projects/Otter_MCU/Otter_MCU.srcs/sources_1/imports/Lab/233_Mux4-1/233_Mux4-1.srcs/sources_1/new/Mux4-1.sv
  C:/Users/alexp/Desktop/CPE_233/Projects/Otter_MCU/Otter_MCU.srcs/sources_1/new/PC.sv
  C:/Users/alexp/Desktop/CPE_233/Projects/Otter_MCU/Otter_MCU.srcs/sources_1/new/RegFile.sv
  C:/Users/alexp/Desktop/CPE_233/Projects/Otter_MCU/Otter_MCU.srcs/sources_1/imports/CPE_233/otter_memory.sv
  C:/Users/alexp/Desktop/CPE_233/Projects/Otter_MCU/Otter_MCU.srcs/sources_1/new/OTTER_MCU.sv
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}

synth_design -top OTTER_MCU -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef OTTER_MCU.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file OTTER_MCU_utilization_synth.rpt -pb OTTER_MCU_utilization_synth.pb"
