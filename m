Return-Path: <linux-acpi+bounces-7497-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 261C494DFCD
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Aug 2024 05:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14AC1F2150D
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Aug 2024 03:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CD0D29E;
	Sun, 11 Aug 2024 03:18:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C1DC8E9
	for <linux-acpi@vger.kernel.org>; Sun, 11 Aug 2024 03:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723346307; cv=none; b=aQlYQ3rfUoijEadogUDji3oeTfSAOmfbBcbEdlck0UzRMQeLiEDOGd0w7IX7tE7HWEl884hK5/saX9P9rs41tityhl8LKXgGgJ+/qcWHcNCqhP5Gsr1OIw36Ra8MLwF+YMB6PFMiV2M5edlHIjGQl2OAO2vf0L+7CDbSmHnm9L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723346307; c=relaxed/simple;
	bh=RjGr9rtSbiHKqzi/yemZ2/pD/vrUvH452hjeVB2ZvVA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GRhVGiTyISi/9IPE7QJBGKVBbxqMNJdF9dOjitkv08hkV9fEXGXt6qJiURplF/HCjdnM2YwKY7qzdICkSd19ZazGNO2yTufZvqnIp+4BQ1KDk/9LUET/90Feq04Vui1l6IWDlxZPTAFZHnqXq7TCwNj0eLY2qDoPx3VZ1LVzBIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WhN9Y1wFhzpTKR;
	Sun, 11 Aug 2024 11:17:05 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 003B61400D8;
	Sun, 11 Aug 2024 11:18:20 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 11 Aug 2024 11:18:20 +0800
From: Hanjun Guo <guohanjun@huawei.com>
To: Sunil V L <sunilvl@ventanamicro.com>, Haibo Xu <haibo1.xu@intel.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
CC: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-riscv@lists.infradead.org>, Hanjun Guo
	<guohanjun@huawei.com>
Subject: [PATCH] ACPI: RISCV: Make acpi_numa_get_nid() to be static
Date: Sun, 11 Aug 2024 11:18:04 +0800
Message-ID: <20240811031804.3347298-1-guohanjun@huawei.com>
X-Mailer: git-send-email 2.25.1
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

acpi_numa_get_nid() is only called in acpi_numa.c for riscv,
no need to add it in head file, so make it static and remove
related functions in the asm/acpi.h.

Spotted by doing some cleanup for arm64 ACPI.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 arch/riscv/include/asm/acpi.h | 2 --
 arch/riscv/kernel/acpi_numa.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index e0a1f84404f3..6e13695120bc 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -91,10 +91,8 @@ static inline void acpi_get_cbo_block_size(struct acpi_table_header *table,
 #endif /* CONFIG_ACPI */
 
 #ifdef CONFIG_ACPI_NUMA
-int acpi_numa_get_nid(unsigned int cpu);
 void acpi_map_cpus_to_nodes(void);
 #else
-static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
 static inline void acpi_map_cpus_to_nodes(void) { }
 #endif /* CONFIG_ACPI_NUMA */
 
diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_numa.c
index 0231482d6946..a93c773b60e6 100644
--- a/arch/riscv/kernel/acpi_numa.c
+++ b/arch/riscv/kernel/acpi_numa.c
@@ -30,7 +30,7 @@
 
 static int acpi_early_node_map[NR_CPUS] __initdata = { NUMA_NO_NODE };
 
-int __init acpi_numa_get_nid(unsigned int cpu)
+static int __init acpi_numa_get_nid(unsigned int cpu)
 {
 	return acpi_early_node_map[cpu];
 }
-- 
2.25.1


