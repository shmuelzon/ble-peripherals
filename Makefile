# Applications
EAGLE:=$(shell ls /mnt/c/Program\ Files/EAGLE*/eagle.exe)
OPENSCAD:=/mnt/c/Program Files/OpenSCAD/openscad.exe

# Find all source files
SCHEMATIC_FILES:=$(shell find . -type f -name '*.sch')
BOARD_FILES:=$(shell find . -type f -name '*.brd')
SCAD_FILES:=$(shell find . -type f -name '*.scad')

# Define targets
$(foreach f,$(SCHEMATIC_FILES), \
  $(eval tmp:=$(patsubst %.sch, %-schematic.png, $(f))) \
  $(eval $(tmp): $(f)) \
  $(eval SCHEMATIC_TARGETS+=$(tmp)) \
)

$(foreach f,$(BOARD_FILES), \
  $(eval tmp:=$(patsubst %.brd, %-layout.png, $(f))) \
  $(eval $(tmp): $(f)) \
  $(eval BOARD_TARGETS+=$(tmp)) \
)

$(foreach f,$(SCAD_FILES), \
  $(eval tmp:=$(patsubst %.scad, %.stl, $(f))) \
  $(eval $(tmp): $(f)) \
  $(eval SCAD_TARGETS+=$(tmp)) \
)

# Build rules
%-schematic.png:
	@echo "Generating $@"
	@rm -f $@
	@"$(EAGLE)" -C "EXPORT IMAGE $@ 300; QUIT" $<

%-layout.png:
	@echo "Generating $@"
	@rm -f $@
	@"$(EAGLE)" -C "RATSNEST; EXPORT IMAGE $@ 300; UNDO; QUIT" $<

%.stl:
	@echo "Generating $@"
	@"$(OPENSCAD)" -o $@ $<

all: $(SCHEMATIC_TARGETS) $(BOARD_TARGETS) $(SCAD_TARGETS)
clean:
	rm -f $(SCHEMATIC_TARGETS) $(BOARD_TARGETS) $(SCAD_TARGETS)

.DEFAULT_GOAL:=all
.PHONY:=all clean
