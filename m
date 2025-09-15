Return-Path: <linux-acpi+bounces-16916-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDE8B573E7
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 11:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB0F17F528
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 09:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693022F8BC1;
	Mon, 15 Sep 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruTyMvFv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF2D2F83C0;
	Mon, 15 Sep 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926639; cv=none; b=q2nn99lykwnzP5YluLDlnZ7SbKZVdTdhoQ56/oTM9n+U+N/XlcKt42y2169LmGOwBcotIGakmyIAt7jZ4M7+PwT1MHCZO9O1w0h2eYY0Z9NB8CEAiDSY2VDKM+ZKuInwYT7ugfBZpQlX/qu7rZdQtbgGvpoDIOpuQ/fksVU7RCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926639; c=relaxed/simple;
	bh=zjGTnTXeZxX9IWdZqt0xePIPCnSCFLQrvT6nM+URiUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n18cqXfTZZF+4KuQsJlkAMadBc8S3Ki81lFUJhctq68yiwMxdTGrBbhqaponYAkaWKDN7dw6B1OSDaDJ79nGCvYH3Rs4OkgZeyC66QQMxWVqgl2rFSiAkvkZ/8T7sU0BhQoFlnH3+YiKJS7VQ0vns0Pmd/cg8BX2fQz+InJaIyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruTyMvFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3253C4CEFA;
	Mon, 15 Sep 2025 08:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926639;
	bh=zjGTnTXeZxX9IWdZqt0xePIPCnSCFLQrvT6nM+URiUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ruTyMvFvXi5wF4RTv9vNiyAy7u3vGpdMJohif3vDGXUanFxhSoNICzHSCsyJDRBEf
	 SEyC80MXODrLsEYqf/0r3eJvAqgNTyTY20on6N4auQtugLBrQ1NH9t5sHVoGLmEmJT
	 9Zyj+oTMOFZhBnd6POBl1jfKUwTJZFePhXWdfDLv89PAn/qyKh+e6wN6YplNG+K0ld
	 WAviNoAaQV9KAMGW8jmVpIQLVD/Fsz6ypUP4Q9moy5vxxGnS6Ap8LWrF6jdi7pMWsj
	 EbBrwH4DRi2vnO35EcFHNuJv0//FLzWoK4k3lwMoPkbfnSDmLfP+iE4Z4VaoYQOxTU
	 aKCqhnsy+MHTw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uy51R-00000006IHP-0ena;
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
Subject: [PATCH v2 23/25] irqchip: Kill irq-partition-percpu
Date: Mon, 15 Sep 2025 09:57:00 +0100
Message-Id: <20250915085702.519996-24-maz@kernel.org>
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

This code is now completely unused, and nobody will ever miss it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/Kconfig                      |   3 -
 drivers/irqchip/Makefile                     |   1 -
 drivers/irqchip/irq-partition-percpu.c       | 241 -------------------
 include/linux/irqchip/irq-partition-percpu.h |  53 ----
 4 files changed, 298 deletions(-)
 delete mode 100644 drivers/irqchip/irq-partition-percpu.c
 delete mode 100644 include/linux/irqchip/irq-partition-percpu.h

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index c31d2f99d7b91..4bb25d21f6e9b 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -450,9 +450,6 @@ config LS_SCFG_MSI
 	depends on PCI_MSI
 	select IRQ_MSI_LIB
 
-config PARTITION_PERCPU
-	bool
-
 config STM32MP_EXTI
 	tristate "STM32MP extended interrupts and event controller"
 	depends on (ARCH_STM32 && !ARM_SINGLE_ARMV7M) || COMPILE_TEST
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 93e3ced023bb8..da429f3e29ec7 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -36,7 +36,6 @@ obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_ITS_PARENT)	+= irq-gic-its-msi-parent.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v4.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+= irq-gic-v3-its-fsl-mc-msi.o
-obj-$(CONFIG_PARTITION_PERCPU)		+= irq-partition-percpu.o
 obj-$(CONFIG_ARM_GIC_V5)		+= irq-gic-v5.o irq-gic-v5-irs.o irq-gic-v5-its.o \
 					   irq-gic-v5-iwb.o
 obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+= irq-mbigen.o
diff --git a/drivers/irqchip/irq-partition-percpu.c b/drivers/irqchip/irq-partition-percpu.c
deleted file mode 100644
index 4441ffe149ea0..0000000000000
--- a/drivers/irqchip/irq-partition-percpu.c
+++ /dev/null
@@ -1,241 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2016 ARM Limited, All Rights Reserved.
- * Author: Marc Zyngier <marc.zyngier@arm.com>
- */
-
-#include <linux/bitops.h>
-#include <linux/interrupt.h>
-#include <linux/irqchip.h>
-#include <linux/irqchip/chained_irq.h>
-#include <linux/irqchip/irq-partition-percpu.h>
-#include <linux/irqdomain.h>
-#include <linux/seq_file.h>
-#include <linux/slab.h>
-
-struct partition_desc {
-	int				nr_parts;
-	struct partition_affinity	*parts;
-	struct irq_domain		*domain;
-	struct irq_desc			*chained_desc;
-	unsigned long			*bitmap;
-	struct irq_domain_ops		ops;
-};
-
-static bool partition_check_cpu(struct partition_desc *part,
-				unsigned int cpu, unsigned int hwirq)
-{
-	return cpumask_test_cpu(cpu, &part->parts[hwirq].mask);
-}
-
-static void partition_irq_mask(struct irq_data *d)
-{
-	struct partition_desc *part = irq_data_get_irq_chip_data(d);
-	struct irq_chip *chip = irq_desc_get_chip(part->chained_desc);
-	struct irq_data *data = irq_desc_get_irq_data(part->chained_desc);
-
-	if (partition_check_cpu(part, smp_processor_id(), d->hwirq) &&
-	    chip->irq_mask)
-		chip->irq_mask(data);
-}
-
-static void partition_irq_unmask(struct irq_data *d)
-{
-	struct partition_desc *part = irq_data_get_irq_chip_data(d);
-	struct irq_chip *chip = irq_desc_get_chip(part->chained_desc);
-	struct irq_data *data = irq_desc_get_irq_data(part->chained_desc);
-
-	if (partition_check_cpu(part, smp_processor_id(), d->hwirq) &&
-	    chip->irq_unmask)
-		chip->irq_unmask(data);
-}
-
-static int partition_irq_set_irqchip_state(struct irq_data *d,
-					   enum irqchip_irq_state which,
-					   bool val)
-{
-	struct partition_desc *part = irq_data_get_irq_chip_data(d);
-	struct irq_chip *chip = irq_desc_get_chip(part->chained_desc);
-	struct irq_data *data = irq_desc_get_irq_data(part->chained_desc);
-
-	if (partition_check_cpu(part, smp_processor_id(), d->hwirq) &&
-	    chip->irq_set_irqchip_state)
-		return chip->irq_set_irqchip_state(data, which, val);
-
-	return -EINVAL;
-}
-
-static int partition_irq_get_irqchip_state(struct irq_data *d,
-					   enum irqchip_irq_state which,
-					   bool *val)
-{
-	struct partition_desc *part = irq_data_get_irq_chip_data(d);
-	struct irq_chip *chip = irq_desc_get_chip(part->chained_desc);
-	struct irq_data *data = irq_desc_get_irq_data(part->chained_desc);
-
-	if (partition_check_cpu(part, smp_processor_id(), d->hwirq) &&
-	    chip->irq_get_irqchip_state)
-		return chip->irq_get_irqchip_state(data, which, val);
-
-	return -EINVAL;
-}
-
-static int partition_irq_set_type(struct irq_data *d, unsigned int type)
-{
-	struct partition_desc *part = irq_data_get_irq_chip_data(d);
-	struct irq_chip *chip = irq_desc_get_chip(part->chained_desc);
-	struct irq_data *data = irq_desc_get_irq_data(part->chained_desc);
-
-	if (chip->irq_set_type)
-		return chip->irq_set_type(data, type);
-
-	return -EINVAL;
-}
-
-static void partition_irq_print_chip(struct irq_data *d, struct seq_file *p)
-{
-	struct partition_desc *part = irq_data_get_irq_chip_data(d);
-	struct irq_chip *chip = irq_desc_get_chip(part->chained_desc);
-	struct irq_data *data = irq_desc_get_irq_data(part->chained_desc);
-
-	seq_printf(p, "%5s-%lu", chip->name, data->hwirq);
-}
-
-static struct irq_chip partition_irq_chip = {
-	.irq_mask		= partition_irq_mask,
-	.irq_unmask		= partition_irq_unmask,
-	.irq_set_type		= partition_irq_set_type,
-	.irq_get_irqchip_state	= partition_irq_get_irqchip_state,
-	.irq_set_irqchip_state	= partition_irq_set_irqchip_state,
-	.irq_print_chip		= partition_irq_print_chip,
-};
-
-static void partition_handle_irq(struct irq_desc *desc)
-{
-	struct partition_desc *part = irq_desc_get_handler_data(desc);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	int cpu = smp_processor_id();
-	int hwirq;
-
-	chained_irq_enter(chip, desc);
-
-	for_each_set_bit(hwirq, part->bitmap, part->nr_parts) {
-		if (partition_check_cpu(part, cpu, hwirq))
-			break;
-	}
-
-	if (unlikely(hwirq == part->nr_parts))
-		handle_bad_irq(desc);
-	else
-		generic_handle_domain_irq(part->domain, hwirq);
-
-	chained_irq_exit(chip, desc);
-}
-
-static int partition_domain_alloc(struct irq_domain *domain, unsigned int virq,
-				  unsigned int nr_irqs, void *arg)
-{
-	int ret;
-	irq_hw_number_t hwirq;
-	unsigned int type;
-	struct irq_fwspec *fwspec = arg;
-	struct partition_desc *part;
-
-	BUG_ON(nr_irqs != 1);
-	ret = domain->ops->translate(domain, fwspec, &hwirq, &type);
-	if (ret)
-		return ret;
-
-	part = domain->host_data;
-
-	set_bit(hwirq, part->bitmap);
-	irq_set_chained_handler_and_data(irq_desc_get_irq(part->chained_desc),
-					 partition_handle_irq, part);
-	irq_set_percpu_devid_partition(virq, &part->parts[hwirq].mask);
-	irq_domain_set_info(domain, virq, hwirq, &partition_irq_chip, part,
-			    handle_percpu_devid_irq, NULL, NULL);
-	irq_set_status_flags(virq, IRQ_NOAUTOEN);
-
-	return 0;
-}
-
-static void partition_domain_free(struct irq_domain *domain, unsigned int virq,
-				  unsigned int nr_irqs)
-{
-	struct irq_data *d;
-
-	BUG_ON(nr_irqs != 1);
-
-	d = irq_domain_get_irq_data(domain, virq);
-	irq_set_handler(virq, NULL);
-	irq_domain_reset_irq_data(d);
-}
-
-int partition_translate_id(struct partition_desc *desc, void *partition_id)
-{
-	struct partition_affinity *part = NULL;
-	int i;
-
-	for (i = 0; i < desc->nr_parts; i++) {
-		if (desc->parts[i].partition_id == partition_id) {
-			part = &desc->parts[i];
-			break;
-		}
-	}
-
-	if (WARN_ON(!part)) {
-		pr_err("Failed to find partition\n");
-		return -EINVAL;
-	}
-
-	return i;
-}
-
-struct partition_desc *partition_create_desc(struct fwnode_handle *fwnode,
-					     struct partition_affinity *parts,
-					     int nr_parts,
-					     int chained_irq,
-					     const struct irq_domain_ops *ops)
-{
-	struct partition_desc *desc;
-	struct irq_domain *d;
-
-	BUG_ON(!ops->select || !ops->translate);
-
-	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
-	if (!desc)
-		return NULL;
-
-	desc->ops = *ops;
-	desc->ops.free = partition_domain_free;
-	desc->ops.alloc = partition_domain_alloc;
-
-	d = irq_domain_create_linear(fwnode, nr_parts, &desc->ops, desc);
-	if (!d)
-		goto out;
-	desc->domain = d;
-
-	desc->bitmap = bitmap_zalloc(nr_parts, GFP_KERNEL);
-	if (WARN_ON(!desc->bitmap))
-		goto out;
-
-	desc->chained_desc = irq_to_desc(chained_irq);
-	desc->nr_parts = nr_parts;
-	desc->parts = parts;
-
-	return desc;
-out:
-	if (d)
-		irq_domain_remove(d);
-	kfree(desc);
-
-	return NULL;
-}
-
-struct irq_domain *partition_get_domain(struct partition_desc *dsc)
-{
-	if (dsc)
-		return dsc->domain;
-
-	return NULL;
-}
diff --git a/include/linux/irqchip/irq-partition-percpu.h b/include/linux/irqchip/irq-partition-percpu.h
deleted file mode 100644
index b35ee22c278f8..0000000000000
--- a/include/linux/irqchip/irq-partition-percpu.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2016 ARM Limited, All Rights Reserved.
- * Author: Marc Zyngier <marc.zyngier@arm.com>
- */
-
-#ifndef __LINUX_IRQCHIP_IRQ_PARTITION_PERCPU_H
-#define __LINUX_IRQCHIP_IRQ_PARTITION_PERCPU_H
-
-#include <linux/fwnode.h>
-#include <linux/cpumask_types.h>
-#include <linux/irqdomain.h>
-
-struct partition_affinity {
-	cpumask_t			mask;
-	void				*partition_id;
-};
-
-struct partition_desc;
-
-#ifdef CONFIG_PARTITION_PERCPU
-int partition_translate_id(struct partition_desc *desc, void *partition_id);
-struct partition_desc *partition_create_desc(struct fwnode_handle *fwnode,
-					     struct partition_affinity *parts,
-					     int nr_parts,
-					     int chained_irq,
-					     const struct irq_domain_ops *ops);
-struct irq_domain *partition_get_domain(struct partition_desc *dsc);
-#else
-static inline int partition_translate_id(struct partition_desc *desc,
-					 void *partition_id)
-{
-	return -EINVAL;
-}
-
-static inline
-struct partition_desc *partition_create_desc(struct fwnode_handle *fwnode,
-					     struct partition_affinity *parts,
-					     int nr_parts,
-					     int chained_irq,
-					     const struct irq_domain_ops *ops)
-{
-	return NULL;
-}
-
-static inline
-struct irq_domain *partition_get_domain(struct partition_desc *dsc)
-{
-	return NULL;
-}
-#endif
-
-#endif /* __LINUX_IRQCHIP_IRQ_PARTITION_PERCPU_H */
-- 
2.39.2


