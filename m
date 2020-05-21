Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1721DD848
	for <lists+linux-acpi@lfdr.de>; Thu, 21 May 2020 22:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgEUUaU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 May 2020 16:30:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:24606 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728522AbgEUUaU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 May 2020 16:30:20 -0400
IronPort-SDR: O2qG62BlVsHmEAhQqWYlxyBv0iWzdxnFIAw3yyVjErsg+I8lFXFDfqUq1ZTUOM7neItxg0Luv4
 WzPUVM7lNLgQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 13:30:20 -0700
IronPort-SDR: vrWu62i7IiI2h3w5RzQhiCCuZRtx9Biy18qy8lpj+ZTeHsyEwnaLbPTGb0x5Ue0+pGSlco3DgU
 MNVZ5eSwn9NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400"; 
   d="scan'208";a="283178490"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.97.114])
  by orsmga002.jf.intel.com with ESMTP; 21 May 2020 13:30:19 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] ACPI / DPTF: Add additional attributes to power participant driver
Date:   Thu, 21 May 2020 13:30:15 -0700
Message-Id: <20200521203015.959915-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add two additional attributes to the existing power participant driver:
rest_of_platform_power_mw: (RO) Shows the rest of worst case platform
power in mW outside of S0C. This will help in power distribution to SoC
and rest of the system. For example on a test system, this value is 2.5W
with a 15W TDP SoC. Based on the adapter rating (adapter_rating_mw), user
space software can decide on proper power allocation to SoC to improve
short term performance via powercap/RAPL interface.

prochot_confirm: (WO) Confirm EC about a prochot notification.

Also userspace is notified via sysfs_notify(), whenever power source or
rest of the platform power is changed. So user space can use poll()
system call on those attributes.

The ACPI methods used in this patch are as follows:

PROP
This object evaluates to the rest of worst case platform power in mW.
Bits:
23:0 Worst case rest of platform power in mW.

PBOK
PBOK is a method designed to provide a mechanism for OSPM to change power
setting before EC can de-assert a PROCHOT from a device. The EC may
receive several PROCHOTs, so it has a sequence number attached to PSRC
(read via existing attribute "platform_power_source"). Once OSPM takes
action for a PSRC change notification, it can call PBOK method to confirm
with the sequence number.
Bits:
3:0 Power Delivery State Change Sequence number
30  Reserved
31  0 – Not OK to de-assert PROCHOT
    1 – OK to de-assert PROCHOT

PSRC (Platform Power Source): Not new in this patch but for
documentation for new bits
This object evaluates to an integer that represents the system power
source as well as the power delivery state change sequence number.
Bits:
3:0 The current power source as an integer for AC, DC, USB, Wireless.
0 = DC, 1 = AC, 2 = USB, 3 = Wireless Charging
7:4 Power Delivery State Change Sequence Number. Default value is 0

Notifications:
0x81: (Power State Change) Used to notify when the power source has
changed.
0x84: (PROP change) Used to notify when the platform rest of power has
changed.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2
 Change rest_of_platform_power_mw explanation.
	
 Documentation/ABI/testing/sysfs-platform-dptf | 24 +++++--
 drivers/acpi/dptf/dptf_power.c                | 69 ++++++++++++++++++-
 2 files changed, 88 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
index 325dc0667dbb..e83a9d208849 100644
--- a/Documentation/ABI/testing/sysfs-platform-dptf
+++ b/Documentation/ABI/testing/sysfs-platform-dptf
@@ -27,10 +27,12 @@ KernelVersion:	v4.10
 Contact:	linux-acpi@vger.kernel.org
 Description:
 		(RO) Display the platform power source
-		0x00 = DC
-		0x01 = AC
-		0x02 = USB
-		0x03 = Wireless Charger
+		bits[3:0] Current power source
+			0x00 = DC
+			0x01 = AC
+			0x02 = USB
+			0x03 = Wireless Charger
+		bits[7:4] Power source sequence number
 
 What:		/sys/bus/platform/devices/INT3407:00/dptf_power/battery_steady_power
 Date:		Jul, 2016
@@ -38,3 +40,17 @@ KernelVersion:	v4.10
 Contact:	linux-acpi@vger.kernel.org
 Description:
 		(RO) The maximum sustained power for battery in milliwatts.
+
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/rest_of_platform_power_mw
+Date:		June, 2020
+KernelVersion:	v5.8
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) Shows the rest of worst case platform power outside of SoC.
+
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/prochot_confirm
+Date:		June, 2020
+KernelVersion:	v5.8
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(WO) Confirm embedded controller about a prochot notification.
diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index e4e8b75d39f0..abe99039af74 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -16,6 +16,7 @@
  * ARTG : Adapter rating
  * CTYP : Charger type
  * PBSS : Battery steady power
+ * PROP : Rest of worst case platform Power
  */
 #define DPTF_POWER_SHOW(name, object) \
 static ssize_t name##_show(struct device *dev,\
@@ -39,12 +40,34 @@ DPTF_POWER_SHOW(platform_power_source, PSRC)
 DPTF_POWER_SHOW(adapter_rating_mw, ARTG)
 DPTF_POWER_SHOW(battery_steady_power_mw, PBSS)
 DPTF_POWER_SHOW(charger_type, CTYP)
+DPTF_POWER_SHOW(rest_of_platform_power_mw, PROP)
 
 static DEVICE_ATTR_RO(max_platform_power_mw);
 static DEVICE_ATTR_RO(platform_power_source);
 static DEVICE_ATTR_RO(adapter_rating_mw);
 static DEVICE_ATTR_RO(battery_steady_power_mw);
 static DEVICE_ATTR_RO(charger_type);
+static DEVICE_ATTR_RO(rest_of_platform_power_mw);
+
+static ssize_t prochot_confirm_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct acpi_device *acpi_dev = dev_get_drvdata(dev);
+	acpi_status status;
+	int seq_no;
+
+	if (kstrtouint(buf, 0, &seq_no) < 0)
+		return -EINVAL;
+
+	status = acpi_execute_simple_method(acpi_dev->handle, "PBOK", seq_no);
+	if (ACPI_SUCCESS(status))
+		return count;
+
+	return -EINVAL;
+}
+
+static DEVICE_ATTR_WO(prochot_confirm);
 
 static struct attribute *dptf_power_attrs[] = {
 	&dev_attr_max_platform_power_mw.attr,
@@ -52,6 +75,8 @@ static struct attribute *dptf_power_attrs[] = {
 	&dev_attr_adapter_rating_mw.attr,
 	&dev_attr_battery_steady_power_mw.attr,
 	&dev_attr_charger_type.attr,
+	&dev_attr_rest_of_platform_power_mw.attr,
+	&dev_attr_prochot_confirm.attr,
 	NULL
 };
 
@@ -60,6 +85,33 @@ static const struct attribute_group dptf_power_attribute_group = {
 	.name = "dptf_power"
 };
 
+#define POWER_STATE_CHANGED		0x81
+#define POWER_PROP_CHANGE_EVENT	0x84
+
+static void dptf_power_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct platform_device *pdev = data;
+	char *attr;
+
+	switch (event) {
+	case POWER_STATE_CHANGED:
+		attr = "platform_power_source";
+		break;
+	case POWER_PROP_CHANGE_EVENT:
+		attr = "rest_of_platform_power_mw";
+		break;
+	default:
+		dev_err(&pdev->dev, "Unsupported event [0x%x]\n", event);
+		return;
+	}
+
+	/*
+	 * Notify that an attribute is changed, so that user space can read
+	 * again.
+	 */
+	sysfs_notify(&pdev->dev.kobj, "dptf_power", attr);
+}
+
 static int dptf_power_add(struct platform_device *pdev)
 {
 	struct acpi_device *acpi_dev;
@@ -78,10 +130,21 @@ static int dptf_power_add(struct platform_device *pdev)
 	if (ptype != 0x11)
 		return -ENODEV;
 
+	result = acpi_install_notify_handler(acpi_dev->handle,
+					     ACPI_DEVICE_NOTIFY,
+					     dptf_power_notify,
+					     (void *)pdev);
+	if (result)
+		return result;
+
 	result = sysfs_create_group(&pdev->dev.kobj,
 				    &dptf_power_attribute_group);
-	if (result)
+	if (result) {
+		acpi_remove_notify_handler(acpi_dev->handle,
+					   ACPI_DEVICE_NOTIFY,
+					   dptf_power_notify);
 		return result;
+	}
 
 	platform_set_drvdata(pdev, acpi_dev);
 
@@ -90,7 +153,11 @@ static int dptf_power_add(struct platform_device *pdev)
 
 static int dptf_power_remove(struct platform_device *pdev)
 {
+	struct acpi_device *acpi_dev = platform_get_drvdata(pdev);
 
+	acpi_remove_notify_handler(acpi_dev->handle,
+				   ACPI_DEVICE_NOTIFY,
+				   dptf_power_notify);
 	sysfs_remove_group(&pdev->dev.kobj, &dptf_power_attribute_group);
 
 	return 0;
-- 
2.25.4

