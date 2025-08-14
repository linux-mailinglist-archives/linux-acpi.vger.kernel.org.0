Return-Path: <linux-acpi+bounces-15690-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6479B26B84
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 17:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40D61CE1F21
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 15:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F5223CEF8;
	Thu, 14 Aug 2025 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF7wYjhZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D19523AE9B;
	Thu, 14 Aug 2025 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186389; cv=none; b=GzXAWhcMVaT01wpnbnVLHakCcWRJpT+181MDuAg+XsEDsPqoPOQAobOtfqDZ1dRAR2d1P1fbVLceoiVZDr4R2hjHbXj8NwX4uM6ygneoIR++f6x/xkDb+CTCamTz4KqYkoIdUyv9txqfojYJuZbs0RWUk0ULbB3FLUc+5KuYFGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186389; c=relaxed/simple;
	bh=iSjzjmWTu80cwcbL4cT/to0KlVsFsM7JJGnphItTq5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NUXGe3bC2M5jfYsRISjsNKg9eUlnNMirO0c0UDzQn8BUZvPSFAIWluOnMOByxstH8LnsIUyNJyztgFEfwCZhu1jYAm61HY5UrFk5x35LpdP9NJV59djVjgO6otlH6NqZ2YgCudmUBLYSzhED00nKfQEqWpV2hhiYkXBHVowCdyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF7wYjhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC754C4CEEF;
	Thu, 14 Aug 2025 15:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755186388;
	bh=iSjzjmWTu80cwcbL4cT/to0KlVsFsM7JJGnphItTq5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fF7wYjhZFUqs3vr7YwAWauWU54banRqHRl2x4hrTX4DI+Lud6nrQu1ZY4dXh7sI8f
	 b4VbGwLI/89AghcGVtl+bD53+vwY3/9SVfcBv0ghRl3/8+Lun/5RM2Wcv1NuBFfT82
	 i/ePzioR8hvE+zj2bODZDNxeAu1vVs6NOj6k/xUsMubVquDHmQ819m+aZdzfHBOddB
	 iOFDz/U2uNE56pnrAu8RkAaa1ixZbWrxK/LKgCHZIfPoIGsaAwIY6E0oWDbVYidsoo
	 RdfRP2ENVzwWjO1jijYkXurAVX+7HnZg3XupfxyrAznJ761iLb8gN5PNQUoi3M4Qq6
	 v7/tOpG3VQbNg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uma9q-007VqB-Qc;
	Thu, 14 Aug 2025 16:46:26 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH v2 4/4] clocksource/drivers/arm_arch_timer_mmio: Add MMIO clocksource
Date: Thu, 14 Aug 2025 16:46:22 +0100
Message-Id: <20250814154622.10193-5-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250814154622.10193-1-maz@kernel.org>
References: <20250814154622.10193-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, mark.rutland@arm.com, alexandru.elisei@arm.com, steven.price@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

The MMIO driver can also double as a clocksource, something that was
missing in its previous incarnation. Add it for completeness.

Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Link: https://lore.kernel.org/r/20250807160243.1970533-5-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/clocksource/arm_arch_timer_mmio.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer_mmio.c b/drivers/clocksource/arm_arch_timer_mmio.c
index 3522d1d8cb97b..ebe1987d651eb 100644
--- a/drivers/clocksource/arm_arch_timer_mmio.c
+++ b/drivers/clocksource/arm_arch_timer_mmio.c
@@ -45,6 +45,7 @@ enum arch_timer_access {
 
 struct arch_timer {
 	struct clock_event_device	evt;
+	struct clocksource		cs;
 	struct arch_timer_mem		*gt_block;
 	void __iomem			*base;
 	enum arch_timer_access		access;
@@ -52,6 +53,7 @@ struct arch_timer {
 };
 
 #define evt_to_arch_timer(e) container_of(e, struct arch_timer, evt)
+#define cs_to_arch_timer(c) container_of(c, struct arch_timer, cs)
 
 static void arch_timer_mmio_write(struct arch_timer *timer,
 				  enum arch_timer_reg reg, u64 val)
@@ -128,6 +130,13 @@ static noinstr u64 arch_counter_mmio_get_cnt(struct arch_timer *t)
 	return ((u64) cnt_hi << 32) | cnt_lo;
 }
 
+static u64 arch_mmio_counter_read(struct clocksource *cs)
+{
+	struct arch_timer *at = cs_to_arch_timer(cs);
+
+	return arch_counter_mmio_get_cnt(at);
+}
+
 static int arch_timer_mmio_shutdown(struct clock_event_device *clk)
 {
 	struct arch_timer *at = evt_to_arch_timer(clk);
@@ -256,6 +265,16 @@ static void arch_timer_mmio_setup(struct arch_timer *at, int irq)
 					(unsigned long)CLOCKSOURCE_MASK(56));
 
 	enable_irq(at->evt.irq);
+
+	at->cs = (struct clocksource) {
+		.name	= "arch_mmio_counter",
+		.rating	= 300,
+		.read	= arch_mmio_counter_read,
+		.mask	= CLOCKSOURCE_MASK(56),
+		.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+	};
+
+	clocksource_register_hz(&at->cs, at->rate);
 }
 
 static int arch_timer_mmio_frame_register(struct platform_device *pdev,
-- 
2.39.2


