Return-Path: <linux-acpi+bounces-17981-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F190FBF12F4
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 14:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9EBCE34C2B8
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 12:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71353191AE;
	Mon, 20 Oct 2025 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OppaTkzb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19BB318133;
	Mon, 20 Oct 2025 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963411; cv=none; b=ZF6x2hFlNk0CDZUNcSCur7xnGbJgGcMeSG0awB7w6hzM8E4cfctNLl8MpgsBcLOWRojNon2p4nXR6Lu51fd4S8gBjT/PMYqr3kPBsqeZR+EYYvVUWAER5bXxpOXt+c41NVh5B8iqh+52O548rvYCQ+RQQWIvExTaGtYSChIGE0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963411; c=relaxed/simple;
	bh=vRe08IshBVZgH66zAsJxgYD+sZIV9HYsJFPIPT5JdzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PU6wOe5Xb5Q9j6IpmI9akdTnaKgds+niEDuF0fyBN2DQfQ/WjQErng5wCCnTafrfbT5tQRojRU/YP/jd51TGv5UA68oUh0aY9wJqwr0oCiwTbziqN6sNVI9sPnuBgY1VehoywzTZt/fuyp05bvjniP3aSO5vuEcGwxUAPRYQrso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OppaTkzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B37C16AAE;
	Mon, 20 Oct 2025 12:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760963411;
	bh=vRe08IshBVZgH66zAsJxgYD+sZIV9HYsJFPIPT5JdzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OppaTkzbaK9k6VlRvv3ZEudUZgk4TK/G+tW6ol5mfvMzbkkUnU5L/3eGUCEiiY4pv
	 5b3dpqA/kn0FG+Tjqgcp51DZXvi3GRo2R0eOQ1hCtPr+gvubXkfPh8/ac8tUwc06Oz
	 Gq8+wxx8FIKvakr4Cx3hPO3w2rl249ExtZBC9k/0JfNYOTO02VybTJ8usb8S4MDT4M
	 teLAePD7YreTLYxIW3fL3ZGRpQtZNchiG5kfS6UWyb0VtV6HgxyuGI2SwXT/RtZ1lY
	 MnRGIqILNOKPwucnc+d0ynQ1wtqs5sZltUcutuDOybc34f14xGmiPcYpks5zkUI7vg
	 He+kUOe5VcCIQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vAp1d-0000000FUu2-2a1v;
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
Subject: [PATCH v4 08/26] perf: arm_pmu: Convert to new IRQ affinity retrieval API
Date: Mon, 20 Oct 2025 13:29:25 +0100
Message-ID: <20251020122944.3074811-9-maz@kernel.org>
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
the OF side of the ARM PMU driver over to this new method.

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Tested-by: Will Deacon <will@kernel.org>
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


