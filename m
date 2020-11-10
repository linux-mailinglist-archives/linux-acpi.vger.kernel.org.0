Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9A12ACBD2
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 04:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbgKJDcW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 22:32:22 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.1]:28197 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731960AbgKJDcS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2020 22:32:18 -0500
Received: from [100.112.3.43] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.us-east-1.aws.symcld.net id 29/6E-50652-FB90AAF5; Tue, 10 Nov 2020 03:32:15 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleJIrShJLcpLzFFi42JJl3vFprufc1W
  8wcxlMhb7r0tYdC00sFh4/xSrxddvt9kt3hyfzmSxfF8/o0VTZxObxeeOySwWq/e8YLY4c/oS
  qwOXx6SZM5g9ds66y+7xa9saFo/NK7Q85p0M9Hi/7yqbx5ar7SwenzfJBXBEsWbmJeVXJLBmd
  M95yV5wy77i/7TUBsZm8y5GLg4hgf+MEsf7bjFBOPcZJRY8+MTSxcjJwSagLbFlyy+2LkYODh
  EBGYkPaz1BapgF2pkkVh97zAZSIyzgKXFyagMTiM0ioCJx9OFVsDivgJXE2tn/GEFsCQF5iae
  9y5lBbE4Ba4mrx7+yg9hCAiEST3a8ZYGoF5Q4OfMJmM0MVN+8dTYzhC0hcfDFC2aYOSc3fGKC
  sBMklr28wzyBUWAWkvZZSNpnIWlfwMi8itE0qSgzPaMkNzEzR9fQwEDX0NBI11jX1EQvsUo3S
  a+0WDc1sbhE11AvsbxYr7gyNzknRS8vtWQTIzCeUgqYzXYw/nz9Qe8QoyQHk5IobxbTqnghvq
  T8lMqMxOKM+KLSnNTiQ4wyHBxKEryObEA5waLU9NSKtMwcYGzDpCU4eJREeF+wAKV5iwsSc4s
  z0yFSpxgVpcR5p7ADJQRAEhmleXBtsHRyiVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5Iw7zGQ
  KTyZeSVw018BLWYCWhzguAJkcUkiQkqqgWlFQ6PNxPef1qdN4nIItzSdtML6T83UC4tz/FyvT
  eiU+ycukfG15XvM1eCYhw2c1UFP5rm0XSw96X10u2om7/d7RYmhL0TnrC61yt7vHdFUdX3OT9
  9APVfWUN57xtwq2k3KZ2bcFhV7OGmh6nV7ltl9y1OYjNsWuS454rpbO0RB6pyyWpuD5MYXe77
  lTFPfnvX+zSbdu7cP66969YDhCau4Hcem1bsy7jm/mPJ4K6N5jo+tbVxAttETXc13r+53Xpy/
  JS0g+Ihuss3WKefF/dbK/5/nM/Grpd6z7s+imdFrt7ZHqMzN6Ll56JzCYpbuYzpFwWGzX9Z5T
  9mVzSnd3zJhsuKz7ll6t140KH46IqDEUpyRaKjFXFScCAB9F0f1ogMAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-26.tower-395.messagelabs.com!1604979133!361365!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30568 invoked from network); 10 Nov 2020 03:32:14 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-26.tower-395.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 Nov 2020 03:32:14 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id B41E82C103C0F36E9865;
        Tue, 10 Nov 2020 11:32:10 +0800 (CST)
Received: from localhost.home (10.64.89.28) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Mon, 9 Nov 2020
 19:32:06 -0800
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <rjw@rjwysocki.net>, <hdegoede@redhat.com>,
        <mgross@linux.intel.com>, <linux-acpi@vger.kernel.org>,
        <mario.limonciello@dell.com>, <eliadevito@gmail.com>,
        <hadess@hadess.net>, <bberg@redhat.com>,
        <platform-driver-x86@vger.kernel.org>, <dvhart@infradead.org>
Subject: [PATCH 2/3] ACPI: platform-profile: Add platform profile support
Date:   Mon, 9 Nov 2020 22:31:23 -0500
Message-ID: <20201110033124.3211-3-markpearson@lenovo.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110033124.3211-1-markpearson@lenovo.com>
References: <markpearson@lenovo.com>
 <20201110033124.3211-1-markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.64.89.28]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is the initial implementation of the platform-profile feature.
It provides the details discussed and outlined in the
sysfs-platform_profile document.

Many modern systems have the ability to modify the operating profile to
control aspects like fan speed, temperature and power levels. This
module provides a common sysfs interface that platform modules can register
against to control their individual profile options.

Signed-off-by: Mark Pearson <markpearson@lenovo.com>
---
 MAINTAINERS                      |   8 ++
 drivers/acpi/Kconfig             |  19 ++++
 drivers/acpi/Makefile            |   1 +
 drivers/acpi/platform_profile.c  | 172 +++++++++++++++++++++++++++++++
 include/linux/platform_profile.h |  36 +++++++
 5 files changed, 236 insertions(+)
 create mode 100644 drivers/acpi/platform_profile.c
 create mode 100644 include/linux/platform_profile.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a54806ebf02..e731ac1c4447 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -436,6 +436,14 @@ S:	Orphan
 F:	drivers/platform/x86/wmi.c
 F:	include/uapi/linux/wmi.h
 
+ACPI PLATFORM PROFILE DRIVER
+M:	Mark Pearson <markpearons@lenovo.com>
+L:	linux-acpi@vger.kernel.org
+S:	Supported
+W:	https://01.org/linux-acpi
+B:	https://bugzilla.kernel.org
+F:	drivers/acpi/platform_profile.c
+
 AD1889 ALSA SOUND DRIVER
 L:	linux-parisc@vger.kernel.org
 S:	Maintained
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7540a5179a47..b10a8e0863cf 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -601,3 +601,22 @@ config X86_PM_TIMER
 
 	  You should nearly always say Y here because many modern
 	  systems require this timer.
+
+config ACPI_PLATFORM_PROFILE
+	tristate "ACPI Platform Profile Driver"
+	default y
+	help
+	  This driver adds support for platform-profiles on platforms that
+	  support it.
+
+	  Platform-profiles can be used to control the platform behaviour. For
+	  example whether to operate in a lower power mode, in a higher
+	  power performance mode or between the two.
+
+	  This driver provides the sysfs interface and is used as the registration
+	  point for platform specific drivers.
+
+	  Which profiles are supported is determined on a per-platform basis and
+	  should be obtained from the platform specific driver.
+
+
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 9a957544e357..82dbdc0300ed 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -93,6 +93,7 @@ obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
+obj-$(CONFIG_ACPI_PLATFORM_PROFILE) 	+= platform_profile.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o
diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
new file mode 100644
index 000000000000..3c460c0a3857
--- /dev/null
+++ b/drivers/acpi/platform_profile.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ *  platform_profile.c - Platform profile sysfs interface
+ */
+
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/string.h>
+#include <linux/device.h>
+#include <linux/acpi.h>
+#include <linux/mutex.h>
+#include <acpi/acpi_bus.h>
+#include <linux/platform_profile.h>
+
+struct platform_profile *cur_profile;
+DEFINE_MUTEX(profile_lock);
+
+/* Ensure the first char of each profile is unique */
+static char *profile_str[] = {
+	"Low-power",
+	"Cool",
+	"Quiet",
+	"Balance",
+	"Performance",
+	"Unknown"
+};
+
+static ssize_t platform_profile_choices_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	int i;
+	int ret, count = 0;
+
+	mutex_lock(&profile_lock);
+	if (!cur_profile) {
+		mutex_unlock(&profile_lock);
+		return -ENODEV;
+	}
+
+	if (!cur_profile->choices) {
+		mutex_unlock(&profile_lock);
+		return snprintf(buf, PAGE_SIZE, "None");
+	}
+
+	for (i = profile_low; i < profile_unknown; i++) {
+		if (cur_profile->choices & (1 << i)) {
+			ret = snprintf(buf+count, PAGE_SIZE, "%s ", profile_str[i]);
+			if (ret < 0)
+				break;
+			count += ret;
+		}
+	}
+	mutex_unlock(&profile_lock);
+	return count;
+}
+
+static ssize_t platform_profile_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	enum profile_option profile = profile_unknown;
+
+	mutex_lock(&profile_lock);
+	if (!cur_profile) {
+		mutex_unlock(&profile_lock);
+		return -ENODEV;
+	}
+	if (cur_profile->profile_get)
+		profile = cur_profile->profile_get();
+	mutex_unlock(&profile_lock);
+
+	return snprintf(buf, PAGE_SIZE, "%s", profile_str[profile]);
+}
+
+static ssize_t platform_profile_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	enum profile_option profile;
+
+	mutex_lock(&profile_lock);
+	if (!cur_profile) {
+		mutex_unlock(&profile_lock);
+		return -ENODEV;
+	}
+
+	/* Scan for a matching profile */
+	for (profile = profile_low; profile < profile_unknown; profile++) {
+		if (toupper(buf[0]) == profile_str[profile][0])
+			break;
+	}
+	if (profile == profile_unknown) {
+		mutex_unlock(&profile_lock);
+		return -EINVAL;
+	}
+
+	if (cur_profile->profile_set)
+		cur_profile->profile_set(profile);
+
+	mutex_unlock(&profile_lock);
+	return count;
+}
+
+static DEVICE_ATTR_RO(platform_profile_choices);
+static DEVICE_ATTR_RW(platform_profile);
+
+static struct attribute *platform_profile_attributes[] = {
+	&dev_attr_platform_profile_choices.attr,
+	&dev_attr_platform_profile.attr,
+	NULL,
+};
+
+static const struct attribute_group platform_profile_attr_group = {
+	.attrs = platform_profile_attributes,
+};
+
+int platform_profile_notify(void)
+{
+	if (!cur_profile)
+		return -ENODEV;
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	return 0;
+}
+EXPORT_SYMBOL_GPL(platform_profile_notify);
+
+int platform_profile_register(struct platform_profile *pprof)
+{
+	mutex_lock(&profile_lock);
+	/* We can only have one active profile */
+	if (cur_profile) {
+		mutex_unlock(&profile_lock);
+		return -EEXIST;
+	}
+	cur_profile = pprof;
+	mutex_unlock(&profile_lock);
+	return sysfs_create_group(acpi_kobj, &platform_profile_attr_group);
+}
+EXPORT_SYMBOL_GPL(platform_profile_register);
+
+int platform_profile_unregister(void)
+{
+	mutex_lock(&profile_lock);
+	sysfs_remove_group(acpi_kobj, &platform_profile_attr_group);
+	cur_profile = NULL;
+	mutex_unlock(&profile_lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(platform_profile_unregister);
+
+static int __init platform_profile_init(void)
+{
+	cur_profile = NULL;
+	return 0;
+}
+
+static void platform_profile_exit(void)
+{
+	sysfs_remove_group(acpi_kobj, &platform_profile_attr_group);
+	cur_profile = NULL;
+}
+
+MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
+MODULE_LICENSE("GPL");
+
+module_init(platform_profile_init);
+module_exit(platform_profile_exit);
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
new file mode 100644
index 000000000000..347a12172c09
--- /dev/null
+++ b/include/linux/platform_profile.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * platform_profile.h - platform profile sysfs interface
+ *
+ * See Documentation/ABI/testing/sysfs-platform_profile for more information.
+ */
+
+#ifndef _PLATFORM_PROFILE_H_
+#define _PLATFORM_PROFILE_H_
+
+/*
+ * If more options are added please update profile_str
+ * array in platform-profile.c
+ */
+
+enum profile_option {
+	profile_low,
+	profile_cool,
+	profile_quiet,
+	profile_balance,
+	profile_perform,
+	profile_unknown /* Must always be last */
+};
+
+struct platform_profile {
+	unsigned int choices; /* bitmap of available choices */
+	int cur_profile;      /* Current active profile */
+	int (*profile_get)(void);
+	int (*profile_set)(int profile);
+};
+
+extern int platform_profile_register(struct platform_profile *pprof);
+extern int platform_profile_unregister(void);
+extern int platform_profile_notify(void);
+
+#endif  /*_PLATFORM_PROFILE_H_*/
-- 
2.28.0

