Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9B0597D50
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Aug 2022 06:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243225AbiHREWs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Aug 2022 00:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243274AbiHREWV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Aug 2022 00:22:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E47219000;
        Wed, 17 Aug 2022 21:22:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AE1AB82039;
        Thu, 18 Aug 2022 04:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC41CC433D6;
        Thu, 18 Aug 2022 04:22:13 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-acpi@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH V2 1/2] LoongArch: Add CPU HWMon platform driver
Date:   Thu, 18 Aug 2022 12:22:07 +0800
Message-Id: <20220818042208.2896457-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This add CPU HWMon (temperature sensor) platform driver for Loongson-3.

Tested-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Fix build warning reported by lkp.

 drivers/platform/Kconfig               |   3 +
 drivers/platform/Makefile              |   1 +
 drivers/platform/loongarch/Kconfig     |  26 ++++
 drivers/platform/loongarch/Makefile    |   1 +
 drivers/platform/loongarch/cpu_hwmon.c | 194 +++++++++++++++++++++++++
 5 files changed, 225 insertions(+)
 create mode 100644 drivers/platform/loongarch/Kconfig
 create mode 100644 drivers/platform/loongarch/Makefile
 create mode 100644 drivers/platform/loongarch/cpu_hwmon.c

diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
index b437847b6237..9c68e2def2cb 100644
--- a/drivers/platform/Kconfig
+++ b/drivers/platform/Kconfig
@@ -2,6 +2,9 @@
 if MIPS
 source "drivers/platform/mips/Kconfig"
 endif
+if LOONGARCH
+source "drivers/platform/loongarch/Kconfig"
+endif
 
 source "drivers/platform/goldfish/Kconfig"
 
diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
index 4de08ef4ec9d..41640172975a 100644
--- a/drivers/platform/Makefile
+++ b/drivers/platform/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_X86)		+= x86/
+obj-$(CONFIG_LOONGARCH)		+= loongarch/
 obj-$(CONFIG_MELLANOX_PLATFORM)	+= mellanox/
 obj-$(CONFIG_MIPS)		+= mips/
 obj-$(CONFIG_OLPC_EC)		+= olpc/
diff --git a/drivers/platform/loongarch/Kconfig b/drivers/platform/loongarch/Kconfig
new file mode 100644
index 000000000000..a1542843b0ad
--- /dev/null
+++ b/drivers/platform/loongarch/Kconfig
@@ -0,0 +1,26 @@
+#
+# LoongArch Platform Specific Drivers
+#
+
+menuconfig LOONGARCH_PLATFORM_DEVICES
+	bool "LoongArch Platform Specific Device Drivers"
+	default LOONGARCH
+	help
+	  Say Y here to get to see options for device drivers of various
+	  LoongArch platforms, including vendor-specific laptop/desktop
+	  extension and hardware monitor drivers. This option itself does
+	  not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
+
+if LOONGARCH_PLATFORM_DEVICES
+
+config CPU_HWMON
+	bool "Loongson CPU HWMon Driver"
+	depends on MACH_LOONGSON64
+	select HWMON
+	default y
+	help
+	  Loongson-3A/3B/3C CPU HWMon (temperature sensor) driver.
+
+endif # LOONGARCH_PLATFORM_DEVICES
diff --git a/drivers/platform/loongarch/Makefile b/drivers/platform/loongarch/Makefile
new file mode 100644
index 000000000000..8dfd03924c37
--- /dev/null
+++ b/drivers/platform/loongarch/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_CPU_HWMON) += cpu_hwmon.o
diff --git a/drivers/platform/loongarch/cpu_hwmon.c b/drivers/platform/loongarch/cpu_hwmon.c
new file mode 100644
index 000000000000..71a462426397
--- /dev/null
+++ b/drivers/platform/loongarch/cpu_hwmon.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+#include <linux/module.h>
+#include <linux/reboot.h>
+#include <linux/jiffies.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+
+#include <asm/loongson.h>
+
+static int nr_packages;
+static struct device *cpu_hwmon_dev;
+
+static int loongson3_cpu_temp(int cpu)
+{
+	u32 reg;
+
+	reg = iocsr_read32(LOONGARCH_IOCSR_CPUTEMP) & 0xff;
+
+	return (int)((s8)reg) * 1000;
+}
+
+static ssize_t cpu_temp_label(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	int id = (to_sensor_dev_attr(attr))->index - 1;
+	return sprintf(buf, "CPU %d Temperature\n", id);
+}
+
+static ssize_t get_cpu_temp(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	int id = (to_sensor_dev_attr(attr))->index - 1;
+	int value = loongson3_cpu_temp(id);
+	return sprintf(buf, "%d\n", value);
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, 0444, get_cpu_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp1_label, 0444, cpu_temp_label, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp2_input, 0444, get_cpu_temp, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp2_label, 0444, cpu_temp_label, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp3_input, 0444, get_cpu_temp, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp3_label, 0444, cpu_temp_label, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp4_input, 0444, get_cpu_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp4_label, 0444, cpu_temp_label, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp5_input, 0444, get_cpu_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp5_label, 0444, cpu_temp_label, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp6_input, 0444, get_cpu_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp6_label, 0444, cpu_temp_label, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp7_input, 0444, get_cpu_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp7_label, 0444, cpu_temp_label, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp8_input, 0444, get_cpu_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp8_label, 0444, cpu_temp_label, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp9_input, 0444, get_cpu_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp9_label, 0444, cpu_temp_label, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp10_input, 0444, get_cpu_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp10_label, 0444, cpu_temp_label, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp11_input, 0444, get_cpu_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp11_label, 0444, cpu_temp_label, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp12_input, 0444, get_cpu_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp12_label, 0444, cpu_temp_label, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp13_input, 0444, get_cpu_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp13_label, 0444, cpu_temp_label, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp14_input, 0444, get_cpu_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp14_label, 0444, cpu_temp_label, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp15_input, 0444, get_cpu_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp15_label, 0444, cpu_temp_label, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp16_input, 0444, get_cpu_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp16_label, 0444, cpu_temp_label, NULL, 4);
+
+static struct attribute *cpu_hwmon_attributes[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_label.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_label.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_label.dev_attr.attr,
+	&sensor_dev_attr_temp4_input.dev_attr.attr,
+	&sensor_dev_attr_temp4_label.dev_attr.attr,
+	&sensor_dev_attr_temp5_input.dev_attr.attr,
+	&sensor_dev_attr_temp5_label.dev_attr.attr,
+	&sensor_dev_attr_temp6_input.dev_attr.attr,
+	&sensor_dev_attr_temp6_label.dev_attr.attr,
+	&sensor_dev_attr_temp7_input.dev_attr.attr,
+	&sensor_dev_attr_temp7_label.dev_attr.attr,
+	&sensor_dev_attr_temp8_input.dev_attr.attr,
+	&sensor_dev_attr_temp8_label.dev_attr.attr,
+	&sensor_dev_attr_temp9_input.dev_attr.attr,
+	&sensor_dev_attr_temp9_label.dev_attr.attr,
+	&sensor_dev_attr_temp10_input.dev_attr.attr,
+	&sensor_dev_attr_temp10_label.dev_attr.attr,
+	&sensor_dev_attr_temp11_input.dev_attr.attr,
+	&sensor_dev_attr_temp11_label.dev_attr.attr,
+	&sensor_dev_attr_temp12_input.dev_attr.attr,
+	&sensor_dev_attr_temp12_label.dev_attr.attr,
+	&sensor_dev_attr_temp13_input.dev_attr.attr,
+	&sensor_dev_attr_temp13_label.dev_attr.attr,
+	&sensor_dev_attr_temp14_input.dev_attr.attr,
+	&sensor_dev_attr_temp14_label.dev_attr.attr,
+	&sensor_dev_attr_temp15_input.dev_attr.attr,
+	&sensor_dev_attr_temp15_label.dev_attr.attr,
+	&sensor_dev_attr_temp16_input.dev_attr.attr,
+	&sensor_dev_attr_temp16_label.dev_attr.attr,
+	NULL
+};
+static umode_t cpu_hwmon_is_visible(struct kobject *kobj,
+				    struct attribute *attr, int i)
+{
+	int id = i / 2;
+
+	if (id < nr_packages)
+		return attr->mode;
+	return 0;
+}
+
+static struct attribute_group cpu_hwmon_group = {
+	.attrs = cpu_hwmon_attributes,
+	.is_visible = cpu_hwmon_is_visible,
+};
+
+static const struct attribute_group *cpu_hwmon_groups[] = {
+	&cpu_hwmon_group,
+	NULL
+};
+
+static int cpu_initial_threshold = 72000;
+static int cpu_thermal_threshold = 96000;
+module_param(cpu_thermal_threshold, int, 0644);
+MODULE_PARM_DESC(cpu_thermal_threshold, "cpu thermal threshold (96000 (default))");
+
+static struct delayed_work thermal_work;
+
+static void do_thermal_timer(struct work_struct *work)
+{
+	int i, value, temp_max = 0;
+
+	for (i=0; i<nr_packages; i++) {
+		value = loongson3_cpu_temp(i);
+		if (value > temp_max)
+			temp_max = value;
+	}
+
+	if (temp_max <= cpu_thermal_threshold)
+		schedule_delayed_work(&thermal_work, msecs_to_jiffies(5000));
+	else
+		orderly_poweroff(true);
+}
+
+static int __init loongson_hwmon_init(void)
+{
+	int i, value, temp_max = 0;
+
+	pr_info("Loongson Hwmon Enter...\n");
+
+	nr_packages = loongson_sysconf.nr_cpus /
+		loongson_sysconf.cores_per_package;
+
+	cpu_hwmon_dev = hwmon_device_register_with_groups(NULL, "cpu_hwmon",
+							  NULL, cpu_hwmon_groups);
+	if (IS_ERR(cpu_hwmon_dev)) {
+		pr_err("hwmon_device_register fail!\n");
+		return PTR_ERR(cpu_hwmon_dev);
+	}
+
+	for (i = 0; i < nr_packages; i++) {
+		value = loongson3_cpu_temp(i);
+		if (value > temp_max)
+			temp_max = value;
+	}
+
+	pr_info("Initial CPU temperature is %d (highest).\n", temp_max);
+	if (temp_max > cpu_initial_threshold)
+		cpu_thermal_threshold += temp_max - cpu_initial_threshold;
+
+	INIT_DEFERRABLE_WORK(&thermal_work, do_thermal_timer);
+	schedule_delayed_work(&thermal_work, msecs_to_jiffies(20000));
+
+	return 0;
+}
+
+static void __exit loongson_hwmon_exit(void)
+{
+	cancel_delayed_work_sync(&thermal_work);
+	hwmon_device_unregister(cpu_hwmon_dev);
+}
+
+module_init(loongson_hwmon_init);
+module_exit(loongson_hwmon_exit);
+
+MODULE_AUTHOR("Huacai Chen <chenhuacai@loongson.cn>");
+MODULE_DESCRIPTION("Loongson CPU Hwmon driver");
+MODULE_LICENSE("GPL");
-- 
2.31.1

