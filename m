Return-Path: <linux-acpi+bounces-7502-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EBE94DFFD
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Aug 2024 06:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544C82819D4
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Aug 2024 04:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E96D14AA9;
	Sun, 11 Aug 2024 04:23:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231291171C
	for <linux-acpi@vger.kernel.org>; Sun, 11 Aug 2024 04:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723350215; cv=none; b=pQsFulgf1rN+LecIebxncVS5ioTW9w87E+3Pa7z69ORFsxPdEtinBN6SijdZ2mh7iPkVfyYFNDjcdsgEVnmSmrXhRD+apzvMV2NB9x/dWyMb9Xd9KOLVS7xz5DrcRQl4Eu84ZZD26+UZwkULmGw4KVvBBMNu2EB9+1MBrHwwOLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723350215; c=relaxed/simple;
	bh=37p30hmVwlYYjNuW+Hxc5jsFpZWdhlpW3NjHuwz5kR8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwhWroYHZSImAoZjJifVwXfI+4S1IH04eU1tT6d7Tscg5n9GV05ie58zFOiOCe/yUtlHVJdRxtKXq3ZShNkBtpTYgjrX7Qx02fthD8pafIgVuBa8JDxkfYa6xRg+kVLebwTe8W+F0/pfljteXGDM9qqKwChewGOFnA8bkkv6cgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WhPXs5GyxzQpWs;
	Sun, 11 Aug 2024 12:18:53 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A98714022E;
	Sun, 11 Aug 2024 12:23:24 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 11 Aug 2024 12:23:24 +0800
From: Hanjun Guo <guohanjun@huawei.com>
To: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
CC: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Hanjun
 Guo <guohanjun@huawei.com>
Subject: [PATCH v2 4/4] ARM64: ACPI: Move the NUMA code to drivers/acpi/arm64/
Date: Sun, 11 Aug 2024 12:23:03 +0800
Message-ID: <20240811042303.3498761-5-guohanjun@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240811042303.3498761-1-guohanjun@huawei.com>
References: <20240811042303.3498761-1-guohanjun@huawei.com>
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
ACPI numa node and cpu, so move the ACPI NUMA code to
drivers/acpi/arm64/.

Since arm64 selects ACPI_NUMA by default if ACPI=y, just move the
function definitions under CONFIG_ARM64 in linux/acpi.h, as the
caller of acpi_map_cpus_to_nodes() is only with ACPI selected, so
no inline function is needed, this will solve the conflict with
riscv implementation as well.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 arch/arm64/include/asm/acpi.h                         | 6 ------
 arch/arm64/kernel/Makefile                            | 1 -
 drivers/acpi/arm64/Makefile                           | 1 +
 {arch/arm64/kernel => drivers/acpi/arm64}/acpi_numa.c | 0
 include/linux/acpi.h                                  | 1 +
 5 files changed, 2 insertions(+), 7 deletions(-)
 rename {arch/arm64/kernel => drivers/acpi/arm64}/acpi_numa.c (100%)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 40a501e1f26b..572355783971 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -174,12 +174,6 @@ static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 }
 #endif /* CONFIG_ACPI_APEI */
 
-#ifdef CONFIG_ACPI_NUMA
-void acpi_map_cpus_to_nodes(void);
-#else
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
index 0687a442fec7..09e0c2ad8c43 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -253,6 +253,7 @@ static inline void acpi_arch_dma_setup(struct device *dev) { }
 #endif
 
 #ifdef CONFIG_ARM64
+void acpi_map_cpus_to_nodes(void);
 void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
 #else
 static inline void
-- 
2.25.1


