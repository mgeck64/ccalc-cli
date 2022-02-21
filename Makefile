#
# Compiler flags
#
CCXX   = g++
CC     = gcc
CXXFLAGS = -Wall -Werror -Wextra -std=gnu++20 -isystem /usr/local/include/boost_1_74_0
CFLAGS   = -Wall -Werror -Wextra

#
# Project files
#
CPPSRCS = $(wildcard *.cpp)
CSRCS = $(wildcard *.c)
OBJS = $(CPPSRCS:.cpp=.o) $(CSRCS:.c=.o)
EXE = ccalc

#
# Debug build settings
#
DBGDIR = debug
DBGEXE = $(DBGDIR)/$(EXE)
DBGOBJS = $(addprefix $(DBGDIR)/, $(OBJS))
DBGDEPS = $(DBGOBJS:%.o=%.d)
DBGFLAGS = -g -O0 -DDEBUG

#
# Release build settings
#
RELDIR = release
RELEXE = $(RELDIR)/$(EXE)
RELOBJS = $(addprefix $(RELDIR)/, $(OBJS))
RELDEPS = $(RELOBJS:%.o=%.d)
RELFLAGS = -Os -DNDEBUG
PREFIX = /usr
# DestDir, normally undefined, is to allow for staging installations to
# temporary directories before manually moving them to their actual place

.PHONY: all clean debug release remake install uninstall

# Default build
all: install

#
# Debug rules
#
debug: make_dbgdir $(DBGEXE)

$(DBGEXE): $(DBGOBJS)
	$(CCXX) -o $(DBGEXE) $^ -lccalc-dbg

-include $(DBGDEPS)

$(DBGDIR)/%.o: %.cpp
	$(CCXX) -c $(CXXFLAGS) $(DBGFLAGS) -MMD -o $@ $<

$(DBGDIR)/%.o: %.c
	$(CC) -c $(CFLAGS) $(DBGFLAGS) -MMD -o $@ $<

#
# Release rules
#
release: make_reldir $(RELEXE)

$(RELEXE): $(RELOBJS)
	$(CCXX) -o $(RELEXE) $^ -lccalc-rel

-include $(RELDEPS)

$(RELDIR)/%.o: %.cpp
	$(CCXX) -c $(CXXFLAGS) $(RELFLAGS) -MMD -o $@ $<

$(RELDIR)/%.o: %.c
	$(CC) -c $(CFLAGS) $(RELFLAGS) -MMD -o $@ $<

#
# Install/uninstall rules
#

install: make_reldir $(RELDIR)/$(EXE)
	sudo install -D $(RELDIR)/$(EXE) $(DESTDIR)$(PREFIX)/bin/$(EXE)

uninstall:
	sudo rm -f $(DESTDIR)$(PREFIX)/bin/$(EXE)

#
# Other rules
#
make_dbgdir:
	@mkdir -p $(DBGDIR)

make_reldir:
	@mkdir -p $(RELDIR)

remake: clean all

clean:
	@rm -r -f $(RELDIR) $(DBGDIR)