Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CF17051A5
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 17:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjEPPG4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 11:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbjEPPGw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 11:06:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B8A76BD
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 08:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684249608; x=1715785608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DmdrV8W0DFloDwAhOBlyO2OW498DIbTt7o/CsTXG9Fs=;
  b=mjXTS2usu6L3Gf5y8gNLllsjNfJhnlcgeGPiOCJMCZx8tsKmM7pTBsIa
   fcq2387lLmuREtTk0apwRODgBjuI6uMiLPN9z6M58BMEJ8PUNC5fBU22s
   CGYjxyTVpjmWeubLIXU6duuXcajI2HY1Mdv1WmdtjrWb14vKXYCN+rdxV
   o5YGedJY4ZoJx+vDwl/JHjE7AB5m3/iUerZ/cJrZF3O/kivChaiS94UJ+
   6yremjUjk67NejHAUhHWoSKAL6x2NPB7c8trjC1AnaEeinR7nPacfGIQH
   HLVMo5HHcEOXZksfkOSTpDJq244M3ULsW0F1m/FMcgIx5ubUk3WvFMBRd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417158343"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417158343"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 08:06:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="704446241"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="704446241"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 08:06:16 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 1/2] acpi: Use _OSC method to convey processor OSPM capabilities
Date:   Tue, 16 May 2023 17:05:57 +0200
Message-Id: <20230516150558.149886-2-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230516150558.149886-1-michal.wilczynski@intel.com>
References: <20230516150558.149886-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI 3.0 introduced a new Operating System Capabilities _OSC control
method. This method is similar to _PDC, which was marked as deprecated
in ACPI 3.0.

Prefer using _OSC method over deprecated _PDC in the acpi_bus_init(). In
case of the failure of the _OSC, try using  _PDC as a fallback.

Refactor workaround for HWP introduced in
commit a21211672c9a ("ACPI / processor: Request native thermal interrupt
handling via _OSC"). This workaround was already using _OSC to work around
buggy BIOS in Skylake systems. Change acpi_hwp_native_thermal_lvt_osc() to
acpi_processor_osc() and make it more generic.

Change arch_acpi_set_pdc_bits() to arch_acpi_set_proc_cap_bits() as the
capabilities bitfield is not _PDC specific.

Introduce new define ACPI_PDC_COLLAB_PROC_PERF instead of using
hard-coded value.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 arch/ia64/include/asm/acpi.h  |  4 +--
 arch/x86/include/asm/acpi.h   | 12 +++++----
 drivers/acpi/acpi_processor.c | 49 +++++++++++++++++++----------------
 drivers/acpi/bus.c            | 11 +++++---
 drivers/acpi/internal.h       |  4 +--
 drivers/acpi/processor_pdc.c  |  2 +-
 include/acpi/pdc_intel.h      |  1 +
 7 files changed, 46 insertions(+), 37 deletions(-)

diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
index 87927eb824cc..43797cb44383 100644
--- a/arch/ia64/include/asm/acpi.h
+++ b/arch/ia64/include/asm/acpi.h
@@ -69,9 +69,9 @@ extern int __initdata nid_to_pxm_map[MAX_NUMNODES];
 #endif
 
 static inline bool arch_has_acpi_pdc(void) { return true; }
-static inline void arch_acpi_set_pdc_bits(u32 *buf)
+static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
 {
-	buf[2] |= ACPI_PDC_EST_CAPABILITY_SMP;
+	*cap |= ACPI_PDC_EST_CAPABILITY_SMP;
 }
 
 #ifdef CONFIG_ACPI_NUMA
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 8eb74cf386db..a73d1acfa551 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -100,23 +100,25 @@ static inline bool arch_has_acpi_pdc(void)
 		c->x86_vendor == X86_VENDOR_CENTAUR);
 }
 
-static inline void arch_acpi_set_pdc_bits(u32 *buf)
+static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
 {
 	struct cpuinfo_x86 *c = &cpu_data(0);
 
-	buf[2] |= ACPI_PDC_C_CAPABILITY_SMP;
+	*cap |= ACPI_PDC_C_CAPABILITY_SMP;
 
 	if (cpu_has(c, X86_FEATURE_EST))
-		buf[2] |= ACPI_PDC_EST_CAPABILITY_SWSMP;
+		*cap |= ACPI_PDC_EST_CAPABILITY_SWSMP;
 
 	if (cpu_has(c, X86_FEATURE_ACPI))
-		buf[2] |= ACPI_PDC_T_FFH;
+		*cap |= ACPI_PDC_T_FFH;
 
+	if (cpu_has(c, X86_FEATURE_HWP))
+		*cap |= ACPI_PDC_COLLAB_PROC_PERF;
 	/*
 	 * If mwait/monitor is unsupported, C2/C3_FFH will be disabled
 	 */
 	if (!cpu_has(c, X86_FEATURE_MWAIT))
-		buf[2] &= ~(ACPI_PDC_C_C2C3_FFH);
+		*cap &= ~(ACPI_PDC_C_C2C3_FFH);
 }
 
 static inline bool acpi_has_cpu_in_madt(void)
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index f9aa02cac6d1..26f6c002016b 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -510,13 +510,12 @@ static void acpi_processor_remove(struct acpi_device *device)
 
 #ifdef CONFIG_X86
 static bool acpi_hwp_native_thermal_lvt_set;
-static acpi_status __init acpi_hwp_native_thermal_lvt_osc(acpi_handle handle,
-							  u32 lvl,
-							  void *context,
-							  void **rv)
+static acpi_status __init acpi_processor_osc(acpi_handle handle, u32 lvl,
+					     void *context, void **rv)
 {
 	u8 sb_uuid_str[] = "4077A616-290C-47BE-9EBD-D87058713953";
-	u32 capbuf[2];
+	u32 capbuf[2] = { 0 };
+	acpi_status status;
 	struct acpi_osc_context osc_context = {
 		.uuid_str = sb_uuid_str,
 		.rev = 1,
@@ -524,39 +523,43 @@ static acpi_status __init acpi_hwp_native_thermal_lvt_osc(acpi_handle handle,
 		.cap.pointer = capbuf,
 	};
 
-	if (acpi_hwp_native_thermal_lvt_set)
-		return AE_CTRL_TERMINATE;
+	arch_acpi_set_proc_cap_bits(&capbuf[OSC_SUPPORT_DWORD]);
 
-	capbuf[0] = 0x0000;
-	capbuf[1] = 0x1000; /* set bit 12 */
+	if (boot_option_idle_override == IDLE_NOMWAIT)
+		capbuf[OSC_SUPPORT_DWORD] &= ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
 
-	if (ACPI_SUCCESS(acpi_run_osc(handle, &osc_context))) {
+	status = acpi_run_osc(handle, &osc_context);
+	if (ACPI_SUCCESS(status)) {
 		if (osc_context.ret.pointer && osc_context.ret.length > 1) {
 			u32 *capbuf_ret = osc_context.ret.pointer;
 
-			if (capbuf_ret[1] & 0x1000) {
+			if (!acpi_hwp_native_thermal_lvt_set &&
+			    capbuf_ret[1] & 0x1000) {
 				acpi_handle_info(handle,
-					"_OSC native thermal LVT Acked\n");
+						 "_OSC native thermal LVT Acked\n");
 				acpi_hwp_native_thermal_lvt_set = true;
 			}
 		}
 		kfree(osc_context.ret.pointer);
 	}
 
-	return AE_OK;
+	return status;
 }
 
-void __init acpi_early_processor_osc(void)
+acpi_status __init acpi_early_processor_osc(void)
 {
-	if (boot_cpu_has(X86_FEATURE_HWP)) {
-		acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
-				    ACPI_UINT32_MAX,
-				    acpi_hwp_native_thermal_lvt_osc,
-				    NULL, NULL, NULL);
-		acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID,
-				 acpi_hwp_native_thermal_lvt_osc,
-				 NULL, NULL);
-	}
+	acpi_status status;
+
+	status = acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
+				     ACPI_UINT32_MAX, acpi_processor_osc, NULL,
+				     NULL, NULL);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	status = acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID, acpi_processor_osc,
+				  NULL, NULL);
+
+	return status;
 }
 #endif
 
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index d161ff707de4..892c55bbe594 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1317,9 +1317,6 @@ static int __init acpi_bus_init(void)
 		goto error1;
 	}
 
-	/* Set capability bits for _OSC under processor scope */
-	acpi_early_processor_osc();
-
 	/*
 	 * _OSC method may exist in module level code,
 	 * so it must be run after ACPI_FULL_INITIALIZATION
@@ -1335,7 +1332,13 @@ static int __init acpi_bus_init(void)
 
 	acpi_sysfs_init();
 
-	acpi_early_processor_set_pdc();
+	status = acpi_early_processor_osc();
+	if (ACPI_FAILURE(status)) {
+		pr_err("_OSC processor control methods failed, trying _PDC\n");
+		acpi_early_processor_set_pdc();
+	} else {
+		pr_err("_OSC methods ran successfully\n");
+	}
 
 	/*
 	 * Maybe EC region is required at bus_scan/acpi_get_devices. So it
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 06ad497067ac..58e892376391 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -156,9 +156,9 @@ static inline void acpi_early_processor_set_pdc(void) {}
 #endif
 
 #ifdef CONFIG_X86
-void acpi_early_processor_osc(void);
+acpi_status acpi_early_processor_osc(void);
 #else
-static inline void acpi_early_processor_osc(void) {}
+static inline acpi_status acpi_early_processor_osc(void) { return AE_ERROR; }
 #endif
 
 /* --------------------------------------------------------------------------
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 18fb04523f93..8d10d000ebc2 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -73,7 +73,7 @@ static void acpi_set_pdc_bits(u32 *buf)
 	buf[2] = ACPI_PDC_SMP_T_SWCOORD;
 
 	/* Twiddle arch-specific bits needed for _PDC */
-	arch_acpi_set_pdc_bits(buf);
+	arch_acpi_set_proc_cap_bits(&buf[2]);
 }
 
 static struct acpi_object_list *acpi_processor_alloc_pdc(void)
diff --git a/include/acpi/pdc_intel.h b/include/acpi/pdc_intel.h
index 967c552d1cd3..9427f639287f 100644
--- a/include/acpi/pdc_intel.h
+++ b/include/acpi/pdc_intel.h
@@ -16,6 +16,7 @@
 #define ACPI_PDC_C_C1_FFH		(0x0100)
 #define ACPI_PDC_C_C2C3_FFH		(0x0200)
 #define ACPI_PDC_SMP_P_HWCOORD		(0x0800)
+#define ACPI_PDC_COLLAB_PROC_PERF	(0x1000)
 
 #define ACPI_PDC_EST_CAPABILITY_SMP	(ACPI_PDC_SMP_C1PT | \
 					 ACPI_PDC_C_C1_HALT | \
-- 
2.40.1

