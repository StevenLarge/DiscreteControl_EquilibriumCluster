#MAKEFILE for Propogator routine
#
#Steven Large
#January 14th 2018

PRODUCT_EQ = EquilibriumSampling.exe

ODIR = obj
LDIR = lib
IDIR = include
SDIR = src

MAINFILE_EQ = $(SDIR)/EquilibriumSampling_Cluster.cpp

SOURCES_EQ = $(SDIR)/Propogator.cpp
LIBRARIES_EQ = $(LDIR)/ReadWrite.cpp
OBJECTS_EQ = $(SDIR)/$(ODIR)/Propogator.o
OBJECTS_EQ_LIB = $(SDIR)/$(ODIR)/ReadWrite.o

CFLAGS = -I.

DEPS_EQ = $(IDIR)/DiscreteControl.h $(IDIR)/DiscreteControl_Eq.h

#CC = g++ -std=c++0x -O3
CC = g++ -std=c++11 -O3

all: $(PRODUCT_EQ)

$(OBJECTS_EQ): $(SOURCES_EQ)
	$(CC) -c $(SOURCES_EQ) -o $(OBJECTS_EQ) $(CFLAGS)

$(OBJECTS_EQ_LIB): $(LIBRARIES_EQ)
	$(CC) -c $(LIBRARIES_EQ) -o $(OBJECTS_EQ_LIB) $(CFLAGS)

$(PRODUCT_EQ): $(MAINFILE_EQ) $(OBJECTS_EQ) $(OBJECTS_EQ_LIB) $(DEPS_EQ)
	$(CC) $(MAINFILE_EQ) $(OBJECTS_EQ) $(OBJECTS_EQ_LIB) -o $(PRODUCT_EQ) $(CFLAGS)

clean:
	rm -f $(SDIR)/$(ODIR)/*.o

clean_ex:
	rm *.exe

