puts "INFO: Catapult HLS project: $HLS_PROJECT"

set PROJECT_BASE_DIR ..

options set Flows/SCVerify/INCL_DIRS "$PROJECT_BASE_DIR/src $PROJECT_BASE_DIR/tb"
options set Flows/SCVerify/LINK_LIBNAMES ""
options set Flows/OSCI/COMP_FLAGS "-Wall -Wno-unknown-pragmas -Wno-unused-label"

flow package option set /SCVerify/INVOKE_ARGS ""

solution file add $PROJECT_BASE_DIR/src/simple.h
solution file add $PROJECT_BASE_DIR/tb/tb.cpp -exclude true

go analyze
go compile

flow run /SCVerify/launch_make ./scverify/Verify_orig_cxx_osci.mk {} SIMTOOL=osci sim

solution library add nangate-45nm_beh -- -rtlsyntool OasysRTL -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
solution library add ccs_sample_rom

go libraries

# target 1ns, 1GHz clock period
directive set -CLOCKS { \
    clk { \
        -CLOCK_PERIOD 1 \
            -CLOCK_EDGE rising \
            -CLOCK_HIGH_TIME 0.5 \
            -CLOCK_OFFSET 0.000000 \
            -CLOCK_UNCERTAINTY 0.0 \
            -RESET_KIND sync \
            -RESET_SYNC_NAME rst \
            -RESET_SYNC_ACTIVE high \
            -RESET_ASYNC_NAME arst_n \
            -RESET_ASYNC_ACTIVE low \
            -ENABLE_NAME {} \
            -ENABLE_ACTIVE high \
        }
    }
    go assembly

###
# See the video tutorial to apply the proper directives
###

go architect
go allocate
go extract
go assembly

go extract
