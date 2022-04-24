# Compilers
CC=gcc
CLANG=clang
MPICC=mpicc

# Compiler flags
CFLAGS=-O3 -std=gnu11
# OMPFLAGS=-fopenmp $(CFLAGS)
CLANGFLAGS=-g -c -emit-llvm -O1
#-DPOLYBENCH_DUMP_ARRAYS

# utilities
UTIL_INC=-I utilities/
UTIL_OBJ=utilities/polybench.o


BIN=01.adi \
	02.seidel2d \
	03.regdetect \

all: $(BIN)

# objects

ADI_OBJ = $(UTIL_OBJ) \
			stencils/adi/adi.o

$(ADI_OBJ): %.o: %.c
	$(CLANG) $(CLANGFLAGS) $(UTIL_INC) $^ -o $@

SEIDEL2D_OBJ = $(UTIL_OBJ) \
			stencils/seidel-2d/seidel-2d.o

$(SEIDEL2D_OBJ): %.o: %.c
	$(CLANG) $(CLANGFLAGS) $(UTIL_INC) $^ -o $@

REGDETECT_OBJ = $(UTIL_OBJ) \
			medley/reg_detect/reg_detect.o

$(REGDETECT_OBJ): %.o: %.c
	$(CLANG) $(CLANGFLAGS) $(UTIL_INC) $^ -o $@

# make 

01.adi: $(ADI_OBJ)
	mkdir -p bin
	llvm-link $^ -o bin/$@.bc
	llc -O0 bin/$@.bc -filetype=obj -o bin/$@.o
	$(CLANG) bin/$@.o -o bin/$@ 

#-DPOLYBENCH_DUMP_ARRAYS

02.seidel2d: $(SEIDEL2D_OBJ)
	mkdir -p bin
	llvm-link $^ -o bin/$@.bc
	llc -O0 bin/$@.bc -filetype=obj -o bin/$@.o
	$(CLANG) bin/$@.o -o bin/$@ 

03.regdetect: $(REGDETECT_OBJ)
	mkdir -p bin
	llvm-link $^ -o bin/$@.bc
	llc -O0 bin/$@.bc -filetype=obj -o bin/$@.o
	$(CLANG) bin/$@.o -o bin/$@ 

clean:
	rm -f $(ADI_OBJ) bin/01.adi* $(SEIDEL2D_OBJ) bin/02.seidel2d* $(REGDETECT_OBJ) bin/03.regdetect