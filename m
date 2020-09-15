Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8405326B434
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Sep 2020 01:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgIOXSz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Sep 2020 19:18:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:59141 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbgIOXSn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Sep 2020 19:18:43 -0400
IronPort-SDR: JU3koeQd+eO/dw4ECUEq6BrH1iCFolrmmSLbN78zkFnkaYVhkcLE4PYwldIQSyvW9KLfuY2mAP
 If0O93qfVp9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="147118811"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="147118811"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 16:18:41 -0700
IronPort-SDR: +ynZSTyFjIeqvGWrBWLEWGFH34MZZS/PO6SwNa3//jyiufqCKtmY6WljdBmW6vTKXF86CO61rq
 ZX3tnxet7i9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="483047225"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga005.jf.intel.com with ESMTP; 15 Sep 2020 16:18:41 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] ACPI / DPTF: Add PCH FIVR participant driver
Date:   Tue, 15 Sep 2020 16:18:14 -0700
Message-Id: <20200915231814.408117-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This driver adds support for Dynamic Platform and Thermal Framework
(DPTF) PCH (Platform Controller Hub) FIVR (Fully Integrated Voltage
Regulator) participant support.

This participant is responsible for exposing platform telemetry and
control for:
	freq_mhz_high_clock
	freq_mhz_low_clock

These attributes are used to get and set PCH FIVR switching frequency
for thermal and radio frequency interference mitigation.

Refer to Documentation/ABI/testing/sysfs-platform-dptf for ABI details.

ACPI methods description used in this driver:
RFC0: This ACPI method to set PCH FIVR switching frequency when FIVR
clock is 19.2MHz or 24MHz. The ACPI method takes a DWORD value.
GFC0: This ACPI method to get PCH FIVR switching frequency when FIVR
clock is 19.2MHz or 24MHz.
RFC1: This ACPI method to set PCH FIVR switching frequency when FIVR
clock is 38.4MHz. The ACPI method takes a DWORD value.
GFC1: This ACPI method to get PCH FIVR switching frequency when FIVR
clock is 38.4MHz.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-platform-dptf |  16 +++
 drivers/acpi/dptf/Kconfig                     |  14 ++
 drivers/acpi/dptf/Makefile                    |   1 +
 drivers/acpi/dptf/dptf_pch_fivr.c             | 126 ++++++++++++++++++
 drivers/acpi/dptf/int340x_thermal.c           |   1 +
 5 files changed, 158 insertions(+)
 create mode 100644 drivers/acpi/dptf/dptf_pch_fivr.c

diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
index eeed81ca6949..2cbc660d163b 100644
--- a/Documentation/ABI/testing/sysfs-platform-dptf
+++ b/Documentation/ABI/testing/sysfs-platform-dptf
@@ -92,3 +92,19 @@ Contact:	linux-acpi@vger.kernel.org
 Description:
 		(RO) The battery discharge current capability obtained from battery fuel gauge in
 		milli Amps.
+
+What:		/sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/freq_mhz_low_clock
+Date:		November, 2020
+KernelVersion:	v5.10
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RW) The PCH FIVR (Fully Integrated Voltage Regulator) switching frequency in MHz,
+		when FIVR clock is 19.2MHz or 24MHz.
+
+What:		/sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/freq_mhz_high_clock
+Date:		November, 2020
+KernelVersion:	v5.10
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RW) The PCH FIVR (Fully Integrated Voltage Regulator) switching frequency in MHz,
+		when FIVR clock is 38.4MHz.
diff --git a/drivers/acpi/dptf/Kconfig b/drivers/acpi/dptf/Kconfig
index 90a2fd979282..51f06f36cafa 100644
--- a/drivers/acpi/dptf/Kconfig
+++ b/drivers/acpi/dptf/Kconfig
@@ -14,3 +14,17 @@ config DPTF_POWER
 
 	  To compile this driver as a module, choose M here:
 	  the module will be called dptf_power.
+
+config DPTF_PCH_FIVR
+	tristate "DPTF PCH FIVR Participant"
+	depends on X86
+	help
+	  This driver adds support for Dynamic Platform and Thermal Framework
+	  (DPTF) PCH FIVR Participant device support. This driver allows to
+	  switch PCH FIVR (Fully Integrated Voltage Regulator) frequency.
+	  This participant is responsible for exposing:
+		freq_mhz_low_clock
+		freq_mhz_high_clock
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called dptf_pch_fivr.
diff --git a/drivers/acpi/dptf/Makefile b/drivers/acpi/dptf/Makefile
index 1a9b0a2b25bf..297340682f66 100644
--- a/drivers/acpi/dptf/Makefile
+++ b/drivers/acpi/dptf/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_ACPI)             += int340x_thermal.o
 obj-$(CONFIG_DPTF_POWER)	+= dptf_power.o
+obj-$(CONFIG_DPTF_PCH_FIVR)	+= dptf_pch_fivr.o
diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
new file mode 100644
index 000000000000..4ab288827747
--- /dev/null
+++ b/drivers/acpi/dptf/dptf_pch_fivr.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * dptf_pch_fivr:  DPTF PCH FIVR Participant driver
+ * Copyright (c) 2020, Intel Corporation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+/*
+ * Presentation of attributes which are defined for INT1045
+ * They are:
+ * freq_mhz_low_clock : Set PCH FIVR switching freq for
+ *			FIVR clock 19.2MHz and 24MHz
+ * freq_mhz_high_clock : Set PCH FIVR switching freq for
+ *			FIVR clock 38.4MHz
+ */
+#define PCH_FIVR_SHOW(name, method) \
+static ssize_t name##_show(struct device *dev,\
+			   struct device_attribute *attr,\
+			   char *buf)\
+{\
+	struct acpi_device *acpi_dev = dev_get_drvdata(dev);\
+	unsigned long long val;\
+	acpi_status status;\
+\
+	status = acpi_evaluate_integer(acpi_dev->handle, #method,\
+				       NULL, &val);\
+	if (ACPI_SUCCESS(status))\
+		return sprintf(buf, "%d\n", (int)val);\
+	else\
+		return -EINVAL;\
+}
+
+#define PCH_FIVR_STORE(name, method) \
+static ssize_t name##_store(struct device *dev,\
+			    struct device_attribute *attr,\
+			    const char *buf, size_t count)\
+{\
+	struct acpi_device *acpi_dev = dev_get_drvdata(dev);\
+	acpi_status status;\
+	u32 val;\
+\
+	if (kstrtouint(buf, 0, &val) < 0)\
+		return -EINVAL;\
+\
+	status = acpi_execute_simple_method(acpi_dev->handle, #method, val);\
+	if (ACPI_SUCCESS(status))\
+		return count;\
+\
+	return -EINVAL;\
+}
+
+PCH_FIVR_SHOW(freq_mhz_low_clock, GFC0)
+PCH_FIVR_SHOW(freq_mhz_high_clock, GFC1)
+PCH_FIVR_STORE(freq_mhz_low_clock, RFC0)
+PCH_FIVR_STORE(freq_mhz_high_clock, RFC1)
+
+static DEVICE_ATTR_RW(freq_mhz_low_clock);
+static DEVICE_ATTR_RW(freq_mhz_high_clock);
+
+static struct attribute *fivr_attrs[] = {
+	&dev_attr_freq_mhz_low_clock.attr,
+	&dev_attr_freq_mhz_high_clock.attr,
+	NULL
+};
+
+static const struct attribute_group pch_fivr_attribute_group = {
+	.attrs = fivr_attrs,
+	.name = "pch_fivr_switch_frequency"
+};
+
+static int pch_fivr_add(struct platform_device *pdev)
+{
+	struct acpi_device *acpi_dev;
+	unsigned long long ptype;
+	acpi_status status;
+	int result;
+
+	acpi_dev = ACPI_COMPANION(&(pdev->dev));
+	if (!acpi_dev)
+		return -ENODEV;
+
+	status = acpi_evaluate_integer(acpi_dev->handle, "PTYP", NULL, &ptype);
+	if (ACPI_FAILURE(status) || ptype != 0x05)
+		return -ENODEV;
+
+	result = sysfs_create_group(&pdev->dev.kobj,
+				    &pch_fivr_attribute_group);
+	if (result)
+		return result;
+
+	platform_set_drvdata(pdev, acpi_dev);
+
+	return 0;
+}
+
+static int pch_fivr_remove(struct platform_device *pdev)
+{
+	sysfs_remove_group(&pdev->dev.kobj, &pch_fivr_attribute_group);
+
+	return 0;
+}
+
+static const struct acpi_device_id pch_fivr_device_ids[] = {
+	{"INTC1045", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, pch_fivr_device_ids);
+
+static struct platform_driver pch_fivr_driver = {
+	.probe = pch_fivr_add,
+	.remove = pch_fivr_remove,
+	.driver = {
+		.name = "DPTF PCH FIVR",
+		.acpi_match_table = pch_fivr_device_ids,
+	},
+};
+
+module_platform_driver(pch_fivr_driver);
+
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ACPI DPTF PCH FIVR driver");
diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index bc71a6a60334..8d420c7e7178 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -27,6 +27,7 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	{"INTC1040"},
 	{"INTC1043"},
 	{"INTC1044"},
+	{"INTC1045"},
 	{"INTC1047"},
 	{""},
 };
-- 
2.25.4

