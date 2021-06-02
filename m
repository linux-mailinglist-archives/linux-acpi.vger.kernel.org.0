Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344A53984F5
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 11:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhFBJIn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 05:08:43 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2956 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhFBJIi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 05:08:38 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw33w2DcBz694W;
        Wed,  2 Jun 2021 17:03:56 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:45 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:44 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 11/18] ACPI: processor_throttling: Cleanup the printing messages
Date:   Wed, 2 Jun 2021 16:54:33 +0800
Message-ID: <1622624080-56025-12-git-send-email-guohanjun@huawei.com>
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

The log messages in processor_throttling.c is not in consistency,
we have some printk() calls with PREFIX, but some are not; also we
use pr_*() functions without prefix. So add pr_fmt() and unify
them with pr_*() functions.

While at it, fix some obvious coding style issues when going
through the functions.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/processor_throttling.c | 60 ++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 34 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index e61b8f0..0086afe 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -9,6 +9,8 @@
  *  			- Added processor hotplug support
  */
 
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -20,8 +22,6 @@
 #include <asm/io.h>
 #include <linux/uaccess.h>
 
-#define PREFIX "ACPI: "
-
 /* ignore_tpc:
  *  0 -> acpi processor driver doesn't ignore _TPC values
  *  1 -> acpi processor driver ignores _TPC values
@@ -236,8 +236,7 @@ static int acpi_processor_throttling_notifier(unsigned long event, void *data)
 		if (pr->throttling_platform_limit > target_state)
 			target_state = pr->throttling_platform_limit;
 		if (target_state >= p_throttling->state_count) {
-			printk(KERN_WARNING
-				"Exceed the limit of T-state \n");
+			pr_warn("Exceed the limit of T-state \n");
 			target_state = p_throttling->state_count - 1;
 		}
 		p_tstate->target_state = target_state;
@@ -256,8 +255,7 @@ static int acpi_processor_throttling_notifier(unsigned long event, void *data)
 				  cpu, target_state);
 		break;
 	default:
-		printk(KERN_WARNING
-			"Unsupported Throttling notifier event\n");
+		pr_warn("Unsupported Throttling notifier event\n");
 		break;
 	}
 
@@ -422,7 +420,7 @@ static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
 	ptc = (union acpi_object *)buffer.pointer;
 	if (!ptc || (ptc->type != ACPI_TYPE_PACKAGE)
 	    || (ptc->package.count != 2)) {
-		printk(KERN_ERR PREFIX "Invalid _PTC data\n");
+		pr_err("Invalid _PTC data\n");
 		result = -EFAULT;
 		goto end;
 	}
@@ -436,8 +434,7 @@ static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
 	if ((obj.type != ACPI_TYPE_BUFFER)
 	    || (obj.buffer.length < sizeof(struct acpi_ptc_register))
 	    || (obj.buffer.pointer == NULL)) {
-		printk(KERN_ERR PREFIX
-		       "Invalid _PTC data (control_register)\n");
+		pr_err("Invalid _PTC data (control_register)\n");
 		result = -EFAULT;
 		goto end;
 	}
@@ -453,7 +450,7 @@ static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
 	if ((obj.type != ACPI_TYPE_BUFFER)
 	    || (obj.buffer.length < sizeof(struct acpi_ptc_register))
 	    || (obj.buffer.pointer == NULL)) {
-		printk(KERN_ERR PREFIX "Invalid _PTC data (status_register)\n");
+		pr_err("Invalid _PTC data (status_register)\n");
 		result = -EFAULT;
 		goto end;
 	}
@@ -465,14 +462,14 @@ static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
 
 	if ((throttling->control_register.bit_width +
 		throttling->control_register.bit_offset) > 32) {
-		printk(KERN_ERR PREFIX "Invalid _PTC control register\n");
+		pr_err("Invalid _PTC control register\n");
 		result = -EFAULT;
 		goto end;
 	}
 
 	if ((throttling->status_register.bit_width +
 		throttling->status_register.bit_offset) > 32) {
-		printk(KERN_ERR PREFIX "Invalid _PTC status register\n");
+		pr_err("Invalid _PTC status register\n");
 		result = -EFAULT;
 		goto end;
 	}
@@ -506,7 +503,7 @@ static int acpi_processor_get_throttling_states(struct acpi_processor *pr)
 
 	tss = buffer.pointer;
 	if (!tss || (tss->type != ACPI_TYPE_PACKAGE)) {
-		printk(KERN_ERR PREFIX "Invalid _TSS data\n");
+		pr_err("Invalid _TSS data\n");
 		result = -EFAULT;
 		goto end;
 	}
@@ -546,15 +543,14 @@ static int acpi_processor_get_throttling_states(struct acpi_processor *pr)
 		}
 
 		if (!tx->freqpercentage) {
-			printk(KERN_ERR PREFIX
-			       "Invalid _TSS data: freq is zero\n");
+			pr_err("Invalid _TSS data: freq is zero\n");
 			result = -EFAULT;
 			kfree(pr->throttling.states_tss);
 			goto end;
 		}
 	}
 
-      end:
+end:
 	kfree(buffer.pointer);
 
 	return result;
@@ -587,13 +583,13 @@ static int acpi_processor_get_tsd(struct acpi_processor *pr)
 
 	tsd = buffer.pointer;
 	if (!tsd || (tsd->type != ACPI_TYPE_PACKAGE)) {
-		printk(KERN_ERR PREFIX "Invalid _TSD data\n");
+		pr_err("Invalid _TSD data\n");
 		result = -EFAULT;
 		goto end;
 	}
 
 	if (tsd->package.count != 1) {
-		printk(KERN_ERR PREFIX "Invalid _TSD data\n");
+		pr_err("Invalid _TSD data\n");
 		result = -EFAULT;
 		goto end;
 	}
@@ -606,19 +602,19 @@ static int acpi_processor_get_tsd(struct acpi_processor *pr)
 	status = acpi_extract_package(&(tsd->package.elements[0]),
 				      &format, &state);
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX "Invalid _TSD data\n");
+		pr_err("Invalid _TSD data\n");
 		result = -EFAULT;
 		goto end;
 	}
 
 	if (pdomain->num_entries != ACPI_TSD_REV0_ENTRIES) {
-		printk(KERN_ERR PREFIX "Unknown _TSD:num_entries\n");
+		pr_err("Unknown _TSD:num_entries\n");
 		result = -EFAULT;
 		goto end;
 	}
 
 	if (pdomain->revision != ACPI_TSD_REV0_REVISION) {
-		printk(KERN_ERR PREFIX "Unknown _TSD:revision\n");
+		pr_err("Unknown _TSD:revision\n");
 		result = -EFAULT;
 		goto end;
 	}
@@ -639,7 +635,7 @@ static int acpi_processor_get_tsd(struct acpi_processor *pr)
 		pthrottling->shared_type = DOMAIN_COORD_TYPE_SW_ALL;
 	}
 
-      end:
+end:
 	kfree(buffer.pointer);
 	return result;
 }
@@ -711,8 +707,7 @@ static int acpi_throttling_rdmsr(u64 *value)
 
 	if ((this_cpu_read(cpu_info.x86_vendor) != X86_VENDOR_INTEL) ||
 		!this_cpu_has(X86_FEATURE_ACPI)) {
-		printk(KERN_ERR PREFIX
-			"HARDWARE addr space,NOT supported yet\n");
+		pr_err("HARDWARE addr space,NOT supported yet\n");
 	} else {
 		msr_low = 0;
 		msr_high = 0;
@@ -732,8 +727,7 @@ static int acpi_throttling_wrmsr(u64 value)
 
 	if ((this_cpu_read(cpu_info.x86_vendor) != X86_VENDOR_INTEL) ||
 		!this_cpu_has(X86_FEATURE_ACPI)) {
-		printk(KERN_ERR PREFIX
-			"HARDWARE addr space,NOT supported yet\n");
+		pr_err("HARDWARE addr space,NOT supported yet\n");
 	} else {
 		msr = value;
 		wrmsr_safe(MSR_IA32_THERM_CONTROL,
@@ -745,15 +739,13 @@ static int acpi_throttling_wrmsr(u64 value)
 #else
 static int acpi_throttling_rdmsr(u64 *value)
 {
-	printk(KERN_ERR PREFIX
-		"HARDWARE addr space,NOT supported yet\n");
+	pr_err("HARDWARE addr space,NOT supported yet\n");
 	return -1;
 }
 
 static int acpi_throttling_wrmsr(u64 value)
 {
-	printk(KERN_ERR PREFIX
-		"HARDWARE addr space,NOT supported yet\n");
+	pr_err("HARDWARE addr space,NOT supported yet\n");
 	return -1;
 }
 #endif
@@ -784,7 +776,7 @@ static int acpi_read_throttling_status(struct acpi_processor *pr,
 		ret = acpi_throttling_rdmsr(value);
 		break;
 	default:
-		printk(KERN_ERR PREFIX "Unknown addr space %d\n",
+		pr_err("Unknown addr space %d\n",
 		       (u32) (throttling->status_register.space_id));
 	}
 	return ret;
@@ -817,7 +809,7 @@ static int acpi_write_throttling_state(struct acpi_processor *pr,
 		ret = acpi_throttling_wrmsr(value);
 		break;
 	default:
-		printk(KERN_ERR PREFIX "Unknown addr space %d\n",
+		pr_err("Unknown addr space %d\n",
 		       (u32) (throttling->control_register.space_id));
 	}
 	return ret;
@@ -926,7 +918,7 @@ static int acpi_processor_get_fadt_info(struct acpi_processor *pr)
 	}
 	/* TBD: Support duty_cycle values that span bit 4. */
 	else if ((pr->throttling.duty_offset + pr->throttling.duty_width) > 4) {
-		printk(KERN_WARNING PREFIX "duty_cycle spans bit 4\n");
+		pr_warn("duty_cycle spans bit 4\n");
 		return -EINVAL;
 	}
 
@@ -1246,7 +1238,7 @@ int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 			goto end;
 	}
 
-      end:
+end:
 	if (result)
 		pr->flags.throttling = 0;
 
-- 
1.7.12.4

