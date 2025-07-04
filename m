Return-Path: <linux-acpi+bounces-15012-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB7DAF88E0
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 09:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6401C20ED6
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 07:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED79281358;
	Fri,  4 Jul 2025 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NO5Xdtoh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513EB27A909
	for <linux-acpi@vger.kernel.org>; Fri,  4 Jul 2025 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751612911; cv=none; b=LCqUQ82b7zL5n96OSocNkiQtinqjzWrRVkxk1GRfjPNTQYViZIqd9GtHjo1/lAUzZdQ1H0aude9vQ7ITqzPnuPkFb8jO9RhxEpDqv1n356RjJgAL0uYe6rJMDuZNtJ6eT3/nViShLl/NKKOBH/xdxOFIUiEXlSAqL5OuV4mLSWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751612911; c=relaxed/simple;
	bh=I7RqpMJ6v65DpI87Sc8YLWiEzPruC7pN8mdwYUe+nhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blWyGqoJRMRaluL7ozHn6SNNGzU6PUROHh6n8Wo3/BqcEBYpQK46ptnMGgdxckkie6hwfa1oYSu86F3FndrNsS89wXh0NLlLpnwbTgCQQH1Dp+q/2fBtIHwyIFKwItPUspKDGSScFmIIhwHCP3862HWdba+RjkVi5BKaKlEHrAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=NO5Xdtoh; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-313cde344d4so715162a91.0
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jul 2025 00:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751612908; x=1752217708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXIk2wJTifWddC0moyVA6HWex2pYqM3d1BK6ny8Nz5A=;
        b=NO5XdtohaSn5UK8Uwwdsqr8/yHnwTeTDqgGdPPPTqQAN+uwQBggrAehI4BkCOoZ3Sj
         tO/I0qcQsZUIlrGTjLCKObofscZbtAchvqlVMTfKBU3i0h3d+Yl6zn8alrz7N+QZ7ebx
         s/CcFHuwfWsDRmVOUfxRnpl8qBmmj3N8h0rmU5dpFQvoXeOIsCT/KOV2waXWxqEgX0rB
         WleZl7YK9Xi6M3aQGx9gmcfQlEF7PQsq2KwImxnIAMLD2XSeiDDcSbdV+7qn9ARvvI+6
         PXutqeWLu3tHUsEwXJCZdaZnJP3RlL7I6m1A2nX09D+3adPVKaLhYHS2OImdp+b/52Ym
         KyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751612908; x=1752217708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXIk2wJTifWddC0moyVA6HWex2pYqM3d1BK6ny8Nz5A=;
        b=IVXguIZ/Gul+N/FywuNKUS2bmgdVaKrW7/AdHjXEgkTSrI6MlfLbccuVO4Vm3kEu/6
         71ddZYhAekqnDzwBkQGRbttqR7uNQQKx3r5j/ztGw3J/Q5fpjMrege+ls/nTFF0SSyoK
         ztSIos1sZLlmFvbMSF3iglSL/2uOKNMQke2v2eQNq3jL5KT10NLF3lKBfsw3ksURpyoD
         rC+ab8bSWg36fr0rmQp/DAuVGCuRmljmIrDiEMxSL516HRXp1pCjFT6h+wzooWDzYTWh
         lB04z+24EbmCpTSSFbZl60mpmjXTRknCAYn8mxqbAlps41f0pgsy7pAkElH6HT7cbNBR
         cwdA==
X-Forwarded-Encrypted: i=1; AJvYcCVzALlym4JLXxm3m1aQqc1cL/pY6/TXX0SO1L+49zMXTG26eC8aoqRZa15pr7OZwdOLRZqEyfrcxuyu@vger.kernel.org
X-Gm-Message-State: AOJu0YzD4NWvkXWLtBpcXgIB/03li2nadeCBqGftTMXhegJWH76MQDfh
	G6EeXwW4YoGMjdLJvdWgU9NldnnPJnPnQS6j/doeeCuJF4KuLOKWDEanivqtm/tJObM=
X-Gm-Gg: ASbGncuhGZh4jGucelXAHmJvvRGWeWu2VR2YI1t3nSqFFSfsKWVLwsE3rCvob2IIWkH
	+d/x7sOsF2SOjNpxlRIyNBwI/sSt2VPZr2ECcaqySBKhdm+8GU4TXJ5M8kYUS0ex1AAYPlz88Pz
	32LUv6VMBNIqVw+bmBtQtLGd9SEO4uLIqPbe+lxTEVA5uG4mUlKXKua4oF0FsgSBVvrUTNVehk3
	OL3noMG+2Rg04PkZ4t/rLqHU4wsFt6NgXKwi5JJKN4/ebB2NM6DuXzY4cSyQb6bCb0dNcDKn1Vn
	UprztajQhh2AYEG3WhUS+zZU9PA9Wk+cMK+8sCDW4fMjiA3BadjUNvlY89GI/rIoSJMYh8PRH+R
	LdmqVYy+SoESS7OqRqtVZe3wyaw==
X-Google-Smtp-Source: AGHT+IF05WFmbdowgMKPPyXXWCNrZhPQrflWbhpnzrcFI6weJVBBWzHArAW3aGdBc+YuLB+9c8B5Bg==
X-Received: by 2002:a17:90a:dfcc:b0:311:a314:c2ca with SMTP id 98e67ed59e1d1-31aadce5676mr1522577a91.6.1751612908338;
        Fri, 04 Jul 2025 00:08:28 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaae59a93sm1358697a91.12.2025.07.04.00.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 00:08:27 -0700 (PDT)
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
Subject: [PATCH v8 22/24] irqchip/riscv-rpmi-sysmsi: Add ACPI support
Date: Fri,  4 Jul 2025 12:33:54 +0530
Message-ID: <20250704070356.1683992-23-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704070356.1683992-1-apatel@ventanamicro.com>
References: <20250704070356.1683992-1-apatel@ventanamicro.com>
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
index 96bf6aa55681..dfa8cc0e23dd 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -619,7 +619,7 @@ config RISCV_IMSIC
 
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


