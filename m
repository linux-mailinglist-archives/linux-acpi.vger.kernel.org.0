Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6541DF167
	for <lists+linux-acpi@lfdr.de>; Fri, 22 May 2020 23:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbgEVVpO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 May 2020 17:45:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:1829 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731036AbgEVVpO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 May 2020 17:45:14 -0400
IronPort-SDR: wyNlP05v2QZgCvQiL+nDBe4njUr9hZDGH4BFkDyykCRtfx8e/a8KRl+szQHU8J30US+zBqMpU0
 OvyeH8YiREbg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 14:45:13 -0700
IronPort-SDR: iQVFDAqkKs0sASnlwzGZJkhDLcy8EYTFt0TNSJj2HV00g62mhL7SHX1Ogh6l+EzTeGLYqg65ko
 F4TrOwyHdSQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,423,1583222400"; 
   d="scan'208";a="283523359"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.101.173])
  by orsmga002.jf.intel.com with ESMTP; 22 May 2020 14:45:13 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] ACPI / DPTF: Add DPTF battery participant driver
Date:   Fri, 22 May 2020 14:45:09 -0700
Message-Id: <20200522214509.1003362-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This driver adds support for Dynamic Platform and Thermal Framework
battery participant device support.

These attributes are presented via sysfs interface under the platform
device for the battery participant:
$ls /sys/bus/platform/devices/INT3532:00/dptf_battery
	current_discharge_capbility_ma
	max_platform_power_mw
	no_load_voltage_mv
	high_freq_impedance_mohm
	max_steady_state_power_mw

Refer to the documentation at
Documentation/ABI/testing/sysfs-platform-dptf
for details.

Here the implementation reuses existing dptf-power.c as the motivation and
processing is same. It also shares one ACPI method. Here this change is
using participant type, "PTYP" method to identify and do different
processing. By using participant type, create/delete either "dptf_power"
or "dptf_battery" attribute group and send notifications.

The particpant type for for the battery participant is 0x0C.

ACPI methods description:

PMAX (Intel(R) Dynamic Tuning Platform Max Power Supplied by Battery):
This object evaluates to the maximum platform power that can be supported
by the battery in milli watts.

PBSS (Intel(R) Dynamic Tuning Power Battery Steady State):
This object returns the max sustained power for battery in milli watts.

RBHF (Intel(R) Dynamic Tuning High Frequency Impedance):
This object returns high frequency impedance value that can be obtained
from battery fuel gauge.

VBNL (Intel(R) Dynamic Tuning No-Load Voltage)
This object returns battery instantaneous no-load voltage that can be
obtained from battery fuel gauge in milli volts

CMPP (Intel(R) Dynamic Tuning Current Discharge Capability)
This object returns battery discharge current capability obtained from
battery fuel gauge milli amps.

Notifications:

0x80: PMAX change. Used to notify Intel(R)Dynamic Tuning Battery
participant driver when the PMAX has changed by 250mw.
0x83: PBSS change. Used to notify Intel(R) Dynamic Tuning Battery
participant driver when the power source has changed.
0x85: RBHF change. Used to notify Intel(R)Dynamic Tuning Battery
participant driver when the RBHF has changed over a threshold by
5mOhm.
0x86: Battery Capability change. Used to notify Intel(R)Dynamic Tuning
Battery participant driver when the battery capability has changed.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
Comment
	I know this is close to merge window, so it can be differed to 5.9
	if this is a problem.

 Documentation/ABI/testing/sysfs-platform-dptf | 38 +++++++++
 drivers/acpi/dptf/dptf_power.c                | 82 ++++++++++++++++---
 2 files changed, 110 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
index e83a9d208849..ef923958c750 100644
--- a/Documentation/ABI/testing/sysfs-platform-dptf
+++ b/Documentation/ABI/testing/sysfs-platform-dptf
@@ -54,3 +54,41 @@ KernelVersion:	v5.8
 Contact:	linux-acpi@vger.kernel.org
 Description:
 		(WO) Confirm embedded controller about a prochot notification.
+
+What:		/sys/bus/platform/devices/INT3532:00/dptf_battery/max_platform_power_mw
+Date:		June, 2020
+KernelVersion:	v5.8
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) The maximum platform power that can be supported by the battery in milli watts.
+
+What:		/sys/bus/platform/devices/INT3532:00/dptf_battery/max_steady_state_power_mw
+Date:		June, 2020
+KernelVersion:	v5.8
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) The maximum sustained power for battery in milli watts.
+
+What:		/sys/bus/platform/devices/INT3532:00/dptf_battery/high_freq_impedance_mohm
+Date:		June, 2020
+KernelVersion:	v5.8
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) The high frequency impedance value that can be obtained from battery
+		fuel gauge in milli Ohms.
+
+What:		/sys/bus/platform/devices/INT3532:00/dptf_battery/no_load_voltage_mv
+Date:		June, 2020
+KernelVersion:	v5.8
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) The no-load voltage that can be obtained from battery fuel gauge in
+		milli volts.
+
+What:		/sys/bus/platform/devices/INT3532:00/dptf_battery/current_discharge_capbility_ma
+Date:		June, 2020
+KernelVersion:	v5.8
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) The battery discharge current capability obtained from battery fuel gauge in
+		milli Amps.
diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index abe99039af74..5fab7e350db8 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -10,13 +10,19 @@
 #include <linux/platform_device.h>
 
 /*
- * Presentation of attributes which are defined for INT3407. They are:
+ * Presentation of attributes which are defined for INT3407 and INT3532.
+ * They are:
  * PMAX : Maximum platform powe
  * PSRC : Platform power source
  * ARTG : Adapter rating
  * CTYP : Charger type
  * PBSS : Battery steady power
  * PROP : Rest of worst case platform Power
+ * PBSS : Power Battery Steady State
+ * PBSS : Power Battery Steady State
+ * RBHF : High Frequency Impedance
+ * VBNL : Instantaneous No-Load Voltage
+ * CMPP : Current Discharge Capability
  */
 #define DPTF_POWER_SHOW(name, object) \
 static ssize_t name##_show(struct device *dev,\
@@ -41,6 +47,10 @@ DPTF_POWER_SHOW(adapter_rating_mw, ARTG)
 DPTF_POWER_SHOW(battery_steady_power_mw, PBSS)
 DPTF_POWER_SHOW(charger_type, CTYP)
 DPTF_POWER_SHOW(rest_of_platform_power_mw, PROP)
+DPTF_POWER_SHOW(max_steady_state_power_mw, PBSS)
+DPTF_POWER_SHOW(high_freq_impedance_mohm, RBHF)
+DPTF_POWER_SHOW(no_load_voltage_mv, VBNL)
+DPTF_POWER_SHOW(current_discharge_capbility_ma, CMPP);
 
 static DEVICE_ATTR_RO(max_platform_power_mw);
 static DEVICE_ATTR_RO(platform_power_source);
@@ -48,6 +58,10 @@ static DEVICE_ATTR_RO(adapter_rating_mw);
 static DEVICE_ATTR_RO(battery_steady_power_mw);
 static DEVICE_ATTR_RO(charger_type);
 static DEVICE_ATTR_RO(rest_of_platform_power_mw);
+static DEVICE_ATTR_RO(max_steady_state_power_mw);
+static DEVICE_ATTR_RO(high_freq_impedance_mohm);
+static DEVICE_ATTR_RO(no_load_voltage_mv);
+static DEVICE_ATTR_RO(current_discharge_capbility_ma);
 
 static ssize_t prochot_confirm_store(struct device *dev,
 				     struct device_attribute *attr,
@@ -85,8 +99,38 @@ static const struct attribute_group dptf_power_attribute_group = {
 	.name = "dptf_power"
 };
 
+static struct attribute *dptf_battery_attrs[] = {
+	&dev_attr_max_platform_power_mw.attr,
+	&dev_attr_max_steady_state_power_mw.attr,
+	&dev_attr_high_freq_impedance_mohm.attr,
+	&dev_attr_no_load_voltage_mv.attr,
+	&dev_attr_current_discharge_capbility_ma.attr,
+	NULL
+};
+
+static const struct attribute_group dptf_battery_attribute_group = {
+	.attrs = dptf_battery_attrs,
+	.name = "dptf_battery"
+};
+
+#define MAX_POWER_CHANGED		0x80
 #define POWER_STATE_CHANGED		0x81
+#define STEADY_STATE_POWER_CHANGED	0x83
 #define POWER_PROP_CHANGE_EVENT	0x84
+#define IMPEDANCED_CHNGED		0x85
+#define VOLTAGE_CURRENT_CHANGED	0x86
+
+static long long dptf_participant_type(acpi_handle handle)
+{
+	unsigned long long ptype;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(handle, "PTYP", NULL, &ptype);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return ptype;
+}
 
 static void dptf_power_notify(acpi_handle handle, u32 event, void *data)
 {
@@ -100,6 +144,15 @@ static void dptf_power_notify(acpi_handle handle, u32 event, void *data)
 	case POWER_PROP_CHANGE_EVENT:
 		attr = "rest_of_platform_power_mw";
 		break;
+	case MAX_POWER_CHANGED:
+		attr = "max_platform_power_mw";
+		break;
+	case STEADY_STATE_POWER_CHANGED:
+		attr = "max_steady_state_power_mw";
+		break;
+	case VOLTAGE_CURRENT_CHANGED:
+		attr = "no_load_voltage_mv";
+		break;
 	default:
 		dev_err(&pdev->dev, "Unsupported event [0x%x]\n", event);
 		return;
@@ -109,13 +162,16 @@ static void dptf_power_notify(acpi_handle handle, u32 event, void *data)
 	 * Notify that an attribute is changed, so that user space can read
 	 * again.
 	 */
-	sysfs_notify(&pdev->dev.kobj, "dptf_power", attr);
+	if (dptf_participant_type(handle) == 0x0CULL)
+		sysfs_notify(&pdev->dev.kobj, "dptf_battery", attr);
+	else
+		sysfs_notify(&pdev->dev.kobj, "dptf_power", attr);
 }
 
 static int dptf_power_add(struct platform_device *pdev)
 {
+	const struct attribute_group *attr_group;
 	struct acpi_device *acpi_dev;
-	acpi_status status;
 	unsigned long long ptype;
 	int result;
 
@@ -123,11 +179,12 @@ static int dptf_power_add(struct platform_device *pdev)
 	if (!acpi_dev)
 		return -ENODEV;
 
-	status = acpi_evaluate_integer(acpi_dev->handle, "PTYP", NULL, &ptype);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	if (ptype != 0x11)
+	ptype = dptf_participant_type(acpi_dev->handle);
+	if (ptype == 0x11)
+		attr_group = &dptf_power_attribute_group;
+	else if (ptype == 0x0C)
+		attr_group = &dptf_battery_attribute_group;
+	else
 		return -ENODEV;
 
 	result = acpi_install_notify_handler(acpi_dev->handle,
@@ -138,7 +195,7 @@ static int dptf_power_add(struct platform_device *pdev)
 		return result;
 
 	result = sysfs_create_group(&pdev->dev.kobj,
-				    &dptf_power_attribute_group);
+				    attr_group);
 	if (result) {
 		acpi_remove_notify_handler(acpi_dev->handle,
 					   ACPI_DEVICE_NOTIFY,
@@ -158,13 +215,18 @@ static int dptf_power_remove(struct platform_device *pdev)
 	acpi_remove_notify_handler(acpi_dev->handle,
 				   ACPI_DEVICE_NOTIFY,
 				   dptf_power_notify);
-	sysfs_remove_group(&pdev->dev.kobj, &dptf_power_attribute_group);
+
+	if (dptf_participant_type(acpi_dev->handle) == 0x0CULL)
+		sysfs_remove_group(&pdev->dev.kobj, &dptf_battery_attribute_group);
+	else
+		sysfs_remove_group(&pdev->dev.kobj, &dptf_power_attribute_group);
 
 	return 0;
 }
 
 static const struct acpi_device_id int3407_device_ids[] = {
 	{"INT3407", 0},
+	{"INT3532", 0},
 	{"INTC1047", 0},
 	{"", 0},
 };
-- 
2.25.4

