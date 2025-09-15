Return-Path: <linux-acpi+bounces-16901-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E49B573C8
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 10:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799DB3BBA6B
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 08:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1E42F3C12;
	Mon, 15 Sep 2025 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt8lf4DK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202592F3C00;
	Mon, 15 Sep 2025 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926635; cv=none; b=ZZZyJTmNm5EpkxvWRZeiMyqbVVIWC2CE4mMskZtnHzTR5f5AzB+3/rS3+sp3nr1wlAKIst888MJ5vjOfE8oPd6ppTNXCb2UiZLEAcf75Vm1TyGBw4PX0WwcvLbuPR9VM//k9TFNHLxZuun8iA8EuUsT8zQeAFrWCjT0r/6kEZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926635; c=relaxed/simple;
	bh=gHNda0QWGnywO22OHTHAtrEXJraB/koPwbnWeNVZoWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=chwpimlQwWdIivuoZe1tcrl1vAYa0E1BpinMMHI68XhdM1Ghe0fIlp/X+/XoZnK0ZOXe2JyeX34ObdM947Y2uTEvUb1HkhJ/WQ3NmaukhGfqgHIcxKclboRr3TLptvM/MGJDOXqJ2RQG9D5pk1pTEu5N+mdFnEDjhJKo2QRUWIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mt8lf4DK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021D7C4CEFA;
	Mon, 15 Sep 2025 08:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926635;
	bh=gHNda0QWGnywO22OHTHAtrEXJraB/koPwbnWeNVZoWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mt8lf4DK5Em0WPwF/BQK2uapI4QT3/pn42dQjrg/IFg0v+jJOrd+iTrjmnAk1uMYh
	 hqkIGL7Jo1NqFaEiaUCrfdQDBwx9dYIJ2vZRX8mNl+gGun5LLY3N3WSoNn9e6rJQET
	 hhWTNWl11cZ+xlCq2IZK10lGzUuwu6QFi+oipOL+Vxwrrf8aJYNYP4pyhDNt1J1YBX
	 oAuVhFdaQCFF/jLMeBSe3Da3uz8h9FNhUw3LbpSuBlHwOuMBuIH+kpY8qPZ4aaO2p6
	 BuWgbBiaPGmJSfwoRqNcbPCz1ftB54JKMsFYSt3mWK2rdwK/m8+AtqN8XbfmsHngPZ
	 rc+0wNp2f8Trw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uy51N-00000006IHP-0kQD;
	Mon, 15 Sep 2025 08:57:13 +0000
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
Subject: [PATCH v2 08/25] perf: arm_pmu: Convert to new IRQ affinity retrieval API
Date: Mon, 15 Sep 2025 09:56:45 +0100
Message-Id: <20250915085702.519996-9-maz@kernel.org>
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
2.39.2


