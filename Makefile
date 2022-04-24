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
	03.fdtd2d \
	04.fdtdapml \
	05.jacobi-1d-imper \
	06.jacobi-2d-imper \
	10.regdetect \

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

FDTD2D_OBJ = $(UTIL_OBJ) \
			stencils/fdtd-2d/fdtd-2d.o

$(FDTD2D_OBJ): %.o: %.c
	$(CLANG) $(CLANGFLAGS) $(UTIL_INC) $^ -o $@

FDTDAPML_OBJ = $(UTIL_OBJ) \
			stencils/fdtd-apml/fdtd-apml.o

$(FDTDAPML_OBJ): %.o: %.c
	$(CLANG) $(CLANGFLAGS) $(UTIL_INC) $^ -o $@

JACOBI_1D_IMPER_OBJ = $(UTIL_OBJ) \
			stencils/jacobi-1d-imper/jacobi-1d-imper.o

$(JACOBI_1D_IMPER_OBJ): %.o: %.c
	$(CLANG) $(CLANGFLAGS) $(UTIL_INC) $^ -o $@

JACOBI_2D_IMPER_OBJ = $(UTIL_OBJ) \
			stencils/jacobi-2d-imper/jacobi-2d-imper.o

$(JACOBI_2D_IMPER_OBJ): %.o: %.c
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

03.fdtd2d: $(FDTD2D_OBJ)
	mkdir -p bin
	llvm-link $^ -o bin/$@.bc
	llc -O0 bin/$@.bc -filetype=obj -o bin/$@.o
	$(CLANG) bin/$@.o -o bin/$@ 

04.fdtdapml: $(FDTDAPML_OBJ)
	mkdir -p bin
	llvm-link $^ -o bin/$@.bc
	llc -O0 bin/$@.bc -filetype=obj -o bin/$@.o
	$(CLANG) bin/$@.o -o bin/$@ 

05.jacobi-1d-imper: $(JACOBI_1D_IMPER_OBJ)
	mkdir -p bin
	llvm-link $^ -o bin/$@.bc
	llc -O0 bin/$@.bc -filetype=obj -o bin/$@.o
	$(CLANG) bin/$@.o -o bin/$@ 

06.jacobi-2d-imper: $(JACOBI_2D_IMPER_OBJ)
	mkdir -p bin
	llvm-link $^ -o bin/$@.bc
	llc -O0 bin/$@.bc -filetype=obj -o bin/$@.o
	$(CLANG) bin/$@.o -o bin/$@ 

10.regdetect: $(REGDETECT_OBJ)
	mkdir -p bin
	llvm-link $^ -o bin/$@.bc
	llc -O0 bin/$@.bc -filetype=obj -o bin/$@.o
	$(CLANG) bin/$@.o -o bin/$@ 

clean:
	rm -f $(ADI_OBJ) bin/01.adi* \
		$(SEIDEL2D_OBJ) bin/02.seidel2d* \
		$(FDTD2D_OBJ) bin/03.fdtd2d* \
		$(FDTDAPML_OBJ) bin/04.fdtdapml* \
		$(JACOBI_1D_IMPER_OBJ) bin/jacobi-1d-imper* \
		$(JACOBI_2D_IMPER_OBJ) bin/jacobi-2d-imper* \
		$(REGDETECT_OBJ) bin/10.regdetect* \
	 	