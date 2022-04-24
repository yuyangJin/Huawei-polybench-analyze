# Compilers
CC=gcc
CLANG=clang
MPICC=mpicc
LLC=llc

# Compiler flags
CFLAGS=-O3 -std=gnu11
# OMPFLAGS=-fopenmp $(CFLAGS)
CLANGFLAGS=-g -c -emit-llvm -O1
LLCFLAGS=-O3
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
	20.durbin \
	21.dynprog \
	22.ludcmp \

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

DURBIN_OBJ = $(UTIL_OBJ) \
			linear-algebra/solvers/durbin/durbin.o

$(DURBIN_OBJ): %.o: %.c
	$(CLANG) $(CLANGFLAGS) $(UTIL_INC) $^ -o $@

DYNPROG_OBJ = $(UTIL_OBJ) \
			linear-algebra/solvers/dynprog/dynprog.o

$(DYNPROG_OBJ): %.o: %.c
	$(CLANG) $(CLANGFLAGS) $(UTIL_INC) $^ -o $@

LUDCMP_OBJ = $(UTIL_OBJ) \
			linear-algebra/solvers/ludcmp/ludcmp.o

$(LUDCMP_OBJ): %.o: %.c
	$(CLANG) $(CLANGFLAGS) $(UTIL_INC) $^ -o $@


# make 

01.adi: $(ADI_OBJ)
	mkdir -p bin
	llvm-link $^ -o bin/$@.bc
	$(LLC) $(LLCFLAGS) bin/$@.bc -filetype=obj -o bin/$@.o
	$(CLANG) bin/$@.o -o bin/$@ 

#-DPOLYBENCH_DUMP_ARRAYS

02.seidel2d: $(SEIDEL2D_OBJ)
	mkdir -p bin
	llvm-link $^ -o bin/$@.bc
	$(LLC) $(LLCFLAGS) bin/$@.bc -filetype=obj -o bin/$@.o
	$(CLANG) bin/$@.o -o bin/$@ 

03.fdtd2d: $(FDTD2D_OBJ)
	mkdir -p bin
	llvm-link $^ -o bin/$@.bc
	$(LLC) $(LLCFLAGS) bin/$@.bc -filetype=obj -o bin/$@.o
	$(CLANG) bin/$@.o -o bin/$@ 

04.fdtdapml: $(FDTDAPML_OBJ)
	mkdir -p bin
	llvm-link $^ -o bin/$@.bc
	$(LLC) $(LLCFLAGS) bin/$@.bc -filetype=obj -o bin/$@.o
	$(CLANG) bin/$@.o -o bin/$@ 

05.jacobi-1d-imper: $(JACOBI_1D_IMPER_OBJ)
	mkdir -p bin
	llvm-link $^ -o bin/$@.bc
	$(LLC) $(LLCFLAGS) bin/$@.bc -filetype=obj -o bin/$@.o
	$(CLANG) bin/$@.o -o bin/$@ 

06.jacobi-2d-imper: $(JACOBI_2D_IMPER_OBJ)
	mkdir -p bin
	llvm-link $^ -o bin/$@.bc
	$(LLC) $(LLCFLAGS) bin/$@.bc -filetype=obj -o bin/$@.o
	$(CLANG) bin/$@.o -o bin/$@ 

10.regdetect: $(REGDETECT_OBJ)
	mkdir -p bin
	llvm-link $^ -o bin/$@.bc
	$(LLC) $(LLCFLAGS) bin/$@.bc -filetype=obj -o bin/$@.o
	$(CLANG) bin/$@.o -o bin/$@ 

20.durbin: $(DURBIN_OBJ)
	mkdir -p bin
	llvm-link $^ -o bin/$@.bc
	$(LLC) $(LLCFLAGS) bin/$@.bc -filetype=obj -o bin/$@.o
	$(CLANG) bin/$@.o -o bin/$@ 

21.dynprog: $(DYNPROG_OBJ)
	mkdir -p bin
	llvm-link $^ -o bin/$@.bc
	$(LLC) $(LLCFLAGS) bin/$@.bc -filetype=obj -o bin/$@.o
	$(CLANG) bin/$@.o -o bin/$@ 

22.ludcmp: $(LUDCMP_OBJ)
	mkdir -p bin
	llvm-link $^ -o bin/$@.bc
	$(LLC) $(LLCFLAGS) bin/$@.bc -filetype=obj -o bin/$@.o
	$(CLANG) bin/$@.o -o bin/$@ 

clean:
	rm -f $(ADI_OBJ) bin/01.adi* \
		$(SEIDEL2D_OBJ) bin/02.seidel2d* \
		$(FDTD2D_OBJ) bin/03.fdtd2d* \
		$(FDTDAPML_OBJ) bin/04.fdtdapml* \
		$(JACOBI_1D_IMPER_OBJ) bin/05.jacobi-1d-imper* \
		$(JACOBI_2D_IMPER_OBJ) bin/06.jacobi-2d-imper* \
		$(REGDETECT_OBJ) bin/10.regdetect* \
		$(DURBIN_OBJ) bin/20.durbin* \
		$(DYNPROG_OBJ) bin/21.dynprog* \
		$(LUDCMP_OBJ) bin/22.ludcmp* \
	 	