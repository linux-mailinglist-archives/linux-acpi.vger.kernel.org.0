Return-Path: <linux-acpi+bounces-17196-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54438B8F8A5
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 10:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 680097AFEB9
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 08:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D3B305078;
	Mon, 22 Sep 2025 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gderv2+K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED2E305056;
	Mon, 22 Sep 2025 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529730; cv=none; b=c8P1USpCfvR9BE1THqTNZpnHozJ086jWcPA1+3OPjUC6M0upH9b5nf+o7N5tiAP+hMB9gNfZT+D/hKNgxlmE8uyU7QD5ZUBsLYLWUP37nbEQegfNKch2/rEO+UHXQdCYoWijtFonNqeT5GGVyTseB13jdEU31sKteGFTAUmT0Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529730; c=relaxed/simple;
	bh=cvZ2bG6UgYQzigEKIrFLrXkwQbGabtL1b8+eUxAZgR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoPHBFHxglKxDqBYjcjybkbSDxP0nh0g/V3Z8LOXjR/wJVjSII3h9cdS40+E9iXyo64+2kWtzqsYMxhSJWCZTQ01M0lwh1V84jL1UKvo5/Hab/xb/ujsBXaHOuBs5U4MlcJX1wVHrcYClnqDlBJqh4LQ9ZnG6JXuPBO6RSQo+a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gderv2+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C831C4CEF5;
	Mon, 22 Sep 2025 08:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758529730;
	bh=cvZ2bG6UgYQzigEKIrFLrXkwQbGabtL1b8+eUxAZgR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gderv2+Kk/B3Mls0DFGEI98zWvNCig0HqjpwWwcC24CZ4CxHJ2XWjBP4opHh6lQX6
	 nH72ImXHTfnRgwYk82VPy+upt6V9flZPHJRe8FN8+uHENGjCT4fafzzhqqqznxMxvo
	 Y3QLoNjjz67gpzjT+GIHZz1nWk9DeeRVZ1y0N1P+8zz/AAksQlt4R1x7XUAu/U0Zt0
	 BZ0vxoKozooP+8xpQVYIAFlShfzMBGXCdKavtS1NEliPvZ8rpDd23Y7VN1StKr6UGf
	 F0vtHM0zc0++g9WABDbkVxIUAh8+aKewXnGXhU9Ti/EZ3vREoJPgyibHsNoTiow6XR
	 nCVyJi9yeEsYg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1v0bui-00000008Kds-2LDP;
	Mon, 22 Sep 2025 08:28:48 +0000
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
Subject: [PATCH v3 24/26] genirq: Kill irq_{g,s}et_percpu_devid_partition()
Date: Mon, 22 Sep 2025 09:28:31 +0100
Message-ID: <20250922082833.2038905-25-maz@kernel.org>
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
2.47.3


