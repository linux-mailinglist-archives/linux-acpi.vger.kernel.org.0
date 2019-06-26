Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89E0A573B7
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2019 23:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfFZVhf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Jun 2019 17:37:35 -0400
Received: from foss.arm.com ([217.140.110.172]:41452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbfFZVhf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Jun 2019 17:37:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAE4A139F;
        Wed, 26 Jun 2019 14:37:34 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.30.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A1F4F3F246;
        Wed, 26 Jun 2019 14:37:34 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, Jeremy Linton <jeremy.linton@arm.com>,
        Hanjun Gou <gouhanjun@huawei.com>
Subject: [PATCH v5 3/4] arm_pmu: acpi: spe: Add initial MADT/SPE probing
Date:   Wed, 26 Jun 2019 16:37:17 -0500
Message-Id: <20190626213718.39423-4-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626213718.39423-1-jeremy.linton@arm.com>
References: <20190626213718.39423-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI 6.3 adds additional fields to the MADT GICC
structure to describe SPE PPI's. We pick these out
of the cached reference to the madt_gicc structure
similarly to the core PMU code. We then create a platform
device referring to the IRQ and let the user/module loader
decide whether to load the SPE driver.

Tested-by: Hanjun Gou <gouhanjun@huawei.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/acpi.h |  3 ++
 drivers/perf/arm_pmu_acpi.c   | 72 +++++++++++++++++++++++++++++++++++
 include/linux/perf/arm_pmu.h  |  2 +
 3 files changed, 77 insertions(+)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index ada0bc480a1b..b263e239cb59 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -38,6 +38,9 @@
 	(!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH || \
 	(unsigned long)(entry) + (entry)->header.length > (end))
 
+#define ACPI_MADT_GICC_SPE  (ACPI_OFFSET(struct acpi_madt_generic_interrupt, \
+	spe_interrupt) + sizeof(u16))
+
 /* Basic configuration for ACPI */
 #ifdef	CONFIG_ACPI
 pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index d2c2978409d2..acce8781c456 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -71,6 +71,76 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
 	acpi_unregister_gsi(gsi);
 }
 
+#if IS_ENABLED(CONFIG_ARM_SPE_PMU)
+static struct resource spe_resources[] = {
+	{
+		/* irq */
+		.flags          = IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device spe_dev = {
+	.name = ARMV8_SPE_PDEV_NAME,
+	.id = -1,
+	.resource = spe_resources,
+	.num_resources = ARRAY_SIZE(spe_resources)
+};
+
+/*
+ * For lack of a better place, hook the normal PMU MADT walk
+ * and create a SPE device if we detect a recent MADT with
+ * a homogeneous PPI mapping.
+ */
+static void arm_spe_acpi_register_device(void)
+{
+	int cpu, hetid, irq, ret;
+	bool first = true;
+	u16 gsi = 0;
+
+	/*
+	 * Sanity check all the GICC tables for the same interrupt number.
+	 * For now, we only support homogeneous ACPI/SPE machines.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct acpi_madt_generic_interrupt *gicc;
+
+		gicc = acpi_cpu_get_madt_gicc(cpu);
+		if (gicc->header.length < ACPI_MADT_GICC_SPE)
+			return;
+
+		if (first) {
+			gsi = gicc->spe_interrupt;
+			if (!gsi)
+				return;
+			hetid = find_acpi_cpu_topology_hetero_id(cpu);
+			first = false;
+		} else if ((gsi != gicc->spe_interrupt) ||
+			   (hetid != find_acpi_cpu_topology_hetero_id(cpu))) {
+			pr_warn("ACPI: SPE must be homogeneous\n");
+			return;
+		}
+	}
+
+	irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE,
+				ACPI_ACTIVE_HIGH);
+	if (irq < 0) {
+		pr_warn("ACPI: SPE Unable to register interrupt: %d\n", gsi);
+		return;
+	}
+
+	spe_resources[0].start = irq;
+	ret = platform_device_register(&spe_dev);
+	if (ret < 0) {
+		pr_warn("ACPI: SPE: Unable to register device\n");
+		acpi_unregister_gsi(gsi);
+	}
+}
+#else
+static inline void arm_spe_acpi_register_device(void)
+{
+}
+#endif /* CONFIG_ARM_SPE_PMU */
+
 static int arm_pmu_acpi_parse_irqs(void)
 {
 	int irq, cpu, irq_cpu, err;
@@ -276,6 +346,8 @@ static int arm_pmu_acpi_init(void)
 	if (acpi_disabled)
 		return 0;
 
+	arm_spe_acpi_register_device();
+
 	ret = arm_pmu_acpi_parse_irqs();
 	if (ret)
 		return ret;
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index a9b0ee408fbd..71f525a35ac2 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -171,4 +171,6 @@ void armpmu_free_irq(int irq, int cpu);
 
 #endif /* CONFIG_ARM_PMU */
 
+#define ARMV8_SPE_PDEV_NAME "arm,spe-v1"
+
 #endif /* __ARM_PMU_H__ */
-- 
2.21.0

