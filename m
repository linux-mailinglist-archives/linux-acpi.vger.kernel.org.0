Return-Path: <linux-acpi+bounces-16919-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AFAB573E9
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 11:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D549317F7C5
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 09:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16A12F998A;
	Mon, 15 Sep 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZRFfemI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53AE2F90D6;
	Mon, 15 Sep 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926639; cv=none; b=GoU3Sv3F7DDBU/xvzLTx1wiZQ2F3O6w0RWj64i/vNkQENyf9Vcdcep6COqL0l94oG66o3Zwd7VfB46jqjaPFXoZXi8SEb4HgSFVjfCvRVQckhs48bVGUxiRWZFx8Qkm0lYXtnQhV/4MFrwEfAc/y+yYWTbDH2WfQM0Nwfk3jtxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926639; c=relaxed/simple;
	bh=kzh4j/H3RZDe7ZkyacsAHuKMIz0DQecjQ2j642GjAyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LPt2RO2A/f5KmtPA/v7K46mdYt7wC71MD1N9HzUVMy64j9hMkAPs3jwt19G/Pd0oQHoeMQJxEsavT9nTKdrfDH2jCd+xT7DMau8cgYvOlNSzZXg+/xBLsGj5lXxRqh7+6n9DJiZEgK+yAG3gFTwJDI/XWGTFDcQObFgcZ7Zxgc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZRFfemI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8313DC4CEFA;
	Mon, 15 Sep 2025 08:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926639;
	bh=kzh4j/H3RZDe7ZkyacsAHuKMIz0DQecjQ2j642GjAyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EZRFfemIR5d70YvHXUxHp3+8Vxolt0dIQTzuIr4clY0Q98Rqrh23wn43RwVLJvkJB
	 31nzSVBxTqHyxXad5F1a9BG3tauYuL7SQjzZg3qIobMrtk5X8Ytw2SQbglnTUK2Y6f
	 0BI7tVuwilMo3hzV5dGBRu3ne+fxeU7EPtaAWMBdhkH1esQ695ZiQEdAtXG+xV1+g7
	 7MVNI1LFCLbqH8YghRl2VSpeUH+DNS+av3XDH4HhstMDKoMV+v1xp/+N1MrIrlLiPy
	 v3OisHFj/WdWvDNn/8IQuuOaRRaRlDeV1VdtL02DB3OCTcFmYZZSLwxEdSuZwlNyQA
	 JttL69Zgls4nA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uy51R-00000006IHP-2wOa;
	Mon, 15 Sep 2025 08:57:17 +0000
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
Subject: [PATCH v2 25/25] perf: arm_pmu: Kill last use of per-CPU cpu_armpmu pointer
Date: Mon, 15 Sep 2025 09:57:02 +0100
Message-Id: <20250915085702.519996-26-maz@kernel.org>
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

Having removed the use of the cpu_armpmu per-CPU variable from the
interrupt handling, the only user left is the BRBE scheduler hook.

It is easy to drop the use of this variable by following the pointer
to the generic PMU structure, and get the arm_pmu structure from there.

Perform the conversion and kill cpu_armpmu altogether.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/perf/arm_pmu.c       | 5 -----
 drivers/perf/arm_pmuv3.c     | 2 +-
 include/linux/perf/arm_pmu.h | 2 --
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 23814707cf771..7171d8e0d27a5 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -104,7 +104,6 @@ static const struct pmu_irq_ops percpu_pmunmi_ops = {
 	.free_pmuirq = armpmu_free_percpu_pmunmi
 };
 
-DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
 static DEFINE_PER_CPU(int, cpu_irq);
 static DEFINE_PER_CPU(const struct pmu_irq_ops *, cpu_irq_ops);
 
@@ -726,8 +725,6 @@ static int arm_perf_starting_cpu(unsigned int cpu, struct hlist_node *node)
 	if (pmu->reset)
 		pmu->reset(pmu);
 
-	per_cpu(cpu_armpmu, cpu) = pmu;
-
 	irq = armpmu_get_cpu_irq(pmu, cpu);
 	if (irq)
 		per_cpu(cpu_irq_ops, cpu)->enable_pmuirq(irq);
@@ -747,8 +744,6 @@ static int arm_perf_teardown_cpu(unsigned int cpu, struct hlist_node *node)
 	if (irq)
 		per_cpu(cpu_irq_ops, cpu)->disable_pmuirq(irq);
 
-	per_cpu(cpu_armpmu, cpu) = NULL;
-
 	return 0;
 }
 
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index f6d7bab5d555c..2dee2d928aaef 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1039,7 +1039,7 @@ static int armv8pmu_user_event_idx(struct perf_event *event)
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
2.39.2


