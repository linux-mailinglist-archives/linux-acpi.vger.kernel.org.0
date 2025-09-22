Return-Path: <linux-acpi+bounces-17194-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A366EB8F87E
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 10:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B653B42D4
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 08:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A94E304BD7;
	Mon, 22 Sep 2025 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+0rHNCu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F79304982;
	Mon, 22 Sep 2025 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529730; cv=none; b=f+PKF9Btuxg01yr7ZYrst6by4Z7HnI09ZE5/l8sYZR7B3kjG1LSmjYALFIozeN8FX/qbwnnOaQTrmv2AsZw59DfF3R2OucJdhpm2t0bKC1Ozx/5rkLkRmZzcognelScOqUT7QGKUKakFXUE7yPcGE4MBMTQXqsIps4cw0rQEemY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529730; c=relaxed/simple;
	bh=VdHLzjxPctdzw7v/CwtNrG0e3DgB4aoWVfgqEs1pc7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uV07qLWzrTrj4LLHanKLlIp5CcWOKzYgx77LdeyH3qqP6Hk+vhcFEjBA/7eQj9YG5YBDYljrj0OA0Q5GrEzcdCzQPaw7l6t6Utpnu6Ofsn5s4gnjrHpPpbTiqc60+AgIdOnc0btZ5HY4VwRPLXEepWV6QoHiSyPcg02+5XpxGM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+0rHNCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5ACCC4CEF0;
	Mon, 22 Sep 2025 08:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758529729;
	bh=VdHLzjxPctdzw7v/CwtNrG0e3DgB4aoWVfgqEs1pc7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I+0rHNCuAarGwwcHKAI6lHBF3NRJZTmoMjB/mhcwyo66OvZbMxH+LFeGIcSk3CDup
	 6NG1BhJFxOOEiZ9PZlMFVJQxAskoBIEhIBAyMGYmTxJPl52hbwVPDL2EzQc2+kkS28
	 30yFNbTjjZFQTQ+Dk3Uq7vn0nkqylAQqJXNsuVT5rQ4zf4chKvumybQ9IQbQO7BR61
	 zB4A7SfMgHcg7BJPyWnbHLKtJwaVwQjnt+NVsQIfNifZTyQ/pDa3tutgMe+zYdRelV
	 QU9a9yJoGcUzqHcC7Hq7bVsmAHUxagwpwwetedB7cUZk+7V7yfcXQivwNV6ijv2uVM
	 Aex+6zdDkfOLg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1v0buh-00000008Kds-47XW;
	Mon, 22 Sep 2025 08:28:48 +0000
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
Subject: [PATCH v3 22/26] irqchip/apple-aic: Drop support for custom PMU irq partitions
Date: Mon, 22 Sep 2025 09:28:29 +0100
Message-ID: <20250922082833.2038905-23-maz@kernel.org>
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

Similarly to what has been done for GICv3, drop the irq partitioning
support from the AIC driver, effectively merging the two per-cpu
interrupts for the PMU.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-apple-aic.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index cb8b6f40ce8d3..6305d25b9e77b 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -578,16 +578,9 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 	}
 
 	if ((read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & (PMCR0_IMODE | PMCR0_IACT)) ==
-			(FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_FIQ) | PMCR0_IACT)) {
-		int irq;
-		if (cpumask_test_cpu(smp_processor_id(),
-				     &aic_irqc->fiq_aff[AIC_CPU_PMU_P]->aff))
-			irq = AIC_CPU_PMU_P;
-		else
-			irq = AIC_CPU_PMU_E;
+			(FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_FIQ) | PMCR0_IACT))
 		generic_handle_domain_irq(aic_irqc->hw_domain,
-					  AIC_FIQ_HWIRQ(irq));
-	}
+					  AIC_FIQ_HWIRQ(AIC_CPU_PMU_P));
 
 	if (static_branch_likely(&use_fast_ipi) &&
 	    (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ) &&
@@ -632,18 +625,7 @@ static int aic_irq_domain_map(struct irq_domain *id, unsigned int irq,
 				    handle_fasteoi_irq, NULL, NULL);
 		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
 	} else {
-		int fiq = FIELD_GET(AIC_EVENT_NUM, hw);
-
-		switch (fiq) {
-		case AIC_CPU_PMU_P:
-		case AIC_CPU_PMU_E:
-			irq_set_percpu_devid_partition(irq, &ic->fiq_aff[fiq]->aff);
-			break;
-		default:
-			irq_set_percpu_devid(irq);
-			break;
-		}
-
+		irq_set_percpu_devid(irq);
 		irq_domain_set_info(id, irq, hw, &fiq_chip, id->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
 	}
@@ -732,6 +714,10 @@ static int aic_irq_domain_translate(struct irq_domain *id,
 				break;
 			}
 		}
+
+		/* Merge the two PMUs on a single interrupt */
+		if (*hwirq == AIC_CPU_PMU_E)
+			*hwirq = AIC_CPU_PMU_P;
 		break;
 	default:
 		return -EINVAL;
-- 
2.47.3


