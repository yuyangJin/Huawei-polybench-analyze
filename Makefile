# Compilers
CC=gcc
CLANG=clang
MPICC=mpicc

# Compiler flags
CFLAGS=-O3 -std=gnu11
# OMPFLAGS=-fopenmp $(CFLAGS)
CLANGFLAGS=-g -c -emit-llvm -O2 
#-DPOLYBENCH_DUMP_ARRAYS

# utilities
UTIL_INC=-I utilities/
UTIL_OBJ=utilities/polybench.o


BIN=01.adi \
	#01.adi.bin 

all: $(BIN)

# objects

ADI_OBJ = $(UTIL_OBJ) \
			stencils/adi/adi.o

$(ADI_OBJ): %.o: %.c
	$(CLANG) $(CLANGFLAGS) $(UTIL_INC) $^ -o $@

# make 

01.adi: $(ADI_OBJ)
	mkdir -p bin
	llvm-link $^ -o bin/$@.bc
	llc -O0 bin/$@.bc -filetype=obj -o bin/$@.o
	$(CLANG) bin/$@.o -o bin/$@ 

#-DPOLYBENCH_DUMP_ARRAYS

clean:
	rm -f $(ADI_OBJ) bin/01.adi*