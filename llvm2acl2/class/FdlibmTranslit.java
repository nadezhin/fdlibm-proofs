/*
 * Copyright (c) 1998, 2015, Oracle and/or its affiliates. All rights reserved.
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 * This code is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 only, as
 * published by the Free Software Foundation.  Oracle designates this
 * particular file as subject to the "Classpath" exception as provided
 * by Oracle in the LICENSE file that accompanied this code.
 *
 * This code is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 * version 2 for more details (a copy is included in the LICENSE file that
 * accompanied this code).
 *
 * You should have received a copy of the GNU General Public License version
 * 2 along with this work; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
 *
 * Please contact Oracle, 500 Oracle Parkway, Redwood Shores, CA 94065 USA
 * or visit www.oracle.com if you need additional information or have any
 * questions.
 */

/**
 * A transliteration of the "Freely Distributable Math Library"
 * algorithms from C into Java. That is, this port of the algorithms
 * is as close to the C originals as possible while still being
 * readable legal Java.
 */
public class FdlibmTranslit {
    private FdlibmTranslit() {
        throw new UnsupportedOperationException("No FdLibmTranslit instances for you.");
    }

    /**
     * Return the low-order 32 bits of the double argument as an int.
     */
    private static int __LO(double x) {
        long transducer = Double.doubleToRawLongBits(x);
        return (int)transducer;
    }

    /**
     * Return a double with its low-order bits of the second argument
     * and the high-order bits of the first argument..
     */
    private static double __LO(double x, int low) {
        long transX = Double.doubleToRawLongBits(x);
        return Double.longBitsToDouble((transX & 0xFFFF_FFFF_0000_0000L)|low );
    }

    /**
     * Return the high-order 32 bits of the double argument as an int.
     */
    private static int __HI(double x) {
        long transducer = Double.doubleToRawLongBits(x);
        return (int)(transducer >> 32);
    }

    /**
     * Return a double with its high-order bits of the second argument
     * and the low-order bits of the first argument..
     */
    private static double __HI(double x, int high) {
        long transX = Double.doubleToRawLongBits(x);
        return Double.longBitsToDouble((transX & 0x0000_0000_FFFF_FFFFL)|( ((long)high)) << 32 );
    }

    public static double hypot(double x, double y) {
        return Hypot.compute(x, y);
    }

    /**
     * cbrt(x)
     * Return cube root of x
     */
    public static class Cbrt {
        // unsigned
        private static final int B1 = 715094163; /* B1 = (682-0.03306235651)*2**20 */
        private static final int B2 = 696219795; /* B2 = (664-0.03306235651)*2**20 */

        private static final double C =  5.42857142857142815906e-01; /* 19/35     = 0x3FE15F15, 0xF15F15F1 */
        private static final double D = -7.05306122448979611050e-01; /* -864/1225 = 0xBFE691DE, 0x2532C834 */
        private static final double E =  1.41428571428571436819e+00; /* 99/70     = 0x3FF6A0EA, 0x0EA0EA0F */
        private static final double F =  1.60714285714285720630e+00; /* 45/28     = 0x3FF9B6DB, 0x6DB6DB6E */
        private static final double G =  3.57142857142857150787e-01; /* 5/14      = 0x3FD6DB6D, 0xB6DB6DB7 */

        public static strictfp double compute(double x) {
            int     hx;
            double  r, s, t=0.0, w;
            int sign; // unsigned

            hx = __HI(x);           // high word of x
            sign = hx & 0x80000000;             // sign= sign(x)
            hx  ^= sign;
            if (hx >= 0x7ff00000)
                return (x+x); // cbrt(NaN,INF) is itself
            if ((hx | __LO(x)) == 0)
                return(x);          // cbrt(0) is itself

            x = __HI(x, hx);   // x <- |x|
            // rough cbrt to 5 bits
            if (hx < 0x00100000) {               // subnormal number
                t = __HI(t, 0x43500000);          // set t= 2**54
                t *= x;
                t = __HI(t, __HI(t)/3+B2);
            } else {
                t = __HI(t, hx/3+B1);
            }

            // new cbrt to 23 bits, may be implemented in single precision
            r = t * t/x;
            s = C + r*t;
            t *= G + F/(s + E + D/s);

            // chopped to 20 bits and make it larger than cbrt(x)
            t = __LO(t, 0);
            t = __HI(t, __HI(t)+0x00000001);


            // one step newton iteration to 53 bits with error less than 0.667 ulps
            s = t * t;          // t*t is exact
            r = x / s;
            w = t + t;
            r= (r - t)/(w + r);  // r-s is exact
            t= t + t*r;

            // retore the sign bit
            t = __HI(t, __HI(t) | sign);
            return(t);
        }
    }

    /**
     * hypot(x,y)
     *
     * Method :
     *      If (assume round-to-nearest) z = x*x + y*y
     *      has error less than sqrt(2)/2 ulp, than
     *      sqrt(z) has error less than 1 ulp (exercise).
     *
     *      So, compute sqrt(x*x + y*y) with some care as
     *      follows to get the error below 1 ulp:
     *
     *      Assume x > y > 0;
     *      (if possible, set rounding to round-to-nearest)
     *      1. if x > 2y  use
     *              x1*x1 + (y*y + (x2*(x + x1))) for x*x + y*y
     *      where x1 = x with lower 32 bits cleared, x2 = x - x1; else
     *      2. if x <= 2y use
     *              t1*y1 + ((x-y) * (x-y) + (t1*y2 + t2*y))
     *      where t1 = 2x with lower 32 bits cleared, t2 = 2x - t1,
     *      y1= y with lower 32 bits chopped, y2 = y - y1.
     *
     *      NOTE: scaling may be necessary if some argument is too
     *            large or too tiny
     *
     * Special cases:
     *      hypot(x,y) is INF if x or y is +INF or -INF; else
     *      hypot(x,y) is NAN if x or y is NAN.
     *
     * Accuracy:
     *      hypot(x,y) returns sqrt(x^2 + y^2) with error less
     *      than 1 ulps (units in the last place)
     */
    static class Hypot {
        public static double compute(double x, double y) {
            double a = x;
            double b = y;
            double t1, t2, y1, y2, w;
            int j, k, ha, hb;

            ha = __HI(x) & 0x7fffffff;        // high word of  x
            hb = __HI(y) & 0x7fffffff;        // high word of  y
            if(hb > ha) {
                a = y;
                b = x;
                j = ha;
                ha = hb;
                hb = j;
            } else {
                a = x;
                b = y;
            }
            a = __HI(a, ha);   // a <- |a|
            b = __HI(b, hb);   // b <- |b|
            if ((ha - hb) > 0x3c00000) {
                return a + b;  // x / y > 2**60
            }
            k=0;
            if (ha > 0x5f300000) {   // a>2**500
                if (ha >= 0x7ff00000) {       // Inf or NaN
                    w = a + b;                // for sNaN
                    if (((ha & 0xfffff) | __LO(a)) == 0)
                        w = a;
                    if (((hb ^ 0x7ff00000) | __LO(b)) == 0)
                        w = b;
                    return w;
                }
                // scale a and b by 2**-600
                ha -= 0x25800000;
                hb -= 0x25800000;
                k += 600;
                a = __HI(a, ha);
                b = __HI(b, hb);
            }
            if (hb < 0x20b00000) {   // b < 2**-500
                if (hb <= 0x000fffff) {      // subnormal b or 0 */
                    if ((hb | (__LO(b))) == 0)
                        return a;
                    t1 = 0;
                    t1 = __HI(t1, 0x7fd00000);  // t1=2^1022
                    b *= t1;
                    a *= t1;
                    k -= 1022;
                } else {            // scale a and b by 2^600
                    ha += 0x25800000;       // a *= 2^600
                    hb += 0x25800000;       // b *= 2^600
                    k -= 600;
                    a = __HI(a, ha);
                    b = __HI(b, hb);
                }
            }
            // medium size a and b
            w = a - b;
            if (w > b) {
                t1 = 0;
                t1 = __HI(t1, ha);
                t2 = a - t1;
                w  = Math.sqrt(t1*t1 - (b*(-b) - t2 * (a + t1)));
            } else {
                a  = a + a;
                y1 = 0;
                y1 = __HI(y1, hb);
                y2 = b - y1;
                t1 = 0;
                t1 = __HI(t1, ha + 0x00100000);
                t2 = a - t1;
                w  = Math.sqrt(t1*y1 - (w*(-w) - (t1*y2 + t2*b)));
            }
            if (k != 0) {
                t1 = 1.0;
                int t1_hi = __HI(t1);
                t1_hi += (k << 20);
                t1 = __HI(t1, t1_hi);
                return t1 * w;
            } else
                return w;
        }
    }
}
