Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FDB42376E
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Oct 2021 07:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhJFFPc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Oct 2021 01:15:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:63177 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhJFFPb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 6 Oct 2021 01:15:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="225810866"
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="225810866"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 22:13:39 -0700
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="623711886"
Received: from magonza1-mobl.amr.corp.intel.com (HELO mbernalm-mobl.luna.faberale.com) ([10.252.250.120])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 22:13:38 -0700
From:   Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>
To:     Rafael J Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH] ACPI: tools: fix compilation error
Date:   Wed,  6 Oct 2021 00:13:18 -0500
Message-Id: <20211006051318.117094-1-miguel.bernal.marin@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When acpi tools are compiled the following error is showed:

   $ cd tools/power/acpi
   $ make
     DESCEND tools/acpidbg
     MKDIR    include
     CP       include
     CC       tools/acpidbg/acpidbg.o
   In file included from /home/linux/tools/power/acpi/include/acpi/platform/acenv.h:152,
                    from /home/linux/tools/power/acpi/include/acpi/acpi.h:22,
                    from acpidbg.c:9:
   /home/linux/tools/power/acpi/include/acpi/platform/acgcc.h:25:10: fatal error: linux/stdarg.h: No such file or directory
      29 | #include <linux/stdarg.h>
         |          ^~~~~~~~~~~~~~~~
   compilation terminated.

Keep the same logic from ACPICA, just identify when is used inside kernel
or by acpi tool.

Fixes: c0891ac15f04 ("isystem: ship and use stdarg.h")
Signed-off-by: Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>
---
 include/acpi/platform/acgcc.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index fb172a03a753..20ecb004f5a4 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -22,9 +22,14 @@ typedef __builtin_va_list va_list;
 #define va_arg(v, l)            __builtin_va_arg(v, l)
 #define va_copy(d, s)           __builtin_va_copy(d, s)
 #else
+#ifdef __KERNEL__
 #include <linux/stdarg.h>
-#endif
-#endif
+#else
+/* Used to build acpi tools */
+#include <stdarg.h>
+#endif /* __KERNEL__ */
+#endif /* ACPI_USE_BUILTIN_STDARG */
+#endif /* ! va_arg */

 #define ACPI_INLINE             __inline__

--
2.31.1

