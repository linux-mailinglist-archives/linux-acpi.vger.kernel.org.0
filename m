Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333C82C5997
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Nov 2020 17:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391520AbgKZQwX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Nov 2020 11:52:23 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.3]:61118 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391590AbgKZQwX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 26 Nov 2020 11:52:23 -0500
Received: from [100.112.1.203] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.us-east-1.aws.symcld.net id 3D/4C-29643-34DDFBF5; Thu, 26 Nov 2020 16:52:19 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRWlGSWpSXmKPExsWSLveKTdf57v5
  4g+5dchb7r0tYdC00sFh4/xSrxddvt9kt3hyfzmSxfF8/o8XHZRwWnzsms1is3vOC2WLtl3ls
  FmdOX2J14PaYNHMGs8fOWXfZPX5tW8PisXmFlse8k4EePW2bmDze77vK5rHlajuLx+dNcgGcU
  ayZeUn5FQmsGb3bdjIWHPCvOHhMs4Hxl3MXIxeHkMB/Roln15pYuhg5gZyHjBKfr4iA2GwC2h
  Jbtvxi62Lk4BARkJH4sNYTpJ5ZYAGTxJfra1hB4sICPhJb2pNBylkEVCU2//jEBGLzClhLTOr
  7yQhiSwjISzztXc4MYnMK2Eg8nvOOHWJVqET/0ifMEPWCEidnPgE7gRmovnnrbGYIW0Li4IsX
  zBBzFCQmL7jKBGEnSCx7eYd5AqPALCTts5C0z0LSvoCReRWjaVJRZnpGSW5iZo6uoYGBrqGhk
  a6hroWlXmKVbpJeabFuamJxia6hXmJ5sV5xZW5yTopeXmrJJkZgdKUUMEbuYNz3+oPeIUZJDi
  YlUd4le/bHC/El5adUZiQWZ8QXleakFh9ilOHgUJLg9bwNlBMsSk1PrUjLzAFGOkxagoNHSYT
  3N0iat7ggMbc4Mx0idYpRUUqcdxtIQgAkkVGaB9cGSy6XGGWlhHkZGRgYhHgKUotyM0tQ5V8x
  inMwKgnzhoFM4cnMK4Gb/gpoMRPQ4umce0AWlyQipKQamAodlm57aKp//fimtKp3rrX6AcWTU
  /WEDoTv7L9+2cIut0U5mp3VO5vl+6tb25VtUpsY1pQtS5NVYTz4UEDPJm69RN0DpXeGgpfEeH
  61hH24einLSJvRU+E2j/VHvhTpeaeueX+TtnWZFemy+oZs/c04i1kKKxZ67srLW/fTZ2Fd9Zv
  pFX+cFqncnb/VX1rz6rzHzYqJaQ8/p6UeiOuV8j2tMe3+V+2JpySkeib/3Xbtpc+jFQEfBSuX
  8a0r7ZwWv1C4r+JA4A3OjgKDktKJF20Xt8Yvmavr9D6lNctdwtJoW3nvpL3Mlxa8Y1VZm1MUl
  h1zg7O2QrB20b3KkLmCItfkm1SndypEZfwN7buhxFKckWioxVxUnAgAXl1656kDAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-4.tower-396.messagelabs.com!1606409537!1406277!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7489 invoked from network); 26 Nov 2020 16:52:19 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-4.tower-396.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Nov 2020 16:52:19 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 4D81B908DC87CDDAB036;
        Fri, 27 Nov 2020 00:52:14 +0800 (CST)
Received: from localhost.home (10.64.80.205) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Thu, 26 Nov
 2020 08:52:09 -0800
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <hdegoede@redhat.com>, <mgross@linux.intel.com>,
        <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <rjw@rjwysocki.net>,
        <hadess@hadess.net>, <pobrn@protonmail.com>,
        <mario.limnociello@dell.com>, <eliadevito@gmail.com>,
        <bberg@redhat.com>, <dvhart@infradead.org>
Subject: [PATCH v4 2/3] ACPI: platform-profile: Add platform profile support
Date:   Thu, 26 Nov 2020 11:51:42 -0500
Message-ID: <20201126165143.32776-2-markpearson@lenovo.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201126165143.32776-1-markpearson@lenovo.com>
References: <markpearson@lenovo.com>
 <20201126165143.32776-1-markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.64.80.205]
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

Changes in v3:
 - Add missed platform_profile.h file

Changes in v4:
 - Clean up duplicate entry in Kconfig file
 - Add linux/bits.h to include list
 - Remove unnecessary items from include list
 - Make cur_profile const
 - Clean up comments
 - formatting clean-ups
 - add checking of profile return value to show function
 - add checking to store to see if it's a supported profile
 - revert ENOTSUPP change in store function
 - improved error checking in profile registration
 - improved profile naming (now platform_profile_*)

 drivers/acpi/Kconfig             |  14 ++
 drivers/acpi/Makefile            |   1 +
 drivers/acpi/platform_profile.c  | 215 +++++++++++++++++++++++++++++++
 include/linux/platform_profile.h |  36 ++++++
 4 files changed, 266 insertions(+)
 create mode 100644 drivers/acpi/platform_profile.c
 create mode 100644 include/linux/platform_profile.h

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index edf1558c1105..c1ca6255ff85 100644
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
index 000000000000..678cb4596ada
--- /dev/null
+++ b/drivers/acpi/platform_profile.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/* Platform profile sysfs interface */
+
+#include <linux/acpi.h>
+#include <linux/bits.h>
+#include <linux/init.h>
+#include <linux/mutex.h>
+#include <linux/platform_profile.h>
+#include <linux/sysfs.h>
+
+static const struct platform_profile_handler *cur_profile;
+static DEFINE_MUTEX(profile_lock);
+
+static const char * const profile_names[] = {
+	[platform_profile_low] = "low-power",
+	[platform_profile_cool] = "cool",
+	[platform_profile_quiet] = "quiet",
+	[platform_profile_balance] = "balance",
+	[platform_profile_perform] = "performance",
+};
+static_assert(ARRAY_SIZE(profile_names) == platform_profile_perform+1);
+
+static ssize_t platform_profile_choices_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	int len = 0;
+	int err, i;
+
+	err = mutex_lock_interruptible(&profile_lock);
+	if (err)
+		return err;
+
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
+	for (i = 0; i < ARRAY_SIZE(profile_names); i++) {
+		if (cur_profile->choices & BIT(i)) {
+			if (len == 0)
+				len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
+			else
+				len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
+		}
+	}
+	len += sysfs_emit_at(buf, len, "\n");
+	mutex_unlock(&profile_lock);
+	return len;
+}
+
+static ssize_t platform_profile_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	enum platform_profile_option profile = platform_profile_balance;
+	int err;
+
+	err = mutex_lock_interruptible(&profile_lock);
+	if (err)
+		return err;
+
+	if (!cur_profile) {
+		mutex_unlock(&profile_lock);
+		return -ENODEV;
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
+	/* Check that profile is valid index */
+	if ((profile < 0) || (profile >= ARRAY_SIZE(profile_names)))
+		return sysfs_emit(buf, "\n");
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
+	err = mutex_lock_interruptible(&profile_lock);
+	if (err)
+		return err;
+
+	if (!cur_profile) {
+		mutex_unlock(&profile_lock);
+		return -ENODEV;
+	}
+
+	if (!cur_profile->profile_set) {
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
+	/* Check that platform supports this profile choice */
+	if (!(cur_profile->choices & BIT(i))) {
+		mutex_unlock(&profile_lock);
+		return -EOPNOTSUPP;
+	}
+
+	err = cur_profile->profile_set(i);
+	mutex_unlock(&profile_lock);
+	if (err)
+		return err;
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
+void platform_profile_notify(void)
+{
+	if (!cur_profile)
+		return;
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+}
+EXPORT_SYMBOL_GPL(platform_profile_notify);
+
+int platform_profile_register(const struct platform_profile_handler *pprof)
+{
+	int err;
+
+	err = mutex_lock_interruptible(&profile_lock);
+	if (err)
+		return err;
+
+	/* We can only have one active profile */
+	if (cur_profile) {
+		mutex_unlock(&profile_lock);
+		return -EEXIST;
+	}
+
+	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
+	if (err) {
+		mutex_unlock(&profile_lock);
+		return err;
+	}
+
+	cur_profile = pprof;
+	mutex_unlock(&profile_lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(platform_profile_register);
+
+int platform_profile_unregister(void)
+{
+	int err;
+
+	err = mutex_lock_interruptible(&profile_lock);
+	if (err)
+		return err;
+
+	if (!cur_profile) {
+		mutex_unlock(&profile_lock);
+		return -ENODEV;
+	}
+
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
+	/* Check if we have a registered profile, and clean up */
+	if (cur_profile) {
+		sysfs_remove_group(acpi_kobj, &platform_profile_group);
+		cur_profile = NULL;
+	}
+}
+module_exit(platform_profile_exit);
+
+MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
new file mode 100644
index 000000000000..33ccd40bb9cf
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
+	platform_profile_low,
+	platform_profile_cool,
+	platform_profile_quiet,
+	platform_profile_balance,
+	platform_profile_perform,
+};
+
+struct platform_profile_handler {
+	unsigned int choices; /* Bitmap of available choices */
+	int (*profile_get)(enum platform_profile_option *profile);
+	int (*profile_set)(enum platform_profile_option profile);
+};
+
+int platform_profile_register(const struct platform_profile_handler *pprof);
+int platform_profile_unregister(void);
+void platform_profile_notify(void);
+
+#endif  /*_PLATFORM_PROFILE_H_*/
-- 
2.28.0

