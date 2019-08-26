Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE57D9CB9F
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2019 10:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbfHZIco (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Aug 2019 04:32:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:55345 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfHZIc1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Aug 2019 04:32:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 01:32:26 -0700
X-IronPort-AV: E=Sophos;i="5.64,431,1559545200"; 
   d="scan'208";a="204502153"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 01:32:25 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 9F1F820B48;
        Mon, 26 Aug 2019 11:32:23 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1i2APB-0002KE-5R; Mon, 26 Aug 2019 11:31:13 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 2/5] ACPI: Add a convenience function to tell a device is suspended in probe
Date:   Mon, 26 Aug 2019 11:31:09 +0300
Message-Id: <20190826083112.8888-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190826083112.8888-1-sakari.ailus@linux.intel.com>
References: <20190826083112.8888-1-sakari.ailus@linux.intel.com>
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
 drivers/acpi/device_pm.c | 35 +++++++++++++++++++++++++++++++++++
 include/linux/acpi.h     |  5 +++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index adcdf78ce4de8..7d6b40396ea71 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1344,4 +1344,39 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 	return 1;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
+
+/**
+ * acpi_dev_low_power_state_probe - Tell if a device is in a low power state
+ *				    during probe
+ * @dev: The device
+ *
+ * Tell whether a given device is in a low power state during the driver's probe
+ * or remove operation.
+ *
+ * Drivers of devices on certain busses such as I²C can generally assume (on
+ * ACPI based systems) that the devices they control are powered on without
+ * driver having to do anything about it. Using struct
+ * device_driver.probe_low_power and "probe-low-power" property, this can be
+ * negated and the driver has full control of the device power management.
+ * Always returns false on non-ACPI based systems. True is returned on ACPI
+ * based systems iff the device is in a low power state during probe or remove.
+ */
+bool acpi_dev_low_power_state_probe(struct device *dev)
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
+EXPORT_SYMBOL_GPL(acpi_dev_low_power_state_probe);
+
 #endif /* CONFIG_PM */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 9426b9aaed86f..a20b4246107ac 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -912,6 +912,7 @@ int acpi_dev_resume(struct device *dev);
 int acpi_subsys_runtime_suspend(struct device *dev);
 int acpi_subsys_runtime_resume(struct device *dev);
 int acpi_dev_pm_attach(struct device *dev, bool power_on);
+bool acpi_dev_low_power_state_probe(struct device *dev);
 #else
 static inline int acpi_dev_runtime_suspend(struct device *dev) { return 0; }
 static inline int acpi_dev_runtime_resume(struct device *dev) { return 0; }
@@ -921,6 +922,10 @@ static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
 {
 	return 0;
 }
+static inline bool acpi_dev_low_power_state_probe(struct device *dev)
+{
+	return false;
+}
 #endif
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
-- 
2.20.1

