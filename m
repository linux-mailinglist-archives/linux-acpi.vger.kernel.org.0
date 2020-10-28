Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512A029D582
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Oct 2020 23:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgJ1WEg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Oct 2020 18:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbgJ1WEd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Oct 2020 18:04:33 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7A3C0613CF;
        Wed, 28 Oct 2020 15:04:32 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d24so872143ljg.10;
        Wed, 28 Oct 2020 15:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=akECrq7o9HUEnJdCiI8zEh/8bSiP+m63+FBfjf6s0F8=;
        b=WmU1FpEy7SQataM0NhkZnYY0FpjhTCmMRqecukjtK0B1KZCa7sOilIQauinQrcMIX9
         2rBt2N0Dbg4A7iYD8JDUZda7fK1n5iQz3mrfGHIQ9HElTO5Mk1AItjGdR/O1sdnw1m5S
         JtXoZIMEx4HwjuAzykZic6MjVCvlLVyLjl2BzhnsrByR7H91Y8lTr0koyn1hKaRQ0Soy
         zHywpeJTa6RPuqk+cqOi39dLCWCyx2HTFrrVf0xVXuzaiTa3JEEbri+rCGqPfgVimhOa
         uIlPuAZOSXV9lbS6dtYRaRc4zm2K6L+dukgyYr1fdnm74XvoCmd7mb+z+t6FhqS2wDJq
         qkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=akECrq7o9HUEnJdCiI8zEh/8bSiP+m63+FBfjf6s0F8=;
        b=Wwjc6LeDamfjLvLXdN5ePmZKXXoa65NgGjxDp4jSJr3QdgdbTTZ7K/pnPELA+83Qrs
         oZazLUzkTLdyV+Owanx9LeNRzualrkjbKrN2zQRGfHOyZhimL3F5i3vHio0WtGwX4H2r
         iELwhV1eHrPypL+tVzkv4t6ow5igDJqOGKhvrk/wQASznhk73+ufXyxWytUwN3xmHY5g
         ovruftNX+hEhJlbfXtZzBKHoeAx2DbR7SrCvl9hsHRLPjf9X/pNIqZ2Cdgd1GFEaYJjN
         xkE1yD67QvqXoetiNV2FJHGlYBe89kLxQOvFOA6/syeRLC5rkQiOCDTmWaV6rc115d0S
         Rgdw==
X-Gm-Message-State: AOAM531rkIAcKEKjdUD/P/XEpa3wboBnzMw6gOef0lo2Y7+z6P3BiHqj
        b9O3GJV+mR7RLq478Eoi+9JYPOoCGTs=
X-Google-Smtp-Source: ABdhPJwu2hqgHtN6pGncrLaNaGjwhlVyTNaQbT7aV/cSdYee1XA+pqKC9SelNk5EpVWMOMge+7yzjA==
X-Received: by 2002:a17:906:c1ce:: with SMTP id bw14mr6854441ejb.302.1603882475915;
        Wed, 28 Oct 2020 03:54:35 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a52a.dip0.t-ipconnect.de. [217.229.165.42])
        by smtp.gmail.com with ESMTPSA id ks17sm2709156ejb.41.2020.10.28.03.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 03:54:35 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH v5] platform/surface: Add Driver to set up lid GPEs on MS Surface device
Date:   Wed, 28 Oct 2020 11:54:27 +0100
Message-Id: <20201028105427.1593764-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Conventionally, wake-up events for a specific device, in our case the
lid device, are managed via the ACPI _PRW field. While this does not
seem strictly necessary based on ACPI spec, the kernel disables GPE
wakeups to avoid non-wakeup interrupts preventing suspend by default and
only enables GPEs associated via the _PRW field with a wake-up capable
device. This behavior has been introduced in commit f941d3e41da7 ("ACPI:
EC / PM: Disable non-wakeup GPEs for suspend-to-idle") and is described
in more detail in its commit message.

Unfortunately, on MS Surface devices, there is no _PRW field present on
the lid device, thus no GPE is associated with it, and therefore the GPE
responsible for sending the status-change notification to the lid gets
disabled during suspend, making it impossible to wake the device via the
lid.

This patch introduces a pseudo-device and respective driver which, based
on some DMI matching, marks the corresponding GPE of the lid device for
wake and enables it during suspend. The behavior of this driver models
the behavior of the ACPI/PM core for normal wakeup GPEs, properly
declared via the _PRW field.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Note: This patch depends and is based on

  [PATCH v4] platform/surface: Create a platform subdirectory for
             Microsoft Surface devices

which can be found at

  https://lore.kernel.org/platform-driver-x86/20201009141128.683254-1-luzmaximilian@gmail.com/

and is currently in platform-drivers-x86/for-next.

Changes in v2:
 - Use software nodes and device properties instead of platform data.
 - Simplify module alias.
 - Add comment regarding origin of GPE numbers.
 - Fix style issues.

Changes in v3:
 - Rebase onto v5.9-rc5
 - Fix and restructure error handling and module cleanup.
 - Remove unnecessary platform_set_drvdata(..., NULL) calls.
 - Add pr_fmt definition
 - Return -ENODEV if no compatible device is found in module init.

Changes in v4:
 - Rebase onto platform/surface patch-set
 - Add copyright line
 - Fix typo in comment

Changes in v5:
 - Rebase onto current platform-drivers-x86/for-next
 - Fix MAINTAINERS entry

---
 MAINTAINERS                            |   6 +
 drivers/platform/surface/Kconfig       |  10 +
 drivers/platform/surface/Makefile      |   1 +
 drivers/platform/surface/surface_gpe.c | 309 +++++++++++++++++++++++++
 4 files changed, 326 insertions(+)
 create mode 100644 drivers/platform/surface/surface_gpe.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 38b70bd41d96..17e51a309a3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11658,6 +11658,12 @@ F:	drivers/scsi/smartpqi/smartpqi*.[ch]
 F:	include/linux/cciss*.h
 F:	include/uapi/linux/cciss*.h
 
+MICROSOFT SURFACE GPE LID SUPPORT DRIVER
+M:	Maximilian Luz <luzmaximilian@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/surface/surface_gpe.c
+
 MICROSOFT SURFACE HARDWARE PLATFORM SUPPORT
 M:	Hans de Goede <hdegoede@redhat.com>
 M:	Mark Gross <mgross@linux.intel.com>
diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index 10902ea43861..33040b0b3b79 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -40,6 +40,16 @@ config SURFACE_3_POWER_OPREGION
 	  This driver provides support for ACPI operation
 	  region of the Surface 3 battery platform driver.
 
+config SURFACE_GPE
+	tristate "Surface GPE/Lid Support Driver"
+	depends on ACPI
+	depends on DMI
+	help
+	  This driver marks the GPEs related to the ACPI lid device found on
+	  Microsoft Surface devices as wakeup sources and prepares them
+	  accordingly. It is required on those devices to allow wake-ups from
+	  suspend by opening the lid.
+
 config SURFACE_PRO3_BUTTON
 	tristate "Power/home/volume buttons driver for Microsoft Surface Pro 3/4 tablet"
 	depends on ACPI && INPUT
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
index dcb1df06d57a..cedfb027ded1 100644
--- a/drivers/platform/surface/Makefile
+++ b/drivers/platform/surface/Makefile
@@ -7,4 +7,5 @@
 obj-$(CONFIG_SURFACE3_WMI)		+= surface3-wmi.o
 obj-$(CONFIG_SURFACE_3_BUTTON)		+= surface3_button.o
 obj-$(CONFIG_SURFACE_3_POWER_OPREGION)	+= surface3_power.o
+obj-$(CONFIG_SURFACE_GPE)		+= surface_gpe.o
 obj-$(CONFIG_SURFACE_PRO3_BUTTON)	+= surfacepro3_button.o
diff --git a/drivers/platform/surface/surface_gpe.c b/drivers/platform/surface/surface_gpe.c
new file mode 100644
index 000000000000..0f44a52d3a9b
--- /dev/null
+++ b/drivers/platform/surface/surface_gpe.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Surface GPE/Lid driver to enable wakeup from suspend via the lid by
+ * properly configuring the respective GPEs. Required for wakeup via lid on
+ * newer Intel-based Microsoft Surface devices.
+ *
+ * Copyright (C) 2020 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/acpi.h>
+#include <linux/dmi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+/*
+ * Note: The GPE numbers for the lid devices found below have been obtained
+ *       from ACPI/the DSDT table, specifically from the GPE handler for the
+ *       lid.
+ */
+
+static const struct property_entry lid_device_props_l17[] = {
+	PROPERTY_ENTRY_U32("gpe", 0x17),
+	{},
+};
+
+static const struct property_entry lid_device_props_l4D[] = {
+	PROPERTY_ENTRY_U32("gpe", 0x4D),
+	{},
+};
+
+static const struct property_entry lid_device_props_l4F[] = {
+	PROPERTY_ENTRY_U32("gpe", 0x4F),
+	{},
+};
+
+static const struct property_entry lid_device_props_l57[] = {
+	PROPERTY_ENTRY_U32("gpe", 0x57),
+	{},
+};
+
+/*
+ * Note: When changing this, don't forget to check that the MODULE_ALIAS below
+ *       still fits.
+ */
+static const struct dmi_system_id dmi_lid_device_table[] = {
+	{
+		.ident = "Surface Pro 4",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Surface Pro 4"),
+		},
+		.driver_data = (void *)lid_device_props_l17,
+	},
+	{
+		.ident = "Surface Pro 5",
+		.matches = {
+			/*
+			 * We match for SKU here due to generic product name
+			 * "Surface Pro".
+			 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "Surface_Pro_1796"),
+		},
+		.driver_data = (void *)lid_device_props_l4F,
+	},
+	{
+		.ident = "Surface Pro 5 (LTE)",
+		.matches = {
+			/*
+			 * We match for SKU here due to generic product name
+			 * "Surface Pro"
+			 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "Surface_Pro_1807"),
+		},
+		.driver_data = (void *)lid_device_props_l4F,
+	},
+	{
+		.ident = "Surface Pro 6",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Surface Pro 6"),
+		},
+		.driver_data = (void *)lid_device_props_l4F,
+	},
+	{
+		.ident = "Surface Pro 7",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Surface Pro 7"),
+		},
+		.driver_data = (void *)lid_device_props_l4D,
+	},
+	{
+		.ident = "Surface Book 1",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Surface Book"),
+		},
+		.driver_data = (void *)lid_device_props_l17,
+	},
+	{
+		.ident = "Surface Book 2",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Surface Book 2"),
+		},
+		.driver_data = (void *)lid_device_props_l17,
+	},
+	{
+		.ident = "Surface Book 3",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Surface Book 3"),
+		},
+		.driver_data = (void *)lid_device_props_l4D,
+	},
+	{
+		.ident = "Surface Laptop 1",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Surface Laptop"),
+		},
+		.driver_data = (void *)lid_device_props_l57,
+	},
+	{
+		.ident = "Surface Laptop 2",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Surface Laptop 2"),
+		},
+		.driver_data = (void *)lid_device_props_l57,
+	},
+	{
+		.ident = "Surface Laptop 3 (Intel 13\")",
+		.matches = {
+			/*
+			 * We match for SKU here due to different variants: The
+			 * AMD (15") version does not rely on GPEs.
+			 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "Surface_Laptop_3_1867:1868"),
+		},
+		.driver_data = (void *)lid_device_props_l4D,
+	},
+	{ }
+};
+
+struct surface_lid_device {
+	u32 gpe_number;
+};
+
+static int surface_lid_enable_wakeup(struct device *dev, bool enable)
+{
+	const struct surface_lid_device *lid = dev_get_drvdata(dev);
+	int action = enable ? ACPI_GPE_ENABLE : ACPI_GPE_DISABLE;
+	acpi_status status;
+
+	status = acpi_set_gpe_wake_mask(NULL, lid->gpe_number, action);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "failed to set GPE wake mask: %s\n",
+			acpi_format_exception(status));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int surface_gpe_suspend(struct device *dev)
+{
+	return surface_lid_enable_wakeup(dev, true);
+}
+
+static int surface_gpe_resume(struct device *dev)
+{
+	return surface_lid_enable_wakeup(dev, false);
+}
+
+static SIMPLE_DEV_PM_OPS(surface_gpe_pm, surface_gpe_suspend, surface_gpe_resume);
+
+static int surface_gpe_probe(struct platform_device *pdev)
+{
+	struct surface_lid_device *lid;
+	u32 gpe_number;
+	acpi_status status;
+	int ret;
+
+	ret = device_property_read_u32(&pdev->dev, "gpe", &gpe_number);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to read 'gpe' property: %d\n", ret);
+		return ret;
+	}
+
+	lid = devm_kzalloc(&pdev->dev, sizeof(*lid), GFP_KERNEL);
+	if (!lid)
+		return -ENOMEM;
+
+	lid->gpe_number = gpe_number;
+	platform_set_drvdata(pdev, lid);
+
+	status = acpi_mark_gpe_for_wake(NULL, gpe_number);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&pdev->dev, "failed to mark GPE for wake: %s\n",
+			acpi_format_exception(status));
+		return -EINVAL;
+	}
+
+	status = acpi_enable_gpe(NULL, gpe_number);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&pdev->dev, "failed to enable GPE: %s\n",
+			acpi_format_exception(status));
+		return -EINVAL;
+	}
+
+	ret = surface_lid_enable_wakeup(&pdev->dev, false);
+	if (ret)
+		acpi_disable_gpe(NULL, gpe_number);
+
+	return ret;
+}
+
+static int surface_gpe_remove(struct platform_device *pdev)
+{
+	struct surface_lid_device *lid = dev_get_drvdata(&pdev->dev);
+
+	/* restore default behavior without this module */
+	surface_lid_enable_wakeup(&pdev->dev, false);
+	acpi_disable_gpe(NULL, lid->gpe_number);
+
+	return 0;
+}
+
+static struct platform_driver surface_gpe_driver = {
+	.probe = surface_gpe_probe,
+	.remove = surface_gpe_remove,
+	.driver = {
+		.name = "surface_gpe",
+		.pm = &surface_gpe_pm,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+
+static struct platform_device *surface_gpe_device;
+
+static int __init surface_gpe_init(void)
+{
+	const struct dmi_system_id *match;
+	struct platform_device *pdev;
+	struct fwnode_handle *fwnode;
+	int status;
+
+	match = dmi_first_match(dmi_lid_device_table);
+	if (!match) {
+		pr_info("no compatible Microsoft Surface device found, exiting\n");
+		return -ENODEV;
+	}
+
+	status = platform_driver_register(&surface_gpe_driver);
+	if (status)
+		return status;
+
+	fwnode = fwnode_create_software_node(match->driver_data, NULL);
+	if (IS_ERR(fwnode)) {
+		status = PTR_ERR(fwnode);
+		goto err_node;
+	}
+
+	pdev = platform_device_alloc("surface_gpe", PLATFORM_DEVID_NONE);
+	if (!pdev) {
+		status = -ENOMEM;
+		goto err_alloc;
+	}
+
+	pdev->dev.fwnode = fwnode;
+
+	status = platform_device_add(pdev);
+	if (status)
+		goto err_add;
+
+	surface_gpe_device = pdev;
+	return 0;
+
+err_add:
+	platform_device_put(pdev);
+err_alloc:
+	fwnode_remove_software_node(fwnode);
+err_node:
+	platform_driver_unregister(&surface_gpe_driver);
+	return status;
+}
+module_init(surface_gpe_init);
+
+static void __exit surface_gpe_exit(void)
+{
+	struct fwnode_handle *fwnode = surface_gpe_device->dev.fwnode;
+
+	platform_device_unregister(surface_gpe_device);
+	platform_driver_unregister(&surface_gpe_driver);
+	fwnode_remove_software_node(fwnode);
+}
+module_exit(surface_gpe_exit);
+
+MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
+MODULE_DESCRIPTION("Surface GPE/Lid Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("dmi:*:svnMicrosoftCorporation:pnSurface*:*");
-- 
2.29.1

