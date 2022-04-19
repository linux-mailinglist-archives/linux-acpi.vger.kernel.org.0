Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16620506F90
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Apr 2022 15:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344750AbiDSOAh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Apr 2022 10:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbiDSOAg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Apr 2022 10:00:36 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFAC38DB4
        for <linux-acpi@vger.kernel.org>; Tue, 19 Apr 2022 06:57:51 -0700 (PDT)
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 23JDvF6E043713;
        Tue, 19 Apr 2022 22:57:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Tue, 19 Apr 2022 22:57:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 23JDvEXF043698
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Apr 2022 22:57:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <892bb009-4ba8-15fa-c8f9-eb66ab75b2f0@I-love.SAKURA.ne.jp>
Date:   Tue, 19 Apr 2022 22:57:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-acpi@vger.kernel.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] ACPI: Avoid flush_scheduled_work() usage
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Flushing system-wide workqueues is dangerous and will be forbidden.
Replace system_wq with local acpi_wq.

Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
This patch blindly converts schedule_{,rcu_}work() into queue_{,rcu_}work()
within drivers/acpi/ directory, based on an assumption that none of work items
outside of drivers/acpi/ directory needs to be handled by acpi_wq.
Also, I kept sharing acpi_wq between acpi/ and acpi/apei, based on assumption
that sharing is safe and correct behavior. Did I convert correctly?

 drivers/acpi/acpi_video.c         | 2 +-
 drivers/acpi/apei/apei-internal.h | 1 +
 drivers/acpi/apei/ghes.c          | 2 +-
 drivers/acpi/bus.c                | 2 +-
 drivers/acpi/internal.h           | 1 +
 drivers/acpi/osl.c                | 6 +++++-
 drivers/acpi/scan.c               | 2 +-
 drivers/acpi/video_detect.c       | 2 +-
 8 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 990ff5b0aeb8..18a5b8dd766e 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1637,7 +1637,7 @@ static void brightness_switch_event(struct acpi_video_device *video_device,
 		return;
 
 	video_device->switch_brightness_event = event;
-	schedule_delayed_work(&video_device->switch_brightness_work, HZ / 10);
+	queue_delayed_work(acpi_wq, &video_device->switch_brightness_work, HZ / 10);
 }
 
 static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index 1d6ef9654725..205dcacf8abf 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -136,4 +136,5 @@ int cper_estatus_check_header(const struct acpi_hest_generic_status *estatus);
 int cper_estatus_check(const struct acpi_hest_generic_status *estatus);
 
 int apei_osc_setup(void);
+extern struct workqueue_struct *acpi_wq;
 #endif
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d91ad378c00d..871b5f6c2b45 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -619,7 +619,7 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 	entry->error_severity = sev;
 
 	INIT_WORK(&entry->work, ghes_vendor_record_work_func);
-	schedule_work(&entry->work);
+	queue_work(acpi_wq, &entry->work);
 }
 
 static bool ghes_do_proc(struct ghes *ghes,
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index e807bffc0804..7dae7f884187 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -608,7 +608,7 @@ static void acpi_sb_notify(acpi_handle handle, u32 event, void *data)
 
 	if (event == ACPI_SB_NOTIFY_SHUTDOWN_REQUEST) {
 		if (!work_busy(&acpi_sb_work))
-			schedule_work(&acpi_sb_work);
+			queue_work(acpi_wq, &acpi_sb_work);
 	} else
 		pr_warn("event %x is not supported by \\_SB device\n", event);
 }
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 628bf8f18130..5f77c7c573a6 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -77,6 +77,7 @@ void acpi_lpss_init(void);
 #else
 static inline void acpi_lpss_init(void) {}
 #endif
+extern struct workqueue_struct *acpi_wq;
 
 void acpi_apd_init(void);
 
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 7a70c4bfc23c..1725125890cd 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -64,6 +64,7 @@ static int (*__acpi_os_prepare_extended_sleep)(u8 sleep_state, u32 val_a,
 
 static acpi_osd_handler acpi_irq_handler;
 static void *acpi_irq_context;
+struct workqueue_struct *acpi_wq;
 static struct workqueue_struct *kacpid_wq;
 static struct workqueue_struct *kacpi_notify_wq;
 static struct workqueue_struct *kacpi_hotplug_wq;
@@ -1575,7 +1576,7 @@ acpi_status acpi_release_memory(acpi_handle handle, struct resource *res,
 	 */
 	synchronize_rcu();
 	rcu_barrier();
-	flush_scheduled_work();
+	flush_workqueue(acpi_wq);
 
 	return AE_OK;
 }
@@ -1755,9 +1756,11 @@ acpi_status __init acpi_os_initialize(void)
 
 acpi_status __init acpi_os_initialize1(void)
 {
+	acpi_wq = alloc_workqueue("acpi", 0, 0);
 	kacpid_wq = alloc_workqueue("kacpid", 0, 1);
 	kacpi_notify_wq = alloc_workqueue("kacpi_notify", 0, 1);
 	kacpi_hotplug_wq = alloc_ordered_workqueue("kacpi_hotplug", 0);
+	BUG_ON(!acpi_wq);
 	BUG_ON(!kacpid_wq);
 	BUG_ON(!kacpi_notify_wq);
 	BUG_ON(!kacpi_hotplug_wq);
@@ -1786,6 +1789,7 @@ acpi_status acpi_os_terminate(void)
 	destroy_workqueue(kacpid_wq);
 	destroy_workqueue(kacpi_notify_wq);
 	destroy_workqueue(kacpi_hotplug_wq);
+	destroy_workqueue(acpi_wq);
 
 	return AE_OK;
 }
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 762b61f67e6c..f16aaec445f2 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2676,7 +2676,7 @@ void acpi_scan_table_notify(void)
 		return;
 
 	INIT_WORK(work, acpi_table_events_fn);
-	schedule_work(work);
+	queue_work(acpi_wq, work);
 }
 
 int acpi_reconfig_notifier_register(struct notifier_block *nb)
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index becc198e4c22..441664275645 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -529,7 +529,7 @@ static int acpi_video_backlight_notify(struct notifier_block *nb,
 	/* A raw bl registering may change video -> native */
 	if (backlight->props.type == BACKLIGHT_RAW &&
 	    val == BACKLIGHT_REGISTERED)
-		schedule_work(&backlight_notify_work);
+		queue_work(acpi_wq, &backlight_notify_work);
 
 	return NOTIFY_OK;
 }
-- 
2.32.0

