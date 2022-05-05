Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2CC51B586
	for <lists+linux-acpi@lfdr.de>; Thu,  5 May 2022 03:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiEECCU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 May 2022 22:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbiEECCS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 May 2022 22:02:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C14251E4F;
        Wed,  4 May 2022 18:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651715917; x=1683251917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5JGo0CUXEeDd0hKD63fYj2DEOqA2I95e7owhFGJ3cD0=;
  b=T2vi7lviGPNuzJvBAs+HON3xp/9sCWSnLTDimeia0D56KrotSEV/osNb
   cSmPXn9jx54NpSw9Z/xa0wZlefRSSsxmLNzQc0cuJSHUPIf84XCQk2wlW
   Y1W+ITpjRceo7oJbyYnxUWma9Ux7IsMXEg+kCqK3xVOngKBlexFeHSnPd
   WYLEo3dv4ud/1r5DW6is32jnywbQKSZCsU+pnxbwO/yF+6euoSCfdissl
   aLRU9OLGvSG0cD44ahEv0bqg5VVUYI7uDI5EQXqwNfERfHGCzABWIaN4c
   AAavDzmW/fEr0Vznirer6G/oq7LbWPn3WRYZuAHazalNtvkaBMfBgAQ7l
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="293153507"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="293153507"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 18:58:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="537106061"
Received: from rzhang1-dev.sh.intel.com ([10.239.48.43])
  by orsmga006.jf.intel.com with ESMTP; 04 May 2022 18:58:33 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, kvalo@kernel.org, alexandre.belloni@bootlin.com
Cc:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-wireless@vger.kernel.org,
        daniel.lezcano@linaro.org, merez@codeaurora.org, mat.jonczyk@o2.pl,
        sumeet.r.pawnikar@intel.com, len.brown@intel.com
Subject: [PATCH 7/7] rtc: cmos: Add suspend/resume endurance testing hook
Date:   Thu,  5 May 2022 09:58:14 +0800
Message-Id: <20220505015814.3727692-8-rui.zhang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220505015814.3727692-1-rui.zhang@intel.com>
References: <20220505015814.3727692-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Automated suspend/resume testing uses the RTC for wakeup.
A short rtcwake period is desirable, so that more suspend/resume
cycles can be completed, while the machine is available for testing.

But if too short a wake interval is specified, the event can occur,
while still suspending, and then no event wakes the suspended system
until the user notices that testing has stalled, and manually intervenes.

Here we add a hook to the rtc-cmos driver to
a) remove the alarm timer in the beginning of suspend, if there is any
b) arm the wakeup in PM notifier callback, which is in the very late stage
   before the system really suspends
The remaining part of suspend is usually measured under 10 ms,
and so arming the timer at this point could be as fast as the minimum
time of 1-second.

But there is a 2nd race.  The RTC has 1-second granularity, and unless
you are timing the timer with a higher resolution timer,
there is no telling if the current time + 1 will occur immediately,
or a full second in the future.  And so 2-seconds is the safest minimum:

Run 1,000 s2idle cycles with (max of) 2 second wakeup period:

 # echo 2 > /sys/module/rtc_cmos/parameters/rtc_wake_override_sec
 # sleepgraph.py -m freeze -multi 1000 0 -skiphtml -gzip

Clear the timer override, to not interfere with subsequent
real use of the machine's suspend/resume feature:

 # echo 0 > /sys/module/rtc_cmos/parameters/rtc_wake_override_sec

Originally-by: Len Brown <len.brown@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/rtc/interface.c |  1 +
 drivers/rtc/rtc-cmos.c  | 45 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 9edd662c69ac..fb93aa2dc99c 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -1020,6 +1020,7 @@ void rtc_timer_cancel(struct rtc_device *rtc, struct rtc_timer *timer)
 		rtc_timer_remove(rtc, timer);
 	mutex_unlock(&rtc->ops_lock);
 }
+EXPORT_SYMBOL_GPL(rtc_timer_cancel);
 
 /**
  * rtc_read_offset - Read the amount of rtc offset in parts per billion
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 7c006c2b125f..9590c40fa9d8 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -32,6 +32,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
+#include <linux/suspend.h>
 #include <linux/platform_device.h>
 #include <linux/log2.h>
 #include <linux/pm.h>
@@ -70,6 +71,9 @@ static inline int cmos_use_acpi_alarm(void)
 }
 #endif
 
+static int rtc_wake_override_sec;
+module_param(rtc_wake_override_sec, int, 0644);
+
 struct cmos_rtc {
 	struct rtc_device	*rtc;
 	struct device		*dev;
@@ -89,6 +93,7 @@ struct cmos_rtc {
 	u8			century;
 
 	struct rtc_wkalrm	saved_wkalrm;
+	struct notifier_block	pm_nb;
 };
 
 /* both platform and pnp busses use negative numbers for invalid irqs */
@@ -744,6 +749,42 @@ static irqreturn_t cmos_interrupt(int irq, void *p)
 		return IRQ_NONE;
 }
 
+static int cmos_pm_notify(struct notifier_block *nb, unsigned long mode, void *_unused)
+{
+	struct cmos_rtc *cmos = container_of(nb, struct cmos_rtc, pm_nb);
+	struct rtc_device       *rtc = cmos->rtc;
+	unsigned long           now;
+	struct rtc_wkalrm       alm;
+
+	if (rtc_wake_override_sec == 0)
+		return NOTIFY_OK;
+
+	switch (mode) {
+	case PM_SUSPEND_PREPARE:
+		/*
+		 * Cancel the timer to make sure it won't fire
+		 * before rtc is rearmed later.
+		 */
+		rtc_timer_cancel(rtc, &rtc->aie_timer);
+		break;
+	case PM_SUSPEND_LATE:
+		if (rtc_read_time(rtc, &alm.time))
+			return NOTIFY_BAD;
+
+		now = rtc_tm_to_time64(&alm.time);
+		memset(&alm, 0, sizeof(alm));
+		rtc_time64_to_tm(now + rtc_wake_override_sec, &alm.time);
+		alm.enabled = true;
+		if (rtc_set_alarm(rtc, &alm))
+			return NOTIFY_BAD;
+		if (cmos->wake_on)
+			cmos->wake_on(cmos->dev);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
 #ifdef	CONFIG_PNP
 #define	INITSECTION
 
@@ -937,6 +978,9 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 		 nvmem_cfg.size,
 		 use_hpet_alarm() ? ", hpet irqs" : "");
 
+	cmos_rtc.pm_nb.notifier_call = cmos_pm_notify;
+	register_pm_notifier(&cmos_rtc.pm_nb);
+
 	return 0;
 
 cleanup2:
@@ -965,6 +1009,7 @@ static void cmos_do_remove(struct device *dev)
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
 	struct resource *ports;
 
+	unregister_pm_notifier(&cmos_rtc.pm_nb);
 	cmos_do_shutdown(cmos->irq);
 
 	if (is_valid_irq(cmos->irq)) {
-- 
2.17.1

