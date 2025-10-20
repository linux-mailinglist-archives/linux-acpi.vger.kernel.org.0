Return-Path: <linux-acpi+bounces-17979-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CFACEBF12F3
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 14:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B9B64F4B51
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 12:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805FD3176E7;
	Mon, 20 Oct 2025 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RO5U1IzO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B5E313523;
	Mon, 20 Oct 2025 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963411; cv=none; b=jM7GBmbAWdENDVOqsGzWBpSPc4j3wIp8WbpOxRreTOOeAnfisKtYiI7gZGB9q6Cn2ykndVKrfrFarwfZSVz3GRL0T5dYaU3s/oZBfqhiTUqq7joiTO74Sf/RjK5ewxjET9H5pISIkwvIvr1+RaiuTWQc2A9d01Pap4KHIbRglhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963411; c=relaxed/simple;
	bh=Qt273pw+MN6rE7hFzvmJUPrGSE98e5wVy5jP/E+uQbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRmK4o2HkxO3fG/yj4Hu2ZcufVLQu4IZvk292UIvcc28bXejG5dzdymrbkJFCzkSDX0KEUA0WRtt6R1b6p5EsoXh2tQHu16Dus5FgW8y3pxgd878V6eKT+rZnEsU8pxMLBM4f4PrQeMRyzdMkanSkcZdMD5nHTV3Bf7f4RezD8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RO5U1IzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0AEC19422;
	Mon, 20 Oct 2025 12:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760963410;
	bh=Qt273pw+MN6rE7hFzvmJUPrGSE98e5wVy5jP/E+uQbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RO5U1IzObhruD9T6sWbYuFAYXCscBY7XUlCDtXK2X95pC9dewhOnpk00RkVlPpWdw
	 atZyGTomiErROMwylQVPI7+GdXKSsyQqxJmxaM73Ap3zEsLpDWIcMzbV1R7ZhBTSCh
	 9URLWAAhRc88HIDLQfJmtfsnaz3v4Umshs3Du+IyDo+XLhImcTtnrMrBO6w4krxUZp
	 05pk2KSX9KUqeE85Aib4QMbKEVOdenF29/CE+Wjfy7JZ+ZolyUtNCT2LClckK1eVUv
	 Tmp2MYkCNEJ5RDQdJXllezB59N9bVoPukOgbcTNw2QX9yAHo3ns2YDN83FFr7yyU6D
	 83Je3CekjyEsA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vAp1c-0000000FUu2-494k;
	Mon, 20 Oct 2025 12:30:09 +0000
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
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>
Subject: [PATCH v4 06/26] irqchip/apple-aic: Add FW info retrieval support
Date: Mon, 20 Oct 2025 13:29:23 +0100
Message-ID: <20251020122944.3074811-7-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020122944.3074811-1-maz@kernel.org>
References: <20251020122944.3074811-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, tglx@linutronix.de, mark.rutland@arm.com, will@kernel.org, rafael@kernel.org, robh@kernel.org, saravanak@google.com, gregkh@linuxfoundation.org, sven@kernel.org, j@jannau.net, suzuki.poulose@arm.com, james.clark@linaro.org, jonathan.cameron@huawei.com, ruanjinjie@huawei.com, alexandru.elisei@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Plug the new .get_fwspec_info() callback into the Apple AIC driver,
using some of the existing FIQ affinity handling infrastructure.

Acked-by: Sven Peter <sven@kernel.org>
Tested-by: Will Deacon <will@kernel.org>
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


