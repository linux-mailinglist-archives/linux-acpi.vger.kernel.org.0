Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 988E1E2AB6
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2019 09:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437853AbfJXHEY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Oct 2019 03:04:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:61925 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbfJXHEY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 24 Oct 2019 03:04:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 00:04:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,223,1569308400"; 
   d="scan'208";a="201382240"
Received: from fyin-dev.sh.intel.com ([10.239.143.122])
  by orsmga003.jf.intel.com with ESMTP; 24 Oct 2019 00:04:22 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rjw@rjwysocki.net, rafael@kernel.org, lenb@kernel.org
Cc:     fengwei.yin@intel.com
Subject: [PATCH v4] ACPI/processor_idle: Remove dummy wait if kernel is in guest
Date:   Thu, 24 Oct 2019 15:04:20 +0800
Message-Id: <20191024070420.4512-1-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In function acpi_idle_do_entry(), an ioport access is used for
dummy wait to guarantee hardware behavior. But it could trigger
unnecessary VMexit if kernel is running as guest in virtualization
environment.

If it's in virtualization environment, the deeper C state enter
operation (inb()) will trap to hypervisor. It's not needed to do
dummy wait after the inb() call. So we could just remove the
dummy io port access to avoid unnecessary VMexit.

And keep dummy io port access to maintain timing for native
environment.

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
ChangeLog:
v3 -> v4:
 - Drop overengineered function pointer and do check whether
   we are in guest before dummy inl call.

v2 -> v3:
 - Remove dummy io port access totally for virtualization env.

v1 -> v2:
 - Use ndelay instead of dead loop for dummy delay.

 drivers/acpi/processor_idle.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index ed56c6d20b08..2ae95df2e74f 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -642,6 +642,19 @@ static int acpi_idle_bm_check(void)
 	return bm_status;
 }
 
+static void wait_for_freeze(void)
+{
+#ifdef	CONFIG_X86
+	/* No delay is needed if we are in guest */
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return;
+#endif
+	/* Dummy wait op - must do something useless after P_LVL2 read
+	   because chipsets cannot guarantee that STPCLK# signal
+	   gets asserted in time to freeze execution properly. */
+	inl(acpi_gbl_FADT.xpm_timer_block.address);
+}
+
 /**
  * acpi_idle_do_entry - enter idle state using the appropriate method
  * @cx: cstate data
@@ -658,10 +671,7 @@ static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
 	} else {
 		/* IO port based C-state */
 		inb(cx->address);
-		/* Dummy wait op - must do something useless after P_LVL2 read
-		   because chipsets cannot guarantee that STPCLK# signal
-		   gets asserted in time to freeze execution properly. */
-		inl(acpi_gbl_FADT.xpm_timer_block.address);
+		wait_for_freeze();
 	}
 }
 
@@ -682,8 +692,7 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 			safe_halt();
 		else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
 			inb(cx->address);
-			/* See comment in acpi_idle_do_entry() */
-			inl(acpi_gbl_FADT.xpm_timer_block.address);
+			wait_for_freeze();
 		} else
 			return -ENODEV;
 	}
-- 
2.19.1

