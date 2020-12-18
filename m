Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B1F2DE896
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 18:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgLRRyf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Dec 2020 12:54:35 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.112]:7846 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbgLRRyf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Dec 2020 12:54:35 -0500
Received: from [100.112.4.31] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-c.us-east-1.aws.symcld.net id AC/23-29370-39BECDF5; Fri, 18 Dec 2020 17:49:07 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRWlGSWpSXmKPExsWSLveKTXfS6zv
  xBu9n61jsvy5h0bXQwGLh/VOsFl+/3Wa3eHN8OpPF8n39jBZNnU1sFp87JrNYrN7zgtli7Zd5
  bBZnTl9ideD2mDRzBrPHzll32T1+bVvD4rF5hZbHvJOBHj1tm5g83u+7yuax5Wo7i8fnTXIBn
  FGsmXlJ+RUJrBm7nnWyF2wJrHj24ANbA+Mx1y5GLg4hgf+MEocPzGSEcB4ySkyb38zcxcjJwS
  agLbFlyy+2LkYODhEBGYkPaz1BwswC25gkevcFgdjCAj4Snx5uYwOxWQRUJf40t7GD2LwCNhK
  TW3aC2RIC8hJPe5eDjeQUsJXYs/wwO8hIIYEwiYbHTBDlghInZz5hgRgvL9G8dTYzhC0hcfDF
  C2aIMQoSi579Z4OwEySWvbzDPIFRYBaS9llI2mchaV/AyLyK0SypKDM9oyQ3MTNH19DAQNfQ0
  EjXRNfI0EwvsUo3Wa+0WDc1sbhE11AvsbxYr7gyNzknRS8vtWQTIzDGUgpYbuxgvPf6g94hRk
  kOJiVRXq0Hd+KF+JLyUyozEosz4otKc1KLDzHKcHAoSfCWvwLKCRalpqdWpGXmAOMdJi3BwaM
  kwrsaJM1bXJCYW5yZDpE6xagoJc676SFQQgAkkVGaB9cGSzGXGGWlhHkZGRgYhHgKUotyM0tQ
  5V8xinMwKgnzngEZz5OZVwI3/RXQYiagxXwzboMsLklESEk1MLXLqU1/smNKbVz7e+E/fI9MV
  d4ksxyexlOicU9h/cd1nWePc87Q+Lcr6HW15VLGmomib3xfhdseWfV+w0Fv5pzq+t4ZaiGPJF
  +wRDmfWT/VJTlLyURn8QamUxUe9gr/4uTdzx3d2nVX/vKDvesUHwfeT9+bpxLcX3eG796un7q
  Fq9pnRjIXfOR+yfqlfP4nPtf2S5+TgtJUbtesOtTefmFKaT5LaPkL76Qzy7o3fIpO6U+N2bLy
  2JWTU5ZdEA42MH/tdkzdwT9kcWfOp7aZJ1gsEku350pKaN06E+hoa6+zi/Hiqa6r85W3vtvw8
  H5o2TbZgm32ItkNwSFyzUy6P61XCKrYJS3/arr9WeLdYCWW4oxEQy3mouJEALxMtsGsAwAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-34.tower-406.messagelabs.com!1608313744!85171!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24193 invoked from network); 18 Dec 2020 17:49:06 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-34.tower-406.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 18 Dec 2020 17:49:06 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 92CF9829152D54BB5F65;
        Sat, 19 Dec 2020 01:49:01 +0800 (CST)
Received: from localhost.home (10.64.89.183) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Fri, 18 Dec
 2020 09:48:57 -0800
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <hdegoede@redhat.com>, <mgross@linux.intel.com>,
        <rjw@rjwysocki.net>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <hadess@hadess.net>,
        <pobrn@protonmail.com>, <mario.limonciello@dell.com>,
        <eliadevito@gmail.com>, <bberg@redhat.com>, <dvhart@infradead.org>,
        <njoshi1@lenovo.com>
Subject: [PATCH v7 2/3] ACPI: platform-profile: Add platform profile support
Date:   Fri, 18 Dec 2020 12:47:58 -0500
Message-ID: <20201218174759.667457-2-markpearson@lenovo.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201218174759.667457-1-markpearson@lenovo.com>
References: <markpearson@lenovo.com>
 <20201218174759.667457-1-markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.64.89.183]
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

Changes in v5:
 - correct 'balance' to 'balanced' to be consistent with documentation
 - add WARN_ON when checking profile index in show function
 - switch mutex_lock_interruptible back to mutex_lock where appropriate
 - add 'platform_profile_last' as final entry in profile entry. Update
   implementation to use this appropriately
 - Use BITS_TO_LONG and appropriate access functions for choices field
 - Correct error handling as recommended
 - Sanity check profile fields on registration
 - Remove unnecessary init and exit functions

Changed in v6:
 - Change default build option to 'm' and clean in formating in Kconfig
 - Change enums to be capitalised as requested
 - Rename unregister function to remove

Changes in v7
 - version bump along with rest of patch series

 drivers/acpi/Kconfig             |  17 +++
 drivers/acpi/Makefile            |   1 +
 drivers/acpi/platform_profile.c  | 181 +++++++++++++++++++++++++++++++
 include/linux/platform_profile.h |  39 +++++++
 4 files changed, 238 insertions(+)
 create mode 100644 drivers/acpi/platform_profile.c
 create mode 100644 include/linux/platform_profile.h

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index edf1558c1105..5ddff93e38c2 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -326,6 +326,23 @@ config ACPI_THERMAL
 	  To compile this driver as a module, choose M here:
 	  the module will be called thermal.
 
+config ACPI_PLATFORM_PROFILE
+	tristate "ACPI Platform Profile Driver"
+	default m
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
index 000000000000..567b2320693a
--- /dev/null
+++ b/drivers/acpi/platform_profile.c
@@ -0,0 +1,181 @@
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
+	[PLATFORM_PROFILE_LOW] = "low-power",
+	[PLATFORM_PROFILE_COOL] = "cool",
+	[PLATFORM_PROFILE_QUIET] = "quiet",
+	[PLATFORM_PROFILE_BALANCED] = "balanced",
+	[PLATFORM_PROFILE_PERFORM] = "performance",
+};
+static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
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
+	for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
+		if (len == 0)
+			len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
+		else
+			len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
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
+	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
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
+	err = cur_profile->profile_get(&profile);
+	mutex_unlock(&profile_lock);
+	if (err)
+		return err;
+
+	/* Check that profile is valid index */
+	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
+		return -EIO;
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
+	/* Scan for a matching profile */
+	i = sysfs_match_string(profile_names, buf);
+	if (i < 0) {
+		mutex_unlock(&profile_lock);
+		return -EINVAL;
+	}
+
+	/* Check that platform supports this profile choice */
+	if (!test_bit(i, cur_profile->choices)) {
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
+	mutex_lock(&profile_lock);
+	/* We can only have one active profile */
+	if (cur_profile) {
+		mutex_unlock(&profile_lock);
+		return -EEXIST;
+	}
+
+	/* Sanity check the profile handler field are set */
+	if (!pprof || !pprof->choices || !pprof->profile_set ||
+			!pprof->profile_get) {
+		mutex_unlock(&profile_lock);
+		return -EINVAL;
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
+int platform_profile_remove(void)
+{
+	mutex_lock(&profile_lock);
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
+EXPORT_SYMBOL_GPL(platform_profile_remove);
+
+MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
new file mode 100644
index 000000000000..9a1e2abd7602
--- /dev/null
+++ b/include/linux/platform_profile.h
@@ -0,0 +1,39 @@
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
+#include <linux/bitops.h>
+
+/*
+ * If more options are added please update profile_names
+ * array in platform-profile.c and sysfs-platform-profile.rst
+ * documentation.
+ */
+
+enum platform_profile_option {
+	PLATFORM_PROFILE_LOW,
+	PLATFORM_PROFILE_COOL,
+	PLATFORM_PROFILE_QUIET,
+	PLATFORM_PROFILE_BALANCED,
+	PLATFORM_PROFILE_PERFORM,
+	PLATFORM_PROFILE_LAST, /*must always be last */
+};
+
+struct platform_profile_handler {
+	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
+	int (*profile_get)(enum platform_profile_option *profile);
+	int (*profile_set)(enum platform_profile_option profile);
+};
+
+int platform_profile_register(const struct platform_profile_handler *pprof);
+int platform_profile_remove(void);
+void platform_profile_notify(void);
+
+#endif  /*_PLATFORM_PROFILE_H_*/
-- 
2.28.0

