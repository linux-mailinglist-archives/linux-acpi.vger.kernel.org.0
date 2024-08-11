Return-Path: <linux-acpi+bounces-7498-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ED194DFF9
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Aug 2024 06:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57612818D0
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Aug 2024 04:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530F1EED8;
	Sun, 11 Aug 2024 04:23:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E591D11CAB
	for <linux-acpi@vger.kernel.org>; Sun, 11 Aug 2024 04:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723350209; cv=none; b=LFAgpkc+jDjohDWeB/L/Wu2A5QAa/vho2e2JiRbMZ3UdOXnWBggTbCcCObViM6D+8E3I9yxfL94C+SIbPrMlva8LA6z2/WgoOseyy7M+bTnwNxed6w3jQjx4XgvBEb6BEpH3Kw1UmCn5oTeh9XKP9ne1cIfzKsF5PDnPgaTHgzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723350209; c=relaxed/simple;
	bh=xpJSspjo/kxZJVLu6z9sm7UqL8TSnlpBfcXKMMsCcg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLkWA3edCbcE8LF/jIZz1ETcXyIKlT+f3kTjzm7h2UnBs/iEJ9JeTtPPxo6G34G9AaPhqsqRXBOSLKJ2FoN+LY9OB21TnzB1wSPJ/5/sc+CpKtiWGsG/AUcEGMtrCEXQiak1hCERPyov0IW5eCfoqbfE9ONnhWUb2AABS3wMcMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WhPdY2z5CzyP5F;
	Sun, 11 Aug 2024 12:22:57 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 27733180101;
	Sun, 11 Aug 2024 12:23:23 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 11 Aug 2024 12:23:22 +0800
From: Hanjun Guo <guohanjun@huawei.com>
To: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
CC: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Hanjun
 Guo <guohanjun@huawei.com>
Subject: [PATCH v2 1/4] ARM64: ACPI: Remove the leftover acpi_init_cpus()
Date: Sun, 11 Aug 2024 12:23:00 +0800
Message-ID: <20240811042303.3498761-2-guohanjun@huawei.com>
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


