Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E84C42E74D
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Oct 2021 05:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhJODka (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Oct 2021 23:40:30 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:44311 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234139AbhJODk1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Oct 2021 23:40:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Us2dp9w_1634269099;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Us2dp9w_1634269099)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Oct 2021 11:38:19 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        lenb@kernel.org, rjw@rjwysocki.net
Cc:     xueshuai@linux.alibaba.com, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Subject: [PATCH] ACPI, APEI, EINJ: Relax platform response timeout to 1 second.
Date:   Fri, 15 Oct 2021 11:38:17 +0800
Message-Id: <20211015033817.16719-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When injecting an error into the platform, the OSPM executes an
EXECUTE_OPERATION action to instruct the platform to begin the injection
operation. And then, the OSPM busy waits for a while by continually
executing CHECK_BUSY_STATUS action until the platform indicates that the
operation is complete. More specifically, the platform is limited to
respond within 1 millisecond right now. This is too strict for some
platforms.

For example, in Arm platfrom, when injecting a Processor Correctable error,
the OSPM will warn:
    Firmware does not respond in time.

And a message is printed on the console:
    echo: write error: Input/output error

We observe that the waiting time for DDR error injection is about 10 ms
and that for PCIe error injection is about 500 ms in Arm platfrom.

In this patch, we relax the response timeout to 1 second and allow user to
pass the time out value as a argument.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/einj.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 133156759551..fa2386ee37db 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -14,6 +14,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/debugfs.h>
@@ -28,9 +29,9 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "EINJ: " fmt
 
-#define SPIN_UNIT		100			/* 100ns */
-/* Firmware should respond within 1 milliseconds */
-#define FIRMWARE_TIMEOUT	(1 * NSEC_PER_MSEC)
+#define SPIN_UNIT		100			/* 100us */
+/* Firmware should respond within 1 seconds */
+#define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
 #define ACPI5_VENDOR_BIT	BIT(31)
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
 				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
@@ -40,6 +41,8 @@
  * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
  */
 static int acpi5;
+static int timeout_default = FIRMWARE_TIMEOUT;
+module_param(timeout_default, int, 0644);
 
 struct set_error_type_with_address {
 	u32	type;
@@ -176,7 +179,7 @@ static int einj_timedout(u64 *t)
 		return 1;
 	}
 	*t -= SPIN_UNIT;
-	ndelay(SPIN_UNIT);
+	udelay(SPIN_UNIT);
 	touch_nmi_watchdog();
 	return 0;
 }
@@ -403,7 +406,7 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			       u64 param3, u64 param4)
 {
 	struct apei_exec_context ctx;
-	u64 val, trigger_paddr, timeout = FIRMWARE_TIMEOUT;
+	u64 val, trigger_paddr, timeout = timeout_default;
 	int rc;
 
 	einj_exec_ctx_init(&ctx);
-- 
2.20.1.12.g72788fdb

