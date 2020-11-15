Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC692B31AB
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Nov 2020 01:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgKOAo2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 14 Nov 2020 19:44:28 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.113]:57824 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726125AbgKOAo1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 14 Nov 2020 19:44:27 -0500
Received: from [100.112.133.178] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.us-west-2.aws.symcld.net id DA/D7-28581-8E970BF5; Sun, 15 Nov 2020 00:44:24 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRWlGSWpSXmKPExsWSLveKXfd55YZ
  4g3XT9C32X5ew6FpoYLHw/ilWi6/fbrNbvDk+ncli+b5+RoumziY2i88dk1ksVu95wWxx5vQl
  Vgcuj0kzZzB77Jx1l93j17Y1LB6bV2h5zDsZ6PF+31U2jy1X21k8Pm+SC+CIYs3MS8qvSGDNW
  LV2IVPBVp+KXe13mRoYNzp2MXJxCAn8Z5TYtaCbCcL5ySjxZdF6li5GTg42AW2JLVt+sXUxcn
  CICMhIfFjrCVLDLNDOJLH62GM2kBphAQ+JlplfWUFsFgFViasL2llB6nkFbCRezmYCCUsIyEv
  MvPSdHcTmBCo50/UYbLyQgIrE/QdLwMbwCghKnJz5BCzODFTfvHU2M4QtIXHwxQtmiDmKEp23
  3kLNTJBY9vIO8wRGgVlI2mchaZ+FpH0BI/MqRoukosz0jJLcxMwcXUMDA11DQyNdQ2MgNjfTS
  6zSTdIrLdYtTy0u0TXSSywv1iuuzE3OSdHLSy3ZxAiMqpSClg07GP+8+qB3iFGSg0lJlPc214
  Z4Ib6k/JTKjMTijPii0pzU4kOMMhwcShK8H8qBcoJFqempFWmZOcAIh0lLcPAoifC2VwCleYs
  LEnOLM9MhUqcYFaXEeS1BEgIgiYzSPLg2WFK5xCgrJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmY
  9ynIFJ7MvBK46a+AFjMBLd6hDba4JBEhJdXA1McZEcfh+qM//MOxWLP49Mhv/5Ou9Sdc2l01f
  +uP9TEXuwuCJu+e+5V5xZ0z7G+KKnddZvf6bhRdoyt3+eYujsYFTsWR3e6nf8v+tunVf3IlWq
  0wve1hYV6se+umimo79rT/G22ad32UVLw2qyPe97974My5l5/emJO14HORu7TMSnlTQXeDFPH
  shwdb9nz0WKxtvu5BmNt/99+va9pj/p2VX7ozXllI6xj356xsvbqLASUX/3dnrzAQklS+m/Fb
  RW3LqZesZ781aaVVXr/k80brc4DS6V0sxhKM31JFtyib2vNM1rNPvLLncVnSc4b6GXWn3nU6J
  Jxab+LdfJLRIaC9/s3DS8Hztlp1Z0oosRRnJBpqMRcVJwIASWB1AqUDAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-4.tower-356.messagelabs.com!1605401060!65133!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 648 invoked from network); 15 Nov 2020 00:44:23 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-4.tower-356.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Nov 2020 00:44:23 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 64047F544E39D42A7C34;
        Sun, 15 Nov 2020 08:44:18 +0800 (CST)
Received: from banther-ThinkPad-X1-Carbon-Gen-8.home (10.38.109.124) by
 reswpmail04.lenovo.com (10.62.32.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Sat, 14 Nov 2020 16:44:15 -0800
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <rjw@rjwysocki.net>, <hdegoede@redhat.com>,
        <mgross@linux.intel.com>, <linux-acpi@vger.kernel.org>,
        <mario.limonciello@dell.com>, <eliadevito@gmail.com>,
        <hadess@hadess.net>, <bberg@redhat.com>,
        <platform-driver-x86@vger.kernel.org>, <dvhart@infradead.org>
Subject: [PATCH v3] ACPI: platform-profile: Add platform profile support
Date:   Sat, 14 Nov 2020 19:44:02 -0500
Message-ID: <20201115004402.342838-1-markpearson@lenovo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <markpearson@lenovo.com>
References: <markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.38.109.124]
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
Changes in v2:
 Address (hopefully) all recommendations from review including:
 - reorder includes list alphabetically
 - make globals statics and use const as required
 - change profile name scanning to use full string
 - clean up profile name lists to remove unwanted additions
 - use sysfs_emit and sysfs_emit_at appropriately (much nicer!)
 - improve error handling. Return errors to user in all cases and use
   better error codes where appropriate (ENOOPSUPP)
 - clean up sysfs output for better readability
 - formatting fixes where needed
 - improve structure and enum names to be clearer
 - remove cur_profile field from structure. It is now local to the
   actual platform driver file (patch 3 in series)
 - improve checking so if future profile options are added profile_names
   will be updated as well.
 - move CONFIG option next to ACPI_THERMAL as it seemed slightly related
 - removed MAINTAINERS update as not appropriate (note warning message
   is seen when running checkpatch)

Big thank you to reviewers for all the suggestions.

Changes in v3:
 Add missed platform_profile.h file

 drivers/acpi/Kconfig             |  33 ++++++
 drivers/acpi/Makefile            |   1 +
 drivers/acpi/platform_profile.c  | 181 +++++++++++++++++++++++++++++++
 include/linux/platform_profile.h |  36 ++++++
 4 files changed, 251 insertions(+)
 create mode 100644 drivers/acpi/platform_profile.c
 create mode 100644 include/linux/platform_profile.h

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index edf1558c1105..73a99af5ec2c 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -326,6 +326,20 @@ config ACPI_THERMAL
 	  To compile this driver as a module, choose M here:
 	  the module will be called thermal.
 
+config ACPI_PLATFORM_PROFILE
+	tristate "ACPI Platform Profile Driver"
+	default y
+	help
+	  This driver adds support for platform-profiles on platforms that
+	  support it.
+	  Platform-profiles can be used to control the platform behaviour. For
+	  example whether to operate in a lower power mode, in a higher
+	  power performance mode or between the two.
+	  This driver provides the sysfs interface and is used as the registration
+	  point for platform specific drivers.
+	  Which profiles are supported is determined on a per-platform basis and
+	  should be obtained from the platform specific driver.
+
 config ACPI_CUSTOM_DSDT_FILE
 	string "Custom DSDT Table file to include"
 	default ""
@@ -538,3 +552,22 @@ config X86_PM_TIMER
 
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
index 44e412506317..c64a8af106c0 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_ACPI_PCI_SLOT)	+= pci_slot.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI)		+= container.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
+obj-$(CONFIG_ACPI_PLATFORM_PROFILE) 	+= platform_profile.o
 obj-$(CONFIG_ACPI_NFIT)		+= nfit/
 obj-$(CONFIG_ACPI_NUMA)		+= numa/
 obj-$(CONFIG_ACPI)		+= acpi_memhotplug.o
diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
new file mode 100644
index 000000000000..e4bbee48c0f8
--- /dev/null
+++ b/drivers/acpi/platform_profile.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/* Platform profile sysfs interface */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kobject.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_profile.h>
+#include <linux/printk.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+
+static struct platform_profile_handler *cur_profile;
+static DEFINE_MUTEX(profile_lock);
+
+/* Ensure the first char of each profile is unique */
+static const char * const profile_names[] = {
+	[profile_low] = "low-power",
+	[profile_cool] = "cool",
+	[profile_quiet] = "quiet",
+	[profile_balance] = "balance",
+	[profile_perform] = "performance",
+};
+static_assert(ARRAY_SIZE(profile_names) == profile_perform+1);
+
+static ssize_t platform_profile_choices_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	int len = 0;
+	int i;
+
+	mutex_lock(&profile_lock);
+	if (!cur_profile) {
+		mutex_unlock(&profile_lock);
+		return -ENODEV;
+	}
+
+	if (!cur_profile->choices) {
+		mutex_unlock(&profile_lock);
+		return sysfs_emit(buf, "\n");
+	}
+
+	for (i = profile_low; i <= profile_perform; i++) {
+		if (cur_profile->choices & BIT(i)) {
+			if (len == 0)
+				len += sysfs_emit_at(buf, len, "%s",  profile_names[i]);
+			else
+				len += sysfs_emit_at(buf, len, " %s",  profile_names[i]);
+		}
+	}
+	len += sysfs_emit_at(buf, len, "\n");
+	mutex_unlock(&profile_lock);
+
+	return len;
+}
+
+static ssize_t platform_profile_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	enum platform_profile_option profile;
+	int err;
+
+	mutex_lock(&profile_lock);
+	if (!cur_profile) {
+		mutex_unlock(&profile_lock);
+		return -EOPNOTSUPP;
+	}
+
+	if (!cur_profile->profile_get) {
+		mutex_unlock(&profile_lock);
+		return -EOPNOTSUPP;
+	}
+
+	err = cur_profile->profile_get(&profile);
+	mutex_unlock(&profile_lock);
+	if (err < 0)
+		return err;
+
+	return sysfs_emit(buf, "%s\n", profile_names[profile]);
+}
+
+static ssize_t platform_profile_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	int err, i;
+
+	mutex_lock(&profile_lock);
+	if (!cur_profile) {
+		mutex_unlock(&profile_lock);
+		return -EOPNOTSUPP;
+	}
+
+	/* Scan for a matching profile */
+	i = sysfs_match_string(profile_names, buf);
+	if (i < 0) {
+		mutex_unlock(&profile_lock);
+		return -EINVAL;
+	}
+
+	if (!cur_profile->profile_set) {
+		mutex_unlock(&profile_lock);
+		return -EOPNOTSUPP;
+	}
+
+	err = cur_profile->profile_set(i);
+	mutex_unlock(&profile_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static DEVICE_ATTR_RO(platform_profile_choices);
+static DEVICE_ATTR_RW(platform_profile);
+
+static struct attribute *platform_profile_attrs[] = {
+	&dev_attr_platform_profile_choices.attr,
+	&dev_attr_platform_profile.attr,
+	NULL
+};
+
+static const struct attribute_group platform_profile_group = {
+	.attrs = platform_profile_attrs
+};
+
+int platform_profile_notify(void)
+{
+	if (!cur_profile)
+		return -EOPNOTSUPP;
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	return 0;
+}
+EXPORT_SYMBOL_GPL(platform_profile_notify);
+
+int platform_profile_register(struct platform_profile_handler *pprof)
+{
+	mutex_lock(&profile_lock);
+	/* We can only have one active profile */
+	if (cur_profile) {
+		mutex_unlock(&profile_lock);
+		return -EEXIST;
+	}
+
+	cur_profile = pprof;
+	mutex_unlock(&profile_lock);
+	return sysfs_create_group(acpi_kobj, &platform_profile_group);
+}
+EXPORT_SYMBOL_GPL(platform_profile_register);
+
+int platform_profile_unregister(void)
+{
+	mutex_lock(&profile_lock);
+	sysfs_remove_group(acpi_kobj, &platform_profile_group);
+	cur_profile = NULL;
+	mutex_unlock(&profile_lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(platform_profile_unregister);
+
+static int __init platform_profile_init(void)
+{
+	return 0;
+}
+module_init(platform_profile_init);
+
+static void __exit platform_profile_exit(void)
+{
+	sysfs_remove_group(acpi_kobj, &platform_profile_group);
+	cur_profile = NULL;
+}
+module_exit(platform_profile_exit);
+
+MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
new file mode 100644
index 000000000000..f6592434c8ce
--- /dev/null
+++ b/include/linux/platform_profile.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Platform profile sysfs interface
+ *
+ * See Documentation/ABI/testing/sysfs-platform_profile.rst for more
+ * information.
+ */
+
+#ifndef _PLATFORM_PROFILE_H_
+#define _PLATFORM_PROFILE_H_
+
+/*
+ * If more options are added please update profile_names
+ * array in platform-profile.c and sysfs-platform-profile.rst
+ * documentation.
+ */
+
+enum platform_profile_option {
+	profile_low,
+	profile_cool,
+	profile_quiet,
+	profile_balance,
+	profile_perform
+};
+
+struct platform_profile_handler {
+	unsigned int choices; /* Bitmap of available choices */
+	int (*profile_get)(enum platform_profile_option *profile);
+	int (*profile_set)(enum platform_profile_option profile);
+};
+
+int platform_profile_register(struct platform_profile_handler *pprof);
+int platform_profile_unregister(void);
+int platform_profile_notify(void);
+
+#endif  /*_PLATFORM_PROFILE_H_*/
-- 
2.25.1

