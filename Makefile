include $(RTEMS_MAKEFILE_PATH)/Makefile.inc
include $(RTEMS_CUSTOM)
include $(PROJECT_ROOT)/make/leaf.cfg

#### CONFIG ####################################################################

# COMPILER/LINKER
CFLAGS+=-g -O0
#ifeq ($(LWIP_DEBUG), 1)
    CFLAGS+=-DLWIP_DEBUG
#endif # LWIP_DEBUG
LDFLAGS+=-fwhole-program -Wl,--gc-sections -fno-exceptions 

# OUTPUT
LWIP_EXEC=lwip

SOURCES = main.c

#### HEADERS ###################################################################
HEADERS=-I$(RTEMS_MAKEFILE_PATH)/lwip/include
LD_LIBS   += $(LIBLWIPDRV) $(LIBLWIP)
LIBLWIP=$(RTEMS_MAKEFILE_PATH)/lwip/lib/liblwip.a
LIBLWIPDRV=$(RTEMS_MAKEFILE_PATH)/lwip/lib/liblwipdrv.a

################################################################################


BIN=${ARCH}/$(LWIP_EXEC).bin
EXEC=$(LWIP_EXEC).exe
PGM=${ARCH}/$(EXEC)

# optional managers required
MANAGERS=all

# C source names
CSRCS=$(notdir $(SOURCES))
COBJS=$(patsubst %.c,${ARCH}/%.o,$(CSRCS))

OBJS=$(COBJS)

all: ${ARCH} $(PGM) $(BIN)

$(PGM): $(LIBLWIPDRV) $(LIBLWIPDRV) $(OBJS)
	$(make-exe)

$(BIN): $(PGM)
	$(OBJCOPY) -O binary $^ $@

CPPFLAGS+=$(HEADERS)

cleanall: clean
	rm -f *.c
