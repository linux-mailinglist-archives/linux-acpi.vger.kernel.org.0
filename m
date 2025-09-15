Return-Path: <linux-acpi+bounces-16915-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F97EB573E2
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 11:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 360F77AB485
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 08:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1422F83A0;
	Mon, 15 Sep 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uw4sRLJY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A2B2F7ACA;
	Mon, 15 Sep 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926638; cv=none; b=u1LRq787ufu02iI+2CHmDmg3D6z+CIuMjsyXTF+RImfNxISoJ60CkhaEoCh5Ym+UbZNL1Xivan1lTogdYOYqABcaYHF2lekLVS6gHTMYSnTX8K1Eq3MolLRC0U+5d9YznWV6Wl4LUCFwqqrq2u27bVpOSstV7KRtxlLdeaKtVVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926638; c=relaxed/simple;
	bh=TmkHLg0e7YJMiml9l6eg+ELPovgCrjl75ki0cbExAjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YL8QC7FlXbksh2eWzof59m/RkE6BZs4lSjpX+rOwNfDebpJWTi2af/28LvFXqmJ3ZsCbiKJcGxJ6mHTdPudd32YamvqFvqz++mHR2sPO7KIaykzFcBVC+gyaeA3m1yAU/INfTZJX+jOn0InWlPJZuRt7K3mn9upau0ELqr+z1v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uw4sRLJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB434C4CEFB;
	Mon, 15 Sep 2025 08:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926638;
	bh=TmkHLg0e7YJMiml9l6eg+ELPovgCrjl75ki0cbExAjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uw4sRLJYbO9/7+Cq4OHlqG2QRyfv9rLjY9e/5esK6iQNUxi69otS1zmXwoLYaCiPA
	 dacAs/yXQdDFcqYRDdjhGciO8pt9jujmEq/o87UAtmt0eL2P0YLC8Kl0FKgFUbsIpV
	 c1iRvjSJVA8RoegK+VRQpzOnDu3Wn4kRngHlDihPS3qwLRoz5vOESpLEaT4NllPl+e
	 BKypyLbq3XYO7miYoDklj6i45bSOQQntFqh3V8CYaM6lVaZkNLwlSvLQONH7H65Rfx
	 TpyMWos1F1rRbFtQaaL0JyDGCtMgvii9Br1rITzQ5ephDujBLEXnl54xNjTuOSBgCY
	 VC95dIKzXi5mg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uy51Q-00000006IHP-3mQz;
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
Subject: [PATCH v2 22/25] irqchip/apple-aic: Drop support for custom PMU irq partitions
Date: Mon, 15 Sep 2025 09:56:59 +0100
Message-Id: <20250915085702.519996-23-maz@kernel.org>
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
2.39.2


