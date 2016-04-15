HEADERDIR = ../../translit-fdlibm/src/main/resources/mytest
SRCDIR = ../netlib/

HEADER = ${HEADERDIR}/FdlibmTranslitN.java.header
TRAILER = ${HEADERDIR}/FdlibmTranslitN.java.trailer
DIFFFILE = FdlibmTranslitN.diff

C_FILES=\
 ${SRCDIR}/e_acos.c\
 ${SRCDIR}/e_asin.c\
 ${SRCDIR}/s_atan.c\
 ${SRCDIR}/e_atan2.c\
 ${SRCDIR}/s_cbrt.c\
 ${SRCDIR}/s_copysign.c\
 ${SRCDIR}/s_cos.c\
 ${SRCDIR}/k_cos.c\
 ${SRCDIR}/e_cosh.c\
 ${SRCDIR}/e_exp.c\
 ${SRCDIR}/s_expm1.c\
 ${SRCDIR}/s_fabs.c\
 ${SRCDIR}/s_floor.c\
 ${SRCDIR}/e_hypot.c\
 ${SRCDIR}/e_log.c\
 ${SRCDIR}/e_log10.c\
 ${SRCDIR}/s_log1p.c\
 ${SRCDIR}/e_pow.c\
 ${SRCDIR}/e_rem_pio2.c\
 ${SRCDIR}/k_rem_pio2.c\
 ${SRCDIR}/s_scalbn.c\
 ${SRCDIR}/s_sin.c\
 ${SRCDIR}/k_sin.c\
 ${SRCDIR}/e_sinh.c\
 ${SRCDIR}/e_sqrt.c\
 ${SRCDIR}/s_tan.c\
 ${SRCDIR}/k_tan.c\
 ${SRCDIR}/s_tanh.c

all: ${DIFFFILE}

FdlibmTranslitN.diff: FdlibmTranslitN.c FdlibmTranslitN.java 
	diff FdlibmTranslitN.c FdlibmTranslitN.java >${DIFFFILE} ; [ $$? -eq 1 ]

FdlibmTranslitN.c: ${HEADER} ${C_FILES} ${TRAILER}
	cat ${HEADER} ${C_FILES} ${TRAILER} >FdlibmTranslitN.c

clean:
	rm -f ${DIFFFILE} FdlibmTranslitN.c

