Return-Path: <linux-acpi+bounces-17982-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DEFBF1302
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 14:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9523A4F4C05
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 12:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786D531986F;
	Mon, 20 Oct 2025 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oup1IVIo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296313191D7;
	Mon, 20 Oct 2025 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963412; cv=none; b=CUaNf/LjEiaBJDSjFUhrYuSoKnM5gWrgSUjZrdwl+jF6kuNZPkznkh8X0kYf86Edm08vZ5X7ARXRVlEuk1zaQt1DOg3GNHipRK+TJvvjIp6uJBzlzDISTVzSOj3TpXM52XMCSeyeDUlQD1QY0BP0CRaAbVVBRO5uCYJRYCFs94c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963412; c=relaxed/simple;
	bh=WQ1KbYH73pkv7difN/iSChS2f39lIQHsS0IK9hv/d9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anXUqJb56mokR/4p6pVW0At4bq0+bPTn1XY71YNmh6Uy4ra9HDpbOIT+gN+QAZhnmUmRfjWJ8ZUZviX9vArJb6zF42EOh4YHRBVwLNrKvczNblwjBWdw9XcU85qpVsN81Tdz2rppxC1idvsTEN1xpBZS5+4eTrgFHvly19j2WPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oup1IVIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32A2C116B1;
	Mon, 20 Oct 2025 12:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760963411;
	bh=WQ1KbYH73pkv7difN/iSChS2f39lIQHsS0IK9hv/d9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oup1IVIom8Usan9IszwBgDXvWPjVMOoABwyZ6Fg32uCyEX2c0gzWwLlh69ASMVifs
	 yOow+zoKOocgvVTv/e8iyGsZK+FhRvS+9cFdZHW6+TEf9ZSn4eFIY/EMeGa///RM4U
	 y7bT6wM1aOylbKHPyJqGeg1wpjuhTPCOaHxeW6lRSX5Ek9f6go16YHfgHrAm6CrQL9
	 xgDGKLBlGo8WpcM/L4/duob7XRmGLNoc8p2zKPTbpQNIA6IN3+Rn4sMzhn1YNt0pPn
	 OKo85Z9D0ilpSiLmICSGJHKKZU3cbTfOnwtRdLosrchQQes/8eqMgV7RFyLWz1hd8U
	 1kznQfrSB4P9g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vAp1d-0000000FUu2-3utc;
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
Subject: [PATCH v4 09/26] perf: arm_spe_pmu: Convert to new IRQ affinity retrieval API
Date: Mon, 20 Oct 2025 13:29:26 +0100
Message-ID: <20251020122944.3074811-10-maz@kernel.org>
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

Now that the relevant interrupt controllers are equipped with
a callback returning the affinity of per-CPU interrupts, switch
the ARM SPE driver over to this new method.

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Tested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/perf/arm_spe_pmu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index fa50645feddad..1460b02d20e8b 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -1287,8 +1287,10 @@ static void arm_spe_pmu_dev_teardown(struct arm_spe_pmu *spe_pmu)
 static int arm_spe_pmu_irq_probe(struct arm_spe_pmu *spe_pmu)
 {
 	struct platform_device *pdev = spe_pmu->pdev;
-	int irq = platform_get_irq(pdev, 0);
+	const struct cpumask *affinity;
+	int irq;
 
+	irq = platform_get_irq_affinity(pdev, 0, &affinity);
 	if (irq < 0)
 		return -ENXIO;
 
@@ -1297,10 +1299,7 @@ static int arm_spe_pmu_irq_probe(struct arm_spe_pmu *spe_pmu)
 		return -EINVAL;
 	}
 
-	if (irq_get_percpu_devid_partition(irq, &spe_pmu->supported_cpus)) {
-		dev_err(&pdev->dev, "failed to get PPI partition (%d)\n", irq);
-		return -EINVAL;
-	}
+	cpumask_copy(&spe_pmu->supported_cpus, affinity);
 
 	spe_pmu->irq = irq;
 	return 0;
-- 
2.47.3


