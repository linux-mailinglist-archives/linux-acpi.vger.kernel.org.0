Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968833984F6
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 11:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhFBJIo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 05:08:44 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2958 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhFBJIl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 05:08:41 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw33w3LHJz694X;
        Wed,  2 Jun 2021 17:03:56 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:46 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:46 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 17/18] ACPI: sleep: Unify the message printing
Date:   Wed, 2 Jun 2021 16:54:39 +0800
Message-ID: <1622624080-56025-18-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1622624080-56025-1-git-send-email-guohanjun@huawei.com>
References: <1622624080-56025-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Intoduce pr_fmt() and use pr_*() macros to replace printk(), also
remove all the PREFIX for pr_*() calls to generate a unified format
string for prefix.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/sleep.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index df38657..7560c99 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -8,6 +8,8 @@
  * Copyright (c) 2003 Open Source Development Lab
  */
 
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/dmi.h>
@@ -41,7 +43,7 @@ static void acpi_sleep_tts_switch(u32 acpi_state)
 		 * OS can't evaluate the _TTS object correctly. Some warning
 		 * message will be printed. But it won't break anything.
 		 */
-		printk(KERN_NOTICE "Failure in evaluating _TTS object\n");
+		pr_notice("Failure in evaluating _TTS object\n");
 	}
 }
 
@@ -73,8 +75,7 @@ static int acpi_sleep_prepare(u32 acpi_state)
 	}
 	ACPI_FLUSH_CPU_CACHE();
 #endif
-	printk(KERN_INFO PREFIX "Preparing to enter system sleep state S%d\n",
-		acpi_state);
+	pr_info("Preparing to enter system sleep state S%d\n", acpi_state);
 	acpi_enable_wakeup_devices(acpi_state);
 	acpi_enter_sleep_state_prep(acpi_state);
 	return 0;
@@ -459,8 +460,7 @@ static void acpi_pm_finish(void)
 	if (acpi_state == ACPI_STATE_S0)
 		return;
 
-	printk(KERN_INFO PREFIX "Waking up from system sleep state S%d\n",
-		acpi_state);
+	pr_info("Waking up from system sleep state S%d\n", acpi_state);
 	acpi_disable_wakeup_devices(acpi_state);
 	acpi_leave_sleep_state(acpi_state);
 
@@ -581,7 +581,7 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 		error = acpi_suspend_lowlevel();
 		if (error)
 			return error;
-		pr_info(PREFIX "Low-level resume complete\n");
+		pr_info("Low-level resume complete\n");
 		pm_set_resume_via_firmware();
 		break;
 	}
@@ -921,7 +921,7 @@ static void acpi_hibernation_leave(void)
 	acpi_leave_sleep_state_prep(ACPI_STATE_S4);
 	/* Check the hardware signature */
 	if (facs && s4_hardware_signature != facs->hardware_signature)
-		pr_crit("ACPI: Hardware changed while hibernated, success doubtful!\n");
+		pr_crit("Hardware changed while hibernated, success doubtful!\n");
 	/* Restore the NVS memory area */
 	suspend_nvs_restore();
 	/* Allow EC transactions to happen. */
@@ -1029,7 +1029,7 @@ static void acpi_power_off_prepare(void)
 static void acpi_power_off(void)
 {
 	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called */
-	printk(KERN_DEBUG "%s called\n", __func__);
+	pr_debug("%s called\n", __func__);
 	local_irq_disable();
 	acpi_enter_sleep_state(ACPI_STATE_S5);
 }
@@ -1061,7 +1061,7 @@ int __init acpi_sleep_init(void)
 		if (sleep_states[i])
 			pos += sprintf(pos, " S%d", i);
 	}
-	pr_info(PREFIX "(supports%s)\n", supported);
+	pr_info("(supports%s)\n", supported);
 
 	/*
 	 * Register the tts_notifier to reboot notifier list so that the _TTS
-- 
1.7.12.4

