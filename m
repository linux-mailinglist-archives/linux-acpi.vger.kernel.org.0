Return-Path: <linux-acpi+bounces-464-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 136087BBA5D
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 16:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445191C20986
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 14:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69D926E04
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrmT9imn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836041F615;
	Fri,  6 Oct 2023 12:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F57C433CA;
	Fri,  6 Oct 2023 12:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696597187;
	bh=dybQF8DkN2/JhqeqS15XevL69SBvMkd526HSMEBGE2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MrmT9imnkoF3JnWlsyG+olHe5v/Kmz7IuPl1f2srIBIGa99TSCr6L9hnbb3aAF3+7
	 jwQVBLxZUd0poP4OTvdyvaXAcoFPG0NUgHIy0TtZkh6NQwscGBiasnaCJr1FKG7q89
	 idqvool1J/+KhFGIlKiaaJfuWzeqjNG4qHdsqQ6qinPpo30Hx0EcRX2ZajyWsmJQ1Z
	 gY0Grhw2keLHki7LYl041p8iQvbIGS1AWPOJVaD/V5TKHRrK/f2XgmoZE/68zKLuHN
	 aZLmdlfIXPf3oiQ+gZNBTwts31Muj29ntLI+YUfSVyotHDtPjYuknK4XIMTP9hBXYH
	 LKDrPeJAdyliQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Fang Xiang <fangxiang3@xiaomi.com>
Subject: [PATCH v3 3/5] irqchip/gic-v3-its: Split allocation from initialisation of its_node
Date: Fri,  6 Oct 2023 14:59:27 +0200
Message-Id: <20231006125929.48591-4-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006125929.48591-1-lpieralisi@kernel.org>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20231006125929.48591-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Zyngier <maz@kernel.org>

In order to pave the way for more fancy quirk handling without making
more of a mess of this terrible driver, split the allocation of the
ITS descriptor (its_node) from the actual probing.

This will allow firmware-specific hooks to be added between these
two points.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 149 ++++++++++++++++++-------------
 1 file changed, 89 insertions(+), 60 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index adde347dc890..75a2dd550625 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4965,7 +4965,7 @@ static void __init __iomem *its_map_one(struct resource *res, int *err)
 	return NULL;
 }
 
-static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
+static int its_init_domain(struct its_node *its)
 {
 	struct irq_domain *inner_domain;
 	struct msi_domain_info *info;
@@ -4979,7 +4979,7 @@ static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
 
 	inner_domain = irq_domain_create_hierarchy(its_parent,
 						   its->msi_domain_flags, 0,
-						   handle, &its_domain_ops,
+						   its->fwnode_handle, &its_domain_ops,
 						   info);
 	if (!inner_domain) {
 		kfree(info);
@@ -5030,8 +5030,7 @@ static int its_init_vpe_domain(void)
 	return 0;
 }
 
-static int __init its_compute_its_list_map(struct resource *res,
-					   void __iomem *its_base)
+static int __init its_compute_its_list_map(struct its_node *its)
 {
 	int its_number;
 	u32 ctlr;
@@ -5045,15 +5044,15 @@ static int __init its_compute_its_list_map(struct resource *res,
 	its_number = find_first_zero_bit(&its_list_map, GICv4_ITS_LIST_MAX);
 	if (its_number >= GICv4_ITS_LIST_MAX) {
 		pr_err("ITS@%pa: No ITSList entry available!\n",
-		       &res->start);
+		       &its->phys_base);
 		return -EINVAL;
 	}
 
-	ctlr = readl_relaxed(its_base + GITS_CTLR);
+	ctlr = readl_relaxed(its->base + GITS_CTLR);
 	ctlr &= ~GITS_CTLR_ITS_NUMBER;
 	ctlr |= its_number << GITS_CTLR_ITS_NUMBER_SHIFT;
-	writel_relaxed(ctlr, its_base + GITS_CTLR);
-	ctlr = readl_relaxed(its_base + GITS_CTLR);
+	writel_relaxed(ctlr, its->base + GITS_CTLR);
+	ctlr = readl_relaxed(its->base + GITS_CTLR);
 	if ((ctlr & GITS_CTLR_ITS_NUMBER) != (its_number << GITS_CTLR_ITS_NUMBER_SHIFT)) {
 		its_number = ctlr & GITS_CTLR_ITS_NUMBER;
 		its_number >>= GITS_CTLR_ITS_NUMBER_SHIFT;
@@ -5061,75 +5060,50 @@ static int __init its_compute_its_list_map(struct resource *res,
 
 	if (test_and_set_bit(its_number, &its_list_map)) {
 		pr_err("ITS@%pa: Duplicate ITSList entry %d\n",
-		       &res->start, its_number);
+		       &its->phys_base, its_number);
 		return -EINVAL;
 	}
 
 	return its_number;
 }
 
-static int __init its_probe_one(struct resource *res,
-				struct fwnode_handle *handle, int numa_node)
+static int __init its_probe_one(struct its_node *its)
 {
-	struct its_node *its;
-	void __iomem *its_base;
-	u64 baser, tmp, typer;
+	u64 baser, tmp;
 	struct page *page;
 	u32 ctlr;
 	int err;
 
-	its_base = its_map_one(res, &err);
-	if (!its_base)
-		return err;
-
-	pr_info("ITS %pR\n", res);
-
-	its = kzalloc(sizeof(*its), GFP_KERNEL);
-	if (!its) {
-		err = -ENOMEM;
-		goto out_unmap;
-	}
-
-	raw_spin_lock_init(&its->lock);
-	mutex_init(&its->dev_alloc_lock);
-	INIT_LIST_HEAD(&its->entry);
-	INIT_LIST_HEAD(&its->its_device_list);
-	typer = gic_read_typer(its_base + GITS_TYPER);
-	its->typer = typer;
-	its->base = its_base;
-	its->phys_base = res->start;
 	if (is_v4(its)) {
-		if (!(typer & GITS_TYPER_VMOVP)) {
-			err = its_compute_its_list_map(res, its_base);
+		if (!(its->typer & GITS_TYPER_VMOVP)) {
+			err = its_compute_its_list_map(its);
 			if (err < 0)
-				goto out_free_its;
+				goto out;
 
 			its->list_nr = err;
 
 			pr_info("ITS@%pa: Using ITS number %d\n",
-				&res->start, err);
+				&its->phys_base, err);
 		} else {
-			pr_info("ITS@%pa: Single VMOVP capable\n", &res->start);
+			pr_info("ITS@%pa: Single VMOVP capable\n", &its->phys_base);
 		}
 
 		if (is_v4_1(its)) {
-			u32 svpet = FIELD_GET(GITS_TYPER_SVPET, typer);
+			u32 svpet = FIELD_GET(GITS_TYPER_SVPET, its->typer);
 
-			its->sgir_base = ioremap(res->start + SZ_128K, SZ_64K);
+			its->sgir_base = ioremap(its->phys_base + SZ_128K, SZ_64K);
 			if (!its->sgir_base) {
 				err = -ENOMEM;
-				goto out_free_its;
+				goto out;
 			}
 
-			its->mpidr = readl_relaxed(its_base + GITS_MPIDR);
+			its->mpidr = readl_relaxed(its->base + GITS_MPIDR);
 
 			pr_info("ITS@%pa: Using GICv4.1 mode %08x %08x\n",
-				&res->start, its->mpidr, svpet);
+				&its->phys_base, its->mpidr, svpet);
 		}
 	}
 
-	its->numa_node = numa_node;
-
 	page = alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO,
 				get_order(ITS_CMD_QUEUE_SZ));
 	if (!page) {
@@ -5138,12 +5112,9 @@ static int __init its_probe_one(struct resource *res,
 	}
 	its->cmd_base = (void *)page_address(page);
 	its->cmd_write = its->cmd_base;
-	its->fwnode_handle = handle;
 	its->get_msi_base = its_irq_get_msi_base;
 	its->msi_domain_flags = IRQ_DOMAIN_FLAG_ISOLATED_MSI;
 
-	its_enable_quirks(its);
-
 	err = its_alloc_tables(its);
 	if (err)
 		goto out_free_cmd;
@@ -5187,7 +5158,7 @@ static int __init its_probe_one(struct resource *res,
 		ctlr |= GITS_CTLR_ImDe;
 	writel_relaxed(ctlr, its->base + GITS_CTLR);
 
-	err = its_init_domain(handle, its);
+	err = its_init_domain(its);
 	if (err)
 		goto out_free_tables;
 
@@ -5204,11 +5175,8 @@ static int __init its_probe_one(struct resource *res,
 out_unmap_sgir:
 	if (its->sgir_base)
 		iounmap(its->sgir_base);
-out_free_its:
-	kfree(its);
-out_unmap:
-	iounmap(its_base);
-	pr_err("ITS@%pa: failed probing (%d)\n", &res->start, err);
+out:
+	pr_err("ITS@%pa: failed probing (%d)\n", &its->phys_base, err);
 	return err;
 }
 
@@ -5369,10 +5337,53 @@ static const struct of_device_id its_device_id[] = {
 	{},
 };
 
+static struct its_node __init *its_node_init(struct resource *res,
+					     struct fwnode_handle *handle, int numa_node)
+{
+	void __iomem *its_base;
+	struct its_node *its;
+	int err;
+
+	its_base = its_map_one(res, &err);
+	if (!its_base)
+		return NULL;
+
+	pr_info("ITS %pR\n", res);
+
+	its = kzalloc(sizeof(*its), GFP_KERNEL);
+	if (!its)
+		goto out_unmap;
+
+	raw_spin_lock_init(&its->lock);
+	mutex_init(&its->dev_alloc_lock);
+	INIT_LIST_HEAD(&its->entry);
+	INIT_LIST_HEAD(&its->its_device_list);
+
+	its->typer = gic_read_typer(its_base + GITS_TYPER);
+	its->base = its_base;
+	its->phys_base = res->start;
+
+	its->numa_node = numa_node;
+	its->fwnode_handle = handle;
+
+	return its;
+
+out_unmap:
+	iounmap(its_base);
+	return NULL;
+}
+
+static void its_node_destroy(struct its_node *its)
+{
+	iounmap(its->base);
+	kfree(its);
+}
+
 static int __init its_of_probe(struct device_node *node)
 {
 	struct device_node *np;
 	struct resource res;
+	int err;
 
 	/*
 	 * Make sure *all* the ITS are reset before we probe any, as
@@ -5382,8 +5393,6 @@ static int __init its_of_probe(struct device_node *node)
 	 */
 	for (np = of_find_matching_node(node, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
-		int err;
-
 		if (!of_device_is_available(np) ||
 		    !of_property_read_bool(np, "msi-controller") ||
 		    of_address_to_resource(np, 0, &res))
@@ -5396,6 +5405,8 @@ static int __init its_of_probe(struct device_node *node)
 
 	for (np = of_find_matching_node(node, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
+		struct its_node *its;
+
 		if (!of_device_is_available(np))
 			continue;
 		if (!of_property_read_bool(np, "msi-controller")) {
@@ -5409,7 +5420,17 @@ static int __init its_of_probe(struct device_node *node)
 			continue;
 		}
 
-		its_probe_one(&res, &np->fwnode, of_node_to_nid(np));
+
+		its = its_node_init(&res, &np->fwnode, of_node_to_nid(np));
+		if (!its)
+			return -ENOMEM;
+
+		its_enable_quirks(its);
+		err = its_probe_one(its);
+		if (err)  {
+			its_node_destroy(its);
+			return err;
+		}
 	}
 	return 0;
 }
@@ -5521,6 +5542,7 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
 {
 	struct acpi_madt_generic_translator *its_entry;
 	struct fwnode_handle *dom_handle;
+	struct its_node *its;
 	struct resource res;
 	int err;
 
@@ -5545,11 +5567,18 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
 		goto dom_err;
 	}
 
-	err = its_probe_one(&res, dom_handle,
-			acpi_get_its_numa_node(its_entry->translation_id));
+	its = its_node_init(&res, dom_handle,
+			    acpi_get_its_numa_node(its_entry->translation_id));
+	if (!its) {
+		err = -ENOMEM;
+		goto node_err;
+	}
+
+	err = its_probe_one(its);
 	if (!err)
 		return 0;
 
+node_err:
 	iort_deregister_domain_token(its_entry->translation_id);
 dom_err:
 	irq_domain_free_fwnode(dom_handle);
-- 
2.34.1


