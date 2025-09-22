Return-Path: <linux-acpi+bounces-17177-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CFFB8F824
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 10:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E8617252A
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 08:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90082FF165;
	Mon, 22 Sep 2025 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAlC7Idj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928E42FF141;
	Mon, 22 Sep 2025 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529725; cv=none; b=TgVXOrx51ZGeYjd/Vj06Y8JJUmD6AaHe7deyAnfZArAsTb6TL3ISs+81B3ZPyfZOsztdWmZ+JWCTApoTKl5uWRKZu12skQju+VfzMrgYTu3+XmH9e3rJsIFUJCNYjmejEXWdZDzI7QjsTpCiN2Gp/6x9OzXbsxawradzq8y/42g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529725; c=relaxed/simple;
	bh=Lteyum6sORsX/ORFwgAmQ1CfkVj7VaM8cFC9100KNAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rr4uRApjPlYmrUO5jzhIWOD1huYRssC+fR9rL+wA+FdLM10wU9uYtJ8yll3FXKADRaS2SAEURRpqvXcOwGOEYgDk3gOcxoGCn0Qh9IXhzaqk6/LmGNt8zz9Aw9EH3SU8YpjZJHMSMRiy4bh4iLEmm4xDiXH//3p+17DzxGd9bnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAlC7Idj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1E9C4CEF0;
	Mon, 22 Sep 2025 08:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758529725;
	bh=Lteyum6sORsX/ORFwgAmQ1CfkVj7VaM8cFC9100KNAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WAlC7IdjkueDZd9RKSjdPgM//0FrH3HoKvQA7ESMD7o+rATw7VpfSQrigXiUqCrBY
	 VZsGeOMgl6oHKLoxh/S2XEGoRLwpCF2RU9YQ/PxSchiFPktF3SjWf7R8mGDUHKPMQW
	 hoXbf9RsTcMpCF59nGRm9N99B1TyYWssUG4F8rtXdPaEXLCStNclRDR+LmMAQpfj8N
	 1UqkpiTzAaacKZxYImR8bAsHIwUBeLdMREtyRhspgar2aPzX8eWYeIPGiCw4s7Se+T
	 xIlm+AZ09pPoR3BjfrE5UUP/IvgMjzVasjjO4irJ9CKroThTSEMLjcIn7W+V2eyZi4
	 zdaMgyRrtlP9A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1v0bud-00000008Kds-1aCe;
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
Subject: [PATCH v3 06/26] irqchip/apple-aic: Add FW info retrieval support
Date: Mon, 22 Sep 2025 09:28:13 +0100
Message-ID: <20250922082833.2038905-7-maz@kernel.org>
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

Plug the new .get_fwspec_info() callback into the Apple AIC driver,
using some of the existing FIQ affinity handling infrastructure.

Acked-by: Sven Peter <sven@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-apple-aic.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 032d66dceb8ec..cb8b6f40ce8d3 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -651,6 +651,33 @@ static int aic_irq_domain_map(struct irq_domain *id, unsigned int irq,
 	return 0;
 }
 
+static int aic_irq_get_fwspec_info(struct irq_fwspec *fwspec, struct irq_fwspec_info *info)
+{
+	const struct cpumask *mask;
+	u32 intid;
+
+	info->flags = 0;
+	info->affinity = NULL;
+
+	if (fwspec->param[0] != AIC_FIQ)
+		return 0;
+
+	if (fwspec->param_count == 3)
+		intid = fwspec->param[1];
+	else
+		intid = fwspec->param[2];
+
+	if (aic_irqc->fiq_aff[intid])
+		mask = &aic_irqc->fiq_aff[intid]->aff;
+	else
+		mask = cpu_possible_mask;
+
+	info->affinity = mask;
+	info->flags = IRQ_FWSPEC_INFO_AFFINITY_VALID;
+
+	return 0;
+}
+
 static int aic_irq_domain_translate(struct irq_domain *id,
 				    struct irq_fwspec *fwspec,
 				    unsigned long *hwirq,
@@ -753,6 +780,7 @@ static const struct irq_domain_ops aic_irq_domain_ops = {
 	.translate	= aic_irq_domain_translate,
 	.alloc		= aic_irq_domain_alloc,
 	.free		= aic_irq_domain_free,
+	.get_fwspec_info = aic_irq_get_fwspec_info,
 };
 
 /*
-- 
2.47.3


