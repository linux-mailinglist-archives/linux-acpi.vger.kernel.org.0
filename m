Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AAC54B311
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jun 2022 16:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244133AbiFNO0G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Jun 2022 10:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiFNO0F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Jun 2022 10:26:05 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Jun 2022 07:26:01 PDT
Received: from mellanox.co.il (mail-il-dmz.mellanox.com [193.47.165.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E98FF2CE27
        for <linux-acpi@vger.kernel.org>; Tue, 14 Jun 2022 07:26:01 -0700 (PDT)
Received: from Internal Mail-Server by MTLPINE1 (envelope-from asmaa@mellanox.com)
        with SMTP; 14 Jun 2022 17:19:17 +0300
Received: from bu-vnc02.mtbu.labs.mlnx (bu-vnc02.mtbu.labs.mlnx [10.15.2.65])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id 25EEJGBF006076;
        Tue, 14 Jun 2022 10:19:16 -0400
Received: (from asmaa@localhost)
        by bu-vnc02.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id 25EEJGFL006223;
        Tue, 14 Jun 2022 10:19:16 -0400
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     sebastian.reichel@collabora.com, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v2 1/1] Support power control driver for BlueField SoCs.
Date:   Tue, 14 Jun 2022 10:19:11 -0400
Message-Id: <20220614141911.6169-1-asmaa@nvidia.com>
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

Changes made since v1 patch:
- use dev_err_probe
- use devm_work_autocancel
- fix sizeof() in devm_kzalloc

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/power/reset/Kconfig     |  6 ++
 drivers/power/reset/Makefile    |  1 +
 drivers/power/reset/pwr-mlxbf.c | 97 +++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)
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
index 000000000000..c1f9987834a2
--- /dev/null
+++ b/drivers/power/reset/pwr-mlxbf.c
@@ -0,0 +1,97 @@
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
+static int pwr_mlxbf_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct acpi_device *adev;
+	struct pwr_mlxbf *priv;
+	const char *hid;
+	int irq, err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
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
+	irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "Error getting %s irq.\n", priv->hid);
+
+	err = devm_work_autocancel(dev, &priv->send_work, pwr_mlxbf_send_work);
+	if (err)
+		return err;
+
+	err = devm_request_irq(dev, irq, pwr_mlxbf_irq, 0, hid, priv);
+	if (err)
+		dev_err(dev, "Failed request of %s irq\n", priv->hid);
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

