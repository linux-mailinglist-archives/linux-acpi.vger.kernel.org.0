Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFA3246EAA
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Aug 2020 19:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbgHQReZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Aug 2020 13:34:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:23599 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388844AbgHQQhN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Aug 2020 12:37:13 -0400
IronPort-SDR: uVq6HJ9miqKDtUTH2tzhj2YTHvWfUeB8zHg+tpoQwvmbr7bYsEw5TVq7HG5HqRTCdFamq13Ahp
 Dc2iRU5yeKAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="216269417"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="216269417"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 09:36:50 -0700
IronPort-SDR: 4VBIIxzK9/m6cF1oY+mZmDkP99GXi48WB6GISYmLitKxRwZjwoAeCep/GmGvE0jZ9KnjT3KSp2
 Rmfyw8nknEgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="292484276"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 17 Aug 2020 09:36:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BB22016D; Mon, 17 Aug 2020 19:36:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/8] kernel.h: Split out min()/max() et al. helpers
Date:   Mon, 17 Aug 2020 19:36:40 +0300
Message-Id: <20200817163647.48982-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

kernel.h is being used as a dump for all kinds of stuff for a long time.
Here is the attempt to start cleaning it up by splitting out min()/max()
et al. helpers.

At the same time convert users in header and lib folder to use new header.
Though for time being include new header back to kernel.h to avoid twisted
indirected includes for other existing users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch, prerequisite for the rest (Rafael)
 include/linux/blkdev.h    |   1 +
 include/linux/bvec.h      |   6 +-
 include/linux/jiffies.h   |   3 +-
 include/linux/kernel.h    | 142 +------------------------------------
 include/linux/minmax.h    | 145 ++++++++++++++++++++++++++++++++++++++
 include/linux/nodemask.h  |   2 +-
 include/linux/uaccess.h   |   1 +
 kernel/range.c            |   3 +-
 lib/find_bit.c            |   1 +
 lib/hexdump.c             |   1 +
 lib/math/rational.c       |   2 +-
 lib/math/reciprocal_div.c |   1 +
 12 files changed, 162 insertions(+), 146 deletions(-)
 create mode 100644 include/linux/minmax.h

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bb5636cc17b9..3641c7234afb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -8,6 +8,7 @@
 #include <linux/genhd.h>
 #include <linux/list.h>
 #include <linux/llist.h>
+#include <linux/minmax.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
 #include <linux/pagemap.h>
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index ac0c7299d5b8..8c7b3926b69c 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -7,10 +7,14 @@
 #ifndef __LINUX_BVEC_ITER_H
 #define __LINUX_BVEC_ITER_H
 
-#include <linux/kernel.h>
 #include <linux/bug.h>
 #include <linux/errno.h>
+#include <linux/limits.h>
+#include <linux/minmax.h>
 #include <linux/mm.h>
+#include <linux/types.h>
+
+struct page;
 
 /**
  * struct bio_vec - a contiguous range of physical memory addresses
diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index fed6ba96c527..5e13f801c902 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -3,8 +3,9 @@
 #define _LINUX_JIFFIES_H
 
 #include <linux/cache.h>
+#include <linux/limits.h>
 #include <linux/math64.h>
-#include <linux/kernel.h>
+#include <linux/minmax.h>
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/timex.h>
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 500def620d8f..397f66bef709 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -11,6 +11,7 @@
 #include <linux/compiler.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
+#include <linux/minmax.h>
 #include <linux/typecheck.h>
 #include <linux/printk.h>
 #include <linux/build_bug.h>
@@ -834,147 +835,6 @@ ftrace_vprintk(const char *fmt, va_list ap)
 static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
 #endif /* CONFIG_TRACING */
 
-/*
- * min()/max()/clamp() macros must accomplish three things:
- *
- * - avoid multiple evaluations of the arguments (so side-effects like
- *   "x++" happen only once) when non-constant.
- * - perform strict type-checking (to generate warnings instead of
- *   nasty runtime surprises). See the "unnecessary" pointer comparison
- *   in __typecheck().
- * - retain result as a constant expressions when called with only
- *   constant expressions (to avoid tripping VLA warnings in stack
- *   allocation usage).
- */
-#define __typecheck(x, y) \
-		(!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
-
-/*
- * This returns a constant expression while determining if an argument is
- * a constant expression, most importantly without evaluating the argument.
- * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
- */
-#define __is_constexpr(x) \
-	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
-
-#define __no_side_effects(x, y) \
-		(__is_constexpr(x) && __is_constexpr(y))
-
-#define __safe_cmp(x, y) \
-		(__typecheck(x, y) && __no_side_effects(x, y))
-
-#define __cmp(x, y, op)	((x) op (y) ? (x) : (y))
-
-#define __cmp_once(x, y, unique_x, unique_y, op) ({	\
-		typeof(x) unique_x = (x);		\
-		typeof(y) unique_y = (y);		\
-		__cmp(unique_x, unique_y, op); })
-
-#define __careful_cmp(x, y, op) \
-	__builtin_choose_expr(__safe_cmp(x, y), \
-		__cmp(x, y, op), \
-		__cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
-
-/**
- * min - return minimum of two values of the same or compatible types
- * @x: first value
- * @y: second value
- */
-#define min(x, y)	__careful_cmp(x, y, <)
-
-/**
- * max - return maximum of two values of the same or compatible types
- * @x: first value
- * @y: second value
- */
-#define max(x, y)	__careful_cmp(x, y, >)
-
-/**
- * min3 - return minimum of three values
- * @x: first value
- * @y: second value
- * @z: third value
- */
-#define min3(x, y, z) min((typeof(x))min(x, y), z)
-
-/**
- * max3 - return maximum of three values
- * @x: first value
- * @y: second value
- * @z: third value
- */
-#define max3(x, y, z) max((typeof(x))max(x, y), z)
-
-/**
- * min_not_zero - return the minimum that is _not_ zero, unless both are zero
- * @x: value1
- * @y: value2
- */
-#define min_not_zero(x, y) ({			\
-	typeof(x) __x = (x);			\
-	typeof(y) __y = (y);			\
-	__x == 0 ? __y : ((__y == 0) ? __x : min(__x, __y)); })
-
-/**
- * clamp - return a value clamped to a given range with strict typechecking
- * @val: current value
- * @lo: lowest allowable value
- * @hi: highest allowable value
- *
- * This macro does strict typechecking of @lo/@hi to make sure they are of the
- * same type as @val.  See the unnecessary pointer comparisons.
- */
-#define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
-
-/*
- * ..and if you can't take the strict
- * types, you can specify one yourself.
- *
- * Or not use min/max/clamp at all, of course.
- */
-
-/**
- * min_t - return minimum of two values, using the specified type
- * @type: data type to use
- * @x: first value
- * @y: second value
- */
-#define min_t(type, x, y)	__careful_cmp((type)(x), (type)(y), <)
-
-/**
- * max_t - return maximum of two values, using the specified type
- * @type: data type to use
- * @x: first value
- * @y: second value
- */
-#define max_t(type, x, y)	__careful_cmp((type)(x), (type)(y), >)
-
-/**
- * clamp_t - return a value clamped to a given range using a given type
- * @type: the type of variable to use
- * @val: current value
- * @lo: minimum allowable value
- * @hi: maximum allowable value
- *
- * This macro does no typechecking and uses temporary variables of type
- * @type to make all the comparisons.
- */
-#define clamp_t(type, val, lo, hi) min_t(type, max_t(type, val, lo), hi)
-
-/**
- * clamp_val - return a value clamped to a given range using val's type
- * @val: current value
- * @lo: minimum allowable value
- * @hi: maximum allowable value
- *
- * This macro does no typechecking and uses temporary variables of whatever
- * type the input argument @val is.  This is useful when @val is an unsigned
- * type and @lo and @hi are literals that will otherwise be assigned a signed
- * integer type.
- */
-#define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
-
-
 /**
  * swap - swap values of @a and @b
  * @a: first value
diff --git a/include/linux/minmax.h b/include/linux/minmax.h
new file mode 100644
index 000000000000..bfd6ad822914
--- /dev/null
+++ b/include/linux/minmax.h
@@ -0,0 +1,145 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MINMAX_H
+#define _LINUX_MINMAX_H
+
+/*
+ * min()/max()/clamp() macros must accomplish three things:
+ *
+ * - avoid multiple evaluations of the arguments (so side-effects like
+ *   "x++" happen only once) when non-constant.
+ * - perform strict type-checking (to generate warnings instead of
+ *   nasty runtime surprises). See the "unnecessary" pointer comparison
+ *   in __typecheck().
+ * - retain result as a constant expressions when called with only
+ *   constant expressions (to avoid tripping VLA warnings in stack
+ *   allocation usage).
+ */
+#define __typecheck(x, y) \
+	(!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
+
+/*
+ * This returns a constant expression while determining if an argument is
+ * a constant expression, most importantly without evaluating the argument.
+ * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
+ */
+#define __is_constexpr(x) \
+	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
+
+#define __no_side_effects(x, y) \
+		(__is_constexpr(x) && __is_constexpr(y))
+
+#define __safe_cmp(x, y) \
+		(__typecheck(x, y) && __no_side_effects(x, y))
+
+#define __cmp(x, y, op)	((x) op (y) ? (x) : (y))
+
+#define __cmp_once(x, y, unique_x, unique_y, op) ({	\
+		typeof(x) unique_x = (x);		\
+		typeof(y) unique_y = (y);		\
+		__cmp(unique_x, unique_y, op); })
+
+#define __careful_cmp(x, y, op) \
+	__builtin_choose_expr(__safe_cmp(x, y), \
+		__cmp(x, y, op), \
+		__cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
+
+/**
+ * min - return minimum of two values of the same or compatible types
+ * @x: first value
+ * @y: second value
+ */
+#define min(x, y)	__careful_cmp(x, y, <)
+
+/**
+ * max - return maximum of two values of the same or compatible types
+ * @x: first value
+ * @y: second value
+ */
+#define max(x, y)	__careful_cmp(x, y, >)
+
+/**
+ * min3 - return minimum of three values
+ * @x: first value
+ * @y: second value
+ * @z: third value
+ */
+#define min3(x, y, z) min((typeof(x))min(x, y), z)
+
+/**
+ * max3 - return maximum of three values
+ * @x: first value
+ * @y: second value
+ * @z: third value
+ */
+#define max3(x, y, z) max((typeof(x))max(x, y), z)
+
+/**
+ * min_not_zero - return the minimum that is _not_ zero, unless both are zero
+ * @x: value1
+ * @y: value2
+ */
+#define min_not_zero(x, y) ({			\
+	typeof(x) __x = (x);			\
+	typeof(y) __y = (y);			\
+	__x == 0 ? __y : ((__y == 0) ? __x : min(__x, __y)); })
+
+/**
+ * clamp - return a value clamped to a given range with strict typechecking
+ * @val: current value
+ * @lo: lowest allowable value
+ * @hi: highest allowable value
+ *
+ * This macro does strict typechecking of @lo/@hi to make sure they are of the
+ * same type as @val.  See the unnecessary pointer comparisons.
+ */
+#define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
+
+/*
+ * ..and if you can't take the strict
+ * types, you can specify one yourself.
+ *
+ * Or not use min/max/clamp at all, of course.
+ */
+
+/**
+ * min_t - return minimum of two values, using the specified type
+ * @type: data type to use
+ * @x: first value
+ * @y: second value
+ */
+#define min_t(type, x, y)	__careful_cmp((type)(x), (type)(y), <)
+
+/**
+ * max_t - return maximum of two values, using the specified type
+ * @type: data type to use
+ * @x: first value
+ * @y: second value
+ */
+#define max_t(type, x, y)	__careful_cmp((type)(x), (type)(y), >)
+
+/**
+ * clamp_t - return a value clamped to a given range using a given type
+ * @type: the type of variable to use
+ * @val: current value
+ * @lo: minimum allowable value
+ * @hi: maximum allowable value
+ *
+ * This macro does no typechecking and uses temporary variables of type
+ * @type to make all the comparisons.
+ */
+#define clamp_t(type, val, lo, hi) min_t(type, max_t(type, val, lo), hi)
+
+/**
+ * clamp_val - return a value clamped to a given range using val's type
+ * @val: current value
+ * @lo: minimum allowable value
+ * @hi: maximum allowable value
+ *
+ * This macro does no typechecking and uses temporary variables of whatever
+ * type the input argument @val is.  This is useful when @val is an unsigned
+ * type and @lo and @hi are literals that will otherwise be assigned a signed
+ * integer type.
+ */
+#define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
+
+#endif	/* _LINUX_MINMAX_H */
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 27e7fa36f707..7f38399cc9fe 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -90,9 +90,9 @@
  * for such situations. See below and CPUMASK_ALLOC also.
  */
 
-#include <linux/kernel.h>
 #include <linux/threads.h>
 #include <linux/bitmap.h>
+#include <linux/minmax.h>
 #include <linux/numa.h>
 
 typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index ec980bbb786a..6d21d1d87a41 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -3,6 +3,7 @@
 #define __LINUX_UACCESS_H__
 
 #include <linux/instrumented.h>
+#include <linux/minmax.h>
 #include <linux/sched.h>
 #include <linux/thread_info.h>
 
diff --git a/kernel/range.c b/kernel/range.c
index d84de6766472..56435f96da73 100644
--- a/kernel/range.c
+++ b/kernel/range.c
@@ -2,8 +2,9 @@
 /*
  * Range add and subtract
  */
-#include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/minmax.h>
+#include <linux/printk.h>
 #include <linux/sort.h>
 #include <linux/string.h>
 #include <linux/range.h>
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 49f875f1baf7..4a8751010d59 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -16,6 +16,7 @@
 #include <linux/bitmap.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
+#include <linux/minmax.h>
 
 #if !defined(find_next_bit) || !defined(find_next_zero_bit) ||			\
 	!defined(find_next_bit_le) || !defined(find_next_zero_bit_le) ||	\
diff --git a/lib/hexdump.c b/lib/hexdump.c
index 147133f8eb2f..9301578f98e8 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -7,6 +7,7 @@
 #include <linux/ctype.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/minmax.h>
 #include <linux/export.h>
 #include <asm/unaligned.h>
 
diff --git a/lib/math/rational.c b/lib/math/rational.c
index df75c8809693..9781d521963d 100644
--- a/lib/math/rational.c
+++ b/lib/math/rational.c
@@ -11,7 +11,7 @@
 #include <linux/rational.h>
 #include <linux/compiler.h>
 #include <linux/export.h>
-#include <linux/kernel.h>
+#include <linux/minmax.h>
 
 /*
  * calculate best rational approximation for a given fraction
diff --git a/lib/math/reciprocal_div.c b/lib/math/reciprocal_div.c
index bf043258fa00..32436dd4171e 100644
--- a/lib/math/reciprocal_div.c
+++ b/lib/math/reciprocal_div.c
@@ -4,6 +4,7 @@
 #include <asm/div64.h>
 #include <linux/reciprocal_div.h>
 #include <linux/export.h>
+#include <linux/minmax.h>
 
 /*
  * For a description of the algorithm please have a look at
-- 
2.28.0

