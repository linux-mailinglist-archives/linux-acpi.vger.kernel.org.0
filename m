Return-Path: <linux-acpi+bounces-2553-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1B8818EA1
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 18:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A321B282F7A
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 17:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCF43D0CA;
	Tue, 19 Dec 2023 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ad6qfL8/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A69C3D0AD
	for <linux-acpi@vger.kernel.org>; Tue, 19 Dec 2023 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3b8184a84so12631775ad.1
        for <linux-acpi@vger.kernel.org>; Tue, 19 Dec 2023 09:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703007997; x=1703612797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4ypyUsQkr7EY8e5fntZynE18HeG+okjQYWqm+Ns7+I=;
        b=ad6qfL8/Y8kW/Qpz726slNUgU9a9s7dmIMadiSmywjM/ah91s04hZERJ96z75WvHQ+
         zUd0iFND5/1ssJLZ42ppAB5biDACpuTtJJIhsBYCUFG+y7d7yPqVCtQ4t61hJbKoUby3
         79mliIiPB6twUAGNmSZHwvifgaqAa4cBolTDQ/l+7anSllGerzX7dLxHYL+ZZxeJQrZC
         vpghRE7o5sJidv2gObePTHRaJ+p9LJU9JNIe3SOJ6v3NeZ2xc7o7BqgSMGJc1nl/Rd1I
         kvWW1M7dPdYQVJwenGlDJjgeSGMe2n2BYcq6EatoFFxQLXy/1kNvjlOWv6iwcOojVakt
         HNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007997; x=1703612797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4ypyUsQkr7EY8e5fntZynE18HeG+okjQYWqm+Ns7+I=;
        b=kciasPbnDOXeNt4e15V40NmvElYXGxvuazYQBKh5L0sGAMyBKefuEtFpiiRMcw8F7w
         Qm85jcQOQWg/2vQTem1LZAUdNgj+z/ttovb9mv7e5Iji5PKGkvfEcdE2NIAv8o+UPSR/
         6L7hLC48iZSolJ1tp8nBNKSPKXZuEsLAMaA+j9NQ+JCJZCw+/t1cV4ooPHbtWO1EecP6
         8JcK+QblGqfNryGaeal86IGGcHT30oahqbBqj1Uf8/WFiVD7bQASy4YzxsLqOvb/srcv
         cUrhkGpdcaYGHZQ/0GIDJOmdejA9U/ic4jPzF+Ah/Uvdou0JsfrFZg3BmBShF7/SHaUf
         MRbg==
X-Gm-Message-State: AOJu0YxY4uErbKKJFRQG+UK/GLTvxybRj+dFcNLC3rH6XOrOwILph3v3
	EQ/PyZELfQSdDffHP3VJpdgvlQ==
X-Google-Smtp-Source: AGHT+IE76XB7tnKdL9tC+n8jwlqk/Jc+Hfp5dyr5WUhNbnt373mTfQ6cFtiDtzHjW586B7xwz4FHqg==
X-Received: by 2002:a17:902:da87:b0:1d0:7244:f971 with SMTP id j7-20020a170902da8700b001d07244f971mr11268983plx.10.1703007996834;
        Tue, 19 Dec 2023 09:46:36 -0800 (PST)
Received: from sunil-pc.Dlink ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001d3320f6143sm14453015plh.269.2023.12.19.09.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:46:36 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v3 11/17] irqchip: riscv-aplic: Add ACPI support
Date: Tue, 19 Dec 2023 23:15:20 +0530
Message-Id: <20231219174526.2235150-12-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
References: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ACPI support in APLIC drivers. In ACPI, IO devices use Global System
Interrupts (GSI) which is a flat space split across multiple APLICs.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/include/asm/irq.h             |  6 +++
 drivers/irqchip/irq-riscv-aplic-direct.c | 21 +++++---
 drivers/irqchip/irq-riscv-aplic-main.c   | 64 ++++++++++++++----------
 drivers/irqchip/irq-riscv-aplic-main.h   |  1 +
 drivers/irqchip/irq-riscv-aplic-msi.c    |  9 +++-
 5 files changed, 66 insertions(+), 35 deletions(-)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 232314e5f007..df59192a157d 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -22,6 +22,12 @@
 #define APLIC_PLIC_ID(x) ((x) >> 24)
 #define IDC_CONTEXT_ID(x) ((x) & 0x0000ffff)
 
+#ifdef CONFIG_RISCV_APLIC
+struct fwnode_handle *aplic_get_gsi_domain_id(u32 gsi);
+#else
+static inline struct fwnode_handle *aplic_get_gsi_domain_id(u32 gsi) { return NULL; }
+#endif
+
 int __init acpi_get_intc_index_hartid(u32 index, unsigned long *hartid);
 int acpi_get_ext_intc_parent_hartid(u8 id, u32 idx, unsigned long *hartid);
 void acpi_get_plic_nr_contexts(u8 id, int *nr_contexts);
diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-riscv-aplic-direct.c
index 9ed2666bfb5e..3e7a7e092120 100644
--- a/drivers/irqchip/irq-riscv-aplic-direct.c
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2022 Ventana Micro Systems Inc.
  */
 
+#include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
@@ -14,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/printk.h>
 #include <linux/smp.h>
+#include <asm/acpi.h>
 
 #include "irq-riscv-aplic-main.h"
 
@@ -203,17 +205,20 @@ static int aplic_direct_starting_cpu(unsigned int cpu)
 
 static int aplic_direct_parse_parent_hwirq(struct device *dev,
 					   u32 index, u32 *parent_hwirq,
-					   unsigned long *parent_hartid)
+					   unsigned long *parent_hartid,
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
@@ -251,7 +256,7 @@ int aplic_direct_setup(struct device *dev, void __iomem *regs)
 
 	/* Setup per-CPU IDC and target CPU mask */
 	for (i = 0; i < priv->nr_idcs; i++) {
-		rc = aplic_direct_parse_parent_hwirq(dev, i, &hwirq, &hartid);
+		rc = aplic_direct_parse_parent_hwirq(dev, i, &hwirq, &hartid, priv);
 		if (rc) {
 			dev_warn(dev, "parent irq for IDC%d not found\n", i);
 			continue;
diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
index d1b342b66551..31434b3ff690 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -4,12 +4,15 @@
  * Copyright (C) 2022 Ventana Micro Systems Inc.
  */
 
+#include <linux/acpi.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/printk.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/irqchip/riscv-aplic.h>
+#include <linux/irqchip/riscv-imsic.h>
+#include <asm/acpi.h>
 
 #include "irq-riscv-aplic-main.h"
 
@@ -137,38 +140,44 @@ int aplic_setup_priv(struct aplic_priv *priv, struct device *dev,
 		     void __iomem *regs)
 {
 	struct of_phandle_args parent;
+	struct acpi_madt_aplic *aplic;
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
-	rc = of_property_read_u32(to_of_node(dev->fwnode),
-					     "riscv,num-sources",
-					     &priv->nr_irqs);
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
-		while (!of_irq_parse_one(to_of_node(dev->fwnode),
-					 priv->nr_idcs, &parent))
-			priv->nr_idcs++;
+	if (is_of_node(dev->fwnode)) {
+		/* Find out number of interrupt sources */
+		rc = of_property_read_u32(to_of_node(dev->fwnode),
+					  "riscv,num-sources",
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
+			while (!of_irq_parse_one(to_of_node(dev->fwnode),
+						 priv->nr_idcs, &parent))
+				priv->nr_idcs++;
+		}
+	} else {
+		aplic = *(struct acpi_madt_aplic **)dev_get_platdata(dev);
+		if (!aplic) {
+			dev_err(dev, "APLIC platform data is NULL!\n");
+			return -1;
+		}
+		priv->gsi_base = aplic->gsi_base;
+		priv->nr_irqs = aplic->num_sources;
+		priv->nr_idcs = aplic->num_idcs;
+		priv->id = aplic->id;
 	}
 
 	/* Setup initial state APLIC interrupts */
@@ -204,6 +213,9 @@ static int aplic_probe(struct platform_device *pdev)
 	if (is_of_node(dev->fwnode))
 		msi_mode = of_property_present(to_of_node(dev->fwnode),
 						"msi-parent");
+	else
+		msi_mode = imsic_acpi_get_fwnode(NULL) ? 1 : 0;
+
 	if (msi_mode)
 		rc = aplic_msi_setup(dev, regs);
 	else
diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip/irq-riscv-aplic-main.h
index 78267ec58098..dc022e89bc97 100644
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
index 086d00e0429e..03a8ac6554c4 100644
--- a/drivers/irqchip/irq-riscv-aplic-msi.c
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -178,6 +178,7 @@ static void aplic_msi_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 int aplic_msi_setup(struct device *dev, void __iomem *regs)
 {
 	const struct imsic_global_config *imsic_global;
+	struct irq_domain *msi_domain;
 	struct irq_domain *irqdomain;
 	struct aplic_priv *priv;
 	struct aplic_msicfg *mc;
@@ -261,8 +262,14 @@ int aplic_msi_setup(struct device *dev, void __iomem *regs)
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
 
 	/* Create irq domain instance for the APLIC MSI-mode */
-- 
2.39.2


