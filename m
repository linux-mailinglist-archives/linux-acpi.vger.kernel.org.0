Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D69D700B89
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 17:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241874AbjELP0U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 11:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241864AbjELP0R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 11:26:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF7A35A0
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 08:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683905171; x=1715441171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ms1pUHrs8co7tNNnOg3QdrbZPDGN1DGxM48XnWaZtJo=;
  b=X/VMoW2pP8kUGGVIbl/l+WchfXD1rWgIaM+3y04tfyp+ejChoFd3KRkB
   sdLRKPBAGd4S4dx+gbuqLxS9voWE9gvasmk7isuueIhAwL/CAgX/aWq08
   lGuo0u0wywf01LJSvzvont2hERXzsncqjWOQ+xeMfO9fvOEfTwua4ZDi8
   wHEAeax7IPILuI7RkOsvLfMqfq6CbglUy/jMDomMjdeLgZVPNnM1udqms
   iTbx1lsYewjC9xXj+M0OXXB4D50mG4xfeTWPSGiat+dCV6/+XVHdPahra
   /ziOdVnZ+mezsBsxZVhHZz3HKWKVpiW8Qfr0hCSA23zM4f45VhypkqWhz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="330431117"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="330431117"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 08:26:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="733078229"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="733078229"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 08:26:09 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        hanjun.guo@linaro.org,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 2/2] acpi: Move logic responsible for conveying processor OSPM capabilities
Date:   Fri, 12 May 2023 17:25:45 +0200
Message-Id: <20230512152545.125302-3-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230512152545.125302-1-michal.wilczynski@intel.com>
References: <20230512152545.125302-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since _PDC method is deprecated and a preferred method of communicating
OSPM processor power management capabilities is _OSC there is a need to
move functions checking whether processor is present and workarounds for
specific hardware to acpi_processor.c as this logic is not _PDC specific.
It also applies to the _OSC objects.

Move processor_dmi_check(), processor_idle_dmi_table, set_no_mwait() and
processor_physically_present() to acpi_processor.c.
Introduce IDLE_NOMWAIT workaround and processor_dmi_table workarounds to
work with _OSC objects.
Mark acpi_early_processor_set_pdc() and acpi_processor_set_pdc() as
deprecated.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/acpi_processor.c | 83 ++++++++++++++++++++++++++++++++++-
 drivers/acpi/internal.h       |  3 ++
 drivers/acpi/processor_pdc.c  | 80 +--------------------------------
 include/acpi/processor.h      |  2 +-
 4 files changed, 87 insertions(+), 81 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 26f6c002016b..2437c916d8b0 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -10,6 +10,7 @@
  *                     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  */
 
+#include <linux/dmi.h>
 #include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -21,6 +22,8 @@
 
 #include <asm/cpu.h>
 
+#include <xen/xen.h>
+
 #include "internal.h"
 
 DEFINE_PER_CPU(struct acpi_processor *, processors);
@@ -508,7 +511,79 @@ static void acpi_processor_remove(struct acpi_device *device)
 }
 #endif /* CONFIG_ACPI_HOTPLUG_CPU */
 
-#ifdef CONFIG_X86
+bool __init processor_physically_present(acpi_handle handle)
+{
+	int cpuid, type;
+	u32 acpi_id;
+	acpi_status status;
+	acpi_object_type acpi_type;
+	unsigned long long tmp;
+	union acpi_object object = { 0 };
+	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
+
+	status = acpi_get_type(handle, &acpi_type);
+	if (ACPI_FAILURE(status))
+		return false;
+
+	switch (acpi_type) {
+	case ACPI_TYPE_PROCESSOR:
+		status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
+		if (ACPI_FAILURE(status))
+			return false;
+		acpi_id = object.processor.proc_id;
+		break;
+	case ACPI_TYPE_DEVICE:
+		status = acpi_evaluate_integer(handle, "_UID", NULL, &tmp);
+		if (ACPI_FAILURE(status))
+			return false;
+		acpi_id = tmp;
+		break;
+	default:
+		return false;
+	}
+
+	if (xen_initial_domain())
+		/*
+		 * When running as a Xen dom0 the number of processors Linux
+		 * sees can be different from the real number of processors on
+		 * the system, and we still need to execute _PDC for all of
+		 * them.
+		 */
+		return xen_processor_present(acpi_id);
+
+	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
+	cpuid = acpi_get_cpuid(handle, type, acpi_id);
+
+	return !invalid_logical_cpuid(cpuid);
+}
+
+static int __init set_no_mwait(const struct dmi_system_id *id)
+{
+	pr_notice("%s detected - disabling mwait for CPU C-states\n",
+		  id->ident);
+	boot_option_idle_override = IDLE_NOMWAIT;
+	return 0;
+}
+
+static const struct dmi_system_id processor_idle_dmi_table[] __initconst = {
+	{
+	set_no_mwait, "Extensa 5220", {
+	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+	DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+	DMI_MATCH(DMI_PRODUCT_VERSION, "0100"),
+	DMI_MATCH(DMI_BOARD_NAME, "Columbia") }, NULL},
+	{},
+};
+
+void __init processor_dmi_check(void)
+{
+	/*
+	 * Check whether the system is DMI table. If yes, OSPM
+	 * should not use mwait for CPU-states.
+	 */
+	dmi_check_system(processor_idle_dmi_table);
+}
+
 static bool acpi_hwp_native_thermal_lvt_set;
 static acpi_status __init acpi_processor_osc(acpi_handle handle, u32 lvl,
 					     void *context, void **rv)
@@ -523,6 +598,9 @@ static acpi_status __init acpi_processor_osc(acpi_handle handle, u32 lvl,
 		.cap.pointer = capbuf,
 	};
 
+	if (processor_physically_present(handle) == false)
+		return AE_OK;
+
 	arch_acpi_set_proc_cap_bits(&capbuf[OSC_SUPPORT_DWORD]);
 
 	if (boot_option_idle_override == IDLE_NOMWAIT)
@@ -550,6 +628,8 @@ acpi_status __init acpi_early_processor_osc(void)
 {
 	acpi_status status;
 
+	processor_dmi_check();
+
 	status = acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
 				     ACPI_UINT32_MAX, acpi_processor_osc, NULL,
 				     NULL, NULL);
@@ -561,7 +641,6 @@ acpi_status __init acpi_early_processor_osc(void)
 
 	return status;
 }
-#endif
 
 /*
  * The following ACPI IDs are known to be suitable for representing as
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 58e892376391..24e93413ae41 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -155,6 +155,9 @@ void acpi_early_processor_set_pdc(void);
 static inline void acpi_early_processor_set_pdc(void) {}
 #endif
 
+void processor_dmi_check(void);
+bool processor_physically_present(acpi_handle handle);
+
 #ifdef CONFIG_X86
 acpi_status acpi_early_processor_osc(void);
 #else
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 8d10d000ebc2..ce3acd86dd12 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -9,61 +9,12 @@
 
 #define pr_fmt(fmt) "ACPI: " fmt
 
-#include <linux/dmi.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <acpi/processor.h>
 
-#include <xen/xen.h>
-
 #include "internal.h"
 
-static bool __init processor_physically_present(acpi_handle handle)
-{
-	int cpuid, type;
-	u32 acpi_id;
-	acpi_status status;
-	acpi_object_type acpi_type;
-	unsigned long long tmp;
-	union acpi_object object = { 0 };
-	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
-
-	status = acpi_get_type(handle, &acpi_type);
-	if (ACPI_FAILURE(status))
-		return false;
-
-	switch (acpi_type) {
-	case ACPI_TYPE_PROCESSOR:
-		status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
-		if (ACPI_FAILURE(status))
-			return false;
-		acpi_id = object.processor.proc_id;
-		break;
-	case ACPI_TYPE_DEVICE:
-		status = acpi_evaluate_integer(handle, "_UID", NULL, &tmp);
-		if (ACPI_FAILURE(status))
-			return false;
-		acpi_id = tmp;
-		break;
-	default:
-		return false;
-	}
-
-	if (xen_initial_domain())
-		/*
-		 * When running as a Xen dom0 the number of processors Linux
-		 * sees can be different from the real number of processors on
-		 * the system, and we still need to execute _PDC for all of
-		 * them.
-		 */
-		return xen_processor_present(acpi_id);
-
-	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
-	cpuid = acpi_get_cpuid(handle, type, acpi_id);
-
-	return !invalid_logical_cpuid(cpuid);
-}
-
 static void acpi_set_pdc_bits(u32 *buf)
 {
 	buf[0] = ACPI_PDC_REVISION_ID;
@@ -146,7 +97,7 @@ acpi_processor_eval_pdc(acpi_handle handle, struct acpi_object_list *pdc_in)
 	return status;
 }
 
-void acpi_processor_set_pdc(acpi_handle handle)
+void __deprecated acpi_processor_set_pdc(acpi_handle handle)
 {
 	struct acpi_object_list *obj_list;
 
@@ -174,34 +125,7 @@ early_init_pdc(acpi_handle handle, u32 lvl, void *context, void **rv)
 	return AE_OK;
 }
 
-static int __init set_no_mwait(const struct dmi_system_id *id)
-{
-	pr_notice("%s detected - disabling mwait for CPU C-states\n",
-		  id->ident);
-	boot_option_idle_override = IDLE_NOMWAIT;
-	return 0;
-}
-
-static const struct dmi_system_id processor_idle_dmi_table[] __initconst = {
-	{
-	set_no_mwait, "Extensa 5220", {
-	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-	DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-	DMI_MATCH(DMI_PRODUCT_VERSION, "0100"),
-	DMI_MATCH(DMI_BOARD_NAME, "Columbia") }, NULL},
-	{},
-};
-
-static void __init processor_dmi_check(void)
-{
-	/*
-	 * Check whether the system is DMI table. If yes, OSPM
-	 * should not use mwait for CPU-states.
-	 */
-	dmi_check_system(processor_idle_dmi_table);
-}
-
-void __init acpi_early_processor_set_pdc(void)
+void __init __deprecated acpi_early_processor_set_pdc(void)
 {
 	processor_dmi_check();
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 94181fe9780a..83ed42254567 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -372,7 +372,7 @@ static inline void acpi_cppc_processor_exit(struct acpi_processor *pr)
 #endif	/* CONFIG_ACPI_CPPC_LIB */
 
 /* in processor_pdc.c */
-void acpi_processor_set_pdc(acpi_handle handle);
+void __deprecated acpi_processor_set_pdc(acpi_handle handle);
 
 /* in processor_throttling.c */
 #ifdef CONFIG_ACPI_CPU_FREQ_PSS
-- 
2.40.1

