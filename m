Return-Path: <linux-acpi+bounces-16917-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C08E4B573E8
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 11:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4E53A5F9F
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 09:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA0D2F8BCA;
	Mon, 15 Sep 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLZ5PQKr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467562F83CB;
	Mon, 15 Sep 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926639; cv=none; b=DUJ7gId3+z8MiKRjUuNzAZ47X/cBWIW1ljO1Kf/OH3vNdthh3quMqX/crGaTdymyWWjrm1ABCvXDqLFufT+wZpOhgAXycNKUtgpdHCBSsgp9mBAqYVRulMRF0lw9OyVpjtcq0T/wVyUXSoJKgyr07LltBy+tLDGajqd+cPRUIoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926639; c=relaxed/simple;
	bh=f+QGIJt0TLdWgJhUimSN2JgMtMX5elof6Y6UFU21JN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uQzry09PIU7ljp1sxtUdXd0g9L89h1gJNK7GjvhnlK3nRrFruh0K42S+SGUr8vKz1cQtm8snvx7zhrShgDvPCrnFv40NKhtd8LDulSu+WuoBTy04SNp3Z2hXFsDV1wbc1nzq6nsPLvnvYlWM1oGfsfyw6fbcdHa85ae3S1gDs1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLZ5PQKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B781C4CEF9;
	Mon, 15 Sep 2025 08:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926638;
	bh=f+QGIJt0TLdWgJhUimSN2JgMtMX5elof6Y6UFU21JN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mLZ5PQKrGeL+mKmYZ4G2h/tpozhllluN3lpiXEsqAQuPuklDYRdWwBRBxtP1SBTeg
	 gpMaDOoOHnXzOZeSjeG5c3ihWQmc9xR9WGu/V/dCbQ87cgRerKj5X0/gfhLaKvWbLU
	 hIPkXdmj/MDroN17yaflfqmHUlFvN3vKudg9hKLIdVlj6nNUtpvHWgOzPUXLpqvixx
	 wr9mwlZh7mM2ObBZuM2sgayCCUcj1WcmERv0L75zoEKdHBweyylROYMzaSOjiolUXl
	 Q8ADc63+e/8w11+Q5nxtflHAQlqvivlmxrAqPoUTVWpzFLwjD0+lPCxagXqgThJDKH
	 9JHuBQKuxv78g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uy51Q-00000006IHP-2bf4;
	Mon, 15 Sep 2025 08:57:16 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH v2 21/25] irqchip/gic-v3: Drop support for custom PPI partitions
Date: Mon, 15 Sep 2025 09:56:58 +0100
Message-Id: <20250915085702.519996-22-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250915085702.519996-1-maz@kernel.org>
References: <20250915085702.519996-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, tglx@linutronix.de, mark.rutland@arm.com, will@kernel.org, rafael@kernel.org, robh@kernel.org, saravanak@google.com, gregkh@linuxfoundation.org, sven@kernel.org, j@jannau.net, suzuki.poulose@arm.com, james.clark@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

The only thing getting in the way of correctly handling PPIs the way
they were intended is the GICv3 hack that deals with PPI partitions.

Remove that code, allowing the common code to kick in.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/Kconfig      |   1 -
 drivers/irqchip/irq-gic-v3.c | 133 +++--------------------------------
 2 files changed, 8 insertions(+), 126 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 6d12c6ab9ea47..c31d2f99d7b91 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -36,7 +36,6 @@ config GIC_NON_BANKED
 config ARM_GIC_V3
 	bool
 	select IRQ_DOMAIN_HIERARCHY
-	select PARTITION_PERCPU
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 	select HAVE_ARM_SMCCC_DISCOVERY
 	select IRQ_MSI_IOMMU
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index a14fd4c269692..0d8a6f46e9300 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -26,7 +26,6 @@
 #include <linux/irqchip/arm-gic-common.h>
 #include <linux/irqchip/arm-gic-v3.h>
 #include <linux/irqchip/arm-gic-v3-prio.h>
-#include <linux/irqchip/irq-partition-percpu.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/arm-smccc.h>
@@ -46,8 +45,6 @@ static u8 dist_prio_nmi __ro_after_init = GICV3_PRIO_NMI;
 #define FLAGS_WORKAROUND_ASR_ERRATUM_8601001	(1ULL << 2)
 #define FLAGS_WORKAROUND_INSECURE		(1ULL << 3)
 
-#define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
-
 static struct cpumask broken_rdists __read_mostly __maybe_unused;
 
 struct redist_region {
@@ -68,11 +65,15 @@ struct gic_chip_data {
 	u64			flags;
 	bool			has_rss;
 	unsigned int		ppi_nr;
-	struct partition_desc	**ppi_descs;
 	struct partition_affinity *parts;
 	unsigned int		nr_parts;
 };
 
+struct partition_affinity {
+	cpumask_t			mask;
+	struct fwnode_handle		*partition_id;
+};
+
 #define T241_CHIPS_MAX		4
 static void __iomem *t241_dist_base_alias[T241_CHIPS_MAX] __read_mostly;
 static DEFINE_STATIC_KEY_FALSE(gic_nvidia_t241_erratum);
@@ -593,18 +594,6 @@ static void gic_irq_set_prio(struct irq_data *d, u8 prio)
 	writeb_relaxed(prio, base + offset + index);
 }
 
-static u32 __gic_get_ppi_index(irq_hw_number_t hwirq)
-{
-	switch (__get_intid_range(hwirq)) {
-	case PPI_RANGE:
-		return hwirq - 16;
-	case EPPI_RANGE:
-		return hwirq - EPPI_BASE_INTID + 16;
-	default:
-		unreachable();
-	}
-}
-
 static int gic_irq_nmi_setup(struct irq_data *d)
 {
 	struct irq_desc *desc = irq_to_desc(d->irq);
@@ -1628,13 +1617,6 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		case GIC_IRQ_TYPE_LPI:	/* LPI */
 			*hwirq = fwspec->param[1];
 			break;
-		case GIC_IRQ_TYPE_PARTITION:
-			*hwirq = fwspec->param[1];
-			if (fwspec->param[1] >= 16)
-				*hwirq += EPPI_BASE_INTID - 16;
-			else
-				*hwirq += 16;
-			break;
 		default:
 			return -EINVAL;
 		}
@@ -1643,10 +1625,8 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 
 		/*
 		 * Make it clear that broken DTs are... broken.
-		 * Partitioned PPIs are an unfortunate exception.
 		 */
-		WARN_ON(*type == IRQ_TYPE_NONE &&
-			fwspec->param[0] != GIC_IRQ_TYPE_PARTITION);
+		WARN_ON(*type == IRQ_TYPE_NONE);
 		return 0;
 	}
 
@@ -1703,32 +1683,11 @@ static void gic_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 	}
 }
 
-static bool fwspec_is_partitioned_ppi(struct irq_fwspec *fwspec,
-				      irq_hw_number_t hwirq)
-{
-	enum gic_intid_range range;
-
-	if (!gic_data.ppi_descs)
-		return false;
-
-	if (!is_of_node(fwspec->fwnode))
-		return false;
-
-	if (fwspec->param_count < 4 || !fwspec->param[3])
-		return false;
-
-	range = __get_intid_range(hwirq);
-	if (range != PPI_RANGE && range != EPPI_RANGE)
-		return false;
-
-	return true;
-}
-
 static int gic_irq_domain_select(struct irq_domain *d,
 				 struct irq_fwspec *fwspec,
 				 enum irq_domain_bus_token bus_token)
 {
-	unsigned int type, ret, ppi_idx;
+	unsigned int type, ret;
 	irq_hw_number_t hwirq;
 
 	/* Not for us */
@@ -1747,15 +1706,7 @@ static int gic_irq_domain_select(struct irq_domain *d,
 	if (WARN_ON_ONCE(ret))
 		return 0;
 
-	if (!fwspec_is_partitioned_ppi(fwspec, hwirq))
-		return d == gic_data.domain;
-
-	/*
-	 * If this is a PPI and we have a 4th (non-null) parameter,
-	 * then we need to match the partition domain.
-	 */
-	ppi_idx = __gic_get_ppi_index(hwirq);
-	return d == partition_get_domain(gic_data.ppi_descs[ppi_idx]);
+	return d == gic_data.domain;
 }
 
 static int gic_irq_get_fwspec_info(struct irq_fwspec *fwspec, struct irq_fwspec_info *info)
@@ -1812,45 +1763,6 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.get_fwspec_info = gic_irq_get_fwspec_info,
 };
 
-static int partition_domain_translate(struct irq_domain *d,
-				      struct irq_fwspec *fwspec,
-				      unsigned long *hwirq,
-				      unsigned int *type)
-{
-	unsigned long ppi_intid;
-	struct device_node *np;
-	unsigned int ppi_idx;
-	int ret;
-
-	if (!gic_data.ppi_descs)
-		return -ENOMEM;
-
-	np = of_find_node_by_phandle(fwspec->param[3]);
-	if (WARN_ON(!np))
-		return -EINVAL;
-
-	ret = gic_irq_domain_translate(d, fwspec, &ppi_intid, type);
-	if (WARN_ON_ONCE(ret))
-		return 0;
-
-	ppi_idx = __gic_get_ppi_index(ppi_intid);
-	ret = partition_translate_id(gic_data.ppi_descs[ppi_idx],
-				     of_fwnode_handle(np));
-	if (ret < 0)
-		return ret;
-
-	*hwirq = ret;
-	*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
-
-	return 0;
-}
-
-static const struct irq_domain_ops partition_domain_ops = {
-	.translate = partition_domain_translate,
-	.select = gic_irq_domain_select,
-	.get_fwspec_info = gic_irq_get_fwspec_info,
-};
-
 static bool gic_enable_quirk_msm8996(void *data)
 {
 	struct gic_chip_data *d = data;
@@ -2173,12 +2085,7 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 	if (!parts_node)
 		return;
 
-	gic_data.ppi_descs = kcalloc(gic_data.ppi_nr, sizeof(*gic_data.ppi_descs), GFP_KERNEL);
-	if (!gic_data.ppi_descs)
-		goto out_put_node;
-
 	nr_parts = of_get_child_count(parts_node);
-
 	if (!nr_parts)
 		goto out_put_node;
 
@@ -2234,30 +2141,6 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 	gic_data.parts = parts;
 	gic_data.nr_parts = nr_parts;
 
-	for (i = 0; i < gic_data.ppi_nr; i++) {
-		unsigned int irq;
-		struct partition_desc *desc;
-		struct irq_fwspec ppi_fwspec = {
-			.fwnode		= gic_data.fwnode,
-			.param_count	= 3,
-			.param		= {
-				[0]	= GIC_IRQ_TYPE_PARTITION,
-				[1]	= i,
-				[2]	= IRQ_TYPE_NONE,
-			},
-		};
-
-		irq = irq_create_fwspec_mapping(&ppi_fwspec);
-		if (WARN_ON(!irq))
-			continue;
-		desc = partition_create_desc(gic_data.fwnode, parts, nr_parts,
-					     irq, &partition_domain_ops);
-		if (WARN_ON(!desc))
-			continue;
-
-		gic_data.ppi_descs[i] = desc;
-	}
-
 out_put_node:
 	of_node_put(parts_node);
 }
-- 
2.39.2


