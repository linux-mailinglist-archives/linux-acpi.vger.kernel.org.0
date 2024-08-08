Return-Path: <linux-acpi+bounces-7447-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAD694BE4D
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2024 15:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89D028D3DB
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2024 13:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5670618DF67;
	Thu,  8 Aug 2024 13:15:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114B218C322
	for <linux-acpi@vger.kernel.org>; Thu,  8 Aug 2024 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122951; cv=none; b=p2oJsoyZJYVcfGrWBsaNtKlcjkZFO0I2L3+4H4KdGrIPZKbkKv2zgR7GuXkZmXHKkiMIXgmJtTxkWisezhV8AsCVQGCBngbd/6ci9TkFtpqqYUzzzfCmFuJHSSi7l234twofxRLKIRIXBjQ/6zn48KwdrqRyPIwH/9Oq94yPnzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122951; c=relaxed/simple;
	bh=xpJSspjo/kxZJVLu6z9sm7UqL8TSnlpBfcXKMMsCcg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nipZCpROTQCuC9LQIwkC9W53zlmWpwSVWd2j1oJiMoOtyB5WE9QQoSP+ctnvxDMdKjQuVy8APKYFRqKzSgTgj42AmuFVTJcJwqi9xs3v/DTRcznVFCB56dTNheRK5Xpnxm2YoaWaiFokDMFND2qcgu/caY1Z/r/Jl/hR2OlnDfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WfnbH1twyz1T6bJ;
	Thu,  8 Aug 2024 21:15:23 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E22F18005F;
	Thu,  8 Aug 2024 21:15:45 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Aug 2024 21:15:44 +0800
From: Hanjun Guo <guohanjun@huawei.com>
To: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
CC: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Hanjun
 Guo <guohanjun@huawei.com>
Subject: [PATCH 1/3] ARM64: ACPI: Remove the leftover acpi_init_cpus()
Date: Thu, 8 Aug 2024 21:15:20 +0800
Message-ID: <20240808131522.1032431-2-guohanjun@huawei.com>
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

In commit 0f0783365cbb ("ARM64: kernel: unify ACPI and DT cpus
initialization"), function acpi_init_cpus() was removed but the
declaration was left in the asm/acpi.h, remove it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 arch/arm64/include/asm/acpi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index a407f9cd549e..e872d28edb04 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -132,10 +132,8 @@ static inline int get_cpu_for_acpi_id(u32 uid)
 }
 
 static inline void arch_fix_phys_package_id(int num, u32 slot) { }
-void __init acpi_init_cpus(void);
 int apei_claim_sea(struct pt_regs *regs);
 #else
-static inline void acpi_init_cpus(void) { }
 static inline int apei_claim_sea(struct pt_regs *regs) { return -ENOENT; }
 #endif /* CONFIG_ACPI */
 
-- 
2.25.1


