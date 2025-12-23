Return-Path: <linux-acpi+bounces-19805-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D09B6CD8E55
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 11:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC4EB305E7B7
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 10:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D358362157;
	Tue, 23 Dec 2025 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="nJZtzF9W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91790362122;
	Tue, 23 Dec 2025 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766484562; cv=none; b=aagTpIwhZYjrBPtcDEJSc/8VSbZVOTu17VmIOBclr2rtJoUYp17GHFstq1+2xhKJPBv3lfno9wng7eqglaF+S/beOPwZpZqIliWtuHJloKbttJVvt5mN44mquwghaT8+nWzRXtGiiLOxIcP7ZV+C/miX5TTBal8tcHutLWLoOLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766484562; c=relaxed/simple;
	bh=UcXdMzChhao/LlX3VPVi01RAXA75bEXK4EVuNR6xysI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+X5vZkRyDZD459obIre+TmhmytMzwzWUe1ojwqnks8cFdS3vYFzo0uuGL2o62WiRY/Gc05ef3ZDMY5zr9ryIIRM9JG/h9VJxpt4xiBYSj0/KPE2d9qQ1Kh2oF/88UU1zgYB5VNtx34bxgU9K+wB1x5iDYMi9dbOroyr43J5P3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=nJZtzF9W; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mePpf6+5xaNwVOTlLG3Ynqfb7tulPW229mHuSf1VoTw=;
	b=nJZtzF9WVVv1kgZ5C2IhYtB/g5v0SwrTAppG2fg+6P3AYqclvn+sJEY6ARxii5Q3EG4Zicgjj
	r8rr17hCcoLqDe/lOM86NRzVUt9vQ6yaoPQRdUrjq4KXtWn68DwNAlscC3YWhdzJWdMGiE1D2TH
	PsrGBWtBHkiQtrnfbS8v8WI=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4db9dJ41flz1cySV;
	Tue, 23 Dec 2025 18:06:12 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 6794440086;
	Tue, 23 Dec 2025 18:09:18 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Dec 2025 18:09:18 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 23 Dec 2025 18:09:17 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>,
	<AmandeepKaur.Longia@amd.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<prime.zeng@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 5/6] ACPI: processor: idle: Rearrange declarations in header file
Date: Tue, 23 Dec 2025 18:09:13 +0800
Message-ID: <20251223100914.2407069-6-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251223100914.2407069-1-lihuisong@huawei.com>
References: <20251223100914.2407069-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Group all of the declarations of functions that belong to the ACPI
processor idle driver together in one place in processor.h.

While at it, drop the unnecessary extern modifier from the declaraions
of two functions.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
Link: https://patch.msgid.link/20250911112408.1668431-3-lihuisong@huawei.com
[ rjw: Subject and changelog rewrite ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/processor.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 0200aef6e754..24fdaa3c2899 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -425,6 +425,8 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr);
 int acpi_processor_hotplug(struct acpi_processor *pr);
 void acpi_processor_register_idle_driver(void);
 void acpi_processor_unregister_idle_driver(void);
+int acpi_processor_ffh_lpi_probe(unsigned int cpu);
+int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi);
 #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
 
 /* in processor_thermal.c */
@@ -447,11 +449,6 @@ static inline void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
 }
 #endif	/* CONFIG_CPU_FREQ */
 
-#ifdef CONFIG_ACPI_PROCESSOR_IDLE
-extern int acpi_processor_ffh_lpi_probe(unsigned int cpu);
-extern int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi);
-#endif
-
 void acpi_processor_init_invariance_cppc(void);
 
 #endif
-- 
2.33.0


