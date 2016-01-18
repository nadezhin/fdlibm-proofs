CLANG = clang-3.7
INCDIR = ../netlib
SRCDIR = ../netlib
DEFS = -D__LITTLE_ENDIAN -D_IEEE_LIBM

LLVMS =\
 e_acos.llvm\
 e_acosh.llvm\
 e_asin.llvm\
 e_atan2.llvm\
 e_atanh.llvm\
 e_cosh.llvm\
 e_exp.llvm\
 e_fmod.llvm\
 e_gamma.llvm\
 e_gamma_r.llvm\
 e_hypot.llvm\
 e_j0.llvm\
 e_j1.llvm\
 e_jn.llvm\
 e_lgamma.llvm\
 e_lgamma_r.llvm\
 e_log10.llvm\
 e_log.llvm\
 e_pow.llvm\
 e_remainder.llvm\
 e_rem_pio2.llvm\
 e_scalb.llvm\
 e_sinh.llvm\
 e_sqrt.llvm\
 k_cos.llvm\
 k_rem_pio2.llvm\
 k_sin.llvm\
 k_standard.llvm\
 k_tan.llvm\
 s_asinh.llvm\
 s_atan.llvm\
 s_cbrt.llvm\
 s_ceil.llvm\
 s_copysign.llvm\
 s_cos.llvm\
 s_erf.llvm\
 s_expm1.llvm\
 s_fabs.llvm\
 s_finite.llvm\
 s_floor.llvm\
 s_frexp.llvm\
 s_ilogb.llvm\
 s_isnan.llvm\
 s_ldexp.llvm\
 s_lib_version.llvm\
 s_log1p.llvm\
 s_logb.llvm\
 s_matherr.llvm\
 s_modf.llvm\
 s_nextafter.llvm\
 s_rint.llvm\
 s_scalbn.llvm\
 s_signgam.llvm\
 s_significand.llvm\
 s_sin.llvm\
 s_tan.llvm\
 s_tanh.llvm\
 w_acos.llvm\
 w_acosh.llvm\
 w_asin.llvm\
 w_atan2.llvm\
 w_atanh.llvm\
 w_cosh.llvm\
 w_exp.llvm\
 w_fmod.llvm\
 w_gamma.llvm\
 w_gamma_r.llvm\
 w_hypot.llvm\
 w_j0.llvm\
 w_j1.llvm\
 w_jn.llvm\
 w_lgamma.llvm\
 w_lgamma_r.llvm\
 w_log10.llvm\
 w_log.llvm\
 w_pow.llvm\
 w_remainder.llvm\
 w_scalb.llvm\
 w_sinh.llvm\
 w_sqrt.llvm

BCS =\
 e_acos.bc\
 e_acosh.bc\
 e_asin.bc\
 e_atan2.bc\
 e_atanh.bc\
 e_cosh.bc\
 e_exp.bc\
 e_fmod.bc\
 e_gamma.bc\
 e_gamma_r.bc\
 e_hypot.bc\
 e_j0.bc\
 e_j1.bc\
 e_jn.bc\
 e_lgamma.bc\
 e_lgamma_r.bc\
 e_log10.bc\
 e_log.bc\
 e_pow.bc\
 e_remainder.bc\
 e_rem_pio2.bc\
 e_scalb.bc\
 e_sinh.bc\
 e_sqrt.bc\
 k_cos.bc\
 k_rem_pio2.bc\
 k_sin.bc\
 k_standard.bc\
 k_tan.bc\
 s_asinh.bc\
 s_atan.bc\
 s_cbrt.bc\
 s_ceil.bc\
 s_copysign.bc\
 s_cos.bc\
 s_erf.bc\
 s_expm1.bc\
 s_fabs.bc\
 s_finite.bc\
 s_floor.bc\
 s_frexp.bc\
 s_ilogb.bc\
 s_isnan.bc\
 s_ldexp.bc\
 s_lib_version.bc\
 s_log1p.bc\
 s_logb.bc\
 s_matherr.bc\
 s_modf.bc\
 s_nextafter.bc\
 s_rint.bc\
 s_scalbn.bc\
 s_signgam.bc\
 s_significand.bc\
 s_sin.bc\
 s_tan.bc\
 s_tanh.bc\
 w_acos.bc\
 w_acosh.bc\
 w_asin.bc\
 w_atan2.bc\
 w_atanh.bc\
 w_cosh.bc\
 w_exp.bc\
 w_fmod.bc\
 w_gamma.bc\
 w_gamma_r.bc\
 w_hypot.bc\
 w_j0.bc\
 w_j1.bc\
 w_jn.bc\
 w_lgamma.bc\
 w_lgamma_r.bc\
 w_log10.bc\
 w_log.bc\
 w_pow.bc\
 w_remainder.bc\
 w_scalb.bc\
 w_sinh.bc\
 w_sqrt.bc

all: $(LLVMS) $(BCS)

%.llvm : $(SRCDIR)/%.c
	$(CLANG) $< $(DEFS) -I$(INCDIR) -O0 -S -emit-llvm -o $@

%.bc : $(SRCDIR)/%.c
	$(CLANG) $< $(DEFS) -I$(INCDIR) -O0 -c -emit-llvm -o $@

