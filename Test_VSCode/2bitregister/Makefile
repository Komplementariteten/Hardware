# vhdl files
SRC_FILES = src/*.vhd
TB_FILES = tb/*.vhd
TESTBENCH = test_bench
WORK_DIR = work

# testbench
#GHDL CONFIG
GHDL_CMD = /opt/homebrew/bin/ghdl
GHDL_FLAGS  = --workdir=$(WORK_DIR) --ieee=synopsys --warn-no-vital-generic

WAVEFORM_VIEWER = /Applications/gtkwave.app/Contents/Resources/bin/gtkwave

.PHONY: clean

compile:
	mkdir $(WORK_DIR)
	@$(GHDL_CMD) -a -g $(GHDL_FLAGS) $(SRC_FILES) $(TB_FILES)
	@$(GHDL_CMD) -e $(GHDL_FLAGS) $(TESTBENCH)

test:
	@$(GHDL_CMD) -r $(GHDL_FLAGS) $(TESTBENCH) --vcd=$(TESTBENCH).vcd --asserts=disable --stop-time=250ns
	@$(WAVEFORM_VIEWER) $(TESTBENCH).vcd

run:
	@$(GHDL_CMD) -r $(GHDL_FLAGS) $(TESTBENCH)

sim: compile test

build: compile run

all: clean sim

clean:
	rm -f *.vcd
	rm -f *.cf
	rm -rf $(WORK_DIR)