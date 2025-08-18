Return-Path: <linux-acpi+bounces-15781-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D017B29809
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 06:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9BDB5E2324
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 04:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0957E261585;
	Mon, 18 Aug 2025 04:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="S9ErmpTX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D142269823
	for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 04:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490388; cv=none; b=QZH62tSrBm5qD2BgyKmHqP5Vhr/FA4Abr86d7qkuKFOzzga+fV3RGloEP/j6z9fmgnOVaaV4NMjl2T5vMJzQKb3vlW742xgtwkd6imnK2nReAFSJjkvyPRcWlNrhnUyEEmRb7xb1lNZaz6G9EL/XFe/X9PIkAn79bgKXMT6X/uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490388; c=relaxed/simple;
	bh=9HcW+TBvPJK2/+LEsOOqVgiuAIV/UKwGcXz7n5w/VEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbKV1PKOojaj0UhsR68mx94jyJ7yxMpz48bmTXy7EawzFSw4YKy/FTdu0fJPepVVNlRahcSqcXQkablaEHtb/aBo/8w/rw3w0n5nmOYosJjBSdwDtlvAg2O2w49W26f4eAYAhj7pGEKzuoTPpOkWLEO8OhTeHWKIUsaoMNSG+84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=S9ErmpTX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2445806c2ddso31494435ad.1
        for <linux-acpi@vger.kernel.org>; Sun, 17 Aug 2025 21:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490387; x=1756095187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5h5FwLL2itI1aaIPBkXXTJzNb4MmDc/qgyBrNo+u9DI=;
        b=S9ErmpTX2mlsGU9kRNPX83oUmghCYUOxaA7iRCqSTuH2zSPBRQpu7WkwD3R68xw4P2
         hpjsx+rHfEvl1cbx5WcmeiGw8Jn3VoTnS3p/89F7JQqI/aKRWtMatQBxxIIDbnpKoko7
         GjJPsvMl+Xe5xmxCHgJK8PYIkJM15qs8Bq6PgNyiIaesmqVyBrHf8XVWNQR0xTh9ceBm
         Zx5ti6zV2UYGiD5G/ha4CuHVpJivaRn2Ppj+zEwr0lvLFuZXt2PJZVog/pSIKjHvSi72
         2YCIn1EG4dqiYvnNebQlxJYhvLefIJOj5cbdOTYok/8xp54BxGsvy4EJQtOgqHf1nsQM
         VzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490387; x=1756095187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5h5FwLL2itI1aaIPBkXXTJzNb4MmDc/qgyBrNo+u9DI=;
        b=c7u1XdKXAqPmb09KYRLhESu4g3Wc46CRRToMr5nMypeuGN2NDcsAjtL8x1K7Oz/YGG
         iEdqtOtnhuJXKM15Y1VKu5XLRHlnkFIUj9DfJosRpZ+4i6xrABrkYHLrFMNRs2JxoGTd
         +ttC5GdrO6kN/zD9IpS2g5fkG+yEmgNkoc5kSXjM1qjAw0H53Sf40UuyhAiOELg3Eku4
         8unptcPmwhoRubDjOUdA3RoN/3rn8NpFQFKYKodFD8M2sePolLJJ22m0c0jy5zMD+byK
         NYdDsCJaaf2YqrihNRaEjhp1aFl3gHhPTbsiv3rkNl4tA5uPFKmX60Nrfcdf4Zbw6giz
         SR5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHSnb/4bXwWO1CRdJaHPVyb2lLjsozozXWnTQRiger+7Lh02q557oJswRPQwup2EUCqXVadXJ/LswM@vger.kernel.org
X-Gm-Message-State: AOJu0YyrfTMVNYoURLCvn8nlpWvSteO1keA+L47aDpnk88RwGCrIzLoZ
	yXRIFHhElihJ6POEw886Ct8xYYrmy02d7Pch7p91midg7Gs+1MNKOlFQEpUCSpEKdDM=
X-Gm-Gg: ASbGncuBVr+V+Mr43/WARZTD8vExCTMShCzNuKmtzLQkQbgSOUAYRdVK0/4Cc/wmCZX
	TfQZD1QU9XCBkQkSVyoJ5/Dx3S5gO9B6W6RRml/VJ7FvXEjW4OI21QNcg0olZOxxzKJH6QVqHpA
	T9GBm5PjqhXtxs5uAsv+HKpf+Wtfm7neOXVqFUI36KitIiGdhJiHUUfEuTZ38Wiik1LjZoMeH3V
	vKVeEcCm8nz3u1B53hrqRvkok7Hq2nIglWLcl95k4YFHhft48dw4MX6owpcwgkWL7T0c31ANsU1
	Sc2m6XE1BHuE+CeVIWJvkhDT1Mcy6RzoYhVmGoP4iMXkvRmPM6ssMJJOdqiZV23EIDCFgJ/wPnr
	dGl6c16TOfMEklfcln/R92E7mR7biDbdaDT29srhBKBTn4YfLdCwk/B45sZVL9HX4
X-Google-Smtp-Source: AGHT+IGkH4BDAXF4edn8TwIvvipLqLI6fuRlMJ8wwuhqVGiG5/9vRp54UNterQDaAwLw9x2Gzg+I7w==
X-Received: by 2002:a17:902:d50d:b0:244:6860:2f10 with SMTP id d9443c01a7336-2446d6d2d44mr179006705ad.1.1755490386542;
        Sun, 17 Aug 2025 21:13:06 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:13:05 -0700 (PDT)
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
Subject: [PATCH v10 22/24] irqchip/riscv-rpmi-sysmsi: Add ACPI support
Date: Mon, 18 Aug 2025 09:39:18 +0530
Message-ID: <20250818040920.272664-23-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818040920.272664-1-apatel@ventanamicro.com>
References: <20250818040920.272664-1-apatel@ventanamicro.com>
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
index e047ba36df16..a61c6dc63c29 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -636,7 +636,7 @@ config RISCV_IMSIC
 
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


