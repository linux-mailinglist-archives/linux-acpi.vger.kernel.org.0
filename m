Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98F499CB9C
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2019 10:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbfHZIcc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Aug 2019 04:32:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:42753 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729841AbfHZIc2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Aug 2019 04:32:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 01:32:27 -0700
X-IronPort-AV: E=Sophos;i="5.64,431,1559545200"; 
   d="scan'208";a="263867644"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 01:32:25 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 95CE220B47;
        Mon, 26 Aug 2019 11:32:23 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1i2APB-0002KB-3y; Mon, 26 Aug 2019 11:31:13 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/5] ACPI: Enable driver and firmware hints to control power at probe time
Date:   Mon, 26 Aug 2019 11:31:08 +0300
Message-Id: <20190826083112.8888-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190826083112.8888-1-sakari.ailus@linux.intel.com>
References: <20190826083112.8888-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Allow drivers and firmware tell ACPI that there's no need to power on a
device for probe. This requires both a hint from the firmware as well as
an indication from a driver to leave the device off.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/device_pm.c | 15 +++++++++++++--
 include/linux/device.h   |  7 +++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index f616b16c1f0be..adcdf78ce4de8 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1276,7 +1276,12 @@ static void acpi_dev_pm_detach(struct device *dev, bool power_off)
 	if (adev && dev->pm_domain == &acpi_general_pm_domain) {
 		dev_pm_domain_set(dev, NULL);
 		acpi_remove_pm_notifier(adev);
-		if (power_off) {
+		if (power_off
+#ifdef CONFIG_PM
+		    && !(dev->driver->probe_low_power &&
+			 device_property_present(dev, "probe-low-power"))
+#endif
+			) {
 			/*
 			 * If the device's PM QoS resume latency limit or flags
 			 * have been exposed to user space, they have to be
@@ -1324,7 +1329,13 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 
 	acpi_add_pm_notifier(adev, dev, acpi_pm_notify_work_func);
 	dev_pm_domain_set(dev, &acpi_general_pm_domain);
-	if (power_on) {
+
+	if (power_on
+#ifdef CONFIG_PM
+	    && !(dev->driver->probe_low_power &&
+		 device_property_present(dev, "probe-low-power"))
+#endif
+		) {
 		acpi_dev_pm_full_power(adev);
 		acpi_device_wakeup_disable(adev);
 	}
diff --git a/include/linux/device.h b/include/linux/device.h
index 6717adee33f01..4bc0ea4a3201a 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -248,6 +248,12 @@ enum probe_type {
  * @owner:	The module owner.
  * @mod_name:	Used for built-in modules.
  * @suppress_bind_attrs: Disables bind/unbind via sysfs.
+ * @probe_low_power: The driver supports its probe function being called while
+ *		     the device is in a low power state, independently of the
+ *		     expected behaviour on combination of a given bus and
+ *		     firmware interface etc. The driver is responsible for
+ *		     powering the device on using runtime PM in such case.
+ *		     This configuration has no effect if CONFIG_PM is disabled.
  * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
  * @of_match_table: The open firmware table.
  * @acpi_match_table: The ACPI match table.
@@ -285,6 +291,7 @@ struct device_driver {
 	const char		*mod_name;	/* used for built-in modules */
 
 	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
+	bool probe_low_power;
 	enum probe_type probe_type;
 
 	const struct of_device_id	*of_match_table;
-- 
2.20.1

