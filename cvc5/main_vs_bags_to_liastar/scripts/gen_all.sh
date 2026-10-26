#!/bin/zsh
S=/private/tmp/claude-503/-Users-mahgoubyahia-cvc5-12572/f652ee3c-507d-4fa6-8b11-75efc497ec30/scratchpad/sql
Z3LIB=$HOME/spes/.venv/z3/bin
CVC5LIB=$HOME/.cache/cvc5/bags-map-up-pair/build/install/lib
JAVA=/Library/Java/JavaVirtualMachines/jdk-26.jdk/Contents/Home/bin/java
cd ~/spes
CP=target/test-classes:target/classes:$(cat $S/cp.txt)
for sem in bags sets; do
  for b in no_aggregation no_aggregation_sat calcite_tests spark_tests no_aggregation_no_null no_aggregation_no_null_no_cast no_aggregation_no_null_no_cast_no_outer_join bags; do
    echo "=== $b $sem $(date +%T)"
    DYLD_LIBRARY_PATH=$Z3LIB $JAVA -Djava.library.path=$Z3LIB:$CVC5LIB --enable-native-access=ALL-UNNAMED -cp $CP \
      -Dbatch=testData/$b.json -Dsem=$sem -Dout=$S/gen/${b}__${sem}.smt2 -Dcex=none -Dtlimit=100 \
      SimpleQueryTests.Cvc5Analysis > $S/gen/${b}__${sem}.log 2>&1
    echo "    exit $? : $(grep -c '^; RESULT' $S/gen/${b}__${sem}.log) results, $(grep -c '(check-sat)' $S/gen/${b}__${sem}.smt2) problems"
  done
done
echo GEN_DONE
