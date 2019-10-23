Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AADEE1369
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2019 09:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389998AbfJWHts (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Oct 2019 03:49:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:38884 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389978AbfJWHts (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Oct 2019 03:49:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 00:49:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="397961285"
Received: from fyin-dev.sh.intel.com ([10.239.143.122])
  by fmsmga005.fm.intel.com with ESMTP; 23 Oct 2019 00:49:47 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, David.Laight@aculab.com
Cc:     fengwei.yin@intel.com
Subject: [PATCH v3] ACPI/processor_idle: Remove dummy wait if kernel is in guest mode
Date:   Wed, 23 Oct 2019 15:49:45 +0800
Message-Id: <20191023074945.17016-1-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In function acpi_idle_do_entry(), an ioport access is used for dummy
wait to guarantee hardware behavior. But it could trigger unnecessary
vmexit if kernel is running as guest in virtualization environtment.

If it's in virtualization environment, the deeper C state enter
operation (inb()) will trap to hyervisor. It's not needed to do
dummy wait after the inb() call. So we remove the dummy io port
access to avoid unnecessary VMexit.

We keep dummy io port access to maintain timing for native environment.

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
ChangeLog:
v2 -> v3:
 - Remove dummy io port access totally for virtualization env.

v1 -> v2:
 - Use ndelay instead of dead loop for dummy delay.

 drivers/acpi/processor_idle.c | 36 ++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index ed56c6d20b08..0c4a97dd6917 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -58,6 +58,17 @@ struct cpuidle_driver acpi_idle_driver = {
 static
 DEFINE_PER_CPU(struct acpi_processor_cx * [CPUIDLE_STATE_MAX], acpi_cstate);
 
+static void (*dummy_wait)(u64 address);
+
+static void default_dummy_wait(u64 address)
+{
+	inl(address);
+}
+
+static void default_noop_wait(u64 address)
+{
+}
+
 static int disabled_by_idle_boot_param(void)
 {
 	return boot_option_idle_override == IDLE_POLL ||
@@ -660,8 +671,13 @@ static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
 		inb(cx->address);
 		/* Dummy wait op - must do something useless after P_LVL2 read
 		   because chipsets cannot guarantee that STPCLK# signal
-		   gets asserted in time to freeze execution properly. */
-		inl(acpi_gbl_FADT.xpm_timer_block.address);
+		   gets asserted in time to freeze execution properly.
+
+		   This dummy wait is only needed for native env. If we are running
+		   as guest of a hypervisor, we don't need wait op here. We have
+		   different implementation for dummy_wait on native/virtual env. */
+
+		dummy_wait(acpi_gbl_FADT.xpm_timer_block.address);
 	}
 }
 
@@ -683,7 +699,7 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 		else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
 			inb(cx->address);
 			/* See comment in acpi_idle_do_entry() */
-			inl(acpi_gbl_FADT.xpm_timer_block.address);
+			dummy_wait(acpi_gbl_FADT.xpm_timer_block.address);
 		} else
 			return -ENODEV;
 	}
@@ -912,6 +928,20 @@ static inline void acpi_processor_cstate_first_run_checks(void)
 			  max_cstate);
 	first_run++;
 
+	dummy_wait = default_dummy_wait;
+
+#ifdef	CONFIG_X86
+	/* For x86, if we are running in guest, we don't need extra
+	 * access ioport as dummy wait.
+	 */
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
+		pr_err("We are in virtual env");
+		dummy_wait = default_noop_wait;
+	} else {
+		pr_err("We are not in virtual env");
+	}
+#endif
+
 	if (acpi_gbl_FADT.cst_control && !nocst) {
 		status = acpi_os_write_port(acpi_gbl_FADT.smi_command,
 					    acpi_gbl_FADT.cst_control, 8);
-- 
2.19.1

