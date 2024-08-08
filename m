Return-Path: <linux-acpi+bounces-7446-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D195694BE4C
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2024 15:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101281F2654C
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2024 13:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784F418CC1E;
	Thu,  8 Aug 2024 13:15:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7143118C92C
	for <linux-acpi@vger.kernel.org>; Thu,  8 Aug 2024 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122950; cv=none; b=T8GFyxDlX98QwM4PIiTl4Dkozq6dF6wa58N5CttRjrRyQK0cVm/9RRXCT8OUaQaLlz4G+EXIHUOdKelUCL7X2bkRdiWDJcee/bUEkJ91wZyuiJesb5d4evtz0YoYo6w9MVWb+yhKJMhTq2QPm7u36lX0AiO5rTkEnOM9GsmNw/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122950; c=relaxed/simple;
	bh=TiY/hLwWrHHJ+PqEbTFsOYJfRJNQNaR8fHOVCYhOe4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IvODAnZJ7Gd+eEB8zfasmzkbIYy3ChzCNstX74a81gK2kqTrAUNOCfi6uqBw33wX2/J68OSmaTUzTudHpPE/ZlTJg/dLJKEJsdFJmtaISFF/1T7CxmfRmvBpNDqs5GDV32M7NDJo/QetWcIuAYWB5ie6ASyFdGnQwYxZVRdYvkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WfnYW5kkgzDqVY;
	Thu,  8 Aug 2024 21:13:51 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 338201402CC;
	Thu,  8 Aug 2024 21:15:46 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Aug 2024 21:15:45 +0800
From: Hanjun Guo <guohanjun@huawei.com>
To: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
CC: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Hanjun
 Guo <guohanjun@huawei.com>
Subject: [PATCH 3/3] ARM64: ACPI: Move the NUMA code to drivers/acpi/arm64/
Date: Thu, 8 Aug 2024 21:15:22 +0800
Message-ID: <20240808131522.1032431-4-guohanjun@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240808131522.1032431-1-guohanjun@huawei.com>
References: <20240808131522.1032431-1-guohanjun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

The ARM64 ACPI NUMA code can be moved out of arm64 arch code
as it just related to ACPI NUMA table parsing, mappings for
ACPI NUMA and cpu, move the ACPI NUMA code to drivers/acpi/arm64/.

Since arm64 selects ACPI_NUMA by default, so just move the function
definitions under CONFIG_ARM64 in linux/acpi.h.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 arch/arm64/include/asm/acpi.h                         | 8 --------
 arch/arm64/kernel/Makefile                            | 1 -
 drivers/acpi/arm64/Makefile                           | 1 +
 {arch/arm64/kernel => drivers/acpi/arm64}/acpi_numa.c | 0
 include/linux/acpi.h                                  | 4 ++++
 5 files changed, 5 insertions(+), 9 deletions(-)
 rename {arch/arm64/kernel => drivers/acpi/arm64}/acpi_numa.c (100%)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 5e25110ad1b7..572355783971 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -174,14 +174,6 @@ static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 }
 #endif /* CONFIG_ACPI_APEI */
 
-#ifdef CONFIG_ACPI_NUMA
-int acpi_numa_get_nid(unsigned int cpu);
-void acpi_map_cpus_to_nodes(void);
-#else
-static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
-static inline void acpi_map_cpus_to_nodes(void) { }
-#endif /* CONFIG_ACPI_NUMA */
-
 #define ACPI_TABLE_UPGRADE_MAX_PHYS MEMBLOCK_ALLOC_ACCESSIBLE
 
 #endif /*_ASM_ACPI_H*/
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 2b112f3b7510..c7d09c6348a4 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -52,7 +52,6 @@ obj-$(CONFIG_EFI)			+= efi.o efi-rt-wrapper.o
 obj-$(CONFIG_PCI)			+= pci.o
 obj-$(CONFIG_ARMV8_DEPRECATED)		+= armv8_deprecated.o
 obj-$(CONFIG_ACPI)			+= acpi.o
-obj-$(CONFIG_ACPI_NUMA)			+= acpi_numa.o
 obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
 obj-$(CONFIG_PARAVIRT)			+= paravirt.o
 obj-$(CONFIG_RANDOMIZE_BASE)		+= kaslr.o
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 05ecde9eaabe..9aeed2e4ebde 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
 obj-$(CONFIG_ACPI_FFH)		+= ffh.o
 obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
 obj-$(CONFIG_ACPI_IORT) 	+= iort.o
+obj-$(CONFIG_ACPI_NUMA)		+= acpi_numa.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE) += cpuidle.o
 obj-$(CONFIG_ARM_AMBA)		+= amba.o
 obj-y				+= dma.o init.o
diff --git a/arch/arm64/kernel/acpi_numa.c b/drivers/acpi/arm64/acpi_numa.c
similarity index 100%
rename from arch/arm64/kernel/acpi_numa.c
rename to drivers/acpi/arm64/acpi_numa.c
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0687a442fec7..7de4e9dac0c7 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -253,8 +253,12 @@ static inline void acpi_arch_dma_setup(struct device *dev) { }
 #endif
 
 #ifdef CONFIG_ARM64
+int acpi_numa_get_nid(unsigned int cpu);
+void acpi_map_cpus_to_nodes(void);
 void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
 #else
+static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
+static inline void acpi_map_cpus_to_nodes(void) { }
 static inline void
 acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
 #endif
-- 
2.25.1


