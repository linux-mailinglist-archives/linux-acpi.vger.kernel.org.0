Return-Path: <linux-acpi+bounces-15567-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1978DB1DB3C
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Aug 2025 18:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F42E7A5458
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Aug 2025 16:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7D126F44C;
	Thu,  7 Aug 2025 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXps3WOI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6D126E714;
	Thu,  7 Aug 2025 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582570; cv=none; b=MUTAf+iLyuK5E+TT8fLC1IugBgQ4BtqDMsYhPcrBBcukEgVzNcKzU+esjHhCw4BmKbLehTGJY5Wv1rerX6gp6dEBh7qd3z4idBguMzrNTZc5hZ8cETijcAWVX4xlt0yMFPaGinVt5J7Ar7C2yZKkNottiWMcwM8Xr7EWdMkfzMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582570; c=relaxed/simple;
	bh=QS9aCXpsi//WfO6u/n4Am6+277W66GDkBWxlcRfXNUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LFyZtP5D2ObgiGgolTvhYToLAS+TC32gTveCloI250WGtA6Q11aalohEXImqhHiTeJsqjL74gNMGr1PKpeA0ejt5TTYtPR8x9vw7SMe7V7mrTXmbwCCnjbtasEYRD2pqvjQ7F8wAeEkvbFJL15mtMjoZKbx2XOODmUhAAUj+F0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXps3WOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D6BC4CEF6;
	Thu,  7 Aug 2025 16:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754582570;
	bh=QS9aCXpsi//WfO6u/n4Am6+277W66GDkBWxlcRfXNUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YXps3WOIzyMVj0wFG6cpAgPh9DupqJ2rFpAU5SNFKRlTN1uJQmxLM9vAQmZeeiS8O
	 bTkkqtnKIkD/7i0sS2UTzIRZmd7cTSogE/ot8XLH4YfvtWcZMNHOVT8EMlUrL56+5Z
	 kcjKqtaflNrhAIM0F/dvp9+TP1SOqr8qo3q7AXDYbHExXse85O9ltUxtE5sgM9HaJS
	 Ry85+LznugGYAiNYOZRSmSzFS3pcnqLRXgs5e3tUhYDVU1DLTLAFnBulPCirN12I6L
	 ej3+lkgIXxxpR3Q7jM4W1EX7ejh24LYJ06f6h08c85XKc3kuIHtun/pHjK2EHd2a2x
	 NGtEu4gG/rKhA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uk34p-004zf7-II;
	Thu, 07 Aug 2025 17:02:47 +0100
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
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4/4] clocksource/drivers/arm_arch_timer_mmio: Add MMIO clocksource
Date: Thu,  7 Aug 2025 17:02:43 +0100
Message-Id: <20250807160243.1970533-5-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250807160243.1970533-1-maz@kernel.org>
References: <20250807160243.1970533-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, mark.rutland@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

The MMIO driver can also double as a clocksource, something that was
missing in its previous incarnation. Add it for completeness.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/clocksource/arm_arch_timer_mmio.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer_mmio.c b/drivers/clocksource/arm_arch_timer_mmio.c
index fa7294ab609ce..f88e960c24006 100644
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
@@ -255,6 +264,16 @@ static void arch_timer_mmio_setup(struct arch_timer *at, int irq)
 	clockevents_config_and_register(&at->evt, at->rate, 0xf, CLOCKSOURCE_MASK(56));
 
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


