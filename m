Return-Path: <linux-acpi+bounces-17996-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB0FBF1335
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 14:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE84418A0A82
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 12:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028C3320CDB;
	Mon, 20 Oct 2025 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIA2Swll"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF6320CB6;
	Mon, 20 Oct 2025 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963416; cv=none; b=ThdzGkmLYhG2ZA70IQ21besXqded14uNYRPi5wGJUhHs9paM/afNJPXJL8+kKolyy9vv/yaZo3YhsqBA/P1tCZqzKggrYJFlLBBxbR2FnTcYMW2hqwxxSDpH4nFgJLjimJUpQU3SNHnBR3E7JjCyDeGdiTnIA1gvVUS9nDnkbbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963416; c=relaxed/simple;
	bh=LhqnyHO9xQXE51uOqEQco9cZyrEAt+/uNHhbdX8NSGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2L97j9bASTFNnUq8kdxbOuaJvOuhd5WX3Q2FyvUmwqkYF4uOv+Z2lUrYQlQ4X5SoyB3pZ05/1mxUUzdG3iPieboQnuoWcXlXPyRm9iLmQSi5XHNEqEo9a6Iqkbm9TUOppGUXRUao4RaiMXP3WbyCcSHT8Lz3XIjVUf/fWthnZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIA2Swll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC49C116B1;
	Mon, 20 Oct 2025 12:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760963416;
	bh=LhqnyHO9xQXE51uOqEQco9cZyrEAt+/uNHhbdX8NSGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VIA2SwllRV140v5T0/nmR9nAfstHE8fXvWbLVt8DK74CBICzGRaFKRCl1bJrnDDib
	 5H5sUpf8RqyBe/a1kbfDDXX3yp0fntHJCP/q+miXgpJ7LYwM83GKxQNvTe8bLLO+7v
	 OW82n1vBVjZf0pmu/uyTXasVDdK17PmYdXuLV3PgVetxTf0T7thDSntLVtLI83F1VL
	 bTxN1YSQ0S6x8aQlxDmSPbjYcgajkE4ClKJb5BzG0iKMdfCoStDuldZKxlJ9jKh9+C
	 8Ike8xyEx1drtnsjIn688K4Fuiy8ybafALZtyaa7rp0aklpux234I/vOFvckP5XeDu
	 thB1uKcyWaXHA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vAp1i-0000000FUu2-2vI8;
	Mon, 20 Oct 2025 12:30:14 +0000
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
Subject: [PATCH v4 24/26] genirq: Kill irq_{g,s}et_percpu_devid_partition()
Date: Mon, 20 Oct 2025 13:29:41 +0100
Message-ID: <20251020122944.3074811-25-maz@kernel.org>
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

These two helpers do not have any user anymore, and can be removed,
together with the affinity field kept in the irqdesc structure.

Tested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irq.h     |  4 ----
 include/linux/irqdesc.h |  1 -
 kernel/irq/irqdesc.c    | 24 +-----------------------
 3 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index b728c18f6ded7..4a9f1d7b08c39 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -718,10 +718,6 @@ static inline void irq_set_chip_and_handler(unsigned int irq,
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
index db714d3014b5f..6acf268f005bc 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -879,8 +879,7 @@ void __irq_put_desc_unlock(struct irq_desc *desc, unsigned long flags, bool bus)
 		chip_bus_sync_unlock(desc);
 }
 
-int irq_set_percpu_devid_partition(unsigned int irq,
-				   const struct cpumask *affinity)
+int irq_set_percpu_devid(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
@@ -892,31 +891,10 @@ int irq_set_percpu_devid_partition(unsigned int irq,
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


