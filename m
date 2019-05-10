Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB0F19B06
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2019 12:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfEJKJ2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 May 2019 06:09:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:51551 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfEJKJ1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 May 2019 06:09:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 03:09:27 -0700
X-ExtLoop1: 1
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga008.fm.intel.com with ESMTP; 10 May 2019 03:09:25 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTPS id D8DD820A47;
        Fri, 10 May 2019 13:09:24 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1hP2T6-0003p0-05; Fri, 10 May 2019 13:09:32 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rajmohan.mani@intel.com, linux-media@vger.kernel.org
Subject: [PATCH 2/5] ACPI: Add a convenience function to tell a device is suspended in probe
Date:   Fri, 10 May 2019 13:09:27 +0300
Message-Id: <20190510100930.14641-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190510100930.14641-1-sakari.ailus@linux.intel.com>
References: <20190510100930.14641-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a convenience function to tell whether a device is suspended for probe
or remove, for busses where the custom is that drivers don't need to
resume devices in probe, or suspend them in their remove handlers.

Returns false on non-ACPI systems.

Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/device_pm.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/acpi.h     |  5 +++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index ca2409a30d26d..774bf4380afd3 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1287,4 +1287,37 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 	return 1;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
+
+/**
+ * acpi_dev_powered_off_for_probe - Tell if a device is powered off for probe
+ * @dev: The device
+ *
+ * Tell whether a given device has not been powered on for probe or remove.
+ *
+ * Drivers of devices on certain busses such as I²C can generally assume (on
+ * ACPI based systems) that the devices they control are powered on without
+ * driver having to do anything about it. Using struct device_driver.probe_off
+ * and "avoid-power-probe" property, this can be negated and the driver has full
+ * control of the device power management. Always returns false on non-ACPI
+ * based systems. True is returned on ACPI based systems iff the device is
+ * powered off.
+ */
+bool acpi_dev_powered_off_for_probe(struct device *dev)
+{
+	int power_state;
+	int ret;
+
+	if (!is_acpi_device_node(dev_fwnode(dev)))
+		return false;
+
+	ret = acpi_device_get_power(ACPI_COMPANION(dev), &power_state);
+	if (ret) {
+		dev_warn(dev, "Cannot obtain power state (%d)\n", ret);
+		return false;
+	}
+
+	return power_state != ACPI_STATE_D0;
+}
+EXPORT_SYMBOL_GPL(acpi_dev_powered_off_for_probe);
+
 #endif /* CONFIG_PM */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index e22c237be46ae..fc6b97aadcf17 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -913,6 +913,7 @@ int acpi_dev_resume(struct device *dev);
 int acpi_subsys_runtime_suspend(struct device *dev);
 int acpi_subsys_runtime_resume(struct device *dev);
 int acpi_dev_pm_attach(struct device *dev, bool power_on);
+bool acpi_dev_powered_off_for_probe(struct device *dev);
 #else
 static inline int acpi_dev_runtime_suspend(struct device *dev) { return 0; }
 static inline int acpi_dev_runtime_resume(struct device *dev) { return 0; }
@@ -922,6 +923,10 @@ static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
 {
 	return 0;
 }
+static inline bool acpi_dev_powered_off_for_probe(struct device *dev)
+{
+	return false;
+}
 #endif
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
-- 
2.11.0

