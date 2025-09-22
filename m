Return-Path: <linux-acpi+bounces-17180-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D2EB8F82D
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 10:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0FE18A0C46
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 08:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E272FF67F;
	Mon, 22 Sep 2025 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXkHPPek"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FAD2FF64F;
	Mon, 22 Sep 2025 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529726; cv=none; b=Vi2oD9QxQ3NhezsgbzKPWbcJh+FIiia9ZTHtMcW6/4KYMYdFP5fykRipjcSMnrVxoJH/dKAcy4bXe6RPfGAH+88jECLc14aHGZtVh0Ygza44C6QzcxlF+l9mhqSJFJvabHsDXLTceIdy66OvDMb8o1CVXJzmMBuyGVf19KhXNwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529726; c=relaxed/simple;
	bh=hrdjbttIERspzlMoFY+iQP8wEfc0Gh3BVrQ9ANvnM70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7p55tJW9sNY7ei+e7RN5RC+TJ354dva7/5Swd9RFllbfB3l6CptqWtVVbJ5PhxhEO/EBid/o5tGVhfD3qIGP9y7ZfnR4fmLluHT+M8io/zoPR22rXeA6cZ0ZJNMjDyy9hKfkFtT3jDVo+qGqCj/+PxA7KN6U+S2TcEGjQX7XVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXkHPPek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D42C4CEF0;
	Mon, 22 Sep 2025 08:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758529725;
	bh=hrdjbttIERspzlMoFY+iQP8wEfc0Gh3BVrQ9ANvnM70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rXkHPPekoZAV2COy79vJqcaFIoe/D8Ov98smXf001V4JptGz2pZJ5iTx/kcoSluyZ
	 IQUR6D4GnMERSe4sbFQw5hDRd6cEUu0Qwn4dwYIGjbP+Ybg7w7UiF8LIgMpiPGqGGU
	 x39jrTDIkvXK+BXhgFU7K3abYHUEyTtrgQdYzrapPjtYi1EW117Pat8/2slJPaJEsL
	 1o0ehs1ZE0MfMvgS39yw7NFna4zzGLEG+oAf3pNJJGDmbh/GHTkShp7qxuqi8z/Xyp
	 xshfGi9gOwUsilCFNNto3FsTwppK4/dVgkbS9kalOwhjm6UJImTh+D6vJ3Pe6eNBmU
	 Bv4ay5u7m2K4A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1v0bud-00000008Kds-3xnr;
	Mon, 22 Sep 2025 08:28:44 +0000
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
Subject: [PATCH v3 08/26] perf: arm_pmu: Convert to new IRQ affinity retrieval API
Date: Mon, 22 Sep 2025 09:28:15 +0100
Message-ID: <20250922082833.2038905-9-maz@kernel.org>
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

Now that the relevant interrupt controllers are equipped with
a callback returning the affinity of per-CPU interrupts, switch
the OF side of the ARM PMU driver over to this new method.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/perf/arm_pmu_platform.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index 118170a5cedef..9c0494d8a867a 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -42,14 +42,13 @@ static int probe_current_pmu(struct arm_pmu *pmu,
 	return ret;
 }
 
-static int pmu_parse_percpu_irq(struct arm_pmu *pmu, int irq)
+static int pmu_parse_percpu_irq(struct arm_pmu *pmu, int irq,
+				const struct cpumask *affinity)
 {
-	int cpu, ret;
 	struct pmu_hw_events __percpu *hw_events = pmu->hw_events;
+	int cpu;
 
-	ret = irq_get_percpu_devid_partition(irq, &pmu->supported_cpus);
-	if (ret)
-		return ret;
+	cpumask_copy(&pmu->supported_cpus, affinity);
 
 	for_each_cpu(cpu, &pmu->supported_cpus)
 		per_cpu(hw_events->irq, cpu) = irq;
@@ -115,9 +114,12 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
 	}
 
 	if (num_irqs == 1) {
-		int irq = platform_get_irq(pdev, 0);
+		const struct cpumask *affinity;
+		int irq;
+
+		irq = platform_get_irq_affinity(pdev, 0, &affinity);
 		if ((irq > 0) && irq_is_percpu_devid(irq))
-			return pmu_parse_percpu_irq(pmu, irq);
+			return pmu_parse_percpu_irq(pmu, irq, affinity);
 	}
 
 	if (nr_cpu_ids != 1 && !pmu_has_irq_affinity(dev->of_node))
-- 
2.47.3


