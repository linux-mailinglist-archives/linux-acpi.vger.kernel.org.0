Return-Path: <linux-acpi+bounces-7500-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FAD94DFFB
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Aug 2024 06:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1CA28199F
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Aug 2024 04:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CF3FBE8;
	Sun, 11 Aug 2024 04:23:34 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE1D101C4
	for <linux-acpi@vger.kernel.org>; Sun, 11 Aug 2024 04:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723350214; cv=none; b=F93sJisrNa1qYhW2ImdoYcB+FzDMItCA11iuD2FezPdV+EuxZ2oELsr5VvVVWht5oR0StrB4leTs5aXg7QYDm1u8ktR3IU4LEBZjXwUFTI7DkNa9baaRR5oZo3HoXp+KX9c2fvQe7y6UNA0O3Royo3vD7Uq+vcqFV4YRna0yvJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723350214; c=relaxed/simple;
	bh=5iBR2l9ylKoGUWPzBkh3Or4BcYRBka8ZpxwL+cmpe4M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iP9Qx5pEgabC8DEZMtwPF6X2Om1zABAbBiQZpgvj3/Ho/87EJ/yq6yl9R//tBintX8jfr8nrfbstU9/RwGnwpllgwmgogQEEdcC7lKGy4hiJTlr7M9TYqwySLpxZF7dKq+zf3ybgmbFvXwgvYP9RZqh6Z1uShCjblTW55vjFvWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WhPXX25fqz2CmK8;
	Sun, 11 Aug 2024 12:18:36 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A38618001B;
	Sun, 11 Aug 2024 12:23:24 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 11 Aug 2024 12:23:23 +0800
From: Hanjun Guo <guohanjun@huawei.com>
To: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
CC: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Hanjun
 Guo <guohanjun@huawei.com>
Subject: [PATCH v2 3/4] ARM64: ACPI: Make acpi_numa_get_nid() invisible to kernel/smp.c
Date: Sun, 11 Aug 2024 12:23:02 +0800
Message-ID: <20240811042303.3498761-4-guohanjun@huawei.com>
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

To do the preparation of moving acpi_numa.c to drivers/acpi/arm64,
Make acpi_numa_get_nid() invisible to kernel/smp.c, with less
export functions.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 arch/arm64/include/asm/acpi.h | 2 --
 arch/arm64/kernel/acpi_numa.c | 8 +++++++-
 arch/arm64/kernel/smp.c       | 5 -----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 5e25110ad1b7..40a501e1f26b 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -175,10 +175,8 @@ static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 #endif /* CONFIG_ACPI_APEI */
 
 #ifdef CONFIG_ACPI_NUMA
-int acpi_numa_get_nid(unsigned int cpu);
 void acpi_map_cpus_to_nodes(void);
 #else
-static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
 static inline void acpi_map_cpus_to_nodes(void) { }
 #endif /* CONFIG_ACPI_NUMA */
 
diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
index 0c036a9a3c33..2e55ff02bf07 100644
--- a/arch/arm64/kernel/acpi_numa.c
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -29,7 +29,7 @@
 
 static int acpi_early_node_map[NR_CPUS] __initdata = { NUMA_NO_NODE };
 
-int __init acpi_numa_get_nid(unsigned int cpu)
+static int __init acpi_numa_get_nid(unsigned int cpu)
 {
 	return acpi_early_node_map[cpu];
 }
@@ -72,9 +72,15 @@ static int __init acpi_parse_gicc_pxm(union acpi_subtable_headers *header,
 
 void __init acpi_map_cpus_to_nodes(void)
 {
+	int i;
+
 	acpi_table_parse_entries(ACPI_SIG_SRAT, sizeof(struct acpi_table_srat),
 					    ACPI_SRAT_TYPE_GICC_AFFINITY,
 					    acpi_parse_gicc_pxm, 0);
+
+	for (i = 0; i < nr_cpu_ids; i++)
+		early_map_cpu_to_node(i, acpi_numa_get_nid(i));
+
 }
 
 /* Callback for Proximity Domain -> ACPI processor UID mapping */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 5e18fbcee9a2..b717b77ed4d6 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -650,8 +650,6 @@ acpi_parse_gic_cpu_interface(union acpi_subtable_headers *header,
 
 static void __init acpi_parse_and_init_cpus(void)
 {
-	int i;
-
 	/*
 	 * do a walk of MADT to determine how many CPUs
 	 * we have including disabled CPUs, and get information
@@ -669,9 +667,6 @@ static void __init acpi_parse_and_init_cpus(void)
 	 * as separate steps.
 	 */
 	acpi_map_cpus_to_nodes();
-
-	for (i = 0; i < nr_cpu_ids; i++)
-		early_map_cpu_to_node(i, acpi_numa_get_nid(i));
 }
 #else
 #define acpi_parse_and_init_cpus(...)	do { } while (0)
-- 
2.25.1


