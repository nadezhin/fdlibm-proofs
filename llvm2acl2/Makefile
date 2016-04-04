M2_REPOSITORY=${HOME}/.m2/repository
BRIDJ_VERSION=0.7.1-SNAPSHOT
JAR_FILE=target/llvm2acl2-0.1.0-SNAPSHOT.jar
ACL2_DIR=acl2/llvm
ACL2_FILES=\
 ${ACL2_DIR}/w_acos.lisp\
 ${ACL2_DIR}/e_acos.lisp\
 ${ACL2_DIR}/w_asin.lisp\
 ${ACL2_DIR}/e_asin.lisp\
 ${ACL2_DIR}/s_atan.lisp\
 ${ACL2_DIR}/w_atan2.lisp\
 ${ACL2_DIR}/e_atan2.lisp\
 ${ACL2_DIR}/s_cbrt.lisp\
 ${ACL2_DIR}/s_copysign.lisp\
 ${ACL2_DIR}/s_cos.lisp\
 ${ACL2_DIR}/k_cos.lisp\
 ${ACL2_DIR}/w_cosh.lisp\
 ${ACL2_DIR}/e_cosh.lisp\
 ${ACL2_DIR}/w_exp.lisp\
 ${ACL2_DIR}/e_exp.lisp\
 ${ACL2_DIR}/s_expm1.lisp\
 ${ACL2_DIR}/s_fabs.lisp\
 ${ACL2_DIR}/s_floor.lisp\
 ${ACL2_DIR}/w_hypot.lisp\
 ${ACL2_DIR}/e_hypot.lisp\
 ${ACL2_DIR}/w_log.lisp\
 ${ACL2_DIR}/e_log.lisp\
 ${ACL2_DIR}/w_log10.lisp\
 ${ACL2_DIR}/e_log10.lisp\
 ${ACL2_DIR}/s_log1p.lisp\
 ${ACL2_DIR}/w_pow.lisp\
 ${ACL2_DIR}/e_pow.lisp\
 ${ACL2_DIR}/s_scalbn.lisp\
 ${ACL2_DIR}/s_sin.lisp\
 ${ACL2_DIR}/k_sin.lisp\
 ${ACL2_DIR}/w_sinh.lisp\
 ${ACL2_DIR}/e_sinh.lisp\
 ${ACL2_DIR}/w_sqrt.lisp\
 ${ACL2_DIR}/s_tan.lisp\
 ${ACL2_DIR}/k_tan.lisp\
 ${ACL2_DIR}/s_tanh.lisp

# ${ACL2+DIR}/e_rem_pio2.lisp\
# ${ACL2+DIR}/k_rem_pio2.lisp\
# ${ACL2+DIR}/e_sqrt.lisp

all: ${ACL2_FILES}

jar: ${JAR_FILE}

${ACL2_FILES}: ${JAR_FILE}
	LANG=CC; java -ea -classpath ${JAR_FILE}:${M2_REPOSITORY}/com/nativelibs4java/bridj/${BRIDJ_VERSION}/bridj-${BRIDJ_VERSION}.jar jdkproofs.llvm2acl2.DumpACL2

${JAR_FILE}:
	mvn clean install

clean:
	mvn clean
	rm ${ACL2_FILES}

