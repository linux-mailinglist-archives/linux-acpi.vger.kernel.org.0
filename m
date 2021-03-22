Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E025343EA7
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Mar 2021 11:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhCVK6e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Mar 2021 06:58:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230448AbhCVK6J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Mar 2021 06:58:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1D9761931;
        Mon, 22 Mar 2021 10:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616410689;
        bh=D6etE+5ZjccFIlpT9IufI3R6p4hC1yihNdzOnUUrLqw=;
        h=From:To:Cc:Subject:Date:From;
        b=hbXWGIPHRU2BW1goVDukx98kZO8FW1mDVOBE3/yG9MRxnbfIAVtOODvl4/k8QZAxx
         0602wWOjw4SlM3OBt/97z/8pSm9fpfr6zdmluYPTi9zUrRctqGgIaD7o1plV+nQuUj
         X+u6ix8IxvsnzmGBik3hdWRSir/uspc2vhlJi/5StLYP2Gg0W+P6qK4lww4GMYhJLl
         9fZhVBqQ4ZDtKTLYmOSuFPc2IzgVIgAKezhhgsPI50c3s8W49TlojM0CNw5mIhEO5F
         Hatm0HRZHGx1pLi+6tAonS3cGk+2nNKI0VwQ7dIw6HAagK3/10zC52dTlSzk7yyCon
         cK8ox7ZRKcn/w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org
Subject: [PATCH] acpi: avoid -Wempty-body warnings
Date:   Mon, 22 Mar 2021 11:58:00 +0100
Message-Id: <20210322105805.1498602-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The acpi drivers produce a number of avoidable warnings for empty macros
when building with 'make W=1':

drivers/acpi/acpi_processor.c: In function 'acpi_processor_errata_piix4':
drivers/acpi/acpi_processor.c:133:95: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  133 |                                   "Bus master activity detection (BM-IDE) erratum enabled\n"));
      |                                                                                               ^
drivers/acpi/acpi_processor.c:136:82: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  136 |                                   "Type-F DMA livelock erratum (C3 disabled)\n"));
      |                                                                                  ^
drivers/acpi/acpi_processor.c: In function 'acpi_processor_get_info':
drivers/acpi/acpi_processor.c:251:77: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]
  251 |                                   "No bus mastering arbitration control\n"));
      |                                                                             ^
drivers/acpi/processor_pdc.c: In function 'acpi_processor_eval_pdc':
drivers/acpi/processor_pdc.c:136:79: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  136 |                     "Could not evaluate _PDC, using legacy perf. control.\n"));
      |                                                                               ^

I tried making these call no_printk() instead, which would add proper
format string checking, but that turned out to be a rather invasive
change, so just shut up the warning by turning the macros into empty
"do {} while (0)" statements.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/acpi/acoutput.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index 1538a6853822..b5484ef31f27 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -433,23 +433,23 @@
  * This is the non-debug case -- make everything go away,
  * leaving no executable debug code!
  */
-#define ACPI_DEBUG_PRINT(pl)
-#define ACPI_DEBUG_PRINT_RAW(pl)
-#define ACPI_DEBUG_EXEC(a)
-#define ACPI_DEBUG_ONLY_MEMBERS(a)
-#define ACPI_FUNCTION_NAME(a)
-#define ACPI_FUNCTION_TRACE(a)
-#define ACPI_FUNCTION_TRACE_PTR(a, b)
-#define ACPI_FUNCTION_TRACE_U32(a, b)
-#define ACPI_FUNCTION_TRACE_STR(a, b)
-#define ACPI_FUNCTION_ENTRY()
-#define ACPI_DUMP_STACK_ENTRY(a)
-#define ACPI_DUMP_OPERANDS(a, b, c)
-#define ACPI_DUMP_ENTRY(a, b)
-#define ACPI_DUMP_PATHNAME(a, b, c, d)
-#define ACPI_DUMP_BUFFER(a, b)
+#define ACPI_DEBUG_PRINT(pl)			do { } while (0)
+#define ACPI_DEBUG_PRINT_RAW(pl)		do { } while (0)
+#define ACPI_DEBUG_EXEC(a)			do { } while (0)
+#define ACPI_DEBUG_ONLY_MEMBERS(a)		do { } while (0)
+#define ACPI_FUNCTION_NAME(a)			do { } while (0)
+#define ACPI_FUNCTION_TRACE(a)			do { } while (0)
+#define ACPI_FUNCTION_TRACE_PTR(a, b)		do { } while (0)
+#define ACPI_FUNCTION_TRACE_U32(a, b)		do { } while (0)
+#define ACPI_FUNCTION_TRACE_STR(a, b)		do { } while (0)
+#define ACPI_FUNCTION_ENTRY()			do { } while (0)
+#define ACPI_DUMP_STACK_ENTRY(a)		do { } while (0)
+#define ACPI_DUMP_OPERANDS(a, b, c)		do { } while (0)
+#define ACPI_DUMP_ENTRY(a, b)			do { } while (0)
+#define ACPI_DUMP_PATHNAME(a, b, c, d)		do { } while (0)
+#define ACPI_DUMP_BUFFER(a, b)			do { } while (0)
 #define ACPI_IS_DEBUG_ENABLED(level, component) 0
-#define ACPI_TRACE_POINT(a, b, c, d)
+#define ACPI_TRACE_POINT(a, b, c, d)		do { } while (0)
 
 /* Return macros must have a return statement at the minimum */
 
-- 
2.29.2

