Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA7D3984EA
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 11:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhFBJIY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 05:08:24 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3349 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhFBJIX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 05:08:23 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fw31c2yftz19TZL;
        Wed,  2 Jun 2021 17:01:56 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:44 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:44 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 10/18] ACPI: processor_perflib: Cleanup print messages
Date:   Wed, 2 Jun 2021 16:54:32 +0800
Message-ID: <1622624080-56025-11-git-send-email-guohanjun@huawei.com>
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

The log messages in processor_perflib.c is not in consistency,
we have some printk() calls with PREFIX, but some are not; we
use pr_*() functions without prefix. So add pr_fmt() and unify
them with pr_*() functions.

While at it, fix some obvious coding style issues when going
through the functions.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/processor_perflib.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index d088a00..757a98f 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -9,6 +9,8 @@
  *  			- Added processor hotplug support
  */
 
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -20,8 +22,6 @@
 #include <asm/cpufeature.h>
 #endif
 
-#define PREFIX "ACPI: "
-
 #define ACPI_PROCESSOR_FILE_PERFORMANCE	"performance"
 
 static DEFINE_MUTEX(performance_mutex);
@@ -194,7 +194,6 @@ static int acpi_processor_get_performance_control(struct acpi_processor *pr)
 	union acpi_object *pct = NULL;
 	union acpi_object obj = { 0 };
 
-
 	status = acpi_evaluate_object(pr->handle, "_PCT", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		acpi_evaluation_failure_warn(pr->handle, "_PCT", status);
@@ -204,7 +203,7 @@ static int acpi_processor_get_performance_control(struct acpi_processor *pr)
 	pct = (union acpi_object *)buffer.pointer;
 	if (!pct || (pct->type != ACPI_TYPE_PACKAGE)
 	    || (pct->package.count != 2)) {
-		printk(KERN_ERR PREFIX "Invalid _PCT data\n");
+		pr_err("Invalid _PCT data\n");
 		result = -EFAULT;
 		goto end;
 	}
@@ -218,7 +217,7 @@ static int acpi_processor_get_performance_control(struct acpi_processor *pr)
 	if ((obj.type != ACPI_TYPE_BUFFER)
 	    || (obj.buffer.length < sizeof(struct acpi_pct_register))
 	    || (obj.buffer.pointer == NULL)) {
-		printk(KERN_ERR PREFIX "Invalid _PCT data (control_register)\n");
+		pr_err("Invalid _PCT data (control_register)\n");
 		result = -EFAULT;
 		goto end;
 	}
@@ -234,7 +233,7 @@ static int acpi_processor_get_performance_control(struct acpi_processor *pr)
 	if ((obj.type != ACPI_TYPE_BUFFER)
 	    || (obj.buffer.length < sizeof(struct acpi_pct_register))
 	    || (obj.buffer.pointer == NULL)) {
-		printk(KERN_ERR PREFIX "Invalid _PCT data (status_register)\n");
+		pr_err("Invalid _PCT data (status_register)\n");
 		result = -EFAULT;
 		goto end;
 	}
@@ -242,7 +241,7 @@ static int acpi_processor_get_performance_control(struct acpi_processor *pr)
 	memcpy(&pr->performance->status_register, obj.buffer.pointer,
 	       sizeof(struct acpi_pct_register));
 
-      end:
+end:
 	kfree(buffer.pointer);
 
 	return result;
@@ -294,7 +293,6 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 	int i;
 	int last_invalid = -1;
 
-
 	status = acpi_evaluate_object(pr->handle, "_PSS", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		acpi_evaluation_failure_warn(pr->handle, "_PSS", status);
@@ -303,7 +301,7 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 
 	pss = buffer.pointer;
 	if (!pss || (pss->type != ACPI_TYPE_PACKAGE)) {
-		printk(KERN_ERR PREFIX "Invalid _PSS data\n");
+		pr_err("Invalid _PSS data\n");
 		result = -EFAULT;
 		goto end;
 	}
@@ -357,7 +355,7 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 		if (!px->core_frequency ||
 		    ((u32)(px->core_frequency * 1000) !=
 		     (px->core_frequency * 1000))) {
-			printk(KERN_ERR FW_BUG PREFIX
+			pr_err(FW_BUG
 			       "Invalid BIOS _PSS frequency found for processor %d: 0x%llx MHz\n",
 			       pr->id, px->core_frequency);
 			if (last_invalid == -1)
@@ -375,8 +373,8 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 	}
 
 	if (last_invalid == 0) {
-		printk(KERN_ERR FW_BUG PREFIX
-		       "No valid BIOS _PSS frequency found for processor %d\n", pr->id);
+		pr_err(FW_BUG
+			   "No valid BIOS _PSS frequency found for processor %d\n", pr->id);
 		result = -EFAULT;
 		kfree(pr->performance->states);
 		pr->performance->states = NULL;
@@ -385,7 +383,7 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 	if (last_invalid > 0)
 		pr->performance->state_count = last_invalid;
 
-      end:
+end:
 	kfree(buffer.pointer);
 
 	return result;
@@ -426,7 +424,7 @@ int acpi_processor_get_performance_info(struct acpi_processor *pr)
 #ifdef CONFIG_X86
 	if (acpi_has_method(pr->handle, "_PPC")) {
 		if(boot_cpu_has(X86_FEATURE_EST))
-			printk(KERN_WARNING FW_BUG "BIOS needs update for CPU "
+			pr_warn(FW_BUG "BIOS needs update for CPU "
 			       "frequency support\n");
 	}
 #endif
@@ -520,13 +518,13 @@ int acpi_processor_get_psd(acpi_handle handle, struct acpi_psd_package *pdomain)
 
 	psd = buffer.pointer;
 	if (!psd || (psd->type != ACPI_TYPE_PACKAGE)) {
-		printk(KERN_ERR PREFIX "Invalid _PSD data\n");
+		pr_err("Invalid _PSD data\n");
 		result = -EFAULT;
 		goto end;
 	}
 
 	if (psd->package.count != 1) {
-		printk(KERN_ERR PREFIX "Invalid _PSD data\n");
+		pr_err("Invalid _PSD data\n");
 		result = -EFAULT;
 		goto end;
 	}
@@ -537,19 +535,19 @@ int acpi_processor_get_psd(acpi_handle handle, struct acpi_psd_package *pdomain)
 	status = acpi_extract_package(&(psd->package.elements[0]),
 		&format, &state);
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX "Invalid _PSD data\n");
+		pr_err("Invalid _PSD data\n");
 		result = -EFAULT;
 		goto end;
 	}
 
 	if (pdomain->num_entries != ACPI_PSD_REV0_ENTRIES) {
-		printk(KERN_ERR PREFIX "Unknown _PSD:num_entries\n");
+		pr_err("Unknown _PSD:num_entries\n");
 		result = -EFAULT;
 		goto end;
 	}
 
 	if (pdomain->revision != ACPI_PSD_REV0_REVISION) {
-		printk(KERN_ERR PREFIX "Unknown _PSD:revision\n");
+		pr_err("Unknown _PSD:revision\n");
 		result = -EFAULT;
 		goto end;
 	}
@@ -557,7 +555,7 @@ int acpi_processor_get_psd(acpi_handle handle, struct acpi_psd_package *pdomain)
 	if (pdomain->coord_type != DOMAIN_COORD_TYPE_SW_ALL &&
 	    pdomain->coord_type != DOMAIN_COORD_TYPE_SW_ANY &&
 	    pdomain->coord_type != DOMAIN_COORD_TYPE_HW_ALL) {
-		printk(KERN_ERR PREFIX "Invalid _PSD:coord_type\n");
+		pr_err("Invalid _PSD:coord_type\n");
 		result = -EFAULT;
 		goto end;
 	}
-- 
1.7.12.4

