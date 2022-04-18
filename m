Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19BE505DA5
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Apr 2022 19:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347219AbiDRRrn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Apr 2022 13:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347213AbiDRRrm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Apr 2022 13:47:42 -0400
Received: from mellanox.co.il (mail-il-dmz.mellanox.com [193.47.165.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5EB265CC
        for <linux-acpi@vger.kernel.org>; Mon, 18 Apr 2022 10:45:00 -0700 (PDT)
Received: from Internal Mail-Server by MTLPINE1 (envelope-from asmaa@mellanox.com)
        with SMTP; 18 Apr 2022 20:44:59 +0300
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id 23IHirUX030638;
        Mon, 18 Apr 2022 13:44:55 -0400
Received: (from asmaa@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id 23IHir2J004378;
        Mon, 18 Apr 2022 13:44:53 -0400
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>, linus.walleij@linaro.org
Subject: [PATCH v1 1/1] Support power control driver for BlueField SoCs.
Date:   Mon, 18 Apr 2022 13:44:50 -0400
Message-Id: <20220418174450.4304-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch supports handling 2 BlueField power states controlled by GPIO interrupts:
1) chip reset and
2) low power mode

This driver is dependent and should be loaded after the gpio-mlxbf2.c driver,
which is the gpio and interrupt controller.

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/power/reset/Kconfig     |   6 ++
 drivers/power/reset/Makefile    |   1 +
 drivers/power/reset/pwr-mlxbf.c | 100 ++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)
 create mode 100644 drivers/power/reset/pwr-mlxbf.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 4b563db3ab3e..a8c46ba5878f 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -297,4 +297,10 @@ config NVMEM_REBOOT_MODE
 	  then the bootloader can read it and take different
 	  action according to the mode.
 
+config POWER_MLXBF
+	tristate "Mellanox BlueField power handling driver"
+	depends on (GPIO_MLXBF2 && ACPI)
+	help
+	  This driver supports reset or low power mode handling for Mellanox BlueField.
+
 endif
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index f606a2f60539..0a39424fc558 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -35,3 +35,4 @@ obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
 obj-$(CONFIG_NVMEM_REBOOT_MODE) += nvmem-reboot-mode.o
+obj-$(CONFIG_POWER_MLXBF) += pwr-mlxbf.o
diff --git a/drivers/power/reset/pwr-mlxbf.c b/drivers/power/reset/pwr-mlxbf.c
new file mode 100644
index 000000000000..30b3ba13be75
--- /dev/null
+++ b/drivers/power/reset/pwr-mlxbf.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-only or BSD-3-Clause
+
+/*
+ *  Copyright (c) 2022 NVIDIA CORPORATION & AFFILIATES.
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/reboot.h>
+#include <linux/types.h>
+
+const char *rst_pwr_hid = "MLNXBF24";
+const char *low_pwr_hid = "MLNXBF29";
+
+struct pwr_mlxbf {
+	struct work_struct send_work;
+	const char *hid;
+};
+
+static void pwr_mlxbf_send_work(struct work_struct *work)
+{
+	acpi_bus_generate_netlink_event("button/power.*", "Power Button", 0x80, 1);
+}
+
+static irqreturn_t pwr_mlxbf_irq(int irq, void *ptr)
+{
+	struct pwr_mlxbf *priv = ptr;
+
+	if (!strncmp(priv->hid, rst_pwr_hid, 8))
+		emergency_restart();
+
+	if (!strncmp(priv->hid, low_pwr_hid, 8))
+		schedule_work(&priv->send_work);
+
+	return IRQ_HANDLED;
+}
+
+static int
+pwr_mlxbf_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct acpi_device *adev;
+	struct pwr_mlxbf *priv;
+	const char *hid;
+	int irq, err;
+
+	priv = devm_kzalloc(dev, sizeof(struct pwr_mlxbf), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return -ENXIO;
+
+	hid = acpi_device_hid(adev);
+	priv->hid = hid;
+
+	irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(&pdev->dev), 0);
+	if (irq == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else if (irq < 0) {
+		dev_err(&pdev->dev, "Error getting %s irq.\n", priv->hid);
+		return -ENXIO;
+	}
+
+	INIT_WORK(&priv->send_work, pwr_mlxbf_send_work);
+
+	err = devm_request_irq(&pdev->dev, irq, pwr_mlxbf_irq, 0, hid, priv);
+	if (err)
+		dev_err(&pdev->dev, "Failed request of %s irq\n", priv->hid);
+
+	return err;
+}
+
+static const struct acpi_device_id __maybe_unused pwr_mlxbf_acpi_match[] = {
+	{ "MLNXBF24", 0 },
+	{ "MLNXBF29", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, pwr_mlxbf_acpi_match);
+
+static struct platform_driver pwr_mlxbf_driver = {
+	.driver = {
+		.name = "pwr_mlxbf",
+		.acpi_match_table = pwr_mlxbf_acpi_match,
+	},
+	.probe    = pwr_mlxbf_probe,
+};
+
+module_platform_driver(pwr_mlxbf_driver);
+
+MODULE_DESCRIPTION("Mellanox BlueField power driver");
+MODULE_AUTHOR("Asmaa Mnebhi <asmaa@nvidia.com>");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.30.1

