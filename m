Return-Path: <linux-acpi+bounces-16899-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64925B573C4
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 10:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11B41893C9C
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 08:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF962F39D0;
	Mon, 15 Sep 2025 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjPSf40E"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23A02F39B5;
	Mon, 15 Sep 2025 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926634; cv=none; b=I2IGkfh6xCSyX0xqpjnWbJAYm/2NPiBoqyWb4aGWsy6+VpHYomEHWZ7R8q2i4V5qgAiY5DJjdF7dk7e77PO5L+wKp/GX0nta+6LKq2+jNHt/u4ouBQYu/9T/WfG2w86UhE/GX1Z6we4dGxMmmOQ9aX1wMg9uBb7vZjjiT9lxjY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926634; c=relaxed/simple;
	bh=b54oXtSJ1jOB+4cqyMvjMq57VTZoxc0ThWvLI8ltuVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RrFgpaSHt5tq5t87zmaXviILCBLavB53X0oyR9O2DPpaJmSmkmlaDOK7GMARZr+Swr4Dp4CUwGZ/o8LxjZCG8OG/lGGWSwF87G9DLN0IyOBhTC4oMlQL8YYbvsaUtvSLmTtNx+Wj45aUP9QIe0S04zLroPxse9JvfZCRNWhyxHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjPSf40E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6571EC4CEFE;
	Mon, 15 Sep 2025 08:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926634;
	bh=b54oXtSJ1jOB+4cqyMvjMq57VTZoxc0ThWvLI8ltuVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KjPSf40E6TotVtFTseCZ7k5hHBxe+ZImDQR8/ElNulpp1ve3o5p7KZtWzGE1Uievc
	 HNEo1y0XrLTxaI+SS7UgL5iihkLl4XwI1HrDaVkNG5jVMH41Y8giZbualFPiUGSupB
	 ADA2Xj49/pL8+VMyijdfe2CSY/h4EwDaQ3I6kyOqU5lbKqqwGQogwlZdUv/AM5+wah
	 Q+1KtZu2QYlaXID8IHFsUfizBmipkYTno0xtl/ZPrdmgJD0SOcXrWTnTjmIK+iMCtS
	 UlF4BP4og2EADhqlcbUPOPkW8BFFli5xuCGxoAo8/DcXiZjQRDn7mvFqHACbtPmspZ
	 Ymky/Wof7u3yw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uy51M-00000006IHP-1kaB;
	Mon, 15 Sep 2025 08:57:12 +0000
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
Subject: [PATCH v2 05/25] irqchip/gic-v3: Add FW info retrieval support
Date: Mon, 15 Sep 2025 09:56:42 +0100
Message-Id: <20250915085702.519996-6-maz@kernel.org>
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

Plug the new .get_info() callback into the GICv3 core driver,
using some of the existing PPI affinity handling infrastructure.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 53 ++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index dbeb85677b08c..71c278ddd1e39 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -69,6 +69,8 @@ struct gic_chip_data {
 	bool			has_rss;
 	unsigned int		ppi_nr;
 	struct partition_desc	**ppi_descs;
+	struct partition_affinity *parts;
+	unsigned int		nr_parts;
 };
 
 #define T241_CHIPS_MAX		4
@@ -1796,11 +1798,58 @@ static int gic_irq_domain_select(struct irq_domain *d,
 	return d == partition_get_domain(gic_data.ppi_descs[ppi_idx]);
 }
 
+static int gic_irq_get_fwspec_info(struct irq_fwspec *fwspec, struct irq_fwspec_info *info)
+{
+	const struct cpumask *mask = NULL;
+
+	info->flags = 0;
+	info->affinity = NULL;
+
+	/* ACPI is not capable of describing PPI affinity -- yet */
+	if (!is_of_node(fwspec->fwnode))
+		return 0;
+
+	/* If the specifier provides an affinity, use it */
+	if (fwspec->param_count == 4 && fwspec->param[3]) {
+		struct fwnode_handle *fw;
+
+		switch (fwspec->param[0]) {
+		case 1:			/* PPI */
+		case 3:			/* EPPI */
+			break;
+		default:
+			return 0;
+		}
+
+		fw = of_node_to_fwnode(of_find_node_by_phandle(fwspec->param[3]));
+		if (!fw)
+			return -ENOENT;
+
+		for (int i = 0; i < gic_data.nr_parts; i++) {
+			if (gic_data.parts[i].partition_id == fw) {
+				mask = &gic_data.parts[i].mask;
+				break;
+			}
+		}
+
+		if (!mask)
+			return -ENOENT;
+	} else {
+		mask = cpu_possible_mask;
+	}
+
+	info->affinity = mask;
+	info->flags = IRQ_FWSPEC_INFO_AFFINITY_VALID;
+
+	return 0;
+}
+
 static const struct irq_domain_ops gic_irq_domain_ops = {
 	.translate = gic_irq_domain_translate,
 	.alloc = gic_irq_domain_alloc,
 	.free = gic_irq_domain_free,
 	.select = gic_irq_domain_select,
+	.get_fwspec_info = gic_irq_get_fwspec_info,
 };
 
 static int partition_domain_translate(struct irq_domain *d,
@@ -1839,6 +1888,7 @@ static int partition_domain_translate(struct irq_domain *d,
 static const struct irq_domain_ops partition_domain_ops = {
 	.translate = partition_domain_translate,
 	.select = gic_irq_domain_select,
+	.get_fwspec_info = gic_irq_get_fwspec_info,
 };
 
 static bool gic_enable_quirk_msm8996(void *data)
@@ -2231,6 +2281,9 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 		part_idx++;
 	}
 
+	gic_data.parts = parts;
+	gic_data.nr_parts = nr_parts;
+
 	for (i = 0; i < gic_data.ppi_nr; i++) {
 		unsigned int irq;
 		struct partition_desc *desc;
-- 
2.39.2


