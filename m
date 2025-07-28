Return-Path: <linux-acpi+bounces-15385-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D31F1B13848
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 11:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6183BC7B0
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 09:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF3326B0AE;
	Mon, 28 Jul 2025 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YdiXo6J7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2EC253F13
	for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2025 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695875; cv=none; b=MAvHDivek4NJzlO/nCfnE7NbJUA9DQs1XiscV+gv7yWAmrWwRK2vvzy7pzbqBJug1BoKeed7hyHBrJKKnlCzdYKjM6NmIba9XRxlhWSb9VHSghSrYJ5wKyIYkrUl1oIggbd6NUdZNN6LQfqEQSdnGPEBO1/1yuiPaFZ2pTKXFdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695875; c=relaxed/simple;
	bh=FX/B5nGrbSl3HmerIxToYr+lslD0mN8D8gnQDTQi4h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2XS7XSVXv8x66t47DtI9dd5wRs2/eawbNwy25SNX/j6OjlE0CIeMP1OwKS/dklwSqB40aFWVz08x3r0B4zmv8VJFgT0pqx8a17/Fw6+h3crdwSP8WYgpL8vY0/ywDxnOxpknAOEZ3+SyePT6MzQrNu5vuv70dzQN3Y3QoR6Jhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YdiXo6J7; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso3645996a12.3
        for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2025 02:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753695873; x=1754300673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlYXC9F0O8zbv2hE1LP7h6LlplF1lF+tvzzZDmIs1fc=;
        b=YdiXo6J7s1cx4vdf3I8PluAt3l/hrCbaMla7K39qKJmUAJ0B3L/wioZA7soIgPtp+B
         E1XxwGKmJD9sBVJQjROxFFX3TMAtlFmapR1HE3NbxMVJ/uHNvN0+RWdvnAk+kJ9qdN1o
         ZjQhPD8mfo/H31vBRUcDVYIT56a5T0M+irEY0BdtXtmgcAB2rpSTf536EHbo9q7XaBa/
         JhEWJsRZp/QpgXgMhouQ/UDg2gISebfkLuPOAIiEKhHqcRAxNkiYrUSWQ32LY/6CXrkf
         s7Lcmh6eEvvKpeCaazP63uPakm1PtTmOAaUMxjeJ/OXegIi90oHpv9W8j0GUKQgOzF4a
         6fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695873; x=1754300673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlYXC9F0O8zbv2hE1LP7h6LlplF1lF+tvzzZDmIs1fc=;
        b=FM1IZPdNIt4CpqBaCxJlprHhyVu0Fy2LhuhkHZV3BXBgTRmGYwvAGrjEON7ACFBl+9
         SBsgCvOq2JfBp9ht3rCvX5UI24K0SvDIkFu0wN5M8nb5+KI/1sME+O4mG3FPcuMA8HkK
         5Qw4K7IRv2FG4N1f7ejC1kFA2C8NpcJvtr5RPTpZ8cdIfRiLoz2/UCa1CfPCondFAYsi
         N60+HVg8IDIomg09v/ZTNwkxVk4k7045f4Ef9+e0aJkeRFm0aSxsqSTEULaGMHdzIVq1
         qmMeLu7YvE8NjRAwIEaHyNYzAVxrKfYKdRpP66F4WDpEWj66zI19nB0PxQsNXhWmGUwa
         a6iw==
X-Forwarded-Encrypted: i=1; AJvYcCWKWHHaMardFRylSvazcVoGwf+FLVZDUXqP3GoEN87D0puOk2MQu42f5Ou/Wh2cZaWtQzimZUjvJUSk@vger.kernel.org
X-Gm-Message-State: AOJu0YzXCkSm+Cc+Cr5rFtiNGC63IApIDKCBzoQRNtRWeaBzgMolKy2y
	ouqG3HHGHf9zigC9mpE24K5UX4ZHIYkTucTb/h3dxrr34RGgsZmn9vPspq5dPtiVlmw=
X-Gm-Gg: ASbGncsSels2Cp8ohooBO3GGjWqIBWdEvmPods8LOJuWrfiUfZVt32bmqAR5ZqFclgy
	fTqwNybw5eHE/WL4oKtDRi4RpId22c+LJyv2AzIQBzddIrlA2ESEEAra+WbiEum7ix+Dsi9/8Xu
	5aiwOVuCvYuhUzVGl7gknCtBcI2fSgLs4oT3cMESJ2rO8PRJDj3nuvat/yNnrW5ufXanXkuF0Bz
	g6J9/8Ms8hvQ/YYrMHkPt17dlZpmX14qqwfxOuCEF3wmI0jVsu/0nQytrEzC4OTzM4p9NgM1w/5
	zcs5d+jvEEe0dRx7KTg8u4svneu4rmcoqzJUiiINzgPSBi95/IdeYCOSIckPuF9gf2C7L+2N+/c
	Gs3Hwnk2+Q0sD1QerH6FuZRGN9ki+fzsLadds0EKeibkGUYE3kR60uLQEKGlEZlLXchyVyeI=
X-Google-Smtp-Source: AGHT+IGAwJvkdUw2Iit6cp8KQcw8fgP3DTpOBB5lX+b717WF4c4kBlnVYgF0+VaAcfTFETTz20JkcA==
X-Received: by 2002:a17:90b:3b4c:b0:315:b07a:ac12 with SMTP id 98e67ed59e1d1-31e77882e8emr16716236a91.14.1753695872826;
        Mon, 28 Jul 2025 02:44:32 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([122.171.19.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832fbf99sm5396230a91.1.2025.07.28.02.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:44:32 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v9 22/24] irqchip/riscv-rpmi-sysmsi: Add ACPI support
Date: Mon, 28 Jul 2025 15:10:30 +0530
Message-ID: <20250728094032.63545-23-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728094032.63545-1-apatel@ventanamicro.com>
References: <20250728094032.63545-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sunil V L <sunilvl@ventanamicro.com>

Add ACPI support for the RISC-V RPMI system MSI based irqchip driver.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/Kconfig                 |  2 +-
 drivers/irqchip/irq-riscv-rpmi-sysmsi.c | 47 +++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b10e36db2c63..25bac6a21a88 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -620,7 +620,7 @@ config RISCV_IMSIC
 
 config RISCV_RPMI_SYSMSI
 	bool
-	depends on MAILBOX
+	depends on RISCV && MAILBOX
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_MSI_IRQ
 	default RISCV
diff --git a/drivers/irqchip/irq-riscv-rpmi-sysmsi.c b/drivers/irqchip/irq-riscv-rpmi-sysmsi.c
index 92e8847dfccc..5c74c561ce31 100644
--- a/drivers/irqchip/irq-riscv-rpmi-sysmsi.c
+++ b/drivers/irqchip/irq-riscv-rpmi-sysmsi.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2025 Ventana Micro Systems Inc. */
 
+#include <linux/acpi.h>
 #include <linux/bits.h>
 #include <linux/bug.h>
 #include <linux/device.h>
@@ -9,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/mailbox_client.h>
 #include <linux/mailbox/riscv-rpmi-message.h>
 #include <linux/module.h>
@@ -209,6 +211,8 @@ static int rpmi_sysmsi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rpmi_sysmsi_priv *priv;
+	struct fwnode_handle *fwnode;
+	u32 id;
 	int rc;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -239,6 +243,22 @@ static int rpmi_sysmsi_probe(struct platform_device *pdev)
 	}
 	priv->nr_irqs = rc;
 
+	fwnode = dev_fwnode(dev);
+	if (is_acpi_node(fwnode)) {
+		u32 nr_irqs;
+
+		rc = riscv_acpi_get_gsi_info(fwnode, &priv->gsi_base, &id,
+					     &nr_irqs, NULL);
+		if (rc) {
+			dev_err(dev, "failed to find GSI mapping\n");
+			return rc;
+		}
+
+		/* Update with actual GSI range */
+		if (nr_irqs != priv->nr_irqs)
+			riscv_acpi_update_gsi_range(priv->gsi_base, priv->nr_irqs);
+	}
+
 	/*
 	 * The device MSI domain for platform devices on RISC-V architecture
 	 * is only available after the MSI controller driver is probed so,
@@ -252,8 +272,15 @@ static int rpmi_sysmsi_probe(struct platform_device *pdev)
 		 * then we need to set it explicitly before using any platform
 		 * MSI functions.
 		 */
-		if (dev_of_node(dev))
+		if (is_of_node(fwnode)) {
 			of_msi_configure(dev, dev_of_node(dev));
+		} else if (is_acpi_device_node(fwnode)) {
+			struct irq_domain *msi_domain;
+
+			msi_domain = irq_find_matching_fwnode(imsic_acpi_get_fwnode(dev),
+							      DOMAIN_BUS_PLATFORM_MSI);
+			dev_set_msi_domain(dev, msi_domain);
+		}
 
 		if (!dev_get_msi_domain(dev)) {
 			mbox_free_channel(priv->chan);
@@ -268,6 +295,13 @@ static int rpmi_sysmsi_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -ENOMEM, "failed to create MSI irq domain\n");
 	}
 
+#ifdef CONFIG_ACPI
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (adev)
+		acpi_dev_clear_dependencies(adev);
+#endif
+
 	dev_info(dev, "%u system MSIs registered\n", priv->nr_irqs);
 	return 0;
 }
@@ -277,10 +311,17 @@ static const struct of_device_id rpmi_sysmsi_match[] = {
 	{}
 };
 
+static const struct acpi_device_id acpi_rpmi_sysmsi_match[] = {
+	{ "RSCV0006" },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, acpi_rpmi_sysmsi_match);
+
 static struct platform_driver rpmi_sysmsi_driver = {
 	.driver = {
-		.name		= "rpmi-sysmsi",
-		.of_match_table	= rpmi_sysmsi_match,
+		.name			= "rpmi-sysmsi",
+		.of_match_table		= rpmi_sysmsi_match,
+		.acpi_match_table	= acpi_rpmi_sysmsi_match,
 	},
 	.probe = rpmi_sysmsi_probe,
 };
-- 
2.43.0


