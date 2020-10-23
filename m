Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20D2297114
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Oct 2020 16:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750290AbgJWOIh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Oct 2020 10:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750281AbgJWOIf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Oct 2020 10:08:35 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3B6C0613CE;
        Fri, 23 Oct 2020 07:08:35 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a3so2552953ejy.11;
        Fri, 23 Oct 2020 07:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RhhXZCsS8EDeAssFbzhS/LTipD4q3Y5rjG8KRur/p3s=;
        b=kmrI1Cwvczxa04bOmSc3GOM5c+o4oNCD/r1WP2Ybiz7blQdI2glZZ48liw++oBBXf+
         0DWt2mfjdOfJXmdmbXKqShjxJ/URQiYT9AqM6HNcKa7DNIx3VJS4u7zlioh0HWFt+OGC
         aGZfYakfiChMKtDejsek5M+8aNETrLle79dsrpfUN9eragIV5ZlvkAd3tMtvULbkLeNr
         LRYoLkF1y6Ah7ra9YPHAq9iugFrjMRzEGMrXWw93v3JcaluRoaYmfK34hKdQEGLbv1W8
         XKOjGKCwMU0IEsYWB33JWl2rH++fTl2FEBqRmLrhzScN8IRP3wk+SoY8q8tBja11jRcv
         jtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RhhXZCsS8EDeAssFbzhS/LTipD4q3Y5rjG8KRur/p3s=;
        b=Qjh2EUPQo05ORJD+BG4H0VTVtHOXLbNfh4HTOD80TGy8GGMGKvwdAuVsr697Wdwr5e
         plOXlzO3qkWT1juu4ZknR79GECIEQVAKktGlVxZr9s/w8NjDmuj5h9mlvrhQFcPJNzkL
         W1ZT4878laOlKMyHw6t5kgllryp1p88sfOT2GxyAU+ec1dwqCEwznTuCgC4KsE+ZqsVJ
         De785M1L9/qrzGG+UN1drRYPa3o0EaJ5BDBVFMi+RbS8vkqHYm4juRdk98uhPp/Leu1Y
         BleSmKDIefhWBLkexXPWszCj7Vn6I9te4dznfhBf06koxwr+FktI1IcyT1JAjwfuPstp
         NWCw==
X-Gm-Message-State: AOAM533o+chHDOOokbfaS6Ct2DPinCe0M1DrL2VqF8teiMbDYbzBx5Lf
        K1UOMJVIkFYje85mmsIuZbM=
X-Google-Smtp-Source: ABdhPJx1PbVIxOYr6hlE428C4wBvhX2MaB2u7oQ82TjSlYKkhvWQMlbhrYKMekMJ1ZiwbNXZ4/e9EA==
X-Received: by 2002:a17:906:8610:: with SMTP id o16mr2063124ejx.209.1603462113735;
        Fri, 23 Oct 2020 07:08:33 -0700 (PDT)
Received: from xws.fritz.box (pd9e5acf3.dip0.t-ipconnect.de. [217.229.172.243])
        by smtp.gmail.com with ESMTPSA id oz18sm901921ejb.55.2020.10.23.07.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 07:08:32 -0700 (PDT)
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
Subject: [PATCH v4] platform/surface: Add Driver to set up lid GPEs on MS Surface device
Date:   Fri, 23 Oct 2020 16:08:02 +0200
Message-Id: <20201023140802.1916057-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
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

---
 MAINTAINERS                            |   6 +
 drivers/platform/surface/Kconfig       |  10 +
 drivers/platform/surface/Makefile      |   1 +
 drivers/platform/surface/surface_gpe.c | 309 +++++++++++++++++++++++++
 4 files changed, 326 insertions(+)
 create mode 100644 drivers/platform/surface/surface_gpe.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8ff126ced757..31271180dae3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11532,6 +11532,12 @@ F:	drivers/scsi/smartpqi/smartpqi*.[ch]
 F:	include/linux/cciss*.h
 F:	include/uapi/linux/cciss*.h
 
+MICROSOFT SURFACE GPE LID SUPPORT DRIVER
+M:	Maximilian Luz <luzmaximilian@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/surface_gpe.c
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
2.28.0

