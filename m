Return-Path: <linux-acpi+bounces-7522-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CA494E465
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 03:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF461C21123
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 01:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE291292CE;
	Mon, 12 Aug 2024 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ICNYrSl2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6607B7D07D
	for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 01:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424491; cv=none; b=keBNstmwCdWyVazg/f/luoBKBoFhqYmapCsgXYZO4V4fN9LcNtcvEXrwhyRttQHwm5ZZCGZmgZyWZmGFV/tePQpp9X9vMgsoseL6Vlx49/5fNIWwKfpgIEGZydtp8W6jKOnjqmGX8kPZmryjrPjCxG1ayqrPp2v7ihk4Bf09WTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424491; c=relaxed/simple;
	bh=jjQu2jdS/HNK9a4N33zsmxheaJY85iZag0mOYvZYXqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SHIAC1S4wPhHFD44ZsaWFbCkDmPMX+wLnp6uO5hf4ovEIkZEPRplPwzWb09QZLPs9qzLTuX2cwBkqP6Wrl3TwS0MV6jLHH73XqMdiidtkb6fWcQZ5PASwKlTuZjJ1lvl22FZYyyYBPTyyR/wc8pSzDYpbOuDy/kNGerwyQjAk4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ICNYrSl2; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-81fe38c7255so221685239f.1
        for <linux-acpi@vger.kernel.org>; Sun, 11 Aug 2024 18:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424488; x=1724029288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNLSK7wTLWm4CwE5KqZAhFa5+nxzSyIB3H2xsiVowu8=;
        b=ICNYrSl2jshsEWRsq2Glql3cDgQiaQh4SN0IRfKVs7qjozVD8tsvFyD3RZZenWU5E0
         r7AChhgyKll0HFWNB1hxU1jDAAWSgzCeGqqS6DwOF6eZ1k/Z7+jtIlpwm87ipozmpzmk
         FcHBXGgp+YvJtxdWvoJEYFbv41+GVH3U3uqN/Wnh+dtZgu9zcZktgtAgHNwZqrPd1EP/
         3fVrZub8jwkuxep3q2b4Tr5xBxWJ2kEyUh2TUgwpFEdPRRkpiDjL/+Cg0GrJGBgOTJzi
         uGZMttdhxfdwEjLl5W6ZY+dSrQBoUzeo0jcLTDUqK4555WhyU5PiO1qlpvtwd9W37pAi
         O3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424488; x=1724029288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNLSK7wTLWm4CwE5KqZAhFa5+nxzSyIB3H2xsiVowu8=;
        b=YcBngfBQaW3ZSODYGQlE5ykOIl7lfwPAEfwu6sUnBC3SqSDT++GGW25klcM2tQXosl
         17LUa2ufPGkXtmEKN+5aSswr03sOf7oXV5Ddm2hTA6aV1hg/WTK9kylKoaCt4jWfgrH1
         ZRvmAPXb7KmJEafslp0FEUxwIMcfoC+qqhfxMDLCIdm2m6318o8bvlYHT+Oy27Xeisi1
         u044N0bkf14Ej1H60RqROjs3n8omEDXrED4BLzmUoJF3yfkVK0hgPZVTwgjDFEHpwNY1
         eFnC41RTqFhymctHusfyDm2y8nGrTTOzGtyH5UHQOPqlH0sgjmz6cPlFiYe3ijanspM8
         V7cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcBic9P5SAVXmP+S5hBinqpDm60eGL9KTCT8xfhjwOLRVY7kNdH+PrkyotWStEWMd6phMPcikkoFmDO8cPWvZ7nl0R2qF8VIGy6A==
X-Gm-Message-State: AOJu0YxoYPyvNgvZAbuAVVysP5wDnR9AhJpGJRGEprxFZdegI7ZjeWJb
	quYjLzWWrIW9lcHLN1+5NRGOm5oNkOk5ihIpkl3EvMDRQ/7miUJ80pLeCKtnmT4=
X-Google-Smtp-Source: AGHT+IF383Ow04ACkTQv23O0jExDAeidajffTjgaukCfUfErQcvrXz/vXlnALl3G0O0SzK4yssEykg==
X-Received: by 2002:a05:6602:15d3:b0:805:3d47:19cf with SMTP id ca18e2360f4ac-8225eedb1e2mr1121775039f.15.1723424488343;
        Sun, 11 Aug 2024 18:01:28 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:01:27 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v8 17/17] irqchip/sifive-plic: Add ACPI support
Date: Mon, 12 Aug 2024 06:29:29 +0530
Message-ID: <20240812005929.113499-18-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812005929.113499-1-sunilvl@ventanamicro.com>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=cp1252
Content-Transfer-Encoding: 8bit

Add ACPI support in PLIC driver. Use the mapping created early during
boot to get details about the PLIC.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Co-developed-by: Haibo Xu <haibo1.xu@intel.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/irqchip/irq-sifive-plic.c | 95 ++++++++++++++++++++++++-------
 1 file changed, 74 insertions(+), 21 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 9e22f7e378f5..207cfe18ec7f 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2017 SiFive
  * Copyright (C) 2018 Christoph Hellwig
  */
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -70,6 +71,8 @@ struct plic_priv {
 	unsigned long plic_quirks;
 	unsigned int nr_irqs;
 	unsigned long *prio_save;
+	u32 gsi_base;
+	int acpi_plic_id;
 };
 
 struct plic_handler {
@@ -324,6 +327,10 @@ static int plic_irq_domain_translate(struct irq_domain *d,
 {
 	struct plic_priv *priv = d->host_data;
 
+	/* For DT, gsi_base is always zero. */
+	if (fwspec->param[0] >= priv->gsi_base)
+		fwspec->param[0] = fwspec->param[0] - priv->gsi_base;
+
 	if (test_bit(PLIC_QUIRK_EDGE_INTERRUPT, &priv->plic_quirks))
 		return irq_domain_translate_twocell(d, fwspec, hwirq, type);
 
@@ -424,18 +431,37 @@ static const struct of_device_id plic_match[] = {
 	{}
 };
 
+#ifdef CONFIG_ACPI
+
+static const struct acpi_device_id plic_acpi_match[] = {
+	{ "RSCV0001", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, plic_acpi_match);
+
+#endif
 static int plic_parse_nr_irqs_and_contexts(struct platform_device *pdev,
-					   u32 *nr_irqs, u32 *nr_contexts)
+					   u32 *nr_irqs, u32 *nr_contexts,
+					   u32 *gsi_base, u32 *id)
 {
 	struct device *dev = &pdev->dev;
 	int rc;
 
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
-	if (!is_of_node(dev->fwnode))
-		return -EINVAL;
+	if (!is_of_node(dev->fwnode)) {
+		rc = riscv_acpi_get_gsi_info(dev->fwnode, gsi_base, id, nr_irqs, NULL);
+		if (rc) {
+			dev_err(dev, "failed to find GSI mapping\n");
+			return rc;
+		}
+
+		*nr_contexts = acpi_rintc_get_plic_nr_contexts(*id);
+		if (WARN_ON(!*nr_contexts)) {
+			dev_err(dev, "no PLIC context available\n");
+			return -EINVAL;
+		}
+
+		return 0;
+	}
 
 	rc = of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", nr_irqs);
 	if (rc) {
@@ -449,23 +475,29 @@ static int plic_parse_nr_irqs_and_contexts(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	*gsi_base = 0;
+	*id = 0;
+
 	return 0;
 }
 
 static int plic_parse_context_parent(struct platform_device *pdev, u32 context,
-				     u32 *parent_hwirq, int *parent_cpu)
+				     u32 *parent_hwirq, int *parent_cpu, u32 id)
 {
 	struct device *dev = &pdev->dev;
 	struct of_phandle_args parent;
 	unsigned long hartid;
 	int rc;
 
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
-	if (!is_of_node(dev->fwnode))
-		return -EINVAL;
+	if (!is_of_node(dev->fwnode)) {
+		hartid = acpi_rintc_ext_parent_to_hartid(id, context);
+		if (hartid == INVALID_HARTID)
+			return -EINVAL;
+
+		*parent_cpu = riscv_hartid_to_cpuid(hartid);
+		*parent_hwirq = RV_IRQ_EXT;
+		return 0;
+	}
 
 	rc = of_irq_parse_one(to_of_node(dev->fwnode), context, &parent);
 	if (rc)
@@ -489,6 +521,8 @@ static int plic_probe(struct platform_device *pdev)
 	u32 nr_irqs, parent_hwirq;
 	struct plic_priv *priv;
 	irq_hw_number_t hwirq;
+	int id, context_id;
+	u32 gsi_base;
 
 	if (is_of_node(dev->fwnode)) {
 		const struct of_device_id *id;
@@ -498,7 +532,7 @@ static int plic_probe(struct platform_device *pdev)
 			plic_quirks = (unsigned long)id->data;
 	}
 
-	error = plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_contexts);
+	error = plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_contexts, &gsi_base, &id);
 	if (error)
 		return error;
 
@@ -509,6 +543,8 @@ static int plic_probe(struct platform_device *pdev)
 	priv->dev = dev;
 	priv->plic_quirks = plic_quirks;
 	priv->nr_irqs = nr_irqs;
+	priv->gsi_base = gsi_base;
+	priv->acpi_plic_id = id;
 
 	priv->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (WARN_ON(!priv->regs))
@@ -519,12 +555,23 @@ static int plic_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0; i < nr_contexts; i++) {
-		error = plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu);
+		error = plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu,
+						  priv->acpi_plic_id);
 		if (error) {
 			dev_warn(dev, "hwirq for context%d not found\n", i);
 			continue;
 		}
 
+		if (is_of_node(dev->fwnode)) {
+			context_id = i;
+		} else {
+			context_id = acpi_rintc_get_plic_context(priv->acpi_plic_id, i);
+			if (context_id == INVALID_CONTEXT) {
+				dev_warn(dev, "invalid context id for context%d\n", i);
+				continue;
+			}
+		}
+
 		/*
 		 * Skip contexts other than external interrupts for our
 		 * privilege level.
@@ -562,10 +609,10 @@ static int plic_probe(struct platform_device *pdev)
 		cpumask_set_cpu(cpu, &priv->lmask);
 		handler->present = true;
 		handler->hart_base = priv->regs + CONTEXT_BASE +
-			i * CONTEXT_SIZE;
+			context_id * CONTEXT_SIZE;
 		raw_spin_lock_init(&handler->enable_lock);
 		handler->enable_base = priv->regs + CONTEXT_ENABLE_BASE +
-			i * CONTEXT_ENABLE_SIZE;
+			context_id * CONTEXT_ENABLE_SIZE;
 		handler->priv = priv;
 
 		handler->enable_save = devm_kcalloc(dev, DIV_ROUND_UP(nr_irqs, 32),
@@ -581,8 +628,8 @@ static int plic_probe(struct platform_device *pdev)
 		nr_handlers++;
 	}
 
-	priv->irqdomain = irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs + 1,
-						&plic_irqdomain_ops, priv);
+	priv->irqdomain = irq_domain_create_linear(dev->fwnode, nr_irqs + 1,
+						   &plic_irqdomain_ops, priv);
 	if (WARN_ON(!priv->irqdomain))
 		goto fail_cleanup_contexts;
 
@@ -619,13 +666,18 @@ static int plic_probe(struct platform_device *pdev)
 		}
 	}
 
+#ifdef CONFIG_ACPI
+	if (!acpi_disabled)
+		acpi_dev_clear_dependencies(ACPI_COMPANION(dev));
+#endif
+
 	dev_info(dev, "mapped %d interrupts with %d handlers for %d contexts.\n",
 		 nr_irqs, nr_handlers, nr_contexts);
 	return 0;
 
 fail_cleanup_contexts:
 	for (i = 0; i < nr_contexts; i++) {
-		if (plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu))
+		if (plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu, priv->acpi_plic_id))
 			continue;
 		if (parent_hwirq != RV_IRQ_EXT || cpu < 0)
 			continue;
@@ -644,6 +696,7 @@ static struct platform_driver plic_driver = {
 	.driver = {
 		.name		= "riscv-plic",
 		.of_match_table	= plic_match,
+		.acpi_match_table = ACPI_PTR(plic_acpi_match),
 	},
 	.probe = plic_probe,
 };
-- 
2.43.0


