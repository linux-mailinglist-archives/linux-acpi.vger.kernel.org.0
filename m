Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF445B50F1
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Sep 2022 21:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiIKTuR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 11 Sep 2022 15:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIKTuP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Sep 2022 15:50:15 -0400
Received: from vorpal.se (unknown [151.236.221.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AE521E27;
        Sun, 11 Sep 2022 12:50:00 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id D42B4147E0;
        Sun, 11 Sep 2022 19:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1662925787; bh=a4+Uiq9oNYFLSB0X+3ZnD6NYbxsSyA6xdKPJh6N0odY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ilAZhRBfsMPkBQHkKdcbLYKDRrLAVLA5WDEpkg/dM4RPFbJyhZDH4CESCZDyaB50r
         WDPBtcT1WLTULA/jVrM/PtNZg7elRU43mH91qPCvoc6x53udRzYFSVSy3auVDqRq62
         eR/IQGOREiLXQ/5V68N1DlhO0XA+TsYk2k0yptXfFGYa10nYs7Y0dmYx4iSDdQWFxU
         gCOZSEn5Vdz4Djfj4OmKKa5wuRBqR6knkFu+XF7QfBSUD1Eo339L5z53KvK8Po43x2
         gUhB4X90qylvs0/HmJiR959O19ZVAJRKXUMSWfRa7viF2elz0huv5ewya4Pf43nf/e
         UWQeUINA7/gLQ==
From:   Arvid Norlander <lkml@vorpal.se>
To:     platform-driver-x86@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-input@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>,
        Arvid Norlander <lkml@vorpal.se>
Subject: [PATCH RFC 1/2] staging: quickstart: Add ACPI quickstart button (PNP0C32) driver
Date:   Sun, 11 Sep 2022 21:49:33 +0200
Message-Id: <20220911194934.558019-2-lkml@vorpal.se>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220911194934.558019-1-lkml@vorpal.se>
References: <20220911194934.558019-1-lkml@vorpal.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NO_DNS_FOR_FROM,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is loosly based on a previous staging driver that was removed. See
links below for more info on that driver. The original commit ID was
0be013e3dc2ee79ffab8a438bbb4e216837e3d52.

However, here a completely different approach is taken to the user space
API (which should solve the issues the original driver had). Each PNP0C32
device is a button, and each such button gets a separate input device
associated with it (instead of a shared platform input device).

The button ID (as read from ACPI method GHID) is provided via a sysfs file
"button_id".

If the button caused a wakeup it will "latch" the "wakeup_cause" sysfs file
to true. This can be reset by a user space process.

Link: https://marc.info/?l=linux-acpi&m=120550727131007
Link: https://lkml.org/lkml/2010/5/28/327
Signed-off-by: Arvid Norlander <lkml@vorpal.se>
---
 drivers/staging/Kconfig                 |   2 +
 drivers/staging/Makefile                |   1 +
 drivers/staging/quickstart/Kconfig      |  12 +
 drivers/staging/quickstart/Makefile     |   1 +
 drivers/staging/quickstart/quickstart.c | 376 ++++++++++++++++++++++++
 5 files changed, 392 insertions(+)
 create mode 100644 drivers/staging/quickstart/Kconfig
 create mode 100644 drivers/staging/quickstart/Makefile
 create mode 100644 drivers/staging/quickstart/quickstart.c

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 3bd80f9695ac..db89ffbcd1ad 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -50,6 +50,8 @@ source "drivers/staging/iio/Kconfig"
 
 source "drivers/staging/sm750fb/Kconfig"
 
+source "drivers/staging/quickstart/Kconfig"
+
 source "drivers/staging/emxx_udc/Kconfig"
 
 source "drivers/staging/nvec/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 1d9ae39fea14..cb92880f7db5 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_VT6656)		+= vt6656/
 obj-$(CONFIG_VME_BUS)		+= vme_user/
 obj-$(CONFIG_IIO)		+= iio/
 obj-$(CONFIG_FB_SM750)		+= sm750fb/
+obj-$(CONFIG_ACPI_QUICKSTART)	+= quickstart/
 obj-$(CONFIG_USB_EMXX)		+= emxx_udc/
 obj-$(CONFIG_MFD_NVEC)		+= nvec/
 obj-$(CONFIG_STAGING_BOARD)	+= board/
diff --git a/drivers/staging/quickstart/Kconfig b/drivers/staging/quickstart/Kconfig
new file mode 100644
index 000000000000..e1cf1810e967
--- /dev/null
+++ b/drivers/staging/quickstart/Kconfig
@@ -0,0 +1,12 @@
+config ACPI_QUICKSTART
+	tristate "ACPI Quickstart key driver"
+	depends on ACPI
+	depends on INPUT
+	select INPUT_SPARSEKMAP
+	help
+	  Say Y here if you have a platform that supports the ACPI
+	  quickstart key protocol.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called quickstart.
+
diff --git a/drivers/staging/quickstart/Makefile b/drivers/staging/quickstart/Makefile
new file mode 100644
index 000000000000..290e0e476797
--- /dev/null
+++ b/drivers/staging/quickstart/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ACPI_QUICKSTART)		+= quickstart.o
diff --git a/drivers/staging/quickstart/quickstart.c b/drivers/staging/quickstart/quickstart.c
new file mode 100644
index 000000000000..8d76472c6b7f
--- /dev/null
+++ b/drivers/staging/quickstart/quickstart.c
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  quickstart.c - ACPI Direct App Launch driver
+ *
+ *  Copyright (C) 2022 Arvid Norlander <lkml@vorapal.se>
+ *  Copyright (C) 2007-2010 Angelo Arrifano <miknix@gmail.com>
+ *
+ *  Information gathered from disassembled dsdt and from here:
+ *  <https://archive.org/details/microsoft-acpi-dirapplaunch>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ */
+
+#define QUICKSTART_VERSION "1.04"
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/acpi.h>
+#include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
+
+MODULE_AUTHOR("Arvid Norlander <lkml@vorpal.se>");
+MODULE_AUTHOR("Angelo Arrifano");
+MODULE_DESCRIPTION("ACPI Direct App Launch driver");
+MODULE_LICENSE("GPL");
+
+#define QUICKSTART_ACPI_DEVICE_NAME	"quickstart"
+#define QUICKSTART_ACPI_CLASS		"quickstart"
+#define QUICKSTART_ACPI_HID		"PNP0C32"
+
+/*
+ * There will be two events:
+ * 0x02 - A hot button was pressed while device was off/sleeping.
+ * 0x80 - A hot button was pressed while device was up.
+ */
+#define QUICKSTART_EVENT_WAKE		0x02
+#define QUICKSTART_EVENT_RUNTIME	0x80
+
+/*
+ * Each PNP0C32 device is an individual button. This structure
+ * keeps track of data associated with said device.
+ */
+struct quickstart_acpi {
+	struct acpi_device *acpi_dev;
+	struct input_dev *input_device;
+	struct quickstart_button *button;
+	/* Name of button for debug messages */
+	char *name;
+	/* ID of button as returned by GHID */
+	u32 id;
+	/* Flags for cleanup */
+	unsigned int input_registered : 1;
+	unsigned int sysfs_created : 1;
+	/* Track if a wakeup event was received */
+	unsigned int wakeup_cause : 1;
+	/* Name of input device */
+	char input_name[32];
+	/* Physical path for the input device */
+	char phys[32];
+};
+
+/*
+ * Knowing what these buttons do require system specific knowledge.
+ * This could be done by matching on DMI data in a long quirk table.
+ * However, it is easier to leave it up to user space to figure this out.
+ *
+ * Using for example udev hwdb the scancode 0x1 can be remapped suitably.
+ */
+static const struct key_entry quickstart_keymap[] = {
+	{ KE_KEY, 0x1, { KEY_UNKNOWN } },
+	{ KE_END, 0 },
+};
+
+static ssize_t wakeup_cause_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct quickstart_acpi *quickstart = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n",
+			 (quickstart->wakeup_cause ? "true" : "false"));
+}
+
+static ssize_t wakeup_cause_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct quickstart_acpi *quickstart = dev_get_drvdata(dev);
+
+	if (count < 2)
+		return -EINVAL;
+
+	if (strncasecmp(buf, "false", 4) != 0)
+		return -EINVAL;
+
+	quickstart->wakeup_cause = false;
+	return count;
+}
+static DEVICE_ATTR_RW(wakeup_cause);
+
+static ssize_t button_id_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct quickstart_acpi *quickstart = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", quickstart->id);
+}
+static DEVICE_ATTR_RO(button_id);
+
+/* ACPI Driver functions */
+static void quickstart_acpi_notify(struct acpi_device *acpi_dev, u32 event)
+{
+	struct quickstart_acpi *quickstart = acpi_driver_data(acpi_dev);
+
+	if (!quickstart)
+		return;
+
+	switch (event) {
+	case QUICKSTART_EVENT_WAKE:
+		quickstart->wakeup_cause = true;
+		break;
+	case QUICKSTART_EVENT_RUNTIME:
+		if (!sparse_keymap_report_event(quickstart->input_device, 0x1,
+						1, true)) {
+			pr_info("Key handling error\n");
+		}
+		break;
+	default:
+		pr_err("Unexpected ACPI event notify (%u)\n", event);
+		break;
+	}
+}
+
+/*
+ * The GHID ACPI method is used to indicate the "role" of the button.
+ * However, all the meanings of these values are vendor defined.
+ *
+ * We do however expose this value to user space.
+ */
+static int quickstart_acpi_ghid(struct quickstart_acpi *quickstart)
+{
+	acpi_status status;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	int ret = 0;
+	union acpi_object *obj = NULL;
+
+	/*
+	 * This returns a buffer telling the button usage ID,
+	 * and triggers pending notify events (The ones before booting).
+	 */
+	status = acpi_evaluate_object(quickstart->acpi_dev->handle, "GHID",
+				      NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		pr_err("%s GHID method failed\n", quickstart->name);
+		return -EINVAL;
+	}
+	obj = buffer.pointer;
+
+	/*
+	 * GHID returns buffers, sanity check that is the case.
+	 */
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		pr_err("%s GHID did not return buffer\n", quickstart->name);
+		return -EINVAL;
+	}
+
+	/*
+	 * Quoting the specification:
+	 * "The GHID method can return a BYTE, WORD, or DWORD.
+	 *  The value must be encoded in little-endian byte
+	 *  order (least significant byte first)."
+	 */
+	switch (obj->buffer.length) {
+	case 1:
+		quickstart->id = *(u8 *)obj->buffer.pointer;
+		break;
+	case 2:
+		quickstart->id = le16_to_cpu(*(u16 *)obj->buffer.pointer);
+		break;
+	case 4:
+		quickstart->id = le32_to_cpu(*(u32 *)obj->buffer.pointer);
+		break;
+	case 8:
+		quickstart->id = le64_to_cpu(*(u64 *)obj->buffer.pointer);
+		break;
+	default:
+		pr_err("%s GHID method returned buffer of unexpected length %lu\n",
+		       quickstart->name, (unsigned long)obj->buffer.length);
+		ret = -EINVAL;
+		break;
+	}
+
+	kfree(buffer.pointer);
+
+	return ret;
+}
+
+static int quickstart_acpi_config(struct quickstart_acpi *quickstart)
+{
+	char *bid = acpi_device_bid(quickstart->acpi_dev);
+	char *name;
+
+	name = kmalloc(strlen(bid) + 1, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	quickstart->name = name;
+	strcpy(quickstart->name, bid);
+
+	return 0;
+}
+
+static struct attribute *quickstart_attributes[] = {
+	&dev_attr_wakeup_cause.attr,
+	&dev_attr_button_id.attr,
+	NULL,
+};
+
+static const struct attribute_group quickstart_attr_group = {
+	.attrs = quickstart_attributes,
+};
+
+static int quickstart_acpi_remove(struct acpi_device *acpi_dev)
+{
+	struct quickstart_acpi *quickstart;
+
+	if (!acpi_dev)
+		return -EINVAL;
+
+	quickstart = acpi_driver_data(acpi_dev);
+	if (!quickstart)
+		return -EINVAL;
+
+	if (quickstart->sysfs_created)
+		sysfs_remove_group(&quickstart->acpi_dev->dev.kobj,
+				   &quickstart_attr_group);
+
+	kfree(quickstart->name);
+	quickstart->name = NULL;
+
+	kfree(quickstart);
+
+	return 0;
+}
+
+static int quickstart_acpi_add(struct acpi_device *acpi_dev)
+{
+	int ret;
+	struct quickstart_acpi *quickstart;
+
+	if (!acpi_dev)
+		return -EINVAL;
+
+	quickstart = kzalloc(sizeof(*quickstart), GFP_KERNEL);
+	if (!quickstart)
+		return -ENOMEM;
+
+	/*
+	 * This must be set early for proper cleanup on error handling path.
+	 * After this point generic error handling can be used.
+	 */
+	acpi_dev->driver_data = quickstart;
+	quickstart->acpi_dev = acpi_dev;
+	dev_set_drvdata(&acpi_dev->dev, quickstart);
+
+	strcpy(acpi_device_name(acpi_dev), QUICKSTART_ACPI_DEVICE_NAME);
+	strcpy(acpi_device_class(acpi_dev), QUICKSTART_ACPI_CLASS);
+
+	/* Initialize device name */
+	ret = quickstart_acpi_config(quickstart);
+	if (ret < 0)
+		goto error;
+
+	/* Retrieve the GHID ID */
+	ret = quickstart_acpi_ghid(quickstart);
+	if (ret < 0)
+		goto error;
+
+	/* Set up sysfs entries */
+	ret = sysfs_create_group(&quickstart->acpi_dev->dev.kobj,
+				 &quickstart_attr_group);
+	if (ret) {
+		quickstart->sysfs_created = 0;
+		pr_err("Unable to setup sysfs entries\n");
+		goto error;
+	}
+	quickstart->sysfs_created = !ret;
+
+	/* Set up input device */
+	quickstart->input_device =
+		devm_input_allocate_device(&quickstart->acpi_dev->dev);
+	if (!quickstart->input_device) {
+		ret = -ENOMEM;
+		goto error;
+	}
+	ret = sparse_keymap_setup(quickstart->input_device, quickstart_keymap,
+				  NULL);
+	if (ret)
+		goto error;
+
+	snprintf(quickstart->input_name, sizeof(quickstart->phys),
+		 "Quickstart Button %u", quickstart->id);
+	snprintf(quickstart->phys, sizeof(quickstart->phys),
+		 QUICKSTART_ACPI_DEVICE_NAME "/input%u", quickstart->id);
+
+	quickstart->input_device->name = quickstart->input_name;
+	quickstart->input_device->phys = quickstart->phys;
+	quickstart->input_device->id.bustype = BUS_HOST;
+
+	ret = input_register_device(quickstart->input_device);
+	if (ret) {
+		quickstart->input_registered = 0;
+		pr_err("Unable to register input device\n");
+		goto error;
+	}
+	quickstart->input_registered = !ret;
+
+	return 0;
+error:
+	quickstart_acpi_remove(acpi_dev);
+	return ret;
+}
+
+static const struct acpi_device_id quickstart_device_ids[] = {
+	{ QUICKSTART_ACPI_HID, 0 },
+	{ "", 0 },
+};
+MODULE_DEVICE_TABLE(acpi, quickstart_device_ids);
+
+static struct acpi_driver quickstart_acpi_driver = {
+	.name	= "quickstart",
+	.owner	= THIS_MODULE,
+	.class	= QUICKSTART_ACPI_CLASS,
+	.ids	= quickstart_device_ids,
+	.flags	= ACPI_DRIVER_ALL_NOTIFY_EVENTS,
+	.ops	= {
+		.add = quickstart_acpi_add,
+		.remove = quickstart_acpi_remove,
+		.notify = quickstart_acpi_notify
+	},
+};
+
+/* Module functions */
+static void quickstart_exit(void)
+{
+	acpi_bus_unregister_driver(&quickstart_acpi_driver);
+}
+
+static int __init quickstart_init(void)
+{
+	int ret;
+
+	/* ACPI driver register */
+	ret = acpi_bus_register_driver(&quickstart_acpi_driver);
+	if (ret)
+		return ret;
+
+	pr_info("ACPI Direct App Launch ver %s\n", QUICKSTART_VERSION);
+
+	return 0;
+}
+
+module_init(quickstart_init);
+module_exit(quickstart_exit);
-- 
2.37.3

