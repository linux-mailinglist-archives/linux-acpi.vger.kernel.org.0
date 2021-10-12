Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CD042A72B
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 16:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbhJLObf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 10:31:35 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:59237 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237150AbhJLObe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Oct 2021 10:31:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UrbBHyu_1634048958;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0UrbBHyu_1634048958)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Oct 2021 22:29:26 +0800
From:   Liguang Zhang <zhangliguang@linux.alibaba.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Liguang Zhang <zhangliguang@linux.alibaba.com>
Subject: [PATCH V2] ACPI / APEI: restore interrupt before panic in sdei flow
Date:   Tue, 12 Oct 2021 22:29:10 +0800
Message-Id: <20211012142910.9688-1-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When hest acpi table configure Hardware Error Notification type as
Software Delegated Exception(0x0B) for RAS event, OS RAS interacts with
ATF by SDEI mechanism. On the firmware first system, OS was notified by
ATF sdei call.

The calling flow like as below when fatal RAS error happens:

ATF notify OS flow:
  sdei_dispatch_event()
    ehf_activate_priority()
      call sdei callback  // callback registered by OS
    ehf_deactivate_priority()

OS sdei callback:
  sdei_asm_handler()
    __sdei_handler()
      _sdei_handler()
        sdei_event_handler()
          ghes_sdei_critical_callback()
            ghes_in_nmi_queue_one_entry()
              /* if RAS error is fatal */
              __ghes_panic()
                panic()

If fatal RAS error occured, panic was called in sdei_asm_handle()
without ehf_deactivate_priority executed, which lead interrupt masked.
If interrupt masked, system would be halted in kdump flow like this:

arm-smmu-v3 arm-smmu-v3.3.auto: allocated 65536 entries for cmdq
arm-smmu-v3 arm-smmu-v3.3.auto: allocated 32768 entries for evtq
arm-smmu-v3 arm-smmu-v3.3.auto: allocated 65536 entries for priq
arm-smmu-v3 arm-smmu-v3.3.auto: SMMU currently enabled! Resetting...

After debug, we found accurate halted position is:
arm_smmu_device_probe()
  arm_smmu_device_reset()
    arm_smmu_device_disable()
      arm_smmu_write_reg_sync()
        readl_relaxed_poll_timeout()
          readx_poll_timeout()
            read_poll_timeout()
              usleep_range() // hrtimer is never waked.

So interrupt should be restored before panic otherwise kdump will trigger
error. In the process of sdei, a SDEI_EVENT_COMPLETE_AND_RESUME call
should be called before panic for a completed run of ehf_deactivate_priority().

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c    | 25 +++++++++++++++++++++----
 drivers/firmware/arm_sdei.c | 14 ++++++++++++++
 include/linux/arm_sdei.h    |  2 ++
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 0c8330ed1ffd..4f734c60987c 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -141,6 +141,7 @@ static unsigned long ghes_estatus_pool_size_request;
 static struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
 
+static bool ghes_sdei_callback;
 static int ghes_panic_timeout __read_mostly = 30;
 
 static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
@@ -837,18 +838,30 @@ static void ghes_estatus_cache_add(
 	rcu_read_unlock();
 }
 
+static void sdei_api_restore_ras(void)
+{
+	/* reboot to log the error! */
+	if (!panic_timeout)
+		panic_timeout = ghes_panic_timeout;
+	panic("Fatal hardware error!");
+}
+
 static void __ghes_panic(struct ghes *ghes,
 			 struct acpi_hest_generic_status *estatus,
 			 u64 buf_paddr, enum fixed_addresses fixmap_idx)
 {
+	int err;
+
 	__ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
 
 	ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
 
-	/* reboot to log the error! */
-	if (!panic_timeout)
-		panic_timeout = ghes_panic_timeout;
-	panic("Fatal hardware error!");
+	if (ghes_sdei_callback) {
+		err = sdei_api_event_complete_and_resume((unsigned long)sdei_api_restore_ras);
+		if (err)
+			sdei_api_restore_ras();
+	} else
+		sdei_api_restore_ras();
 }
 
 static int ghes_proc(struct ghes *ghes)
@@ -1224,7 +1237,9 @@ static int ghes_sdei_normal_callback(u32 event_num, struct pt_regs *regs,
 	int err;
 
 	raw_spin_lock(&ghes_notify_lock_sdei_normal);
+	ghes_sdei_callback = true;
 	err = __ghes_sdei_callback(ghes, FIX_APEI_GHES_SDEI_NORMAL);
+	ghes_sdei_callback = false;
 	raw_spin_unlock(&ghes_notify_lock_sdei_normal);
 
 	return err;
@@ -1238,7 +1253,9 @@ static int ghes_sdei_critical_callback(u32 event_num, struct pt_regs *regs,
 	int err;
 
 	raw_spin_lock(&ghes_notify_lock_sdei_critical);
+	ghes_sdei_callback = true;
 	err = __ghes_sdei_callback(ghes, FIX_APEI_GHES_SDEI_CRITICAL);
+	ghes_sdei_callback = false;
 	raw_spin_unlock(&ghes_notify_lock_sdei_critical);
 
 	return err;
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index a7e762c352f9..1af6b6b55c57 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -473,6 +473,20 @@ static int sdei_api_event_unregister(u32 event_num)
 			      0, 0, 0, NULL);
 }
 
+int sdei_api_event_complete_and_resume(u64 addr)
+{
+	int err;
+
+	err = invoke_sdei_fn(SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME, addr,
+			      0, 0, 0, 0, NULL);
+	if (err && err != -EIO) {
+		pr_warn_once("failed to restore CPU[%u]: %d\n", smp_processor_id(), err);
+		return err;
+	}
+
+	return 0;
+}
+
 /* Called directly by the hotplug callbacks */
 static void _local_event_unregister(void *data)
 {
diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
index 0a241c5c911d..b6d347085834 100644
--- a/include/linux/arm_sdei.h
+++ b/include/linux/arm_sdei.h
@@ -46,9 +46,11 @@ int sdei_unregister_ghes(struct ghes *ghes);
 /* For use by arch code when CPU hotplug notifiers are not appropriate. */
 int sdei_mask_local_cpu(void);
 int sdei_unmask_local_cpu(void);
+int sdei_api_event_complete_and_resume(u64 addr);
 #else
 static inline int sdei_mask_local_cpu(void) { return 0; }
 static inline int sdei_unmask_local_cpu(void) { return 0; }
+int sdei_api_event_complete_and_resume(u64 addr) { return 0; }
 #endif /* CONFIG_ARM_SDE_INTERFACE */
 
 
-- 
2.19.1.6.gb485710b

