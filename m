Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEB65BA2F
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2019 12:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfGAK6X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Jul 2019 06:58:23 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43078 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbfGAK6U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Jul 2019 06:58:20 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id f1d95cac40fb2e78; Mon, 1 Jul 2019 12:58:17 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        "Robert R. Howell" <RHowell@uwyo.edu>
Subject: [PATCH v2 4/5] ACPI: PM: Introduce "poweroff" callbacks for ACPI PM domain and LPSS
Date:   Mon, 01 Jul 2019 12:54:29 +0200
Message-ID: <4053873.pF5Dq2SYBR@kreacher>
In-Reply-To: <4976412.ihyb9sT5jY@kreacher>
References: <4976412.ihyb9sT5jY@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In general, it is not correct to call pm_generic_suspend(),
pm_generic_suspend_late() and pm_generic_suspend_noirq() during the
hibernation's "poweroff" transition, because device drivers may
provide special callbacks to be invoked then and the wrappers in
question cause system suspend callbacks to be run.  Unfortunately,
that happens in the ACPI PM domain and ACPI LPSS.

To address this potential issue, introduce "poweroff" callbacks
for the ACPI PM and LPSS that will use pm_generic_poweroff(),
pm_generic_poweroff_late() and pm_generic_poweroff_noirq() as
appropriate.

Fixes: 05087360fd7a (ACPI / PM: Take SMART_SUSPEND driver flag into account)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2:
 * Make the new "poweroff" callbacks for the LPSS follow the current
    acpi_lpss_suspend_late/noirq() behavior.

---
 drivers/acpi/acpi_lpss.c |   50 ++++++++++++++++++++++++++++++++++++++--
 drivers/acpi/device_pm.c |   58 ++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/acpi.h     |    2 +
 3 files changed, 104 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/acpi_lpss.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_lpss.c
+++ linux-pm/drivers/acpi/acpi_lpss.c
@@ -1061,6 +1061,13 @@ static int acpi_lpss_suspend_noirq(struc
 	int ret;
 
 	if (pdata->dev_desc->resume_from_noirq) {
+		/*
+		 * The driver's ->suspend_late callback will be invoked by
+		 * acpi_lpss_do_suspend_late(), with the assumption that the
+		 * driver really wanted to run that code in ->suspend_noirq, but
+		 * it could not run after acpi_dev_suspend() and the driver
+		 * expected the latter to be called in the "late" phase.
+		 */
 		ret = acpi_lpss_do_suspend_late(dev);
 		if (ret)
 			return ret;
@@ -1147,6 +1154,43 @@ static int acpi_lpss_restore_noirq(struc
 	/* This is analogous to what happens in acpi_lpss_resume_noirq(). */
 	return acpi_lpss_do_restore_early(dev);
 }
+
+static int acpi_lpss_do_poweroff_late(struct device *dev)
+{
+	int ret = pm_generic_poweroff_late(dev);
+
+	return ret ? ret : acpi_lpss_suspend(dev, device_may_wakeup(dev));
+}
+
+static int acpi_lpss_poweroff_late(struct device *dev)
+{
+	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
+
+	if (dev_pm_smart_suspend_and_suspended(dev))
+		return 0;
+
+	if (pdata->dev_desc->resume_from_noirq)
+		return 0;
+
+	return acpi_lpss_do_poweroff_late(dev);
+}
+
+static int acpi_lpss_poweroff_noirq(struct device *dev)
+{
+	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
+
+	if (dev_pm_smart_suspend_and_suspended(dev))
+		return 0;
+
+	if (pdata->dev_desc->resume_from_noirq) {
+		/* This is analogous to the acpi_lpss_suspend_noirq() case. */
+		int ret = acpi_lpss_do_poweroff_late(dev);
+		if (ret)
+			return ret;
+	}
+
+	return pm_generic_poweroff_noirq(dev);
+}
 #endif /* CONFIG_PM_SLEEP */
 
 static int acpi_lpss_runtime_suspend(struct device *dev)
@@ -1180,9 +1224,9 @@ static struct dev_pm_domain acpi_lpss_pm
 		.resume_noirq = acpi_lpss_resume_noirq,
 		.resume_early = acpi_lpss_resume_early,
 		.freeze = acpi_subsys_freeze,
-		.poweroff = acpi_subsys_suspend,
-		.poweroff_late = acpi_lpss_suspend_late,
-		.poweroff_noirq = acpi_lpss_suspend_noirq,
+		.poweroff = acpi_subsys_poweroff,
+		.poweroff_late = acpi_lpss_poweroff_late,
+		.poweroff_noirq = acpi_lpss_poweroff_noirq,
 		.restore_noirq = acpi_lpss_restore_noirq,
 		.restore_early = acpi_lpss_restore_early,
 #endif
Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -1176,6 +1176,58 @@ int acpi_subsys_restore_early(struct dev
 	return ret ? ret : pm_generic_restore_early(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_restore_early);
+
+/**
+ * acpi_subsys_poweroff - Run the device driver's poweroff callback.
+ * @dev: Device to handle.
+ *
+ * Follow PCI and resume devices from runtime suspend before running their
+ * system poweroff callbacks, unless the driver can cope with runtime-suspended
+ * devices during system suspend and there are no ACPI-specific reasons for
+ * resuming them.
+ */
+int acpi_subsys_poweroff(struct device *dev)
+{
+	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
+	    acpi_dev_needs_resume(dev, ACPI_COMPANION(dev)))
+		pm_runtime_resume(dev);
+
+	return pm_generic_poweroff(dev);
+}
+EXPORT_SYMBOL_GPL(acpi_subsys_poweroff);
+
+/**
+ * acpi_subsys_poweroff_late - Run the device driver's poweroff callback.
+ * @dev: Device to handle.
+ *
+ * Carry out the generic late poweroff procedure for @dev and use ACPI to put
+ * it into a low-power state during system transition into a sleep state.
+ */
+static int acpi_subsys_poweroff_late(struct device *dev)
+{
+	int ret;
+
+	if (dev_pm_smart_suspend_and_suspended(dev))
+		return 0;
+
+	ret = pm_generic_poweroff_late(dev);
+	if (ret)
+		return ret;
+
+	return acpi_dev_suspend(dev, device_may_wakeup(dev));
+}
+
+/**
+ * acpi_subsys_poweroff_noirq - Run the driver's "noirq" poweroff callback.
+ * @dev: Device to suspend.
+ */
+static int acpi_subsys_poweroff_noirq(struct device *dev)
+{
+	if (dev_pm_smart_suspend_and_suspended(dev))
+		return 0;
+
+	return pm_generic_poweroff_noirq(dev);
+}
 #endif /* CONFIG_PM_SLEEP */
 
 static struct dev_pm_domain acpi_general_pm_domain = {
@@ -1191,9 +1243,9 @@ static struct dev_pm_domain acpi_general
 		.resume_noirq = acpi_subsys_resume_noirq,
 		.resume_early = acpi_subsys_resume_early,
 		.freeze = acpi_subsys_freeze,
-		.poweroff = acpi_subsys_suspend,
-		.poweroff_late = acpi_subsys_suspend_late,
-		.poweroff_noirq = acpi_subsys_suspend_noirq,
+		.poweroff = acpi_subsys_poweroff,
+		.poweroff_late = acpi_subsys_poweroff_late,
+		.poweroff_noirq = acpi_subsys_poweroff_noirq,
 		.restore_early = acpi_subsys_restore_early,
 #endif
 	},
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -920,6 +920,7 @@ int acpi_subsys_suspend_late(struct devi
 int acpi_subsys_suspend_noirq(struct device *dev);
 int acpi_subsys_suspend(struct device *dev);
 int acpi_subsys_freeze(struct device *dev);
+int acpi_subsys_poweroff(struct device *dev);
 #else
 static inline int acpi_dev_resume_early(struct device *dev) { return 0; }
 static inline int acpi_subsys_prepare(struct device *dev) { return 0; }
@@ -928,6 +929,7 @@ static inline int acpi_subsys_suspend_la
 static inline int acpi_subsys_suspend_noirq(struct device *dev) { return 0; }
 static inline int acpi_subsys_suspend(struct device *dev) { return 0; }
 static inline int acpi_subsys_freeze(struct device *dev) { return 0; }
+static inline int acpi_subsys_poweroff(struct device *dev) { return 0; }
 #endif
 
 #ifdef CONFIG_ACPI



