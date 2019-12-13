Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA05011E09D
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2019 10:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLMJ1s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Dec 2019 04:27:48 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:41983 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfLMJ1h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Dec 2019 04:27:37 -0500
Received: from 79.184.255.82.ipv4.supernova.orange.pl (79.184.255.82) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id ea518d7512e1c01a; Fri, 13 Dec 2019 10:27:35 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 01/10] ACPI: processor: Export function to claim _CST control
Date:   Fri, 13 Dec 2019 10:11:41 +0100
Message-ID: <1905009.oqaLcrmCQp@kreacher>
In-Reply-To: <3950312.2WmFeOdZGY@kreacher>
References: <3950312.2WmFeOdZGY@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The intel_idle driver will be modified to use ACPI _CST subsequently
and it will need to notify the platform firmware of that if
acpi_gbl_FADT.cst_control is set, so add a routine for this purpose,
acpi_processor_claim_cst_control(), to acpi_processor.c (so that it
is always present which is required by intel_idle) and export it
to allow the ACPI processor driver (which is modular) to call it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

No changes from the RFC version.

---
 drivers/acpi/acpi_processor.c | 25 +++++++++++++++++++++++++
 drivers/acpi/processor_idle.c | 12 ++++--------
 include/linux/acpi.h          |  6 ++++++
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 2c4dda0787e8..8a53f3c5b70e 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -705,3 +705,28 @@ void __init acpi_processor_init(void)
 	acpi_scan_add_handler_with_hotplug(&processor_handler, "processor");
 	acpi_scan_add_handler(&processor_container_handler);
 }
+
+#ifdef CONFIG_ACPI_PROCESSOR_CSTATE
+/**
+ * acpi_processor_claim_cst_control - Request _CST control from the platform.
+ */
+bool acpi_processor_claim_cst_control(void)
+{
+	static bool cst_control_claimed;
+	acpi_status status;
+
+	if (!acpi_gbl_FADT.cst_control || cst_control_claimed)
+		return true;
+
+	status = acpi_os_write_port(acpi_gbl_FADT.smi_command,
+				    acpi_gbl_FADT.cst_control, 8);
+	if (ACPI_FAILURE(status)) {
+		pr_warn("ACPI: Failed to claim processor _CST control\n");
+		return false;
+	}
+
+	cst_control_claimed = true;
+	return true;
+}
+EXPORT_SYMBOL_GPL(acpi_processor_claim_cst_control);
+#endif /* CONFIG_ACPI_PROCESSOR_CSTATE */
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 2ae95df2e74f..dd737d836c03 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -909,7 +909,6 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
 
 static inline void acpi_processor_cstate_first_run_checks(void)
 {
-	acpi_status status;
 	static int first_run;
 
 	if (first_run)
@@ -921,13 +920,10 @@ static inline void acpi_processor_cstate_first_run_checks(void)
 			  max_cstate);
 	first_run++;
 
-	if (acpi_gbl_FADT.cst_control && !nocst) {
-		status = acpi_os_write_port(acpi_gbl_FADT.smi_command,
-					    acpi_gbl_FADT.cst_control, 8);
-		if (ACPI_FAILURE(status))
-			ACPI_EXCEPTION((AE_INFO, status,
-					"Notifying BIOS of _CST ability failed"));
-	}
+	if (nocst)
+		return;
+
+	acpi_processor_claim_cst_control();
 }
 #else
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0f37a7d5fa77..ee39b05e7f76 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -279,6 +279,12 @@ static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
 
 /* Validate the processor object's proc_id */
 bool acpi_duplicate_processor_id(int proc_id);
+/* Processor _CTS control */
+#ifdef CONFIG_ACPI_PROCESSOR_CSTATE
+bool acpi_processor_claim_cst_control(void);
+#else
+static inline bool acpi_processor_claim_cst_control(void) { return false; }
+#endif
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /* Arch dependent functions for cpu hotplug support */
-- 
2.16.4




