Return-Path: <linux-acpi+bounces-16894-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E853BB573BD
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 10:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04178188E07F
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 08:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037952F3627;
	Mon, 15 Sep 2025 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YV4w1Ufh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF5A2F28FC;
	Mon, 15 Sep 2025 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926633; cv=none; b=f/VXfMjT1pzPSQ9sFjZGWPmgcXw5bv2vFQF8nYgB+iciLJ1bWLi+SRd+d1ByRfz6AIV+NiDxN7RDaJfQe8/YDA7Z7/bCxznMdZiO8o8fW9ubKBsBO+zXx9JA2d+L0il5wyhPN5ZNocFRxIrxeUFg3ooXwG6pO4VX9rXl9c0NGtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926633; c=relaxed/simple;
	bh=q2Fd2zOOtwDOEGTqhcpca89zH4earoptsab0Q+WSvVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KwRZvPT9hP2CerZFchuIsjLJy8LNVE86sLJe+wRxikYJl2S+wjALmAyYBSlk6AARd+hjofDS2BjM4hz3+EibiCdC6NHSoRETiIeAhg4BJz66Xm4wWg8g0jhZdJf0TO9+E9J6t1b4ozVsVsT9iHOx/Bh4lnNzK48RWxFUCyXCBWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YV4w1Ufh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78770C4CEFD;
	Mon, 15 Sep 2025 08:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926633;
	bh=q2Fd2zOOtwDOEGTqhcpca89zH4earoptsab0Q+WSvVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YV4w1UfhCsKJsuEcBo34WQ7uWNxd0d2npcHg+kdjaQG3gqsirvyRQ/gsN1VW3/EO1
	 +pA7/mycME+T/F6Os6A/TGie5ajwbKRfRaHCgve89fKpxUoVoD/ihlHlqo8//nSLUX
	 qyI+GAH+8DDoEL50IiMj6/HEs0BFEac+ZaucGYSCYsH3BuxNZfUKUcHBiheMjsQr1x
	 n1msHRssXGuqW7QkO/iRH+h2uF8EmwHV2DBOtNAXiFFI2nnSeUp5FnQb+K+1seX5ZL
	 iPeCqaFS7bnlTlUEg6HyCb6BN9hhjn2Xm+BHyLKIes9HLEwhCaUn4rXdWpn8ugQGwk
	 7yuIkS0ku5wjQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uy51L-00000006IHP-1gOa;
	Mon, 15 Sep 2025 08:57:11 +0000
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
Subject: [PATCH v2 01/25] irqdomain: Add firmware info reporting interface
Date: Mon, 15 Sep 2025 09:56:38 +0100
Message-Id: <20250915085702.519996-2-maz@kernel.org>
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

Allow an irqdomain callback to report firmware-provided information
that is otherwise not available in a generic way. This is reported
using a new data structure (struct irq_fwspec_info).

This callback is optional and the only information that can be
reported currently is the affinity of an interrupt. However, the
containing structure is designed to be extensible, allowing other
potentially relevant information to be reported in the future.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h | 28 ++++++++++++++++++++++++++++
 kernel/irq/irqdomain.c    | 32 +++++++++++++++++++++++++++-----
 2 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 4a86e6b915dd6..34993bf8293c4 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -44,6 +44,24 @@ struct irq_fwspec {
 	u32			param[IRQ_DOMAIN_IRQ_SPEC_PARAMS];
 };
 
+/**
+ * struct irq_fwspec_info - firmware provided IRQ information structure
+ *
+ * @fwspec:		Firmware-specific interrupt specifier
+ * @cpumask:		Affinity mask for this interrupt
+ * @flags:		Information validity flags
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
@@ -69,6 +87,9 @@ void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
  * @translate:	Given @fwspec, decode the hardware irq number (@out_hwirq) and
  *		linux irq type value (@out_type). This is a generalised @xlate
  *		(over struct irq_fwspec) and is preferred if provided.
+ * @get_fwspec_info:
+ *		Given @fwspec, report additional firmware-provided information in
+ *		@info. Optional.
  * @debug_show:	For domains to show specific data for an interrupt in debugfs.
  *
  * Functions below are provided by the driver and called whenever a new mapping
@@ -96,6 +117,7 @@ struct irq_domain_ops {
 	void	(*deactivate)(struct irq_domain *d, struct irq_data *irq_data);
 	int	(*translate)(struct irq_domain *d, struct irq_fwspec *fwspec,
 			     unsigned long *out_hwirq, unsigned int *out_type);
+	int	(*get_fwspec_info)(struct irq_fwspec *fwspec, struct irq_fwspec_info *info);
 #endif
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
 	void	(*debug_show)(struct seq_file *m, struct irq_domain *d,
@@ -602,6 +624,8 @@ void irq_domain_free_irqs_parent(struct irq_domain *domain, unsigned int irq_bas
 
 int irq_domain_disconnect_hierarchy(struct irq_domain *domain, unsigned int virq);
 
+int irq_populate_fwspec_info(struct irq_fwspec *fwspec, struct irq_fwspec_info *info);
+
 static inline bool irq_domain_is_hierarchy(struct irq_domain *domain)
 {
 	return domain->flags & IRQ_DOMAIN_FLAG_HIERARCHY;
@@ -685,6 +709,10 @@ static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
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
2.39.2


