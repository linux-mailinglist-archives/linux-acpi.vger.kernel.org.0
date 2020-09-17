Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D043D26E056
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Sep 2020 18:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgIQQJy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Sep 2020 12:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgIQP7p (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Sep 2020 11:59:45 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63156C061356;
        Thu, 17 Sep 2020 08:58:31 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id lo4so3984961ejb.8;
        Thu, 17 Sep 2020 08:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i2jqX17dPrs1jPVKkRQ5LwVOkLkQAiLqBxm34cBLTpI=;
        b=sbtP6Oh4F6VeLBfgwW0NjLOYNV1C5ipeI3dGQUCYnzwajAnnoiSFRsbpmT9pXZf92h
         /WJhLIliid0Tlz1Vev3NXi5e6OmBdstPv6vdMCYE5g0667K4QH+7PXtPrFpLzFzlLhyj
         IX5HVnsEC+eaqCOtR2dqVwJqgITbQw6iw7/dznAeOyT6cTjyp/oA/eS+o+wQ9oxZxqpC
         o76/siuUn1wVo+lpDekRu5K/7eXurW20wEbpHb9UZS/pcZHETtAVNoBEp66mTAmJFNLq
         OWoX/6fisnbdGG6WA7CwYBx56cYAfSmD0/sbhWRyKye6g2OqvfwOhDxUqnT2GEZ9jGm3
         nP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i2jqX17dPrs1jPVKkRQ5LwVOkLkQAiLqBxm34cBLTpI=;
        b=ErwrnMguQO4HJpvo08xNayYeDgm2QagRLsw9yqT2YVuvV+BnFmQto1GJYQA6Hb7iFr
         lxOv5/Ju/yEw0lW8GKgL+zHjNBC8Uirp7RU0tSH43y5hv8mWatjgFPwiTnAqKQYnC3Ke
         kMhzDcIVq0iBbRgSTQ1mqqbXumrBhNMqSf45w1Eta0QJO4YMfLe4ANf2EI6WmWAzFkOn
         RwWwjCGm61VibJj+l3Y13VEYe1KmvHeqlEoSW/1LYVuzA1q0kVINmAjPB7wdq0jy2I7M
         KnjFRWO6HuwcJOBZi0G0lrl13WDgph2XucS5S7FZCyyDK0FWOtNRUX0d/Ne5a3wItLVL
         xycQ==
X-Gm-Message-State: AOAM531/h7qVDUiUxK8+mcbn6idXI5nT0W6Pwp+z9Ag0kMfDoZbDDFCq
        CnN/P2x4b+XPWAC+FPVDhKE=
X-Google-Smtp-Source: ABdhPJweU/FW35CotruHoztp48fkkThY/D3buxiulPB2jymtq55w0ihqLf2hE8OK9V7RO7Hzr9vT8Q==
X-Received: by 2002:a17:906:4c89:: with SMTP id q9mr32771149eju.290.1600358309635;
        Thu, 17 Sep 2020 08:58:29 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a4c4.dip0.t-ipconnect.de. [217.229.164.196])
        by smtp.gmail.com with ESMTPSA id jo2sm192572ejb.101.2020.09.17.08.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 08:58:28 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH v3] platform/x86: Add Driver to set up lid GPEs on MS Surface devices
Date:   Thu, 17 Sep 2020 17:55:59 +0200
Message-Id: <20200917155559.1686146-1-luzmaximilian@gmail.com>
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

---
 MAINTAINERS                        |   6 +
 drivers/platform/x86/Kconfig       |  10 +
 drivers/platform/x86/Makefile      |   1 +
 drivers/platform/x86/surface_gpe.c | 307 +++++++++++++++++++++++++++++
 4 files changed, 324 insertions(+)
 create mode 100644 drivers/platform/x86/surface_gpe.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d0862b19ce5..b082cc24268e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11557,6 +11557,12 @@ F:	drivers/scsi/smartpqi/smartpqi*.[ch]
 F:	include/linux/cciss*.h
 F:	include/uapi/linux/cciss*.h
 
+MICROSOFT SURFACE GPE LID SUPPORT DRIVER
+M:	Maximilian Luz <luzmaximilian@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/surface_gpe.c
+
 MICROSOFT SURFACE PRO 3 BUTTON DRIVER
 M:	Chen Yu <yu.c.chen@intel.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 40219bba6801..cd29ab65f8b1 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -894,6 +894,16 @@ config SURFACE_3_POWER_OPREGION
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
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 5f823f7eff45..58c2a6f52e39 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
 obj-$(CONFIG_SURFACE3_WMI)		+= surface3-wmi.o
 obj-$(CONFIG_SURFACE_3_BUTTON)		+= surface3_button.o
 obj-$(CONFIG_SURFACE_3_POWER_OPREGION)	+= surface3_power.o
+obj-$(CONFIG_SURFACE_GPE)		+= surface_gpe.o
 obj-$(CONFIG_SURFACE_PRO3_BUTTON)	+= surfacepro3_button.o
 
 # MSI
diff --git a/drivers/platform/x86/surface_gpe.c b/drivers/platform/x86/surface_gpe.c
new file mode 100644
index 000000000000..2857e3862ca4
--- /dev/null
+++ b/drivers/platform/x86/surface_gpe.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Surface GPE/Lid driver to enable wakeup from suspend via the lid by
+ * properly configuring the respective GPEs. Required for wakeup via lid on
+ * newer Intel-based Microsoft Surface devices.
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
+			 * We match for SKU here due to different vairants: The
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

