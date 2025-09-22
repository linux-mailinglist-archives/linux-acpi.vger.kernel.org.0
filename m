Return-Path: <linux-acpi+bounces-17178-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EF9B8F827
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 10:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A539174249
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 08:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94E92FF642;
	Mon, 22 Sep 2025 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oX1fLqJE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19582FF151;
	Mon, 22 Sep 2025 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529725; cv=none; b=fZFF0EP8rJmcG5ymsGa9QYaqDQEKNXmQKLQ2fRSJJ8SqQSpXxaDd2Owt/ROOzm9tkDoivDODu/eefX3cmBZd1A/FlRk2sj2Ayx9stlGmLGpbIDpYvM74FTZ6Rk4YszQh0whcSzhe2FtvbMQBdvxwbVwPXFVNeGx/Idi/VXseMms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529725; c=relaxed/simple;
	bh=5IBVXncBJM26KBDVMYIUqVm5RyJ3XQl6A/mbG+QlK9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C00I9zfIt5C11+gcUYOc3/vfyVBa71oLq8h4BRfUYeJMYeneBprU8anqdEOmaGkkkJ6AKwXv4+i5V+7rwtSiToQBO4liQekXDOUIUB8waJj5ie4SHEIt1luuRlssbzbumdJ4EsBgniSlZlo/JoVPGUyxVbCvmOZme2UZLFJ359I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oX1fLqJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2A8C116B1;
	Mon, 22 Sep 2025 08:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758529725;
	bh=5IBVXncBJM26KBDVMYIUqVm5RyJ3XQl6A/mbG+QlK9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oX1fLqJEwsS3j2MUHRThVKoYjSlFOCw5Vzzv+l5JZsWhB0jOGXpEn50JjeiPZk1TR
	 eetVE0jRiWNbT/jzI4OPBGFO9TpOOUItkgBLhnLp7irks8MzDVTEn0d14j1bSvj64G
	 I60XQaW4YSKZPk+cAa3r7On243LEOiDWRyrXriKydi13vikcj9xljq7va4m1dQAPAk
	 CtWzOXU0OFZBvEjGdbAKUyH4GCPBXjBzmCw6EmjUhNc5tOX71z6qIzfNSVCO3Xjvcd
	 YuAutRDZv6cIs8i8pXbMaGMoaT521ZNDWNHWmeSlfdNWuPlfkbQJm0n/WQIU9z/+k5
	 koocJZTyWM2eg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1v0bud-00000008Kds-0NMH;
	Mon, 22 Sep 2025 08:28:43 +0000
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
	James Clark <james.clark@linaro.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v3 05/26] irqchip/gic-v3: Add FW info retrieval support
Date: Mon, 22 Sep 2025 09:28:12 +0100
Message-ID: <20250922082833.2038905-6-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922082833.2038905-1-maz@kernel.org>
References: <20250922082833.2038905-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, tglx@linutronix.de, mark.rutland@arm.com, will@kernel.org, rafael@kernel.org, robh@kernel.org, saravanak@google.com, gregkh@linuxfoundation.org, sven@kernel.org, j@jannau.net, suzuki.poulose@arm.com, james.clark@linaro.org, jonathan.cameron@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Plug the new .get_fwspec_info() callback into the GICv3 core driver,
using some of the existing PPI affinity handling infrastructure.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 53 ++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index dbeb85677b08c..23ef0c285f30b 100644
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
+		fw = of_fwnode_handle(of_find_node_by_phandle(fwspec->param[3]));
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
2.47.3


