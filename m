Return-Path: <linux-acpi+bounces-17984-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABF6BF13AA
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 14:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2FE420BA6
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 12:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD57031A576;
	Mon, 20 Oct 2025 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4/OrMQp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893CE230996;
	Mon, 20 Oct 2025 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963412; cv=none; b=i5uGlipfKQ/WQOzHm4xBKx6KeGzgwpBvYsYOMzGl4DQWGhL0T21d1L31O/znd4HMTc85tXjutpsWyblmpgk4B+7UHf3zCwQaAhWjFW4VPrjEDeTNC5MJYRliIHpDwOK7tedoycnK9/2tHo3BTYCBpvjeHAvBOuzXDnJAR77WR1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963412; c=relaxed/simple;
	bh=NdsJ0/5jFp68eUG2zA5xcbbdbGYt8W71X/7TRQqfH4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYy+lYyhVitb9libk7ZTeZADaClXFrqWVJE4SbMpGrqjQcB1aJzOkgWQ0TYWH7Ex22TYxz3mQuREip7GkSkk5N6zrrU7jUPwiALZAMSj1NWA0WDgl1PKbMPmh8EeYlWOS8rImW9AHkrg2AnuPz4M+OoGAbd15bwQoKp4JRUkm3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4/OrMQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE0EC116D0;
	Mon, 20 Oct 2025 12:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760963412;
	bh=NdsJ0/5jFp68eUG2zA5xcbbdbGYt8W71X/7TRQqfH4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k4/OrMQpERFhX7s9y836KmhhWWPN7VQv+4Ez7o2ar87qbEZwF2HUHJhWIKTxv8COO
	 mORU/ULMldeBE9wyuDgHxZ5Sp3BKaLjpephmd5HB1p5n7FwgtU6vpPVPgKnnVVWpsi
	 clfxxV4/ZRQRx6INLf7ndNIPqSmauDy1MXQFECa0xNo/BB8yWJ0aiFt/ag5ymmmy7i
	 PgG1+gchpg5VSw8C9pBrpQ/hoSbhBclfxJj4nsfgTHMzmGDz92DU8iUZ2sTTnozBmk
	 c7euD6vTSEUmyfhshFXjIz6EYN0SWCV1NHOCF6Ee2MZkwd347FHvO2k+gqA6G0dJUq
	 nRe/cXUXrASAA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vAp1e-0000000FUu2-0zRC;
	Mon, 20 Oct 2025 12:30:10 +0000
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
Subject: [PATCH v4 10/26] irqchip/gic-v3: Switch high priority PPIs over to handle_percpu_devid_irq()
Date: Mon, 20 Oct 2025 13:29:27 +0100
Message-ID: <20251020122944.3074811-11-maz@kernel.org>
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

It so appears that handle_percpu_devid_irq() is extremely similar to
handle_percpu_devid_fasteoi_nmi(), and that the differences do no
justify the horrid machinery we have in the GICv3 driver to handle
the flow handler switch.

Let's stick with the standard flow handler, even for NMIs.

Suggested-by: Will Deacon <will@kernel.org>
Tested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 54 ++----------------------------------
 1 file changed, 2 insertions(+), 52 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index cf0ba83c6eda6..dd2d6d722fc5e 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -230,9 +230,6 @@ static void __init gic_prio_init(void)
 		!cpus_have_group0);
 }
 
-/* rdist_nmi_refs[n] == number of cpus having the rdist interrupt n set as NMI */
-static refcount_t *rdist_nmi_refs;
-
 static struct gic_kvm_info gic_v3_kvm_info __initdata;
 static DEFINE_PER_CPU(bool, has_rss);
 
@@ -608,24 +605,6 @@ static u32 __gic_get_ppi_index(irq_hw_number_t hwirq)
 	}
 }
 
-static u32 __gic_get_rdist_index(irq_hw_number_t hwirq)
-{
-	switch (__get_intid_range(hwirq)) {
-	case SGI_RANGE:
-	case PPI_RANGE:
-		return hwirq;
-	case EPPI_RANGE:
-		return hwirq - EPPI_BASE_INTID + 32;
-	default:
-		unreachable();
-	}
-}
-
-static u32 gic_get_rdist_index(struct irq_data *d)
-{
-	return __gic_get_rdist_index(d->hwirq);
-}
-
 static int gic_irq_nmi_setup(struct irq_data *d)
 {
 	struct irq_desc *desc = irq_to_desc(d->irq);
@@ -646,20 +625,8 @@ static int gic_irq_nmi_setup(struct irq_data *d)
 		return -EINVAL;
 
 	/* desc lock should already be held */
-	if (gic_irq_in_rdist(d)) {
-		u32 idx = gic_get_rdist_index(d);
-
-		/*
-		 * Setting up a percpu interrupt as NMI, only switch handler
-		 * for first NMI
-		 */
-		if (!refcount_inc_not_zero(&rdist_nmi_refs[idx])) {
-			refcount_set(&rdist_nmi_refs[idx], 1);
-			desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
-		}
-	} else {
+	if (!gic_irq_in_rdist(d))
 		desc->handle_irq = handle_fasteoi_nmi;
-	}
 
 	gic_irq_set_prio(d, dist_prio_nmi);
 
@@ -686,15 +653,8 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
 		return;
 
 	/* desc lock should already be held */
-	if (gic_irq_in_rdist(d)) {
-		u32 idx = gic_get_rdist_index(d);
-
-		/* Tearing down NMI, only switch handler for last NMI */
-		if (refcount_dec_and_test(&rdist_nmi_refs[idx]))
-			desc->handle_irq = handle_percpu_devid_irq;
-	} else {
+	if (!gic_irq_in_rdist(d))
 		desc->handle_irq = handle_fasteoi_irq;
-	}
 
 	gic_irq_set_prio(d, dist_prio_irq);
 }
@@ -2080,19 +2040,9 @@ static const struct gic_quirk gic_quirks[] = {
 
 static void gic_enable_nmi_support(void)
 {
-	int i;
-
 	if (!gic_prio_masking_enabled() || nmi_support_forbidden)
 		return;
 
-	rdist_nmi_refs = kcalloc(gic_data.ppi_nr + SGI_NR,
-				 sizeof(*rdist_nmi_refs), GFP_KERNEL);
-	if (!rdist_nmi_refs)
-		return;
-
-	for (i = 0; i < gic_data.ppi_nr + SGI_NR; i++)
-		refcount_set(&rdist_nmi_refs[i], 0);
-
 	pr_info("Pseudo-NMIs enabled using %s ICC_PMR_EL1 synchronisation\n",
 		gic_has_relaxed_pmr_sync() ? "relaxed" : "forced");
 
-- 
2.47.3


