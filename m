Return-Path: <linux-acpi+bounces-16483-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C87EB49561
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 18:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3785188CF9C
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 16:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528F33101C5;
	Mon,  8 Sep 2025 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvnvrwSM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3493101AD;
	Mon,  8 Sep 2025 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349110; cv=none; b=khWAUcann9+EHBkZHuW4DTRM9Njm234+a/ijXkPw9GQfG5TETwyOqPDLn7/f6wXorjlXXpD8XCojzXLutq+XnBjLGojETYcYtFL0TZPN9/PSxFpmL7Ii74Hd82ih/ZEzgAfL6L6nXF89iv8WA2zrCREyV0HIusM1bsR3n4l/uss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349110; c=relaxed/simple;
	bh=BXehqBShX490v3aAs4Y17GiJfZWz8kwwWxRiKKAQ/G4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MpgXgEpBzQsSgflTuUTj4nOK0Vf/71dJvUvQ4cR0XbqXMu115wd3sdArEhOS4XuYY0wZnPFVzZlLzTGJp2JiQHFnsXZtgfFEQj+DsRiazVY2+BvMbyHqPEl/QaTocLR03uVecrPAKTKx18uUoSqrW2z9dRC7dijBEnbYZ+rm9Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvnvrwSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD92DC4CEF9;
	Mon,  8 Sep 2025 16:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757349109;
	bh=BXehqBShX490v3aAs4Y17GiJfZWz8kwwWxRiKKAQ/G4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qvnvrwSM/pNc7BL66L2RweNhYgu1YmKOuWSMcbDHLsDbaV8+V6TRxiE+4Wfw8N8dq
	 DpcvyYGORdOZmvj/HRKmINlJeCBMwoarVbrY6iHOoqV0NIVxidhRnP0LCIgZ0GpEs3
	 f0wJhHtA07IQ96CycHzKVZKJWrabLBQ3bvJJLCaq8Pn5/cnvn7YL6UdBHm0gsXfH8/
	 ZoSO8SS4lohs2ezmXWYA8thr7ClB16YS8XK+lZrdKclHzPIoMEn1aMly5eYlp0d0Zd
	 B2s5APdqspWT65zKQeYUzF9knBUjqN+Vruzvpv9XbN5FkwQ/reCFyOFvPtDHqkQW8G
	 iPEpWkmnRBv1Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uvemR-00000004NTm-3vA9;
	Mon, 08 Sep 2025 16:31:48 +0000
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
Subject: [PATCH 09/25] perf: arm_spe_pmu: Convert to new IRQ affinity retrieval API
Date: Mon,  8 Sep 2025 17:31:11 +0100
Message-Id: <20250908163127.2462948-10-maz@kernel.org>
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
2.39.2


