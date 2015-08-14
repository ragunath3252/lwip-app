include $(RTEMS_MAKEFILE_PATH)/Makefile.inc
include $(RTEMS_CUSTOM)
include $(PROJECT_ROOT)/make/leaf.cfg

#### CONFIG ####################################################################

# COMPILER/LINKER
CFLAGS+=-g -O0
#-Werror -Wpedantic -Wall -Wextra -Wdouble-promotion -Winit-self \
#    -Wmissing-include-dirs -Wswitch-default -Wunused \
#    -Wmissing-format-attribute -Wtrampolines -Wfloat-equal \
#    -Wdeclaration-after-statement -Wshadow -Wunsafe-loop-optimizations \
#    -Wpointer-arith -Wbad-function-cast -Wcast-align -Wwrite-strings \
#    -Wclobbered -Wjump-misses-init -Wlogical-op -Waggregate-return \
 #   -Wredundant-decls -Wnested-externs -Winvalid-pch -Wlong-long \
  #  -Wvariadic-macros -Wvarargs -Woverlength-strings -Wunsuffixed-float-constants \
   # -Wno-address -DIPv4 -DTARGET_LPC1768
#ifeq ($(LWIP_DEBUG), 1)
    CFLAGS+=-DLWIP_DEBUG
#endif # LWIP_DEBUG
LDFLAGS+=-fwhole-program -Wl,--gc-sections -fno-exceptions

# OUTPUT
LWIP_EXEC=lwip


#### PATHS #####################################################################

# LWIP
LWIP_PATH=..
LWIP_SRC_PATH=$(LWIP_PATH)/src
LWIP_API_PATH=$(LWIP_SRC_PATH)/api
LWIP_CORE_PATH=$(LWIP_SRC_PATH)/core
LWIP_INCL_PATH=$(LWIP_SRC_PATH)/include
LWIP_NETIF_PATH=$(LWIP_SRC_PATH)/netif

# ARCH
LWIPARCH_PATH=ports
LWIPARCH_SRC_PATH=$(LWIPARCH_PATH)
LWIPARCH_INCL_PATH=$(LWIPARCH_PATH)/include

# DRIVER
LWIPDRIVER_PATH=ports
LWIPDRIVER_SRC_PATH=$(LWIPDRIVER_PATH)/netif
LWIPDRIVER_INCL_PATH=$(LWIPDRIVER_PATH)/include/netif

# APP
LWIPAPP_PATH=../lwip_app_posix
LWIPAPP_SRC_PATH=$(LWIPAPP_PATH)/src
LWIPAPP_INCL_PATH=$(LWIPAPP_PATH)/include


#### SOURCES ###################################################################

## CORE
CORE_SRC=$(LWIP_CORE_PATH)/dhcp.c $(LWIP_CORE_PATH)/dns.c \
    $(LWIP_CORE_PATH)/inet_chksum.c $(LWIP_CORE_PATH)/init.c \
    $(LWIP_CORE_PATH)/mem.c $(LWIP_CORE_PATH)/memp.c $(LWIP_CORE_PATH)/netif.c \
    $(LWIP_CORE_PATH)/pbuf.c $(LWIP_CORE_PATH)/raw.c $(LWIP_CORE_PATH)/stats.c \
    $(LWIP_CORE_PATH)/sys.c $(LWIP_CORE_PATH)/tcp_in.c \
    $(LWIP_CORE_PATH)/tcp_out.c $(LWIP_CORE_PATH)/tcp.c \
    $(LWIP_CORE_PATH)/timers.c $(LWIP_CORE_PATH)/udp.c $(LWIP_CORE_PATH)/def.c

## IPv4
IPV4_SRC=$(LWIP_CORE_PATH)/ipv4/autoip.c $(LWIP_CORE_PATH)/ipv4/icmp.c \
    $(LWIP_CORE_PATH)/ipv4/igmp.c $(LWIP_CORE_PATH)/ipv4/ip_frag.c \
    $(LWIP_CORE_PATH)/ipv4/ip4_addr.c $(LWIP_CORE_PATH)/ipv4/ip4.c

## IPv6
IPV6_SRC=$(LWIP_CORE_PATH)/ipv6/dhcp6.c $(LWIP_CORE_PATH)/ipv6/ethip6.c \
    $(LWIP_CORE_PATH)/ipv6/icmp6.c $(LWIP_CORE_PATH)/ipv6/inet6.c \
    $(LWIP_CORE_PATH)/ipv6/ip6_addr.c $(LWIP_CORE_PATH)/ipv6/ip6_frag.c \
    $(LWIP_CORE_PATH)/ipv6/ip6.c $(LWIP_CORE_PATH)/ipv6/mld6.c \
    $(LWIP_CORE_PATH)/ipv6/nd6.c

## SNMP
SNMP_SRC=$(LWIP_CORE_PATH)/snmp/asn1_dec.c $(LWIP_CORE_PATH)/snmp/asn1_enc.c \
    $(LWIP_CORE_PATH)/snmp/mib_structs.c $(LWIP_CORE_PATH)/snmp/mib2.c \
    $(LWIP_CORE_PATH)/snmp/msg_in.c $(LWIP_CORE_PATH)/snmp/msg_out.c

## API
API_SRC=$(LWIP_API_PATH)/api_lib.c $(LWIP_API_PATH)/api_msg.c \
    $(LWIP_API_PATH)/err.c $(LWIP_API_PATH)/netbuf.c $(LWIP_API_PATH)/netdb.c \
    $(LWIP_API_PATH)/netifapi.c $(LWIP_API_PATH)/tcpip.c $(LWIP_API_PATH)/sockets.c #$(LWIP_API_PATH)/pppapi.c \
    $(LWIP_API_PATH)/sockets.c $(LWIP_API_PATH)/tcpip.c

## NETIF
NETIF_SRC=$(LWIP_NETIF_PATH)/etharp.c

## ARCH
##ARCH_SRC= $(LWIPARCH_SRC_PATH)/lwip_chksum.c $(LWIPARCH_SRC_PATH)/perf.c \
 #   $(LWIPARCH_SRC_PATH)/sys_arch.c

ARCH_SRC= $(LWIPARCH_SRC_PATH)/perf.c $(LWIPARCH_SRC_PATH)/sys_arch.c \
	$(LWIPARCH_SRC_PATH)/locator.c $(LWIPARCH_SRC_PATH)/lwiplib.c

# DRIVER
DRIVER_SRC=$(LWIPDRIVER_SRC_PATH)/cpsw.c $(LWIPDRIVER_SRC_PATH)/cpswif.c\
	$(LWIPDRIVER_SRC_PATH)/mdio.c $(LWIPDRIVER_SRC_PATH)/phy.c \
	$(LWIPDRIVER_SRC_PATH)/cpsw_bb.c $(LWIPDRIVER_SRC_PATH)/cache.c \
	$(LWIPDRIVER_SRC_PATH)/cp15.S $(LWIPDRIVER_SRC_PATH)/mmu.c
    #$(LWIPDRIVER_SRC_PATH)/cpswif.c
    #$(LWIPDRIVER_SRC_PATH)/lpc_phy_dp83848.c

## APP
##APP_SRC=$(LWIPAPP_SRC_PATH)/lwip_rtems_tcp_echo_test.c \
  ##  $(LWIPAPP_SRC_PATH)/main.c

## SOURCES
#SOURCES=$(CORE_SRC) $(IPV4_SRC) $(API_SRC) $(NETIF_SRC) $(ARCH_SRC) \
#    $(DRIVER_SRC) $(APP_SRC) ../main.c  ../enetEcho.c ../echod.c ../delay.c
SOURCES = main.c  enetEcho.c echod.c

#### HEADERS ###################################################################

## CORE
CORE_H=$(LWIP_INCL_PATH)

## IPv4
IPV4_H=$(LWIP_INCL_PATH)/ipv4

## IPv6
IPV6_H=$(LWIP_INCL_PATH)/ipv6

## NETIF
NETIF_H=$(LWIP_INCL_PATH)/netif

## ARCH
ARCH_H=$(LWIPARCH_INCL_PATH)

## DRIVER
DRIVER_H=$(LWIPDRIVER_INCL_PATH)

## APP
APP_H=..

# HEADERS
HEADERS=-I$(CORE_H) -I$(IPV4_H) -I$(IPV6_H) -I$(NETIF_H) -I$(ARCH_H) \
    -I$(DRIVER_H) -I$(APP_H) -I$(RTEMS_MAKEFILE_PATH)/lwip/include


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

copy:
	$(foreach FILE, $(SOURCES), cp $(FILE) $(notdir $(FILE)) ; )

all: ${ARCH} $(PGM) $(BIN)

$(PGM): $(OBJS)
	$(make-exe)

$(BIN): $(PGM)
	$(OBJCOPY) -O binary $^ $@

CPPFLAGS+=$(HEADERS)

cleanall: clean
	rm -f *.c
