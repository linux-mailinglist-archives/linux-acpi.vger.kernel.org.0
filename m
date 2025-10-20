Return-Path: <linux-acpi+bounces-17999-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DF3BF13F3
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 14:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4EA425A96
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 12:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB27B322C99;
	Mon, 20 Oct 2025 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdPwPqmB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A718D322A2E;
	Mon, 20 Oct 2025 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963417; cv=none; b=AJTZlS01aVTJ/MZGrsKDzdaW2d9t+emOsoIS/pFk5frjyJiWkJstBWdokN9FeAavlrx2VSyCPmhQLE1fcuMTZGln4agmQeJgxbcymazUWhwb/21gEhS0rC/rf5maST+suM6bkhSzGqv+LO1DlbdSvK8eoQqWuQcQXeHh5OK3CZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963417; c=relaxed/simple;
	bh=bc+Rz/ctD2j/SHWKlDo8/tZQYXMrF+JYSaUu7EU1gpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0OEwNA9v2sroyEJCU111RYHun2ndnEyIz2sOu1ux0mfUskQpccePTTcW/XTbtRYndVyNLNSMrtOIa7yI7IqSxXD0o2qT1KFeyqAphdijz02m3S2nc/72z92Xip1gGFQq1JtQ72KavMpySMUwtqJyxAmX4kk9pgQBaDrUrrJ81w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdPwPqmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F91C4CEF9;
	Mon, 20 Oct 2025 12:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760963417;
	bh=bc+Rz/ctD2j/SHWKlDo8/tZQYXMrF+JYSaUu7EU1gpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YdPwPqmBUbvaNAEgUNfVSRHq4jnUC0ZgisJGjm82JzIUJ33O+qaQ+4y2Z2OM29Ps2
	 Y47FrVRfUt1LhEs94Zat2IHYk0CHPkZ2BftjR6nO3VMtfUsTRGaux0wGH5TnVqab69
	 abA+LWQHHKmSArsHdhhq2fyVwVkj61nrQClnLw17xLLt4YA7HkzvgCb1XgNk+AUs9N
	 AD9+HD6xKbpU7eCvA4b5o2lQ63UgUQCJ6/GLLgMObJ5B4JoRaxKXXM2jxQEV3fx/ul
	 q6hoAJBpVrpByYXf9aIIYNfKHBbLG9RgPvllLIQrZ9OPVrsmroa3nP6mfrjiI71gJY
	 nXnt/rL/N/6Qw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vAp1j-0000000FUu2-1Q5V;
	Mon, 20 Oct 2025 12:30:15 +0000
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
Subject: [PATCH v4 26/26] perf: arm_pmu: Kill last use of per-CPU cpu_armpmu pointer
Date: Mon, 20 Oct 2025 13:29:43 +0100
Message-ID: <20251020122944.3074811-27-maz@kernel.org>
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

Having removed the use of the cpu_armpmu per-CPU variable from the
interrupt handling, the only user left is the BRBE scheduler hook.

It is easy to drop the use of this variable by following the pointer
to the generic PMU structure, and get the arm_pmu structure from there.

Perform the conversion and kill cpu_armpmu altogether.

Suggested-by: Will Deacon <will@kernel.org>
Tested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/perf/arm_pmu.c       | 5 -----
 drivers/perf/arm_pmuv3.c     | 2 +-
 include/linux/perf/arm_pmu.h | 2 --
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 959ceb3d1f556..f7abd13339630 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -104,7 +104,6 @@ static const struct pmu_irq_ops percpu_pmunmi_ops = {
 	.free_pmuirq = armpmu_free_percpu_pmunmi
 };
 
-DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
 static DEFINE_PER_CPU(int, cpu_irq);
 static DEFINE_PER_CPU(const struct pmu_irq_ops *, cpu_irq_ops);
 
@@ -725,8 +724,6 @@ static int arm_perf_starting_cpu(unsigned int cpu, struct hlist_node *node)
 	if (pmu->reset)
 		pmu->reset(pmu);
 
-	per_cpu(cpu_armpmu, cpu) = pmu;
-
 	irq = armpmu_get_cpu_irq(pmu, cpu);
 	if (irq)
 		per_cpu(cpu_irq_ops, cpu)->enable_pmuirq(irq);
@@ -746,8 +743,6 @@ static int arm_perf_teardown_cpu(unsigned int cpu, struct hlist_node *node)
 	if (irq)
 		per_cpu(cpu_irq_ops, cpu)->disable_pmuirq(irq);
 
-	per_cpu(cpu_armpmu, cpu) = NULL;
-
 	return 0;
 }
 
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 69c5cc8f56067..ca8d706d40221 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1064,7 +1064,7 @@ static int armv8pmu_user_event_idx(struct perf_event *event)
 static void armv8pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
 				struct task_struct *task, bool sched_in)
 {
-	struct arm_pmu *armpmu = *this_cpu_ptr(&cpu_armpmu);
+	struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
 	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
 
 	if (!hw_events->branch_users)
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 6690bd77aa4ee..bab26a7d79f4c 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -132,8 +132,6 @@ struct arm_pmu {
 
 #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
 
-DECLARE_PER_CPU(struct arm_pmu *, cpu_armpmu);
-
 u64 armpmu_event_update(struct perf_event *event);
 
 int armpmu_event_set_period(struct perf_event *event);
-- 
2.47.3


