#
#                Common part of GNU Makefiles to build processor modules.
#
#--------------------------- Main IDA directory   --------------------------
IDAUNIX=../../

############################################################################
#                            From ALLMAKE.MAK                              #
############################################################################
# include and help directories are common for all platforms and compilers:
I=$(IDAUNIX)include/
# libraries directory
L=$(IDAUNIX)lib/gcc.w32/
# results directory
R=$(IDAUNIX)bin/
# config directory
C=$(R)cfg/
# object files directory
F=obj/gcc.w32/
# plugins directory
SUBDIR=plugins/
# PLUGIN extension
PLUGIN=.plw
# object file extension
O=.o
# library file extension
A=.a
# File Remover
RM=rm
# File Copier
CP=cp

CC=g++
CFLAGS=-I$(I) -DWIN32 -D__NT__ -D__IDP__ -mrtd -mno-cygwin $(__CFLAGS)

$(F)%$(O): %.cpp
	$(CC) -c $(CFLAGS) $< -o $@

LD=g++
LDFLAGS=--def ../idp.def -Wl,--dll -shared -mno-cygwin $(_LDFLAGS)

IDALIB=$(L)ida$(A)

############################################################################
#                            From MODULE.MAK                               #
############################################################################
ifdef O1
OBJ1=$(F)$(O1)$(O)
endif

ifdef O2
OBJ2=$(F)$(O2)$(O)
endif

ifdef O3
OBJ3=$(F)$(O3)$(O)
endif

ifdef O4
OBJ4=$(F)$(O4)$(O)
endif

ifdef O5
OBJ5=$(F)$(O5)$(O)
endif

ifdef O6
OBJ6=$(F)$(O6)$(O)
endif

ifdef O7
OBJ7=$(F)$(O7)$(O)
endif

ifdef O8
OBJ8=$(F)$(O8)$(O)
endif

ifdef O9
OBJ9=$(F)$(O9)$(O)
endif

ifdef O10
OBJ10=$(F)$(O10)$(O)
endif

ifdef O11
OBJ11=$(F)$(O11)$(O)
endif

ifdef O12
OBJ12=$(F)$(O12)$(O)
endif

ifdef O13
OBJ13=$(F)$(O13)$(O)
endif

ifdef O14
OBJ14=$(F)$(O14)$(O)
endif

ifdef O15
OBJ15=$(F)$(O15)$(O)
endif

OBJS=$(F)ins$(O) $(F)ana$(O) $(F)out$(O) $(F)reg$(O) $(F)emu$(O) \
     $($(OBJ1) $(OBJ2) $(OBJ3) $(OBJ4) $(OBJ5) $(OBJ6) $(OBJ7) \
     $(OBJ8) $(OBJ9) $(OBJ10) $(OBJ11) $(OBJ12) $(OBJ13) $(OBJ14) $(OBJ15)   \
     $(ADDITIONAL_OBJS)

BINARY=$(R)procs/$(PROC).w32

all: $(F) $(BINARY) $(ADDITIONAL_GOALS)

clean:
	-@$(RM) $(F)*$(O)
	-@$(RM) $(BINARY)

distclean: clean
	-@$(RM) $(F)*
	rmdir $(F)

$(F):
	-@mkdir $(F)

# The following problem with cygwin exists: it is impossible to specify the
# dos stub for the output file. The default stub is too short and there is
# to room for the description string. Therefore, mkidp fails and the resulting
# module is not functional. We do not have a solution for this yet.

$(BINARY): $(F) $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS) $(IDALIB) $(LIBS)
	$(R)mkidp$(B) $@ "$(DESCRIPTION)"
