Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC2B19B05
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2019 12:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfEJKJ1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 May 2019 06:09:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:47868 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfEJKJ1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 May 2019 06:09:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 03:09:26 -0700
X-ExtLoop1: 1
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga006.jf.intel.com with ESMTP; 10 May 2019 03:09:25 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTPS id 6BB1420800;
        Fri, 10 May 2019 13:09:24 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1hP2T5-0003ox-80; Fri, 10 May 2019 13:09:31 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rajmohan.mani@intel.com, linux-media@vger.kernel.org
Subject: [PATCH 1/5] ACPI: Enable driver and firmware hints to control power at probe time
Date:   Fri, 10 May 2019 13:09:26 +0300
Message-Id: <20190510100930.14641-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190510100930.14641-1-sakari.ailus@linux.intel.com>
References: <20190510100930.14641-1-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Allow drivers and firmware tell ACPI that there's no need to power on a
device for probe. This requires both a hint from the firmware as well as
an indication from a driver to leave the device off.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/device_pm.c | 9 +++++++--
 include/linux/device.h   | 6 ++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index b859d75eaf9f6..ca2409a30d26d 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1225,7 +1225,9 @@ static void acpi_dev_pm_detach(struct device *dev, bool power_off)
 	if (adev && dev->pm_domain == &acpi_general_pm_domain) {
 		dev_pm_domain_set(dev, NULL);
 		acpi_remove_pm_notifier(adev);
-		if (power_off) {
+		if (power_off &&
+		    !(dev->driver->probe_powered_off &&
+		      device_property_present(dev, "avoid-power-probe"))) {
 			/*
 			 * If the device's PM QoS resume latency limit or flags
 			 * have been exposed to user space, they have to be
@@ -1273,7 +1275,10 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 
 	acpi_add_pm_notifier(adev, dev, acpi_pm_notify_work_func);
 	dev_pm_domain_set(dev, &acpi_general_pm_domain);
-	if (power_on) {
+
+	if (power_on &&
+	    !(dev->driver->probe_powered_off &&
+	      device_property_present(dev, "avoid-power-probe"))) {
 		acpi_dev_pm_full_power(adev);
 		acpi_device_wakeup_disable(adev);
 	}
diff --git a/include/linux/device.h b/include/linux/device.h
index e85264fb66161..2a459fd5b954a 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -245,6 +245,11 @@ enum probe_type {
  * @owner:	The module owner.
  * @mod_name:	Used for built-in modules.
  * @suppress_bind_attrs: Disables bind/unbind via sysfs.
+ * @probe_powered_off: The driver supports its probe function being called while
+ *		       the device is powered off, independently of the expected
+ *		       behaviour on combination of a given bus and firmware
+ *		       interface etc. The driver is responsible for powering the
+ *		       device on using runtime PM in such case.
  * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
  * @of_match_table: The open firmware table.
  * @acpi_match_table: The ACPI match table.
@@ -282,6 +287,7 @@ struct device_driver {
 	const char		*mod_name;	/* used for built-in modules */
 
 	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
+	bool probe_powered_off;
 	enum probe_type probe_type;
 
 	const struct of_device_id	*of_match_table;
-- 
2.11.0

