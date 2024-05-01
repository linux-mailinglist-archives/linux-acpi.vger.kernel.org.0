Return-Path: <linux-acpi+bounces-5571-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E698B89DF
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 14:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDB79B23B8A
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 12:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F41F12FB2D;
	Wed,  1 May 2024 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Mx6D60oz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F245612FB07
	for <linux-acpi@vger.kernel.org>; Wed,  1 May 2024 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566002; cv=none; b=QUns43cU8tZN8vNpgZSfTjWQujrTDPndp2A4cOUORRKBUvpkIHfz5GWMv4eG+ZRi32AyB8DCXpwQVHDxAbeWe5Rz739jLK6WzWZEe97067U1ltOImGIwIfCWke0dV8hOTPyNWTJ2QqTderYPIn+e9tV11SoF6b98V1Fz8Znlu2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566002; c=relaxed/simple;
	bh=Ctl8fjOGCMekGTE69fIp5aXSPpH0EKsLQAWGYrwV+bE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IPNFfUbfQXyoasTIh8LFEk5Ac3zgBL/f5/dTMTA6Jqo2uXuYiWip7Yaiv358BIWmHKbz4BCnW0Bht/Od0OujeMSHiJ4z7kP+Ai5OXafRnfOpjXz7BYVUNWcrAPrTN+fnNuV92nCSOwNYCJZT40HI3cyDY6JYkE5/47OK1JoLHoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Mx6D60oz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e9ffd3f96eso54547365ad.3
        for <linux-acpi@vger.kernel.org>; Wed, 01 May 2024 05:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714566000; x=1715170800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKprQ9DjgmWeNOp2jgUX6DT/fQdt5/GgPVbDil8wt68=;
        b=Mx6D60ozBCEMv0lOoFeLktbUdwnBFtOgnA2ygphrCXXQljGtOKEvFaFUOuCcjbTjHJ
         iowu6qury78Y6uvqUVojiWdoiF+2Vv7xjB4DPk83V1Qjp7tHiYdNvKzJuecj4SdWuAxu
         PKR7ggUt6QjuHNUtn21T4jFCkQbDPlwKiEkOUpYs5M7TzcDCdxoqSalf/Ue/MwMeqZ1/
         pDB6jRMYKJ4a3H61HR7tvRSNh2rMAbN5mVnDk3euksBv6WiRAOJq50rUqYTRXAd+Nw4a
         RUsS2THk/jsAjZQ9U5QvQ5XUQMQgtLX/LFOdW2NYaWoCXBIfg18aHE89q1/OHRfKVVuf
         pEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714566000; x=1715170800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKprQ9DjgmWeNOp2jgUX6DT/fQdt5/GgPVbDil8wt68=;
        b=mOz00OQpsx5Q2G38M27pNmn/NxkGJnh3mvh10Eicqb6vyUGRbfgFN1jf6/CBVi01gr
         MwaTioSizaYw6Q/GHD0TMc7im+F6VY/cC2RzjEFiFoYeB+m6kQFAKtgoWgdAFeGojaXv
         ++LOSwmjVAFvlj/vRKmCGe+Cq/16rB1WdJk2GAebDF8MSpTrPApddNe6AuxcoT3fZ1Hb
         llcEUcJOXybIgxJV8aijKPkSXlV4Dr+V8NsJjciEU5CpsXWHOHu/WLo72EkXDe+bJNcw
         OVJ5ucddIuX2crgJWc9UFMKJ81g2yW4NXCOotkTyCnP5ERF6nNk0ADcjKbtryoaY+Ort
         SiXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1Eetk0CRh45m6m2z4ZthOvEgeRYCMCjTHB0hcvsRCICa9xq+4t9U+O3IVy1Z4suI9BjJ4bKUBx5VhQ6m8fplG8aM+qLGccbAvnw==
X-Gm-Message-State: AOJu0Yzht9m9ZED91oDBFBmytTGjBry460xUpgCeV3ctH2SDkiK7YR2b
	xRyDXBl5Y19lU8pfTkGQC03pls4PQpAc8CohVXmp45CrCSaVR2WKOryLgOHtbwA=
X-Google-Smtp-Source: AGHT+IHXX5ILEyglT/Py3DGUVj43d4poupz49yi1BZblVtQazhBuHxJlZGQemov9OMPe6qk3xCXV3Q==
X-Received: by 2002:a17:902:e841:b0:1eb:156f:8d01 with SMTP id t1-20020a170902e84100b001eb156f8d01mr2061754plg.40.1714566000196;
        Wed, 01 May 2024 05:20:00 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.106])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001ec8888b22esm1336900plb.65.2024.05.01.05.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:19:59 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v5 15/17] irqchip/riscv-aplic: Add ACPI support
Date: Wed,  1 May 2024 17:47:40 +0530
Message-Id: <20240501121742.1215792-16-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ACPI support in APLIC drivers. Use the mapping created early during
boot to get the details about the APLIC.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-aplic-direct.c | 20 ++++---
 drivers/irqchip/irq-riscv-aplic-main.c   | 70 ++++++++++++++++--------
 drivers/irqchip/irq-riscv-aplic-main.h   |  1 +
 drivers/irqchip/irq-riscv-aplic-msi.c    |  9 ++-
 4 files changed, 67 insertions(+), 33 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-riscv-aplic-direct.c
index 4a3ffe856d6c..e24c2d3c78f6 100644
--- a/drivers/irqchip/irq-riscv-aplic-direct.c
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2022 Ventana Micro Systems Inc.
  */
 
+#include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/cpu.h>
@@ -189,17 +190,20 @@ static int aplic_direct_starting_cpu(unsigned int cpu)
 }
 
 static int aplic_direct_parse_parent_hwirq(struct device *dev, u32 index,
-					   u32 *parent_hwirq, unsigned long *parent_hartid)
+					   u32 *parent_hwirq, unsigned long *parent_hartid,
+					   struct aplic_priv *priv)
 {
 	struct of_phandle_args parent;
 	int rc;
 
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
-	if (!is_of_node(dev->fwnode))
-		return -EINVAL;
+	if (!is_of_node(dev->fwnode)) {
+		rc = acpi_get_ext_intc_parent_hartid(priv->id, index, parent_hartid);
+		if (rc)
+			return rc;
+
+		*parent_hwirq = RV_IRQ_EXT;
+		return 0;
+	}
 
 	rc = of_irq_parse_one(to_of_node(dev->fwnode), index, &parent);
 	if (rc)
@@ -237,7 +241,7 @@ int aplic_direct_setup(struct device *dev, void __iomem *regs)
 	/* Setup per-CPU IDC and target CPU mask */
 	current_cpu = get_cpu();
 	for (i = 0; i < priv->nr_idcs; i++) {
-		rc = aplic_direct_parse_parent_hwirq(dev, i, &hwirq, &hartid);
+		rc = aplic_direct_parse_parent_hwirq(dev, i, &hwirq, &hartid, priv);
 		if (rc) {
 			dev_warn(dev, "parent irq for IDC%d not found\n", i);
 			continue;
diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
index 774a0c97fdab..c1fd328ddf7d 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -4,8 +4,10 @@
  * Copyright (C) 2022 Ventana Micro Systems Inc.
  */
 
+#include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/irqchip/riscv-aplic.h>
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -125,39 +127,50 @@ static void aplic_init_hw_irqs(struct aplic_priv *priv)
 	writel(0, priv->regs + APLIC_DOMAINCFG);
 }
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id aplic_acpi_match[] = {
+	{ "RSCV0002", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, aplic_acpi_match);
+
+#endif
+
 int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void __iomem *regs)
 {
 	struct of_phandle_args parent;
 	int rc;
 
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
-	if (!is_of_node(dev->fwnode))
-		return -EINVAL;
-
 	/* Save device pointer and register base */
 	priv->dev = dev;
 	priv->regs = regs;
 
-	/* Find out number of interrupt sources */
-	rc = of_property_read_u32(to_of_node(dev->fwnode), "riscv,num-sources",
-				  &priv->nr_irqs);
-	if (rc) {
-		dev_err(dev, "failed to get number of interrupt sources\n");
-		return rc;
-	}
-
-	/*
-	 * Find out number of IDCs based on parent interrupts
-	 *
-	 * If "msi-parent" property is present then we ignore the
-	 * APLIC IDCs which forces the APLIC driver to use MSI mode.
-	 */
-	if (!of_property_present(to_of_node(dev->fwnode), "msi-parent")) {
-		while (!of_irq_parse_one(to_of_node(dev->fwnode), priv->nr_idcs, &parent))
-			priv->nr_idcs++;
+	if (is_of_node(dev->fwnode)) {
+		/* Find out number of interrupt sources */
+		rc = of_property_read_u32(to_of_node(dev->fwnode), "riscv,num-sources",
+					  &priv->nr_irqs);
+		if (rc) {
+			dev_err(dev, "failed to get number of interrupt sources\n");
+			return rc;
+		}
+
+		/*
+		 * Find out number of IDCs based on parent interrupts
+		 *
+		 * If "msi-parent" property is present then we ignore the
+		 * APLIC IDCs which forces the APLIC driver to use MSI mode.
+		 */
+		if (!of_property_present(to_of_node(dev->fwnode), "msi-parent")) {
+			while (!of_irq_parse_one(to_of_node(dev->fwnode), priv->nr_idcs, &parent))
+				priv->nr_idcs++;
+		}
+	} else {
+		rc = riscv_acpi_get_gsi_info(dev->fwnode, &priv->gsi_base, &priv->id,
+					     &priv->nr_irqs, &priv->nr_idcs);
+		if (rc) {
+			dev_err(dev, "failed to find GSI mapping\n");
+			return rc;
+		}
 	}
 
 	/* Setup initial state APLIC interrupts */
@@ -186,6 +199,9 @@ static int aplic_probe(struct platform_device *pdev)
 	 */
 	if (is_of_node(dev->fwnode))
 		msi_mode = of_property_present(to_of_node(dev->fwnode), "msi-parent");
+	else
+		msi_mode = imsic_acpi_get_fwnode(NULL) ? 1 : 0;
+
 	if (msi_mode)
 		rc = aplic_msi_setup(dev, regs);
 	else
@@ -193,6 +209,11 @@ static int aplic_probe(struct platform_device *pdev)
 	if (rc)
 		dev_err(dev, "failed to setup APLIC in %s mode\n", msi_mode ? "MSI" : "direct");
 
+#ifdef CONFIG_ACPI
+	if (!acpi_disabled)
+		acpi_dev_clear_dependencies(ACPI_COMPANION(dev));
+#endif
+
 	return rc;
 }
 
@@ -205,6 +226,7 @@ static struct platform_driver aplic_driver = {
 	.driver = {
 		.name		= "riscv-aplic",
 		.of_match_table	= aplic_match,
+		.acpi_match_table = ACPI_PTR(aplic_acpi_match),
 	},
 	.probe = aplic_probe,
 };
diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip/irq-riscv-aplic-main.h
index 4393927d8c80..9fbf45c7b4f7 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.h
+++ b/drivers/irqchip/irq-riscv-aplic-main.h
@@ -28,6 +28,7 @@ struct aplic_priv {
 	u32			gsi_base;
 	u32			nr_irqs;
 	u32			nr_idcs;
+	u32			id;
 	void __iomem		*regs;
 	struct aplic_msicfg	msicfg;
 };
diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
index 028444af48bd..f5020241e0ed 100644
--- a/drivers/irqchip/irq-riscv-aplic-msi.c
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -157,6 +157,7 @@ static const struct msi_domain_template aplic_msi_template = {
 int aplic_msi_setup(struct device *dev, void __iomem *regs)
 {
 	const struct imsic_global_config *imsic_global;
+	struct irq_domain *msi_domain;
 	struct aplic_priv *priv;
 	struct aplic_msicfg *mc;
 	phys_addr_t pa;
@@ -239,8 +240,14 @@ int aplic_msi_setup(struct device *dev, void __iomem *regs)
 		 * IMSIC and the IMSIC MSI domains are created later through
 		 * the platform driver probing so we set it explicitly here.
 		 */
-		if (is_of_node(dev->fwnode))
+		if (is_of_node(dev->fwnode)) {
 			of_msi_configure(dev, to_of_node(dev->fwnode));
+		} else {
+			msi_domain = irq_find_matching_fwnode(imsic_acpi_get_fwnode(dev),
+							      DOMAIN_BUS_PLATFORM_MSI);
+			if (msi_domain)
+				dev_set_msi_domain(dev, msi_domain);
+		}
 	}
 
 	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, &aplic_msi_template,
-- 
2.40.1


