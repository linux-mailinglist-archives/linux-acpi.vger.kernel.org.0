Return-Path: <linux-acpi+bounces-16664-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE93DB53024
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 13:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0263BB089
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 11:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF081314B75;
	Thu, 11 Sep 2025 11:24:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1842D7DD4;
	Thu, 11 Sep 2025 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589855; cv=none; b=UPWSXNZVfs2qZ17J+mTzqm+YYjwMCsF7uM+FX2eYeXBkdz0C2xqR6yRZJmzkWQsS7sJhRv7UHCBgMOembWnO9+8kbsbUF7CgN3NLri08eWMXliEDDKtlaKhU2V4OPaeXgJV1O0FtHAGzQO0HBeqkIgT7rmsJIkGisFbnt46+ICs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589855; c=relaxed/simple;
	bh=/sbhAqa/bGWUUifrfJCtI47VcH+qtXTTG33lyC+B2Tg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opwyaXfZMiE8eXiiON4rzVfp/0m9OeTc7r6PmcBMembW0rm2n7SmzAyXsNiVUOpkHtmPPEb77Kq2YjdX477/Kk7CVvyoYfpUtlCBo9qvMMttH6ONlRv8s6IpqBfh+H7/Ah8Ol5WeqfJ6GuCQJupBTnUAVem2n4iu3msZyrDsUdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cMw9226Xnz24j7T;
	Thu, 11 Sep 2025 19:20:54 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 232621A016C;
	Thu, 11 Sep 2025 19:24:11 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Sep 2025 19:24:10 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Sep 2025 19:24:10 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v3 2/3] ACPI: processor: Unify the place of function declaration of processor_idle.c
Date: Thu, 11 Sep 2025 19:24:07 +0800
Message-ID: <20250911112408.1668431-3-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250911112408.1668431-1-lihuisong@huawei.com>
References: <20250911112408.1668431-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100009.china.huawei.com (7.202.194.112)

To unify the place of function declaration of processor_idle.c, move
acpi_processor_ffh_lpi_probe and acpi_processor_ffh_lpi_enter to one
place. And remove 'extern' key word in declaration by the way.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 include/acpi/processor.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 2976a6d0c54f..6ee4a69412de 100644
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


