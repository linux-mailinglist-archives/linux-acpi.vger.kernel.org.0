Return-Path: <linux-acpi+bounces-7445-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A5E94BE4B
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2024 15:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F9928D399
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2024 13:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE5318CC08;
	Thu,  8 Aug 2024 13:15:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5708418C34C
	for <linux-acpi@vger.kernel.org>; Thu,  8 Aug 2024 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122950; cv=none; b=C5EQGRjxg+XgP/R/HyY9ANN8PsZS3XJ7GdB/DLA4QMupRcJh4usZpwHnFkTtGZsVYjoItLjQLUJlybbtDDuggOKzDlOLDXyL+BYXSum4GAPgYLE6AvL6LITgHIq6g/CCOtYRHq4Jn17mO8gpL4qeQFGC/lcXB5zk/mDzAiEweLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122950; c=relaxed/simple;
	bh=sjJ0eZhlAhrVM4dqw8JpuA7hLDl1o1M5bxNmRl1f2Kc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpy2HjJqrArAVXgh41lmjD8Pcvaq4HmAEddLkMJvv+2lhgIqEpQFt8ftfh2qrNzSaibERlt8B+6ZL+JCHNgVk6ZlNWuNw4gXGi+eBytuUtN79VwYliU91yky4K4K1nqHpOvTQxZ6B/780COm4z2wETTK67TuYL6uJG5ZE1Efh74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WfnbY1lJWzcd4t;
	Thu,  8 Aug 2024 21:15:37 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id B186F140488;
	Thu,  8 Aug 2024 21:15:45 +0800 (CST)
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
Subject: [PATCH 2/3] ARM64: ACPI: Remove the leftover arm64_acpi_numa_init()
Date: Thu, 8 Aug 2024 21:15:21 +0800
Message-ID: <20240808131522.1032431-3-guohanjun@huawei.com>
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

In commit eb75541f8b45 ("arm64, numa: Change the numa init functions
name to be generic"), arm64_acpi_numa_init() was renamed to
arch_acpi_numa_init() and be static, so the leftover
arm64_acpi_numa_init() in head file should be removed.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 arch/arm64/include/asm/acpi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index e872d28edb04..5e25110ad1b7 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -175,11 +175,9 @@ static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 #endif /* CONFIG_ACPI_APEI */
 
 #ifdef CONFIG_ACPI_NUMA
-int arm64_acpi_numa_init(void);
 int acpi_numa_get_nid(unsigned int cpu);
 void acpi_map_cpus_to_nodes(void);
 #else
-static inline int arm64_acpi_numa_init(void) { return -ENOSYS; }
 static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
 static inline void acpi_map_cpus_to_nodes(void) { }
 #endif /* CONFIG_ACPI_NUMA */
-- 
2.25.1


