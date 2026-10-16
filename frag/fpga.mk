## DO NOT MODIFY ANYTHING IN THIS FILE WITHOUT PERMISSION FROM THE INSTRUCTOR OR TAs

# Path to the repository root
REPO_ROOT ?= $(shell git rev-parse --show-toplevel)

# If you have the tools installed in a non-standard path,
# you can override these to specify the path to the executable.
NEXTPNR ?= nextpnr-ice40
ICEPROG ?= iceprog
OPENLOAD ?= openfpgaloader
ICEPACK ?= icepack
ICETIME ?= icetime

# This is the default location for the icebreaker Pin Constraints File
# (PCF) Each part may use a different pcf file, so check in the partX
# directory first! Derived from
# https://github.com/icebreaker-fpga/icebreaker-verilog-examples/blob/main/icebreaker/icebreaker.pcf
# Historically PCF_PATH was the path to the PCF file, however with the incoming switch to achitry I've made it hidden.
ICEBRK_PCF_PATH ?= $(PCF_PATH)
ALCUV2_PCF_PATH ?= $(REPO_ROOT)/provided/alcuv2.pcf

# Placement & Route. Depends on synth.mk
icebrk.asc: ice40.json $(ICEBRK_PCF_PATH)
	$(NEXTPNR) -ql icebrk.nplog --up5k --package sg48 --freq 12 --asc $@ --pcf $(ICEBRK_PCF_PATH) --json $< --top top

alcuv2.asc: ice40.json $(ALCUV2_PCF_PATH)
	$(NEXTPNR) -ql alcuv2.nplog --hx8k --package cb132 --freq 100  --asc $@ --pcf $(ALCUV2_PCF_PATH) --json $< --top top

# Programming board
prog-alcuv2: alcuv2.bin
	$(OPENLOAD) --verify -b ice40_generic $<

prog-icebrk: icebrk.bin
	$(OPENLOAD) --verify -b ice40_generic $<

# Bitstream generation.
icebrk.bin: icebrk.asc
	$(ICEPACK) $< $@

alcuv2.bin: alcuv2.asc
	$(ICEPACK) $< $@

# Timing analysis
icebrk.rpt: icebrk.asc
	$(ICETIME) -d up5k -c 12 -mtr $@ $<

alcuv2.rpt: alcuv2.asc
	$(ICETIME) -d hx8k -c 100 -mtr $@ $<

fpga-clean:
	rm -rf icebrk.bin
	rm -rf icebrk.rpt
	rm -rf icebrk.asc
	rm -rf icebrk.nplog

	rm -rf alcuv2.bin
	rm -rf alcuv2.rpt
	rm -rf alcuv2.asc
	rm -rf alcuv2.nplog

fpga-help:
	@echo "  alcuv2.bin: Build the FPGA program (bitstream)"
	@echo "  prog-alcuv2: Program the Alchitry FPGA board"
	@echo "  icebrk.bin: Build the FPGA program (bitstream)"
	@echo "  prog-icebrk: Program the Icebreaker FPGA board"

fpga-vars-help:
	@echo "    NEXTPNR: Override this variable to set the location of your nextpnr executable."
	@echo "    ICEPROG: Override this variable to set the location of your Icebreaker Programmer executable."
	@echo "    ICEPACK: Override this variable to set the location of your icepack executable."
	@echo "    ICETIME: Override this variable to set the location of your icetime executable."

clean: fpga-clean
targets-help: fpga-help
vars-help: fpga-vars-help

.PHONY: prog fpga-clean cpga-help fpga-vars-help clean targets-help vars-help
