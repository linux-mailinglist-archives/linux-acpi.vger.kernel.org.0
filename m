Return-Path: <linux-acpi+bounces-16480-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BA9B4955C
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 18:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A874188B8D5
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 16:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA8D30FC36;
	Mon,  8 Sep 2025 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZGJjwXa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7843430FC23;
	Mon,  8 Sep 2025 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349109; cv=none; b=exOcVo3c7M7HqpXzYVNjiWuB+f0AxGDaqzawQQO63/xrsq4mSETkoUAo6Pnw3CdIHdNRJX9jkd86bHAxK5/HP8JCXo8FGLW3OEHbLL6dD4V3gN2Pcz7Dv9jhzvq3FgEZGorETN+XceTj0bEpJfS4xf6YtLWI7LnZ2JNM9r0GU+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349109; c=relaxed/simple;
	bh=t2t1XQhmTu4QwWw1Mvj257XNXGFyRkE9ARKAhPe4oJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=arvwUjG6OJMKiydBIra5p2ppBCW2Q26n7yBVOn7TqylLkWDIKtDAiA0fZRU5ZxJJV+dqM19hAnzU2gt5vVizRSMJlNeWrT900riKh2rKEBrV7psjsH0W9oEwxIGVEabH2Kry0zmW9xCzM8+BU6k4pmJ8tMXmGKDATdFKKUdoCZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZGJjwXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97C6C4CEFA;
	Mon,  8 Sep 2025 16:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757349109;
	bh=t2t1XQhmTu4QwWw1Mvj257XNXGFyRkE9ARKAhPe4oJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PZGJjwXa4GgFgzXH4FhpcpgeXYYGFHaTE8JKKorNoWhuxqrV+ph71/Wxqz50OWlym
	 fYMU32cIM91+bFkjMDOQh8oFz9ZMg7qtYCcw0Gh/feKnM2DcicJ3IXiX72tXZl6FtB
	 oAqZh0l0J5XNQB5Eb/jRHZ/tdlktjD0U4tA8+UkfAFxgRj4Pi9lrXQEJtzahwgAcU5
	 TXtMJRHerwY2TRCDoWozvylBTU3zuZmX/iOb5/cu3dMuqgWpFo1T7O9Yl9527BBE7g
	 Z2JJIVGdpT0+j59lajuZtnE4WumAelcS87NXt2JF8JOiGAdRNzv9QZyfBLrb0T5pSY
	 Qu7riyUNDJKTg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uvemQ-00000004NTm-3YV5;
	Mon, 08 Sep 2025 16:31:46 +0000
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
Subject: [PATCH 05/25] irqchip/gic-v3: Add FW info retrieval support
Date: Mon,  8 Sep 2025 17:31:07 +0100
Message-Id: <20250908163127.2462948-6-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250908163127.2462948-1-maz@kernel.org>
References: <20250908163127.2462948-1-maz@kernel.org>
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
 drivers/irqchip/irq-gic-v3.c | 55 ++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index dbeb85677b08c..4a90dbf9daedb 100644
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
@@ -1796,11 +1798,60 @@ static int gic_irq_domain_select(struct irq_domain *d,
 	return d == partition_get_domain(gic_data.ppi_descs[ppi_idx]);
 }
 
+static int gic_irq_get_info(struct irq_fwspec_info *info)
+{
+	struct irq_fwspec *fwspec = &info->fwspec;
+	const struct cpumask *mask = NULL;
+
+	info->flags = 0;
+	info->affinity = NULL;
+
+	/* ACPI is not capable of describing PPI affinity -- yet */
+	if (!is_of_node(fwspec->fwnode))
+		goto out;
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
+			goto out;
+		}
+
+		fw = of_node_to_fwnode(of_find_node_by_phandle(fwspec->param[3]));
+		if (!fw)
+			goto out;
+
+		for (int i = 0; i < gic_data.nr_parts; i++) {
+			if (gic_data.parts[i].partition_id == fw) {
+				mask = &gic_data.parts[i].mask;
+				break;
+			}
+		}
+
+		if (!mask)
+			goto out;
+	} else {
+		mask = cpu_possible_mask;
+	}
+
+	info->affinity = mask;
+	info->flags = (IRQ_FWSPEC_INFO_FWSPEC_VALID |
+		       IRQ_FWSPEC_INFO_AFFINITY_VALID);
+out:
+	return 0;
+}
+
 static const struct irq_domain_ops gic_irq_domain_ops = {
 	.translate = gic_irq_domain_translate,
 	.alloc = gic_irq_domain_alloc,
 	.free = gic_irq_domain_free,
 	.select = gic_irq_domain_select,
+	.get_info = gic_irq_get_info,
 };
 
 static int partition_domain_translate(struct irq_domain *d,
@@ -1839,6 +1890,7 @@ static int partition_domain_translate(struct irq_domain *d,
 static const struct irq_domain_ops partition_domain_ops = {
 	.translate = partition_domain_translate,
 	.select = gic_irq_domain_select,
+	.get_info = gic_irq_get_info,
 };
 
 static bool gic_enable_quirk_msm8996(void *data)
@@ -2231,6 +2283,9 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
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


