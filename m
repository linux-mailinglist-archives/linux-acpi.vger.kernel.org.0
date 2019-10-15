Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB1F7D70AD
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2019 10:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfJOIEI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Oct 2019 04:04:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:60385 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfJOIEI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Oct 2019 04:04:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 01:04:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,298,1566889200"; 
   d="scan'208";a="201691351"
Received: from fyin-dev.sh.intel.com ([10.239.143.122])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Oct 2019 01:04:06 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI / processor_idle: use ndelay instead of io port access for wait
Date:   Tue, 15 Oct 2019 16:04:04 +0800
Message-Id: <20191015080404.6013-1-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In function acpi_idle_do_entry(), an ioport access is used for dummy
wait to guarantee hardware behavior. But it could trigger unnecessary
vmexit in virtualization environment.

If we run linux as guest and export all available native C state to
guest, we did see many PM timer access triggered VMexit when guest
enter deeper C state in our environment (We used ACRN hypervisor
instead of kvm or xen which has PM timer emulated and exports all
native C state to guest).

According to the original comments of this part of code, io port
access is only for dummy wait. We could use busy wait instead of io
port access to guarantee hardware behavior and avoid unnecessary
VMexit.

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
ChangeLog:
v1 -> v2:
   - Use ndelay instead of dead loop for dummy delay.

 drivers/acpi/processor_idle.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index ed56c6d20b08..38968d31af28 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -14,6 +14,7 @@
 
 #include <linux/module.h>
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/sched.h>       /* need_resched() */
 #include <linux/tick.h>
@@ -55,6 +56,8 @@ struct cpuidle_driver acpi_idle_driver = {
 };
 
 #ifdef CONFIG_ACPI_PROCESSOR_CSTATE
+static s64 cx_dummy_wait_ns = 0L;
+
 static
 DEFINE_PER_CPU(struct acpi_processor_cx * [CPUIDLE_STATE_MAX], acpi_cstate);
 
@@ -64,6 +67,11 @@ static int disabled_by_idle_boot_param(void)
 		boot_option_idle_override == IDLE_HALT;
 }
 
+static void cx_dummy_wait(void)
+{
+	ndelay(cx_dummy_wait_ns);
+}
+
 /*
  * IBM ThinkPad R40e crashes mysteriously when going into C2 or C3.
  * For now disable this. Probably a bug somewhere else.
@@ -660,8 +668,13 @@ static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
 		inb(cx->address);
 		/* Dummy wait op - must do something useless after P_LVL2 read
 		   because chipsets cannot guarantee that STPCLK# signal
-		   gets asserted in time to freeze execution properly. */
-		inl(acpi_gbl_FADT.xpm_timer_block.address);
+		   gets asserted in time to freeze execution properly.
+
+		   Previously, we do io port access here for delay here. Which
+		   could trigger unnecessary trap to HV. Now, we use dead loop
+		   here to avoid the impact to virtualization env */
+
+		cx_dummy_wait();
 	}
 }
 
@@ -683,7 +696,7 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 		else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
 			inb(cx->address);
 			/* See comment in acpi_idle_do_entry() */
-			inl(acpi_gbl_FADT.xpm_timer_block.address);
+			cx_dummy_wait();
 		} else
 			return -ENODEV;
 	}
@@ -902,6 +915,7 @@ static inline void acpi_processor_cstate_first_run_checks(void)
 {
 	acpi_status status;
 	static int first_run;
+	struct timespec64 ts0, ts1;
 
 	if (first_run)
 		return;
@@ -912,6 +926,14 @@ static inline void acpi_processor_cstate_first_run_checks(void)
 			  max_cstate);
 	first_run++;
 
+	/* profiling the time used for dummy wait op */
+	ktime_get_real_ts64(&ts0);
+	inl(acpi_gbl_FADT.xpm_timer_block.address);
+	ktime_get_real_ts64(&ts1);
+
+	ts1 = timespec64_sub(ts1, ts0);
+	cx_dummy_wait_ns = timespec64_to_ns(&ts1);
+
 	if (acpi_gbl_FADT.cst_control && !nocst) {
 		status = acpi_os_write_port(acpi_gbl_FADT.smi_command,
 					    acpi_gbl_FADT.cst_control, 8);
-- 
2.19.1

