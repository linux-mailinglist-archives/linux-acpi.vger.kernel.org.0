Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 097A3146079
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2020 02:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgAWBly (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Jan 2020 20:41:54 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:44226 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725911AbgAWBlx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jan 2020 20:41:53 -0500
X-IronPort-AV: E=Sophos;i="5.70,351,1574092800"; 
   d="scan'208";a="82502321"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Jan 2020 09:41:48 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id C100A50A9970;
        Thu, 23 Jan 2020 09:32:35 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Thu, 23 Jan 2020 09:41:48 +0800
Received: from TEST.g08.fujitsu.local (10.167.226.147) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Thu, 23 Jan 2020 09:41:47 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <x86@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <rjw@rjwysocki.net>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>
Subject: [RFC PATCH 2/2] x86/acpi: Cleanup acpi_process_madt()
Date:   Thu, 23 Jan 2020 09:41:44 +0800
Message-ID: <20200123014144.19155-3-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200123014144.19155-1-caoj.fnst@cn.fujitsu.com>
References: <20200123014144.19155-1-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: C100A50A9970.A8DA6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

After many duct-taped patches, the readablity of these code chunks are
really hard. This patch does following improvements:

  1. Drop unnecessary comment that is self-documented by function name,
     while supply with necessary comments.
  2. Drop duplicated code: acpi_process_madt() has already been called
     in early madt processing, acpi_lapic & smp_found_config is also
     initialized there.
  3. Fix code logic: variable count's usage is quite confusing now, and
     some code logic is wrong, like count & x2count will never be negative
     after assigned from madt_proc[n].count

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 arch/x86/kernel/acpi/boot.c | 44 +++++++++++++++----------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 2131035bba98..844fc9f26064 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1026,9 +1026,10 @@ static int __init early_acpi_parse_madt_lapic_addr_ovr(void)
 	return count;
 }
 
+/* Returns 0 on success, < 0 on error. */
 static int __init acpi_parse_madt_lapic_entries(void)
 {
-	int count;
+	int count = 0;
 	int x2count = 0;
 	int ret;
 	struct acpi_subtable_proc madt_proc[2];
@@ -1036,10 +1037,13 @@ static int __init acpi_parse_madt_lapic_entries(void)
 	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return -ENODEV;
 
-	count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_SAPIC,
-				      acpi_parse_sapic, MAX_LOCAL_APIC);
+	/* SAPIC is commonly found on Intel Itanium processor. */
+	ret = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_SAPIC,
+				    acpi_parse_sapic, MAX_LOCAL_APIC);
 
-	if (!count) {
+
+	/* No SAPIC entries implies it is not Itanium processor. */
+	if (!ret) {
 		memset(madt_proc, 0, sizeof(madt_proc));
 		madt_proc[0].id = ACPI_MADT_TYPE_LOCAL_APIC;
 		madt_proc[0].handler = acpi_parse_lapic;
@@ -1056,15 +1060,14 @@ static int __init acpi_parse_madt_lapic_entries(void)
 
 		count = madt_proc[0].count;
 		x2count = madt_proc[1].count;
-	}
-	if (!count && !x2count) {
-		printk(KERN_ERR PREFIX "No LAPIC entries present\n");
-		/* TBD: Cleanup to allow fallback to MPS */
-		return -ENODEV;
-	} else if (count < 0 || x2count < 0) {
-		printk(KERN_ERR PREFIX "Error parsing LAPIC entry\n");
-		/* TBD: Cleanup to allow fallback to MPS */
-		return count;
+		if (!count && !x2count) {
+			printk(KERN_ERR PREFIX "No LAPIC entries present\n");
+			/* TBD: Cleanup to allow fallback to MPS */
+			return -ENODEV;
+		}
+	} else if (ret < 0) {
+		printk(KERN_ERR PREFIX "Error parsing SAPIC entries\n");
+		return ret;
 	}
 
 	x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC_NMI,
@@ -1074,7 +1077,7 @@ static int __init acpi_parse_madt_lapic_entries(void)
 	if (count < 0 || x2count < 0) {
 		printk(KERN_ERR PREFIX "Error parsing LAPIC NMI entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
-		return count;
+		return (count < 0) ? count : x2count;
 	}
 	return 0;
 }
@@ -1255,25 +1258,14 @@ static void __init acpi_process_madt(void)
 #ifdef CONFIG_X86_LOCAL_APIC
 	int error;
 
-	if (!acpi_table_parse(ACPI_SIG_MADT, acpi_parse_madt)) {
-
-		/*
-		 * Parse MADT LAPIC entries
-		 */
+	if (acpi_lapic) {
 		error = acpi_parse_madt_lapic_entries();
 		if (!error) {
-			acpi_lapic = 1;
-
-			/*
-			 * Parse MADT IO-APIC entries
-			 */
 			mutex_lock(&acpi_ioapic_lock);
 			error = acpi_parse_madt_ioapic_entries();
 			mutex_unlock(&acpi_ioapic_lock);
 			if (!error) {
 				acpi_set_irq_model_ioapic();
-
-				smp_found_config = 1;
 			}
 		}
 		if (error == -EINVAL) {
-- 
2.21.0



