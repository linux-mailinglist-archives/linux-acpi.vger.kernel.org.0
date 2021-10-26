Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4268943AD31
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 09:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhJZHa7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 03:30:59 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:49375 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229540AbhJZHa6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 03:30:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Utl7RCh_1635233311;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Utl7RCh_1635233311)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Oct 2021 15:28:32 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        lenb@kernel.org, rjw@rjwysocki.net
Cc:     xueshuai@linux.alibaba.com, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Subject: [PATCH v3] ACPI, APEI, EINJ: Relax platform response timeout to 1 second.
Date:   Tue, 26 Oct 2021 15:28:29 +0800
Message-Id: <20211026072829.94262-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20211015033817.16719-1-xueshuai@linux.alibaba.com>
References: <20211015033817.16719-1-xueshuai@linux.alibaba.com>
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

For example, in Arm platform, when injecting a Processor Correctable error,
the OSPM will warn:
    Firmware does not respond in time.

And a message is printed on the console:
    echo: write error: Input/output error

We observe that the waiting time for DDR error injection is about 10 ms and
that for PCIe error injection is about 500 ms in Arm platform.

In this patch, we relax the response timeout to 1 second.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
Changelog v2 -> v3:
- Implemented the timeout in usleep_range instead of msleep.
- Dropped command line interface of timeout.
- Link to the v1 patch: https://lkml.org/lkml/2021/10/14/1402
---
 drivers/acpi/apei/einj.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 133156759551..6e1ff4b62a8f 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -28,9 +28,10 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "EINJ: " fmt
 
-#define SPIN_UNIT		100			/* 100ns */
-/* Firmware should respond within 1 milliseconds */
-#define FIRMWARE_TIMEOUT	(1 * NSEC_PER_MSEC)
+#define SLEEP_UNIT_MIN		1000			/* 1ms */
+#define SLEEP_UNIT_MAX		5000			/* 5ms */
+/* Firmware should respond within 1 seconds */
+#define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
 #define ACPI5_VENDOR_BIT	BIT(31)
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
 				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
@@ -171,13 +172,13 @@ static int einj_get_available_error_type(u32 *type)
 
 static int einj_timedout(u64 *t)
 {
-	if ((s64)*t < SPIN_UNIT) {
+	if ((s64)*t < SLEEP_UNIT_MIN) {
 		pr_warn(FW_WARN "Firmware does not respond in time\n");
 		return 1;
 	}
-	*t -= SPIN_UNIT;
-	ndelay(SPIN_UNIT);
-	touch_nmi_watchdog();
+	*t -= SLEEP_UNIT_MIN;
+	usleep_range(SLEEP_UNIT_MIN, SLEEP_UNIT_MAX);
+
 	return 0;
 }
 
-- 
2.20.1.12.g72788fdb

