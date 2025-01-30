#------------------------------------------------------------
# Sliding Window Walkthrough - Synthesizable
#------------------------------------------------------------

set PROJECT_BASE_DIR ".."

# Reset the options to the factory defaults
options defaults
options set /Input/CppStandard c++11

project new

flow package require /SCVerify
flow package option set /SCVerify/USE_CCS_BLOCK true
flow package option set /SCVerify/INVOKE_ARGS "$COMMON_DIR/data/image/people_gray.bmp $PROJECT_BASE_DIR/sim/out_algorithm.bmp $PROJECT_BASE_DIR/sim/out_hw.bmp"

options set Input/SearchPath "$COMMON_DIR/inc $PROJECT_BASE_DIR/../01_EdgeDetect_Algorithm/src $PROJECT_BASE_DIR/src"

solution file add "$PROJECT_BASE_DIR/src/EdgeDetect_Synthesizable.h" -type C++
solution file add "$PROJECT_BASE_DIR/../01_EdgeDetect_Algorithm/src/EdgeDetect_Algorithm.h" -type C++ -exclude true
solution file add "$PROJECT_BASE_DIR/tb/EdgeDetect_Synthesizable_tb.cpp" -type C++ -exclude true
solution file add {$MGC_HOME/shared/include/bmpUtil/bmp_io.cpp} -type C++ -exclude true

go analyze
directive set -DESIGN_HIERARCHY EdgeDetect_Synthesizable
go compile

directive set /EdgeDetect_Synthesizable/run -DESIGN_GOAL Latency

solution library add nangate-45nm_beh -file {$MGC_HOME/pkgs/siflibs/nangate/nangate-45nm_beh.lib} -- -rtlsyntool OasysRTL
solution library add ccs_sample_mem -file {$MGC_HOME/pkgs/siflibs/ccs_sample_mem.lib}

go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly

directive set /EdgeDetect_Synthesizable/run/VROW -MERGEABLE false
directive set /EdgeDetect_Synthesizable/run/VCOL -MERGEABLE false
directive set /EdgeDetect_Synthesizable/run/HROW -MERGEABLE false
directive set /EdgeDetect_Synthesizable/run/HCOL -MERGEABLE false
directive set /EdgeDetect_Synthesizable/run/MROW -MERGEABLE false
directive set /EdgeDetect_Synthesizable/run/MCOL -MERGEABLE false
directive set /EdgeDetect_Synthesizable/run/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for -MERGEABLE false
go architect
go extract

