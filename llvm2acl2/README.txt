This directory is an attempt to prove equivalence between Fdlibm 5.3 library 
http://www.netlib.org/fdlibm/
and its translation into Java.

******* Directory layout:

netlib/                    Sources of the original Fdlibm library from netlib.org .
netlib.llvm/               Translation of netlib/ files by clang-3.7 to x86_64-pc-linux-gnu target .
jdk8/                      Slightly modified sources of the Fdlibm library found in OpenJDK 8 .
jdk8.llvm/                 Translation of jdk8/ files by clang-3.7 to x86_64-pc-linux-gnu target .
class/                     Variants of transliteration of Fdlibm C files into Java.
class/FdlibmTranslit.java  Manual tranliteration from OpenJDK 9 tests
class/FdlibmTranslitN.java Automatic tranliteration by ../translit-fdlibm
class/8/                   Classfiles of class/FdlibmTranslit.java and class/FdlibmTranslitN.java complied bu OpenJDK 8    
class/9/                   Classfiles of class/FdlibmTranslit.java and class/FdlibmTranslitN.java complied bu OpenJDK 9
pom.xml                    Maven project file of converter from LLVM bitcode to ACL2
nbactions.xml              Netbeans configuration file ot the Converter
src/                       Source files of the Converter
acl2/                      Various ACL2 work
acl2/llvm                  Conversion of from netlib.llvm/*.bc to ACL2 by Maven project
acl2/llvms                 Conversion of from netlib.llvm/*.bc to ACL2 by Maven project in step style
acl2/classes               Conversion of class/9/*.class and some classes from OpenJDK 9 tree
                           into ACL2 classfiles for JVM M5 model. They were converted by acl2m5 
                           https://github.com/nadezhin/acl2/blob/jvm-overload/books/models/jvm/m5/jvm2m5.java
acl2/llvm.lisp             Definition of LLVM primitives in ACL2 (uses some primitives from JVM M5 model
acl2/utils.lisp            Some lemmas about JVM M5 types
acl2/llvm-lemmas.lisp      Lemmas about LLVM primitives
acl2/llvm-rec.lisp         Obsolte definition of LLVM primitives using misc/record 
acl2/llvm-rec-lemmas.lisp  Lemmas about llvm-rec
acl2/fdlibm-translit.lisp  Specification of auxilarry methods in FdlibmTranslit with proofs that
                           bytecode matches the specification
acl2/fdlibm-translitN.lisp Specification of auxilarry methods in FdlibmTranslitN with proofs that
                           bytecode matches the specification
acl2/cbrt.lisp             Manually written LLVM model of cbrt(x). It differs from automatically
                           generated acl2/llvm/s_cbrt.lisp by replacing alloca variables by registers
acl2/cbrt-opt-equ.lisp     Equivalence between acl2/cbrt.lisp and acl2/llvm/s_cbrt.lisp 
acl2/cbrt-opt-jvm          Equivalence between acl2/cbrt.lisp and acl2/classes/FdlibmTranslit$Cbrt.lisp
acl2/cbrt-opt-jvmN         Equivalence between acl2/cbrt.lisp and acl2/classes/FdlibmTranslitN$Cbrt.lisp
acl2/cbrts.lisp            Another style of cbrt definition (as a step function)
acl2/cbrts-equ.lisp        Attemps to prove acl2/cbrts.lisp properties
acl2/cbrt-rec.lisp         Obsolete definition of cbrt based on acl2/llvm-rec.lsip

******* Build and run

How to build and run the Converter:
1) Install maven
2) cd ${PROJECTS}/fdlibm-proofs/llvm2acl2
3) make

This command builds maven projects, installs it in local maven repository and runs the program
which converts some files from netlib.llvm/*.bc to acl2/llvm/*.lisp

I usually develop in Netbeans:
1) Install Netbeans    
2) File|Open Project...  and choose the directory ${PROJECTS}/fdlibm-proofs/llvm2acl2
3) Debug|Debug Project (llvmacl2)

******* Choices.

LLVM model can be done in various ways.
Here are some choises

1) Some primitives are implementation defined on some operands values.
   Examples: division by zero, overflow in SItoFP and UItoFP conversions, NaNs.
   How to specify this. Variants:
    i) Return valid default value like 0;
    ii) Return special value outside domain. Often it is 0;
    iii) encapsulated function with axioms specifying only regular behaviour;
   We chose (ii), though it is not fully implemented yet.
2) How to represent floating-point values like float or double.
   In the same way as in JVM M5 - unsigned-32 or unsigned-64 .
3) Memory. Fdlibm don't use heap. Its memory objects are either gloabl constants
   or local variables. Now they are modelled by constant global memory and by local
   memories for each call frame. This is not universal solution.
4) Memory for local frame maps variable names to sequences of 32-bit words.
   Each double is represented by a pair of 32-word in little-endian order.
   Pointer is a cons of variable name (symbolp) and offset (natp).
5) Call stack and instruction pointer are not represented explicitly.
   Instead they are embedded in ACL2 control structure.
   Basic block is an ACL b* form. The body of a b* block is a tail call of next block (blocks).
   Loops are not implemented yet because of :measure issue.
   Two ways to resolve it:
   i) defunp doesn't require :measure proof but it is not executable;
   ii) Basic block returns a lable of the next basic block instead.
       LLVM interpreted required. Lable is like abn instruction address.
   There is no choice yet. So we can convert functions with if/switch statements and
   can't convert functions with for/while statements.
6) There are three ways to obtain LLVM graph:
   i) from text .llvm fules;
   ii) from binary .bc files;
   iii) from C structures in native memory.
   We choose (iii) because we hope that some LLVM structures can be mapped to ACL2 later.
7) Implementation language and API.
   llvm is written in C++ and it has C interface (for a subset of features).
   There are FFI mappings for other languages (like Java).
   We have some Java libriries and it is reason to use Java.
   Options:
   i) C++ using all classes;
   ii) C using features in C interface;
   iii) Java wrapper if (ii);
   iv) Java wrapper
   Now the choice is (iii), but it is desirable to migrate to (iv) or to (i) for complete API.



******* TODO.
The converter supports only those features that were necessary toconvert Fdlibm C files.
1) Only those types that occured in the Fdlibm are supported.
   For example, it supports only those array types:
   [2 x double] [4 x double] [11 x double] [16 x double]
2) Only those instructions that occured in the Fdlibm;
3) Limited view of heap: only double and i32 types,
   includeing casting double* pointers to i32* pointers;
4) alloca data is local;
5) It is necessary to define guards for operations more accurately:
   division by zero, overflow in SItoFP and UItoFP conversions.
6) Choose a way how to convert loops and convert them;
7) Need Command line arguments to convert something except Fdlibm.
8) Write it in C++ to enhance maintainability ?
9) Look at Jared's nativearith and converge to it if it is reasonable.


