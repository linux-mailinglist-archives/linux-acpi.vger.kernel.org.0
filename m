Return-Path: <linux-acpi+bounces-17181-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A04B8F833
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 10:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72E93AAB03
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 08:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34A22FFF8C;
	Mon, 22 Sep 2025 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLVA0Hrm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8B92FFF83;
	Mon, 22 Sep 2025 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529726; cv=none; b=ianfY+VFruZblFcEJnwTHrcjpSW8F+iiKRoXUtFuT9tkdjWdkRo8z0qgQtajXyZ0Eua6qYvX5QBHKEg/mrhCpwe2F3q6ymK+kW2/O9cKvy1/4dVgE8TVGZCmn7rwbb+WNlNtE+LL+GhiUCBdJ3lqh4jx7niSPle4lWc6NT6vH98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529726; c=relaxed/simple;
	bh=aWSBo2lHQR0VJHlGtar1XrtNXJ6RqCYZkbdnrUFDeQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kp5EYqNPmb0CDt1SOAppRKeKENKrADF/X9ZIRShYlMBcU2a9Sm3eCY6NUK8cyzCVE0JvmLCEsvA1WldnUvRdpP0VIQN78YKAY4apvlpH1OT9Amk3JorZGOIXhoYSVjaC41p2+0F6axVxkcIJXLegC8ELCFMd1tIERqY5pel6AXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLVA0Hrm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB0BC4CEF5;
	Mon, 22 Sep 2025 08:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758529726;
	bh=aWSBo2lHQR0VJHlGtar1XrtNXJ6RqCYZkbdnrUFDeQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lLVA0Hrm7LOPH2SJGYy26ZOqDAvlaKXQJDyb/5qXP9wJt00gXbMTxf4kC4Dq3Q3QT
	 l0GM0j0hZn0VMDXrTS96f/cjk6WtX36n7P4CSndXO0gUCPJ2c5XAUuOsZGxZ7Mdmdb
	 OxE81VWMW1b255zjN55prFVW7iz3dIYhFhmI8gCGd780iJU1xrmD+dSQLG6ljniZAg
	 hG6JTzxlJiXjRNa4IbbB07bQxPSsk9r0Dx3zfmmqlXPe7HuIKBvvuWLh9g6Qs73htf
	 B0Q/sDmZGFUvoOn9LGHrEKJsyfH3hugl3sO95/FAzQU0upRXzU/U1FdlReO5uGK1dC
	 qyDHDhpCTW9rA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1v0bue-00000008Kds-0zpg;
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
Subject: [PATCH v3 09/26] perf: arm_spe_pmu: Convert to new IRQ affinity retrieval API
Date: Mon, 22 Sep 2025 09:28:16 +0100
Message-ID: <20250922082833.2038905-10-maz@kernel.org>
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
the ARM SPE driver over to this new method.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/perf/arm_spe_pmu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 369e77ad5f13f..a1c86a1f21427 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -1211,8 +1211,10 @@ static void arm_spe_pmu_dev_teardown(struct arm_spe_pmu *spe_pmu)
 static int arm_spe_pmu_irq_probe(struct arm_spe_pmu *spe_pmu)
 {
 	struct platform_device *pdev = spe_pmu->pdev;
-	int irq = platform_get_irq(pdev, 0);
+	const struct cpumask *affinity;
+	int irq;
 
+	irq = platform_get_irq_affinity(pdev, 0, &affinity);
 	if (irq < 0)
 		return -ENXIO;
 
@@ -1221,10 +1223,7 @@ static int arm_spe_pmu_irq_probe(struct arm_spe_pmu *spe_pmu)
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


