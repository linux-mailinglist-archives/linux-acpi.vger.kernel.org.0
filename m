Return-Path: <linux-acpi+bounces-7501-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2991994DFFC
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Aug 2024 06:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F0C1F21283
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Aug 2024 04:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD14101C4;
	Sun, 11 Aug 2024 04:23:34 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0442FFC11
	for <linux-acpi@vger.kernel.org>; Sun, 11 Aug 2024 04:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723350214; cv=none; b=VD/kqKwe+1Qk4hCcHwfWWTr4g7dYApbX5eSLo56fuc4/Pw1Olk6tCAwxi++Ky8yjR9rXKSLdCIgKMQrDSiktvhbJpSV/cUXODLOJDKfKOuEPcR4w56SvwKurfoIz9HQsBRpHLVlwNRDK3YM1UPHssGQgg3dIbNoOHiifTsW6+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723350214; c=relaxed/simple;
	bh=sjJ0eZhlAhrVM4dqw8JpuA7hLDl1o1M5bxNmRl1f2Kc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhZaeoPEf2MJSCVx6484AWsSwSnzUdD3QCInY3DgtqwL5PjadpRqI+Eix2AcapuPKpFChZejWn8JOsX8Joh8J7ejoyUypshqwx1vAqtYJMK2saDcosFiHjGapgOxPJMV1+xxYT2+Rkino3ymObLJ/6nQTsuuiXEAar0RFJg8STc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WhPXr5lGtzQpWm;
	Sun, 11 Aug 2024 12:18:52 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B1871800A0;
	Sun, 11 Aug 2024 12:23:23 +0800 (CST)
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
Subject: [PATCH v2 2/4] ARM64: ACPI: Remove the leftover arm64_acpi_numa_init()
Date: Sun, 11 Aug 2024 12:23:01 +0800
Message-ID: <20240811042303.3498761-3-guohanjun@huawei.com>
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


