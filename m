Return-Path: <linux-acpi+bounces-19987-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEF0CFC47E
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 08:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8B67300F9DD
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 07:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82057225A3B;
	Wed,  7 Jan 2026 07:05:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477E523C8A0;
	Wed,  7 Jan 2026 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767769537; cv=none; b=djwywJ/xHv90pvnxzE7yFVHXHhJT+SW2i2tN4MkFWnLRytJPjX+QF8qnC8MHghBKanaEOg+s9gbDpwf6l5ujgY22PMzg4AMV0fDLqcfTUxvS26Pb8peDCaEy0innlVHnwfkMQuBFRqUBAOthjFU9eR3n2M/kyzKDKMQdhEAoe40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767769537; c=relaxed/simple;
	bh=b/pYfAdUR3A8BW4+SW8NHpOxrzrpyGBt8CNouqe183s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oDAxqDhAdFuolyQykik1M4eSvXRzGv3690T0dIdDaWmny3nMpRaaXxPHMplyRmi72FmNeVAYA8SRsuvkK8SfzIdNjGmR6frWmkJ9kqOIQOcjM2WA5XH0wrJ1Us7LI5pPSYVRiqUravZ2V6heFutkCgWRJ2jQf7NXkV+PE3bCkTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3bfc755aeb9711f0a38c85956e01ac42-20260107
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:245e0089-a3c5-41a6-8f86-86f9e708cd96,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:e868cd1c1d5e7262aa7dd6f8100f4b76,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3bfc755aeb9711f0a38c85956e01ac42-20260107
X-User: luriwen@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luriwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 612938542; Wed, 07 Jan 2026 15:05:22 +0800
From: Riwen Lu <luriwen@kylinos.cn>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v2] ACPI: PM: Introduce CONFIG_ACPI_S2IDLE for platform-independent S2Idle support
Date: Wed,  7 Jan 2026 15:05:17 +0800
Message-Id: <20260107070517.1836322-1-luriwen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI S2Idle (suspend-to-idle) code is currently located in sleep.c
and guarded by CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT. This config is
historically tied to x86/ia64 sleep states (S3/S4), which prevents
ACPI-based platforms like ARM64 from using the OS-centric s2idle
framework and its associated wakeup event handling (e.g., from ACPI
buttons or the lid).

Since S2Idle is a software-driven low-power state that does not rely on
firmware sleep states (S3/S4), it should be available to all
ACPI-enabled platforms.

To achieve this, introduce a new, independent Kconfig option,
CONFIG_ACPI_S2IDLE. It is selected by ACPI_SYSTEM_POWER_STATES_SUPPORT
for backward compatibility, but can now also be enabled separately by
other platforms.

Move all s2idle-specific code into a dedicated file,
drivers/acpi/s2idle.c. This creates a clear and independent ACPI s2idle
framework, centered around a default acpi_s2idle_ops and a weakly
defined acpi_s2idle_setup() hook.

The change allows all ACPI platforms to use this common s2idle
infrastructure. Platforms with unique requirements can override the
defaults via the weak function, while others (like ARM64) can now simply
enable the config to obtain functional s2idle support with standard ACPI
wakeup handling.

Signed-off-by: Riwen Lu <luriwen@kylinos.cn>

---
v1 -> v2:
 - Fix acpi_s2idle_setup() declaration error when SUSPEND disabled in x86.
---
 drivers/acpi/Kconfig    |  14 ++++
 drivers/acpi/Makefile   |   2 +
 drivers/acpi/bus.c      |   3 +
 drivers/acpi/internal.h |  10 ++-
 drivers/acpi/s2idle.c   | 167 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/sleep.c    | 145 ----------------------------------
 6 files changed, 194 insertions(+), 147 deletions(-)
 create mode 100644 drivers/acpi/s2idle.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ca00a5dbcf75..03936e4e6ca9 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -54,6 +54,7 @@ config ACPI_GENERIC_GSI
 
 config ACPI_SYSTEM_POWER_STATES_SUPPORT
 	bool
+	select ACPI_S2IDLE
 
 config ACPI_CCA_REQUIRED
 	bool
@@ -112,6 +113,19 @@ config ACPI_SLEEP
 	depends on ACPI_SYSTEM_POWER_STATES_SUPPORT
 	default y
 
+config ACPI_S2IDLE
+	bool "ACPI suspend-to-idle support"
+	depends on SUSPEND
+	help
+	  This option enables the core ACPI framework for the suspend-to-idle
+	  (S2Idle) power state. This state is software-driven and does not
+	  require platform firmware sleep states (S3/S4).
+
+	  It is automatically selected by platforms with
+	  CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT (like x86), but can also
+	  be enabled independently by other ACPI platforms (e.g., ARM64) to
+	  gain support for low-power idle and ACPI wakeup events.
+
 config ACPI_REV_OVERRIDE_POSSIBLE
 	bool "Allow supported ACPI revision to be overridden"
 	depends on X86
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d1b0affb844f..821afc165197 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -35,6 +35,8 @@ acpi-$(CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT) += sleep.o
 acpi-y				+= device_sysfs.o device_pm.o
 acpi-$(CONFIG_ACPI_SLEEP)	+= proc.o
 
+acpi-$(CONFIG_ACPI_S2IDLE)	+= s2idle.o
+
 
 #
 # ACPI Bus and Device Drivers
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a984ccd4a2a0..f355fc3c201b 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1398,6 +1398,9 @@ static int __init acpi_bus_init(void)
 	/* Initialize sleep structures */
 	acpi_sleep_init();
 
+	/* Initialize default acpi s2idle ops */
+	acpi_s2idle_init();
+
 	/*
 	 * Get the system interrupt model and evaluate \_PIC.
 	 */
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 40f875b265a9..7f314acd7148 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -267,13 +267,19 @@ static inline bool acpi_ec_dispatch_gpe(void)
                                   Suspend/Resume
   -------------------------------------------------------------------------- */
 #ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
-extern bool acpi_s2idle_wakeup(void);
 extern int acpi_sleep_init(void);
 #else
-static inline bool acpi_s2idle_wakeup(void) { return false; }
 static inline int acpi_sleep_init(void) { return -ENXIO; }
 #endif
 
+#ifdef CONFIG_ACPI_S2IDLE
+extern bool acpi_s2idle_wakeup(void);
+extern int acpi_s2idle_init(void);
+#else
+static inline bool acpi_s2idle_wakeup(void) { return false; }
+static inline int acpi_s2idle_init(void) { return -ENXIO; }
+#endif
+
 #ifdef CONFIG_ACPI_SLEEP
 void acpi_sleep_proc_init(void);
 int suspend_nvs_alloc(void);
diff --git a/drivers/acpi/s2idle.c b/drivers/acpi/s2idle.c
new file mode 100644
index 000000000000..0c783b0e1a9b
--- /dev/null
+++ b/drivers/acpi/s2idle.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * s2idle.c - ACPI suspend-to-idle support.
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/suspend.h>
+#include <linux/irq.h>
+
+#include "internal.h"
+#include "sleep.h"
+
+#ifdef CONFIG_SUSPEND
+static bool s2idle_wakeup;
+
+int acpi_s2idle_begin(void)
+{
+	acpi_scan_lock_acquire();
+	return 0;
+}
+
+int acpi_s2idle_prepare(void)
+{
+	if (acpi_sci_irq_valid()) {
+		int error;
+
+		error = enable_irq_wake(acpi_sci_irq);
+		if (error)
+			pr_warn("Warning: Failed to enable wakeup from IRQ %d: %d\n",
+				acpi_sci_irq, error);
+
+		acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
+	}
+
+	acpi_enable_wakeup_devices(ACPI_STATE_S0);
+
+	/* Change the configuration of GPEs to avoid spurious wakeup. */
+	acpi_enable_all_wakeup_gpes();
+	acpi_os_wait_events_complete();
+
+	s2idle_wakeup = true;
+	return 0;
+}
+
+bool acpi_s2idle_wake(void)
+{
+	if (!acpi_sci_irq_valid())
+		return pm_wakeup_pending();
+
+	while (pm_wakeup_pending()) {
+		/*
+		 * If IRQD_WAKEUP_ARMED is set for the SCI at this point, the
+		 * SCI has not triggered while suspended, so bail out (the
+		 * wakeup is pending anyway and the SCI is not the source of
+		 * it).
+		 */
+		if (irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq))) {
+			pm_pr_dbg("Wakeup unrelated to ACPI SCI\n");
+			return true;
+		}
+
+		/*
+		 * If the status bit of any enabled fixed event is set, the
+		 * wakeup is regarded as valid.
+		 */
+		if (acpi_any_fixed_event_status_set()) {
+			pm_pr_dbg("ACPI fixed event wakeup\n");
+			return true;
+		}
+
+		/* Check wakeups from drivers sharing the SCI. */
+		if (acpi_check_wakeup_handlers()) {
+			pm_pr_dbg("ACPI custom handler wakeup\n");
+			return true;
+		}
+
+		/*
+		 * Check non-EC GPE wakeups and if there are none, cancel the
+		 * SCI-related wakeup and dispatch the EC GPE.
+		 */
+		if (acpi_ec_dispatch_gpe()) {
+			pm_pr_dbg("ACPI non-EC GPE wakeup\n");
+			return true;
+		}
+
+		acpi_os_wait_events_complete();
+
+		/*
+		 * The SCI is in the "suspended" state now and it cannot produce
+		 * new wakeup events till the rearming below, so if any of them
+		 * are pending here, they must be resulting from the processing
+		 * of EC events above or coming from somewhere else.
+		 */
+		if (pm_wakeup_pending()) {
+			pm_pr_dbg("Wakeup after ACPI Notify sync\n");
+			return true;
+		}
+
+		pm_pr_dbg("Rearming ACPI SCI for wakeup\n");
+
+		pm_wakeup_clear(acpi_sci_irq);
+		rearm_wake_irq(acpi_sci_irq);
+	}
+
+	return false;
+}
+
+void acpi_s2idle_restore(void)
+{
+	/*
+	 * Drain pending events before restoring the working-state configuration
+	 * of GPEs.
+	 */
+	acpi_os_wait_events_complete(); /* synchronize GPE processing */
+	acpi_ec_flush_work(); /* flush the EC driver's workqueues */
+	acpi_os_wait_events_complete(); /* synchronize Notify handling */
+
+	s2idle_wakeup = false;
+
+	acpi_enable_all_runtime_gpes();
+
+	acpi_disable_wakeup_devices(ACPI_STATE_S0);
+
+	if (acpi_sci_irq_valid()) {
+		acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
+		disable_irq_wake(acpi_sci_irq);
+	}
+}
+
+void acpi_s2idle_end(void)
+{
+	acpi_scan_lock_release();
+}
+
+static const struct platform_s2idle_ops acpi_s2idle_ops = {
+	.begin = acpi_s2idle_begin,
+	.prepare = acpi_s2idle_prepare,
+	.wake = acpi_s2idle_wake,
+	.restore = acpi_s2idle_restore,
+	.end = acpi_s2idle_end,
+};
+
+void __weak acpi_s2idle_setup(void)
+{
+	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
+		pr_info("Efficient low-power S0 idle declared\n");
+
+	s2idle_set_ops(&acpi_s2idle_ops);
+}
+
+#else /* !CONFIG_SUSPEND */
+#define s2idle_wakeup		(false)
+void acpi_s2idle_setup(void) {}
+#endif /* !CONFIG_SUSPEND */
+
+bool acpi_s2idle_wakeup(void)
+{
+	return s2idle_wakeup;
+}
+
+int __init acpi_s2idle_init(void)
+{
+	acpi_s2idle_setup();
+	return 0;
+}
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 66ec81e306d4..3dd8eebd7efd 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -716,143 +716,6 @@ static const struct platform_suspend_ops acpi_suspend_ops_old = {
 	.recover = acpi_pm_finish,
 };
 
-static bool s2idle_wakeup;
-
-int acpi_s2idle_begin(void)
-{
-	acpi_scan_lock_acquire();
-	return 0;
-}
-
-int acpi_s2idle_prepare(void)
-{
-	if (acpi_sci_irq_valid()) {
-		int error;
-
-		error = enable_irq_wake(acpi_sci_irq);
-		if (error)
-			pr_warn("Warning: Failed to enable wakeup from IRQ %d: %d\n",
-				acpi_sci_irq, error);
-
-		acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
-	}
-
-	acpi_enable_wakeup_devices(ACPI_STATE_S0);
-
-	/* Change the configuration of GPEs to avoid spurious wakeup. */
-	acpi_enable_all_wakeup_gpes();
-	acpi_os_wait_events_complete();
-
-	s2idle_wakeup = true;
-	return 0;
-}
-
-bool acpi_s2idle_wake(void)
-{
-	if (!acpi_sci_irq_valid())
-		return pm_wakeup_pending();
-
-	while (pm_wakeup_pending()) {
-		/*
-		 * If IRQD_WAKEUP_ARMED is set for the SCI at this point, the
-		 * SCI has not triggered while suspended, so bail out (the
-		 * wakeup is pending anyway and the SCI is not the source of
-		 * it).
-		 */
-		if (irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq))) {
-			pm_pr_dbg("Wakeup unrelated to ACPI SCI\n");
-			return true;
-		}
-
-		/*
-		 * If the status bit of any enabled fixed event is set, the
-		 * wakeup is regarded as valid.
-		 */
-		if (acpi_any_fixed_event_status_set()) {
-			pm_pr_dbg("ACPI fixed event wakeup\n");
-			return true;
-		}
-
-		/* Check wakeups from drivers sharing the SCI. */
-		if (acpi_check_wakeup_handlers()) {
-			pm_pr_dbg("ACPI custom handler wakeup\n");
-			return true;
-		}
-
-		/*
-		 * Check non-EC GPE wakeups and if there are none, cancel the
-		 * SCI-related wakeup and dispatch the EC GPE.
-		 */
-		if (acpi_ec_dispatch_gpe()) {
-			pm_pr_dbg("ACPI non-EC GPE wakeup\n");
-			return true;
-		}
-
-		acpi_os_wait_events_complete();
-
-		/*
-		 * The SCI is in the "suspended" state now and it cannot produce
-		 * new wakeup events till the rearming below, so if any of them
-		 * are pending here, they must be resulting from the processing
-		 * of EC events above or coming from somewhere else.
-		 */
-		if (pm_wakeup_pending()) {
-			pm_pr_dbg("Wakeup after ACPI Notify sync\n");
-			return true;
-		}
-
-		pm_pr_dbg("Rearming ACPI SCI for wakeup\n");
-
-		pm_wakeup_clear(acpi_sci_irq);
-		rearm_wake_irq(acpi_sci_irq);
-	}
-
-	return false;
-}
-
-void acpi_s2idle_restore(void)
-{
-	/*
-	 * Drain pending events before restoring the working-state configuration
-	 * of GPEs.
-	 */
-	acpi_os_wait_events_complete(); /* synchronize GPE processing */
-	acpi_ec_flush_work(); /* flush the EC driver's workqueues */
-	acpi_os_wait_events_complete(); /* synchronize Notify handling */
-
-	s2idle_wakeup = false;
-
-	acpi_enable_all_runtime_gpes();
-
-	acpi_disable_wakeup_devices(ACPI_STATE_S0);
-
-	if (acpi_sci_irq_valid()) {
-		acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
-		disable_irq_wake(acpi_sci_irq);
-	}
-}
-
-void acpi_s2idle_end(void)
-{
-	acpi_scan_lock_release();
-}
-
-static const struct platform_s2idle_ops acpi_s2idle_ops = {
-	.begin = acpi_s2idle_begin,
-	.prepare = acpi_s2idle_prepare,
-	.wake = acpi_s2idle_wake,
-	.restore = acpi_s2idle_restore,
-	.end = acpi_s2idle_end,
-};
-
-void __weak acpi_s2idle_setup(void)
-{
-	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
-		pr_info("Efficient low-power S0 idle declared\n");
-
-	s2idle_set_ops(&acpi_s2idle_ops);
-}
-
 static void __init acpi_sleep_suspend_setup(void)
 {
 	bool suspend_ops_needed = false;
@@ -867,20 +730,12 @@ static void __init acpi_sleep_suspend_setup(void)
 	if (suspend_ops_needed)
 		suspend_set_ops(old_suspend_ordering ?
 				&acpi_suspend_ops_old : &acpi_suspend_ops);
-
-	acpi_s2idle_setup();
 }
 
 #else /* !CONFIG_SUSPEND */
-#define s2idle_wakeup		(false)
 static inline void acpi_sleep_suspend_setup(void) {}
 #endif /* !CONFIG_SUSPEND */
 
-bool acpi_s2idle_wakeup(void)
-{
-	return s2idle_wakeup;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static u32 saved_bm_rld;
 
-- 
2.25.1


