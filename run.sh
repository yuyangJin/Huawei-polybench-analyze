DFG_DIR=/home/jinyuyang/PACMAN_PROJECT/huawei21/data-flow-analyzer
PREFIX=$1
OPT=opt
LLVM_DIS=llvm-dis

$OPT -loop-simplify -mergereturn $PREFIX.bc -o $PREFIX.opt.bc                                                                                                         
$LLVM_DIS $PREFIX.opt.bc                                                                                                                                           
                                                                                                                                                                  
$OPT -load $DFG_DIR/build/src/DFGPass.so -DFGPass $PREFIX.opt.bc -enable-new-pm=0 -o $PREFIX.final.bc                                                                            
$LLVM_DIS $PREFIX.final.bc
