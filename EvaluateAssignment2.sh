#!/bin/bash -eux
DIR=${1:-`pwd`}
UF=${2:-4}
LLVM_SRC=/home/utpal/llvm
LLVM_BUILD=/home/utpal/build/release_70
TEST_CASES=/home/utpal/build/CompEnggAsgn2

rm -f "${LLVM_SRC}"/include/llvm/Transforms/LoopUnrolling/*.h
rm -f "${LLVM_SRC}"/lib/Transforms/LoopUnrolling/*.cpp

find "$DIR" -type f -name "LoopUnroller.cpp" -exec cp '{}' "${LLVM_SRC}"/lib/Transforms/LoopUnrolling/ \;
find "$DIR" -type f -name "LoopUnroller.h" -exec cp '{}' "${LLVM_SRC}"/include/llvm/Transforms/LoopUnrolling/ \;

ninja -C "${LLVM_BUILD}"

cd "${TEST_CASES}"
for f in `ls *.c`;do
  "${LLVM_BUILD}"/bin/clang \
    -S -emit-llvm \
    -Xclang -disable-O0-optnone \
    $f;
done

for f in `ls *.ll`; do
"${LLVM_BUILD}"/bin/opt \
  -load "${LLVM_BUILD}"/lib64/LoopUnroller.so \
  -loop-unrolling \
  -unroll-factor=${UF} \
  -o `basename $f .ll`.o.l \
  -S \
  $f

"${LLVM_BUILD}"/bin/lli `basename $f .ll`.o.l

done
