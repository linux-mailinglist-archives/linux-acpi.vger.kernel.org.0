Return-Path: <linux-acpi+bounces-17973-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD81BF139B
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 14:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90E7423D46
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 12:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5375313E00;
	Mon, 20 Oct 2025 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVq3VnHg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9813128D6;
	Mon, 20 Oct 2025 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963409; cv=none; b=n927PuliRTN1jG2+YYPPQp/GYPPSbzOm7pbIKlOpMPvAjRZUA3P57/iOoeTyCnz4BUCB9oAwTlmEm3kPuYnGUIf1uwyHQ4PVr+htBmZ/o/vdzCnYL+1EVztwHcW+5dUM7idLIDt1yt44m4dDVCEWt2yPycP1c0iryPmJxKdVIxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963409; c=relaxed/simple;
	bh=acaPYQeOSgLtZF/bImsTJHWuVgiSegqBzzgCiK2oJlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfcxpUz3v3wbe1h42XeQ2WQYHMqPX/wECy4nJ3PIjxibW5R+ZQN9NKMQa9DQ39hFkzMtrl6F9TxA1l4+Me3gL2ksFI5c4s2r+6uLjRZKUHNPIEeAQgyaJMNy/2VOPNatyGF1pNNxa1eljXrqQERzLNSG3tNE14WENEDaE6w+0dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVq3VnHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742F7C116C6;
	Mon, 20 Oct 2025 12:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760963409;
	bh=acaPYQeOSgLtZF/bImsTJHWuVgiSegqBzzgCiK2oJlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nVq3VnHgPnDvZVZNZQbepe2oZPJ294fEvG1zkIX3mzdV0Pm/yQLSwbrrWIFmr7gu7
	 eVFy4+1uBC+868LewumBjcOSaDUOckDX0UFu//G1x2cykLCGqfRZ3qQu/kwAqUzFuc
	 JtncrqezRpAy2zr9q07W9DOHHZaKJ38/0FvtXsg8pWbm2cDqbMJYzP2OuO/P2R8RUz
	 42N30WJ/78J49O31J5QJFif1bQ+H6edhCg089/cuwI6uUbSvD4KZARRcNi66jHYdzQ
	 2m8mKoSbrN90er0Wqbaxji78K59r0g8546xllMPBTQuDf9K3FvOwnwaCnvWha8OgvL
	 XsEyJDATkwXLA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vAp1b-0000000FUu2-1fiW;
	Mon, 20 Oct 2025 12:30:07 +0000
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
Subject: [PATCH v4 01/26] irqdomain: Add firmware info reporting interface
Date: Mon, 20 Oct 2025 13:29:18 +0100
Message-ID: <20251020122944.3074811-2-maz@kernel.org>
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

Allow an irqdomain callback to report firmware-provided information
that is otherwise not available in a generic way. This is reported
using a new data structure (struct irq_fwspec_info).

This callback is optional and the only information that can be
reported currently is the affinity of an interrupt. However, the
containing structure is designed to be extensible, allowing other
potentially relevant information to be reported in the future.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h | 27 +++++++++++++++++++++++++++
 kernel/irq/irqdomain.c    | 32 +++++++++++++++++++++++++++-----
 2 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 4a86e6b915dd6..9d6a5e99394fa 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -44,6 +44,23 @@ struct irq_fwspec {
 	u32			param[IRQ_DOMAIN_IRQ_SPEC_PARAMS];
 };
 
+/**
+ * struct irq_fwspec_info - firmware provided IRQ information structure
+ *
+ * @flags:		Information validity flags
+ * @cpumask:		Affinity mask for this interrupt
+ *
+ * This structure reports firmware-specific information about an
+ * interrupt. The only significant information is the affinity of a
+ * per-CPU interrupt, but this is designed to be extended as required.
+ */
+struct irq_fwspec_info {
+	unsigned long		flags;
+	const struct cpumask	*affinity;
+};
+
+#define IRQ_FWSPEC_INFO_AFFINITY_VALID	BIT(0)
+
 /* Conversion function from of_phandle_args fields to fwspec  */
 void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
 			       unsigned int count, struct irq_fwspec *fwspec);
@@ -69,6 +86,9 @@ void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
  * @translate:	Given @fwspec, decode the hardware irq number (@out_hwirq) and
  *		linux irq type value (@out_type). This is a generalised @xlate
  *		(over struct irq_fwspec) and is preferred if provided.
+ * @get_fwspec_info:
+ *		Given @fwspec, report additional firmware-provided information in
+ *		@info. Optional.
  * @debug_show:	For domains to show specific data for an interrupt in debugfs.
  *
  * Functions below are provided by the driver and called whenever a new mapping
@@ -96,6 +116,7 @@ struct irq_domain_ops {
 	void	(*deactivate)(struct irq_domain *d, struct irq_data *irq_data);
 	int	(*translate)(struct irq_domain *d, struct irq_fwspec *fwspec,
 			     unsigned long *out_hwirq, unsigned int *out_type);
+	int	(*get_fwspec_info)(struct irq_fwspec *fwspec, struct irq_fwspec_info *info);
 #endif
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
 	void	(*debug_show)(struct seq_file *m, struct irq_domain *d,
@@ -602,6 +623,8 @@ void irq_domain_free_irqs_parent(struct irq_domain *domain, unsigned int irq_bas
 
 int irq_domain_disconnect_hierarchy(struct irq_domain *domain, unsigned int virq);
 
+int irq_populate_fwspec_info(struct irq_fwspec *fwspec, struct irq_fwspec_info *info);
+
 static inline bool irq_domain_is_hierarchy(struct irq_domain *domain)
 {
 	return domain->flags & IRQ_DOMAIN_FLAG_HIERARCHY;
@@ -685,6 +708,10 @@ static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
 	return false;
 }
 
+static inline int irq_populate_fwspec_info(struct irq_fwspec *fwspec, struct irq_fwspec_info *info)
+{
+	return -EINVAL;
+}
 #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 
 #ifdef CONFIG_GENERIC_MSI_IRQ
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index dc473faadcc81..2652c4cfd877f 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -867,13 +867,9 @@ void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
 }
 EXPORT_SYMBOL_GPL(of_phandle_args_to_fwspec);
 
-unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
+static struct irq_domain *fwspec_to_domain(struct irq_fwspec *fwspec)
 {
 	struct irq_domain *domain;
-	struct irq_data *irq_data;
-	irq_hw_number_t hwirq;
-	unsigned int type = IRQ_TYPE_NONE;
-	int virq;
 
 	if (fwspec->fwnode) {
 		domain = irq_find_matching_fwspec(fwspec, DOMAIN_BUS_WIRED);
@@ -883,6 +879,32 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 		domain = irq_default_domain;
 	}
 
+	return domain;
+}
+
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+int irq_populate_fwspec_info(struct irq_fwspec *fwspec, struct irq_fwspec_info *info)
+{
+	struct irq_domain *domain = fwspec_to_domain(fwspec);
+
+	memset(info, 0, sizeof(*info));
+
+	if (!domain || !domain->ops->get_fwspec_info)
+		return 0;
+
+	return domain->ops->get_fwspec_info(fwspec, info);
+}
+#endif
+
+unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
+{
+	unsigned int type = IRQ_TYPE_NONE;
+	struct irq_domain *domain;
+	struct irq_data *irq_data;
+	irq_hw_number_t hwirq;
+	int virq;
+
+	domain = fwspec_to_domain(fwspec);
 	if (!domain) {
 		pr_warn("no irq domain found for %s !\n",
 			of_node_full_name(to_of_node(fwspec->fwnode)));
-- 
2.47.3


