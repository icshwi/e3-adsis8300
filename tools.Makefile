
APPINC:=include
APPLIB:=lib
APPTOOL:=tools

SUBDIRS :=         \
	acquisition    \
	flash          \
	i2c_rtm        \
	irq            \
	memory         \
	mmap           \
	output         \
	performance    \
	register       \
	remove         \
	speed          \
	i2c_temp

FILES := $(foreach d, $(SUBDIRS),$(wildcard tools/$(d)/*))
BINS_SRCS := $(notdir $(filter %.c,$(FILES)))
BINS := $(BINS_SRCS:.c=)
BINS_OBJS :=$(BINS_SRCS:.c=.o)

VPATH = lib tools/acquisition tools/flash tools/i2c_rtm tools/i2c_temp tools/irq tools/memory tools/mmap tools/output tools/performance tools/register tools/remove tools/speed

CPPFLAGS += -I $(APPINC)
CPPFLAGS += -I $(APPLIB)

# -std=c99 
DRV_SOURCES = sis8300drv.c \
	sis8300drv_utils.c \
	sis8300drv_rtm.c \
	sis8300drv_flash.c \
	sis8300drv_ad9510.c 

DRV_OBJECTS := $(addsuffix .o,$(basename $(DRV_SOURCES)))

CFLAGS := -O3 -D_GNU_SOURCE -Wall
LDFLAGS := -Wall -lpthread -lrt -lm -ludev

build: $(BINS)
	@echo $(BINS_SRCS)

sis8300drv_acq: sis8300drv_acq.o $(DRV_OBJECTS)
	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@

sis8300drv_flashfw: sis8300drv_flashfw.o  $(DRV_OBJECTS)
	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@

sis8300drv_i2c_rtm: sis8300drv_i2c_rtm.o $(DRV_OBJECTS)
	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@

sis8300drv_i2c_temp: sis8300drv_i2c_temp.o $(DRV_OBJECTS)
	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@

sis8300drv_irq: sis8300drv_irq.o $(DRV_OBJECTS)
	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@

sis8300drv_mem: sis8300drv_mem.o $(DRV_OBJECTS)
	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@

sis8300drv_mmap: sis8300drv_mmap.o $(DRV_OBJECTS)
	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@

sis8300drv_out: sis8300drv_out.o $(DRV_OBJECTS)
	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@

sis8300drv_perf: sis8300drv_perf.o $(DRV_OBJECTS)
	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@

sis8300drv_reg: sis8300drv_reg.o $(DRV_OBJECTS)
	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@

sis8300drv_rem: sis8300drv_rem.o $(DRV_OBJECTS)
	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@

sis8300drv_speed: sis8300drv_speed.o $(DRV_OBJECTS)
	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@

.c.o:
	$(COMPILE.c) $(OUTPUT_OPTION) $<

.PHONY: clean build
clean:
	@$(RM) $(BINS) $(DRV_OBJECTS) $(BINS_OBJS)


