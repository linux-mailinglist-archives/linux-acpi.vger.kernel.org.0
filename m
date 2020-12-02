Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63E32CC33D
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Dec 2020 18:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgLBRQh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Dec 2020 12:16:37 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.116]:47942 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726221AbgLBRQg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2020 12:16:36 -0500
Received: from [100.112.133.223] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.us-west-2.aws.symcld.net id 29/62-25369-9DAC7CF5; Wed, 02 Dec 2020 17:11:53 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRWlGSWpSXmKPExsWSLveKXffKqeP
  xBr3/BS32X5ew6FpoYLHw/ilWi6/fbrNbvDk+ncli+b5+RoumziY2i88dk1ksVu95wWyx9ss8
  Noszpy+xOnB7TJo5g9lj56y77B6/tq1h8di8Qstj3slAj562TUwe7/ddZfPYcrWdxePzJrkAz
  ijWzLyk/IoE1oxrP1ayFJzxr9i7eD1rA+NEly5GLg4hgf+MEvNnf2SEcB4wSlx6uR/I4eRgE9
  CW2LLlF1sXIweHiICMxIe1niA1zALzmSSuTbjKDlIjLOAj0bC0lw3EZhFQkdh8sQOsl1fAWmL
  3pRvMILaEgLzE097lzCBzOAVsJGZvzwcJCwmESrxa9YcVolxQ4uTMJywgNjNQefPW2cwQtoTE
  wRcvoMYoSMz7uogFwk6QWPbyDvMERoFZSNpnIWmfhaR9ASPzKkaLpKLM9IyS3MTMHF1DAwNdQ
  0MjXUNjE11DMxO9xCrdJL3SYt3y1OISXSO9xPJiveLK3OScFL281JJNjMBISyloW7KDcdebD3
  qHGCU5mJREeVfNPx4vxJeUn1KZkVicEV9UmpNafIhRhoNDSYJX/yRQTrAoNT21Ii0zBxj1MGk
  JDh4lEV5JkDRvcUFibnFmOkTqFKOilDhvEUhCACSRUZoH1wZLNJcYZaWEeRkZGBiEeApSi3Iz
  S1DlXzGKczAqCfNeOQE0hSczrwRu+iugxUxAi10+HwZZXJKIkJJqYFIpUmqaeyj6ztfUPrkCe
  9urxsvKWyVDz/Xd2nhN6qK87hT/zfas054dMbk9Q4mbb+2yM0cECndzSi6onuHhqpbT/K7kaP
  D1IyveL0lNjmYR9zpyof34AanOl0Jv8gxmfHlsEy36Rnsaz4Nn08//P+tkK/x3P9O1D9mTIlo
  vxOV9ThLn2iRW8DTdJ0fiO+fTY/VP2G8e3R76+EfcFLm7L0QjtV2vvTKwapxQuFKiN2Ovj6j8
  pqsNJ9Yp7X1zJVT78W2Hy8E7WAJTP+2uKNP/snuvQ4ml3lwWKbNIz9Ta3tVbX55pbP8kzHIz8
  eoTP2E5q1l7o4oUHl+eUb196cuys8JsidzqUVNXckV26hysllFiKc5INNRiLipOBACcLjiFrw
  MAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-37.tower-355.messagelabs.com!1606929106!7440!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4321 invoked from network); 2 Dec 2020 17:11:47 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-37.tower-355.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 Dec 2020 17:11:47 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 44EACC56D39F85ECCF7B;
        Thu,  3 Dec 2020 01:11:43 +0800 (CST)
Received: from localhost.home (10.64.84.211) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Wed, 2 Dec 2020
 09:11:38 -0800
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <hdegoede@redhat.com>, <mgross@linux.intel.com>,
        <rjw@rjwysocki.net>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <hadess@hadess.net>,
        <pobrn@protonmail.com>, <mario.limonciello@dell.com>,
        <eliadevito@gmail.com>, <bberg@redhat.com>, <dvhart@infradead.org>
Subject: [PATCH v5 2/3] ACPI: platform-profile: Add platform profile support
Date:   Wed, 2 Dec 2020 12:11:19 -0500
Message-ID: <20201202171120.65269-2-markpearson@lenovo.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201202171120.65269-1-markpearson@lenovo.com>
References: <markpearson@lenovo.com>
 <20201202171120.65269-1-markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.64.84.211]
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

 drivers/acpi/Kconfig             |  14 +++
 drivers/acpi/Makefile            |   1 +
 drivers/acpi/platform_profile.c  | 181 +++++++++++++++++++++++++++++++
 include/linux/platform_profile.h |  39 +++++++
 4 files changed, 235 insertions(+)
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
index 000000000000..1bc092359e35
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
+	[platform_profile_low] = "low-power",
+	[platform_profile_cool] = "cool",
+	[platform_profile_quiet] = "quiet",
+	[platform_profile_balanced] = "balanced",
+	[platform_profile_perform] = "performance",
+};
+static_assert(ARRAY_SIZE(profile_names) == platform_profile_last);
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
+	for_each_set_bit(i, cur_profile->choices, platform_profile_last) {
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
+	enum platform_profile_option profile = platform_profile_balanced;
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
+int platform_profile_unregister(void)
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
+EXPORT_SYMBOL_GPL(platform_profile_unregister);
+
+MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
new file mode 100644
index 000000000000..f2e1b1c90482
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
+	platform_profile_low,
+	platform_profile_cool,
+	platform_profile_quiet,
+	platform_profile_balanced,
+	platform_profile_perform,
+	platform_profile_last, /*must always be last */
+};
+
+struct platform_profile_handler {
+	unsigned long choices[BITS_TO_LONGS(platform_profile_last)];
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

