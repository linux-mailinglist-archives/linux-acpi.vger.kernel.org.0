Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCC92D5D81
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Dec 2020 15:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389941AbgLJOX4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Dec 2020 09:23:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:57660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389923AbgLJOXt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Dec 2020 09:23:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607610183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cI2dIHenqZhZfuz+AUEF2/qcGKhgN5TrogEWAPJ0ubE=;
        b=NQjW7t36xxYUr0eeZgcnyS+0nqRGiiCMrYI00xc0oWzdyr2kxmzcvH4AWoVdETVUxENfgk
        tBogUClmqow860HxIPKyWu5SnZTI7zXz5RjzZtclEokE7T8XMRro+Gmu2tiRlX/+PRLVkm
        kyv/tRuai+e85hjcuFn9nzzPNt03S70=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 72F52AEC3;
        Thu, 10 Dec 2020 14:23:03 +0000 (UTC)
From:   Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org,
        ionela.voinescu@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH 2/2] cpufreq: cppc: convert to a platform driver
Date:   Thu, 10 Dec 2020 15:21:39 +0100
Message-Id: <20201210142139.20490-2-yousaf.kaukab@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201210142139.20490-1-yousaf.kaukab@suse.com>
References: <20201210142139.20490-1-yousaf.kaukab@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Mian Yousaf Kaukab <ykaukab@suse.de>

Instead of piggybacking on ACPI_PROCESSOR_DEVICE_HID, convert the driver
to a proper platform driver with its own ID. Driver will only be probed
when cppc-cpufreq device is available.

Fixes: 28f06f770454 ("cppc_cpufreq: replace per-cpu structures with lists")
Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 drivers/cpufreq/cppc_cpufreq.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index bb4c068601db..defac1dd9a2a 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -11,13 +11,13 @@
 #define pr_fmt(fmt)	"CPPC Cpufreq:"	fmt
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/dmi.h>
 #include <linux/time.h>
 #include <linux/vmalloc.h>
+#include <linux/platform_device.h>
 
 #include <asm/unaligned.h>
 
@@ -512,7 +512,7 @@ static void cppc_check_hisi_workaround(void)
 	acpi_put_table(tbl);
 }
 
-static int __init cppc_cpufreq_init(void)
+static int cppc_cpufreq_probe(struct platform_device *pdev)
 {
 	if (acpi_disabled)
 		return -ENODEV;
@@ -533,26 +533,27 @@ static inline void free_cpu_data(void)
 		list_del(&iter->node);
 		kfree(iter);
 	}
-
 }
 
-static void __exit cppc_cpufreq_exit(void)
+static int cppc_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&cppc_cpufreq_driver);
 
 	free_cpu_data();
+
+	return 0;
 }
 
-module_exit(cppc_cpufreq_exit);
+static struct platform_driver cppc_cpufreq_platform_driver = {
+	.driver = {
+		.name = "cppc-cpufreq",
+	},
+	.probe = cppc_cpufreq_probe,
+	.remove = cppc_cpufreq_remove,
+};
+module_platform_driver(cppc_cpufreq_platform_driver);
+
+MODULE_ALIAS("platform:cppc-cpufreq");
 MODULE_AUTHOR("Ashwin Chaugule");
 MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");
 MODULE_LICENSE("GPL");
-
-late_initcall(cppc_cpufreq_init);
-
-static const struct acpi_device_id cppc_acpi_ids[] __used = {
-	{ACPI_PROCESSOR_DEVICE_HID, },
-	{}
-};
-
-MODULE_DEVICE_TABLE(acpi, cppc_acpi_ids);
-- 
2.26.2

