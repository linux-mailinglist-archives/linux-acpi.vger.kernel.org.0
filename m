Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3390B3DCD99
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Aug 2021 22:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhHAUN7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 1 Aug 2021 16:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhHAUN7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Aug 2021 16:13:59 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B23C06175F;
        Sun,  1 Aug 2021 13:13:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n12so18931344wrr.2;
        Sun, 01 Aug 2021 13:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6UsZEGBOLakzJAyCg9/iQJGqy8ou9ZzeSxHVSWLErR4=;
        b=nGYdB7kNDjk7qAx8v2jQf2mbeeA4hfCO0gYm7Sp/tMjp/B7X3U6i0fYZdtUpwIwp8c
         6GBfA1VQKz+7CTkzfKkXTX6LspwDx0GaYEYeT6poplthv7ovpVMtnz3+uaMlcZG5VviF
         s8j5CsZ9QkfpjEGXpeVB9KWL80zUSmhqw0Zi3mJxl/QCl+tbcRXXONAeMXuRC5ufYlXO
         g7pdM4OPkA2MEWyY7qQunvRpTAvH83pe/6/Eh4as7O9Uhyy2OxZD8NpQWV+cYQksLTza
         eP5MV0V41rRMk3WQUVJyRlGy0tArORSN1p3FuXe0MAtfy1G6riUaSoN4tQgxbgBBErut
         NMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6UsZEGBOLakzJAyCg9/iQJGqy8ou9ZzeSxHVSWLErR4=;
        b=lRa4OXuITyjR7cXxU286G8+n2hyEkVm9jwvBsUj3eM3BDP3OMqIRUhx3wo2SXiB2cn
         1aydxBe4YIBC88Mdmu9FncOea7otqHbobLg2OdvIFppqbN0LK/HwlYct2W85S4g9SXf1
         YzLAp1CLfJYJnBLNQ9ZKDUYKb1U75jougvC6KuNLvxtFFJav9ZtpB7blbDMvPy1CnXDP
         EBNmGu7ybTfXig/KBij2ehgA0L4MdUxjH/kUWPvt/g4HmAU4+1Q4wVglfoDaTsK0Yu3/
         FRQdBIzGee/kcJHgzjHZAlVpaCts6P4QWWxqi5QzyeKkWUMMX1SgJYttsEsXRZIYYs++
         VPTA==
X-Gm-Message-State: AOAM531AW/YzLXlwCtcDJuroh8MYz7aFq4y/YWx3ju/we1LcUSw0Yo/o
        K8heHzTotwrXFsYV/VVncA==
X-Google-Smtp-Source: ABdhPJy+w69VW+gpVhkhA1SjkNRwPLmrZ/k7LlDQcjeu4xvzfyJTxUnCabZjgYf1bFUo1wYS/599+A==
X-Received: by 2002:adf:cd86:: with SMTP id q6mr13794232wrj.422.1627848829259;
        Sun, 01 Aug 2021 13:13:49 -0700 (PDT)
Received: from localhost.localdomain ([46.53.252.172])
        by smtp.gmail.com with ESMTPSA id k6sm8738686wrm.10.2021.08.01.13.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 13:13:49 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        masahiroy@kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: [PATCH 2/3] isystem: ship and use stdarg.h
Date:   Sun,  1 Aug 2021 23:13:35 +0300
Message-Id: <20210801201336.2224111-2-adobriyan@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210801201336.2224111-1-adobriyan@gmail.com>
References: <20210801201336.2224111-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Ship minimal stdarg.h (1 type, 4 macros) as <linux/stdarg.h>.
stdarg.h is the only userspace header commonly used in the kernel.

GPL 2 version of <stdarg.h> can be extracted from
http://archive.debian.org/debian/pool/main/g/gcc-4.2/gcc-4.2_4.2.4.orig.tar.gz

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 arch/parisc/kernel/firmware.c                         |  2 +-
 arch/powerpc/kernel/prom_init.c                       |  2 +-
 arch/powerpc/kernel/rtas.c                            |  2 +-
 arch/powerpc/kernel/udbg.c                            |  2 +-
 arch/s390/boot/pgm_check_info.c                       |  2 +-
 arch/x86/boot/boot.h                                  |  2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c        |  2 +-
 drivers/firmware/efi/libstub/vsprintf.c               |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c            |  2 +-
 drivers/gpu/drm/drm_print.c                           |  2 +-
 drivers/isdn/capi/capiutil.c                          |  2 +-
 drivers/macintosh/via-cuda.c                          |  2 +-
 drivers/macintosh/via-pmu.c                           |  2 +-
 .../atomisp/pci/hive_isp_css_include/print_support.h  |  2 +-
 drivers/staging/media/atomisp/pci/ia_css_env.h        |  2 +-
 .../pci/runtime/debug/interface/ia_css_debug.h        |  2 +-
 drivers/staging/media/atomisp/pci/sh_css_internal.h   |  2 +-
 fs/befs/debug.c                                       |  2 +-
 fs/reiserfs/prints.c                                  |  2 +-
 fs/ufs/super.c                                        |  2 +-
 include/acpi/platform/acgcc.h                         |  2 +-
 include/linux/kernel.h                                |  2 +-
 include/linux/printk.h                                |  2 +-
 include/linux/stdarg.h                                | 11 +++++++++++
 include/linux/string.h                                |  2 +-
 lib/debug_info.c                                      |  3 +--
 lib/kasprintf.c                                       |  2 +-
 lib/kunit/string-stream.h                             |  2 +-
 lib/vsprintf.c                                        |  2 +-
 mm/kfence/report.c                                    |  2 +-
 net/batman-adv/log.c                                  |  2 +-
 31 files changed, 41 insertions(+), 31 deletions(-)
 create mode 100644 include/linux/stdarg.h

diff --git a/arch/parisc/kernel/firmware.c b/arch/parisc/kernel/firmware.c
index 665b70086685..7034227dbdf3 100644
--- a/arch/parisc/kernel/firmware.c
+++ b/arch/parisc/kernel/firmware.c
@@ -51,7 +51,7 @@
  *					prumpf	991016	
  */
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 #include <linux/delay.h>
 #include <linux/init.h>
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index a5bf355ce1d6..10664633f7e3 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -14,7 +14,7 @@
 /* we cannot use FORTIFY as it brings in new symbols */
 #define __NO_FORTIFY
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/init.h>
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 99f2cce635fb..ff80bbad22a5 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -7,7 +7,7 @@
  * Copyright (C) 2001 IBM.
  */
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/spinlock.h>
diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index 01595e8cafe7..b1544b2f6321 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -5,7 +5,7 @@
  * c 2001 PPC 64 Team, IBM Corp
  */
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/console.h>
diff --git a/arch/s390/boot/pgm_check_info.c b/arch/s390/boot/pgm_check_info.c
index 3a46abed2549..b7d8dd88bbf2 100644
--- a/arch/s390/boot/pgm_check_info.c
+++ b/arch/s390/boot/pgm_check_info.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
+#include <linux/stdarg.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <asm/stacktrace.h>
@@ -8,7 +9,6 @@
 #include <asm/setup.h>
 #include <asm/sclp.h>
 #include <asm/uv.h>
-#include <stdarg.h>
 #include "boot.h"
 
 const char hex_asc[] = "0123456789abcdef";
diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index ca866f1cca2e..34c9dbb6a47d 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -18,7 +18,7 @@
 
 #ifndef __ASSEMBLY__
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/types.h>
 #include <linux/edd.h>
 #include <asm/setup.h>
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index ae87dded989d..d489bdc645fe 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -7,7 +7,7 @@
  * Copyright 2011 Intel Corporation; author Matt Fleming
  */
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 #include <linux/ctype.h>
 #include <linux/efi.h>
diff --git a/drivers/firmware/efi/libstub/vsprintf.c b/drivers/firmware/efi/libstub/vsprintf.c
index 1088e288c04d..71c71c222346 100644
--- a/drivers/firmware/efi/libstub/vsprintf.c
+++ b/drivers/firmware/efi/libstub/vsprintf.c
@@ -10,7 +10,7 @@
  * Oh, it's a waste of space, but oh-so-yummy for debugging.
  */
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 #include <linux/compiler.h>
 #include <linux/ctype.h>
diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
index a612ba6dc389..ab6bc5d79012 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -28,9 +28,9 @@
  */
 
 #include <linux/delay.h>
+#include <linux/stdarg.h>
 
 #include "dm_services.h"
-#include <stdarg.h>
 
 #include "dc.h"
 #include "dc_dmub_srv.h"
diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 111b932cf2a9..f783d4963d4b 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -25,7 +25,7 @@
 
 #define DEBUG /* for pr_debug() */
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 #include <linux/io.h>
 #include <linux/moduleparam.h>
diff --git a/drivers/isdn/capi/capiutil.c b/drivers/isdn/capi/capiutil.c
index f26bf3c66d7e..d7ae42edc4a8 100644
--- a/drivers/isdn/capi/capiutil.c
+++ b/drivers/isdn/capi/capiutil.c
@@ -379,7 +379,7 @@ static char *pnames[] =
 	/*2f */ "Useruserdata"
 };
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 /*-------------------------------------------------------*/
 static _cdebbuf *bufprint(_cdebbuf *cdb, char *fmt, ...)
diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index 3581abfb0c6a..cd267392289c 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -9,7 +9,7 @@
  *
  * Copyright (C) 1996 Paul Mackerras.
  */
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 4bdd4c45e7a7..4b98bc26a94b 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -18,7 +18,7 @@
  *    a sleep or a freq. switch
  *
  */
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 #include <linux/errno.h>
diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_include/print_support.h b/drivers/staging/media/atomisp/pci/hive_isp_css_include/print_support.h
index 540b405cc0f7..a3c7f3de6d17 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_include/print_support.h
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_include/print_support.h
@@ -16,7 +16,7 @@
 #ifndef __PRINT_SUPPORT_H_INCLUDED__
 #define __PRINT_SUPPORT_H_INCLUDED__
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 extern int (*sh_css_printf)(const char *fmt, va_list args);
 /* depends on host supplied print function in ia_css_init() */
diff --git a/drivers/staging/media/atomisp/pci/ia_css_env.h b/drivers/staging/media/atomisp/pci/ia_css_env.h
index 6b38723b27cd..3b89bbd837a0 100644
--- a/drivers/staging/media/atomisp/pci/ia_css_env.h
+++ b/drivers/staging/media/atomisp/pci/ia_css_env.h
@@ -17,7 +17,7 @@
 #define __IA_CSS_ENV_H
 
 #include <type_support.h>
-#include <stdarg.h> /* va_list */
+#include <linux/stdarg.h> /* va_list */
 #include "ia_css_types.h"
 #include "ia_css_acc_types.h"
 
diff --git a/drivers/staging/media/atomisp/pci/runtime/debug/interface/ia_css_debug.h b/drivers/staging/media/atomisp/pci/runtime/debug/interface/ia_css_debug.h
index 5e6e7447ae00..e37ef4232c55 100644
--- a/drivers/staging/media/atomisp/pci/runtime/debug/interface/ia_css_debug.h
+++ b/drivers/staging/media/atomisp/pci/runtime/debug/interface/ia_css_debug.h
@@ -19,7 +19,7 @@
 /*! \file */
 
 #include <type_support.h>
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include "ia_css_types.h"
 #include "ia_css_binary.h"
 #include "ia_css_frame_public.h"
diff --git a/drivers/staging/media/atomisp/pci/sh_css_internal.h b/drivers/staging/media/atomisp/pci/sh_css_internal.h
index 3c669ec79b68..496faa7297a5 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_internal.h
+++ b/drivers/staging/media/atomisp/pci/sh_css_internal.h
@@ -20,7 +20,7 @@
 #include <math_support.h>
 #include <type_support.h>
 #include <platform_support.h>
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 #if !defined(ISP2401)
 #include "input_formatter.h"
diff --git a/fs/befs/debug.c b/fs/befs/debug.c
index eb7bd6c692c7..02fa66fb82c2 100644
--- a/fs/befs/debug.c
+++ b/fs/befs/debug.c
@@ -14,7 +14,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #ifdef __KERNEL__
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/string.h>
 #include <linux/spinlock.h>
 #include <linux/kernel.h>
diff --git a/fs/reiserfs/prints.c b/fs/reiserfs/prints.c
index 500f2000eb41..30319dc33c18 100644
--- a/fs/reiserfs/prints.c
+++ b/fs/reiserfs/prints.c
@@ -8,7 +8,7 @@
 #include <linux/string.h>
 #include <linux/buffer_head.h>
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 static char error_buf[1024];
 static char fmt_buf[1024];
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 74028b5a7b0a..00a01471ea05 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -70,7 +70,7 @@
 #include <linux/module.h>
 #include <linux/bitops.h>
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 #include <linux/uaccess.h>
 
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index f6656be81760..fb172a03a753 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -22,7 +22,7 @@ typedef __builtin_va_list va_list;
 #define va_arg(v, l)            __builtin_va_arg(v, l)
 #define va_copy(d, s)           __builtin_va_copy(d, s)
 #else
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #endif
 #endif
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 1b2f0a7e00d6..2776423a587e 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_KERNEL_H
 #define _LINUX_KERNEL_H
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/align.h>
 #include <linux/limits.h>
 #include <linux/linkage.h>
diff --git a/include/linux/printk.h b/include/linux/printk.h
index e834d78f0478..9f3f29ea348e 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -2,7 +2,7 @@
 #ifndef __KERNEL_PRINTK__
 #define __KERNEL_PRINTK__
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/init.h>
 #include <linux/kern_levels.h>
 #include <linux/linkage.h>
diff --git a/include/linux/stdarg.h b/include/linux/stdarg.h
new file mode 100644
index 000000000000..c8dc7f4f390c
--- /dev/null
+++ b/include/linux/stdarg.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#ifndef _LINUX_STDARG_H
+#define _LINUX_STDARG_H
+
+typedef __builtin_va_list va_list;
+#define va_start(v, l)	__builtin_va_start(v, l)
+#define va_end(v)	__builtin_va_end(v)
+#define va_arg(v, T)	__builtin_va_arg(v, T)
+#define va_copy(d, s)	__builtin_va_copy(d, s)
+
+#endif
diff --git a/include/linux/string.h b/include/linux/string.h
index b48d2d28e0b1..5e96d656be7a 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -6,7 +6,7 @@
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
 #include <linux/errno.h>	/* for E2BIG */
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <uapi/linux/string.h>
 
 extern char *strndup_user(const char __user *, long);
diff --git a/lib/debug_info.c b/lib/debug_info.c
index 36daf753293c..cc4723c74af5 100644
--- a/lib/debug_info.c
+++ b/lib/debug_info.c
@@ -5,8 +5,6 @@
  * CONFIG_DEBUG_INFO_REDUCED. Please do not add actual code. However,
  * adding appropriate #includes is fine.
  */
-#include <stdarg.h>
-
 #include <linux/cred.h>
 #include <linux/crypto.h>
 #include <linux/dcache.h>
@@ -22,6 +20,7 @@
 #include <linux/net.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/stdarg.h>
 #include <linux/types.h>
 #include <net/addrconf.h>
 #include <net/sock.h>
diff --git a/lib/kasprintf.c b/lib/kasprintf.c
index bacf7b83ccf0..cd2f5974ed98 100644
--- a/lib/kasprintf.c
+++ b/lib/kasprintf.c
@@ -5,7 +5,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/types.h>
diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
index 5e94b623454f..43f9508a55b4 100644
--- a/lib/kunit/string-stream.h
+++ b/lib/kunit/string-stream.h
@@ -11,7 +11,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/types.h>
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 struct string_stream_fragment {
 	struct kunit *test;
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 26c83943748a..3bcb7be03f93 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -17,7 +17,7 @@
  * - scnprintf and vscnprintf
  */
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/build_bug.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index 2a319c21c939..4b891dd75650 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2020, Google LLC.
  */
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 #include <linux/kernel.h>
 #include <linux/lockdep.h>
diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index f0e5d1429662..7a93a1e94c40 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -7,7 +7,7 @@
 #include "log.h"
 #include "main.h"
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 #include "trace.h"
 
-- 
2.31.1

