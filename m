Return-Path: <linux-acpi+bounces-16918-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC9FB573E6
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 11:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28A607AC178
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 08:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF4D2F8BDA;
	Mon, 15 Sep 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFvgN8Kz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5314E2F83D6;
	Mon, 15 Sep 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926639; cv=none; b=YoaLNPdzLnBuaNuRo1X0kTKLJI5DLY91qWd68GXFB00j3zU2lTFtZoOrp/yO/07ODWtCxckLWvyLr0dux/a8Q6R4iGok5hINEhZWovyQ0zsgb7eLJ8aahbnhD0zwycdejgxoMWzqDEvqEpVTjFedFEBuAUo9LT5x7qNXsHPSo2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926639; c=relaxed/simple;
	bh=KvIlOqxzhmHWGaaeC2n7SGz/r3v3wz0YFXzklQ5EErE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=drxfNkfXqX4ssqKP2hkR1GYbSJWijQkITwyUttmt6iUw7C5H7tkZApVPFNSl3EPc2qyLhpGCYNsQFucanmXXpczuZfz69JAcUMa5z0qtxlZnfzDDszxYU+3q3qyMER0G/FQ0XtmWAn/SuY1ZBU1/TY8fadiGbz79TEPsbdnfZX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFvgN8Kz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D5EC4CEFC;
	Mon, 15 Sep 2025 08:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926639;
	bh=KvIlOqxzhmHWGaaeC2n7SGz/r3v3wz0YFXzklQ5EErE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KFvgN8KzHTmB5mmIOkZNYVQ2CZ6RHtTLkV03SfDetznJerYGBdl+c1BzWx11lhdKr
	 33NXiTJhMP7tdQ01SX3MeFIpGYAyo0kkK9XS9aOYLVm3DgZAJ/x5xb6eNLn8DNhqpD
	 UfTV6QLamah5bn32DKeDhET6/BRzgBgj5dSqT4Hpsm4zPT5iQwO042fTz5Wmh3sRoD
	 bP+IHF9b+cFAhQ7YPMRQzxCzz7Q2sixHU0BJENnRPbIOx+h2WsMg+TId7Lbjx4Qvw5
	 bg9CblwrYTrSxYLR4DDWQ1Bg8x3jBb5P3Ty/z5ASSJATCjW3srz65LpbX/mPArTWp9
	 svp/lxsgl3YDg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uy51R-00000006IHP-1szD;
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
Subject: [PATCH v2 24/25] genirq: Kill irq_{g,s}et_percpu_devid_partition()
Date: Mon, 15 Sep 2025 09:57:01 +0100
Message-Id: <20250915085702.519996-25-maz@kernel.org>
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

These two helpers do not have any user anymore, and can be removed,
together with the affinity field kept in the irqdesc structure.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irq.h     |  4 ----
 include/linux/irqdesc.h |  1 -
 kernel/irq/irqdesc.c    | 24 +-----------------------
 3 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1381f9d1f5c9d..4cac9bc33aa34 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -716,10 +716,6 @@ static inline void irq_set_chip_and_handler(unsigned int irq,
 }
 
 extern int irq_set_percpu_devid(unsigned int irq);
-extern int irq_set_percpu_devid_partition(unsigned int irq,
-					  const struct cpumask *affinity);
-extern int irq_get_percpu_devid_partition(unsigned int irq,
-					  struct cpumask *affinity);
 
 extern void
 __irq_set_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained,
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index fd091c35d5721..37e0b5b5600a4 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -82,7 +82,6 @@ struct irq_desc {
 	int			threads_handled_last;
 	raw_spinlock_t		lock;
 	struct cpumask		*percpu_enabled;
-	const struct cpumask	*percpu_affinity;
 #ifdef CONFIG_SMP
 	const struct cpumask	*affinity_hint;
 	struct irq_affinity_notify *affinity_notify;
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index b64c57b44c203..79df6e3bc3958 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -886,8 +886,7 @@ void __irq_put_desc_unlock(struct irq_desc *desc, unsigned long flags, bool bus)
 		chip_bus_sync_unlock(desc);
 }
 
-int irq_set_percpu_devid_partition(unsigned int irq,
-				   const struct cpumask *affinity)
+int irq_set_percpu_devid(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
@@ -899,31 +898,10 @@ int irq_set_percpu_devid_partition(unsigned int irq,
 	if (!desc->percpu_enabled)
 		return -ENOMEM;
 
-	desc->percpu_affinity = affinity ? : cpu_possible_mask;
-
 	irq_set_percpu_devid_flags(irq);
 	return 0;
 }
 
-int irq_set_percpu_devid(unsigned int irq)
-{
-	return irq_set_percpu_devid_partition(irq, NULL);
-}
-
-int irq_get_percpu_devid_partition(unsigned int irq, struct cpumask *affinity)
-{
-	struct irq_desc *desc = irq_to_desc(irq);
-
-	if (!desc || !desc->percpu_enabled)
-		return -EINVAL;
-
-	if (affinity)
-		cpumask_copy(affinity, desc->percpu_affinity);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(irq_get_percpu_devid_partition);
-
 void kstat_incr_irq_this_cpu(unsigned int irq)
 {
 	kstat_incr_irqs_this_cpu(irq_to_desc(irq));
-- 
2.39.2


