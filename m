Return-Path: <linux-acpi+bounces-16478-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92288B4955B
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 18:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA443AB2B8
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 16:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5779E30FC16;
	Mon,  8 Sep 2025 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvqGokMq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3E930FC02;
	Mon,  8 Sep 2025 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349109; cv=none; b=I7uIBqh1kAB8qDXAcSOhmJLhoYqfqbdqv5GxjGdJz5MKXPIxyQlmGWoQZOw5gjHW+bYxeE+GlZ22BvLOFdSRK6+/cszoKERtbj+xWiszq4hBczPqrc6ZX2GSWuCwGL9z8bOpin6dMM+IudL00a4hcXEFeBXXKgxqfnjmLw9FIiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349109; c=relaxed/simple;
	bh=UgM/OqUibOh9R2u8nSkBg+Ss9N12aimxIdS7tXj+GS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bDuqaFhNchBb5B4a496aLEGfEIw9mFfTvdTGkoU6CM5GvwcsYyu+HnXjfHjuLLS69A7fFPlmZNYoIU+oZ6MwUswNvTS041vJYYeoxcpUH6UBlAhc21Jy1vFkie+5PzOflwPBAIbnFja+93P0+60B1ngwuhgDnnJP0oFglokSv3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvqGokMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081DDC4CEF9;
	Mon,  8 Sep 2025 16:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757349109;
	bh=UgM/OqUibOh9R2u8nSkBg+Ss9N12aimxIdS7tXj+GS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YvqGokMqYuzQK5qItVr7GesEOxxrfiRvN/NEUPnLtbx0PXK5Ho4pWEiHiyDJiA1F2
	 y2oEWjY5WpXqXovP8S2VZiqMkx78MtClRNYj/5KKmKVM7puNQPHoYGrlMxjPuxZTRo
	 3wTrsB45/T7LpyffrkbBMX3Jy+xn0yFGPANpdiJ6fzSqSjkAnTTzvgIYJRuJk050E7
	 OiE+IFIO/8ggFTL3T9QX9f1w32TOY3QxsHGXgshVRTIb9qS97bg8W6QxPkNmMeXJ2V
	 tBNiprX8A8W56C+QpMyGPLTk7fKnBMgNTsRaQSVvKe0PvTHB/9ZX/Q63LnAnKA9yuY
	 9J/8raovlu3Tg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uvemR-00000004NTm-0XAg;
	Mon, 08 Sep 2025 16:31:47 +0000
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
Subject: [PATCH 06/25] irqchip/apple-aic: Add FW info retrieval support
Date: Mon,  8 Sep 2025 17:31:08 +0100
Message-Id: <20250908163127.2462948-7-maz@kernel.org>
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

Plug the new .get_info() callback into the Apple AIC driver,
using some of the existing FIQ affinity handling infrastructure.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-apple-aic.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 032d66dceb8ec..dd89e50a72e83 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -651,6 +651,36 @@ static int aic_irq_domain_map(struct irq_domain *id, unsigned int irq,
 	return 0;
 }
 
+static int aic_irq_get_info(struct irq_fwspec_info *info)
+{
+	struct irq_fwspec *fwspec = &info->fwspec;
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
+
+	info->flags = (IRQ_FWSPEC_INFO_FWSPEC_VALID |
+		       IRQ_FWSPEC_INFO_AFFINITY_VALID);
+
+	return 0;
+}
+
 static int aic_irq_domain_translate(struct irq_domain *id,
 				    struct irq_fwspec *fwspec,
 				    unsigned long *hwirq,
@@ -753,6 +783,7 @@ static const struct irq_domain_ops aic_irq_domain_ops = {
 	.translate	= aic_irq_domain_translate,
 	.alloc		= aic_irq_domain_alloc,
 	.free		= aic_irq_domain_free,
+	.get_info	= aic_irq_get_info,
 };
 
 /*
-- 
2.39.2


