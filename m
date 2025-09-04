Return-Path: <linux-acpi+bounces-16360-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC76B43B35
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 14:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA37C5E05B4
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 12:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F932E1C6F;
	Thu,  4 Sep 2025 12:11:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA442D5410;
	Thu,  4 Sep 2025 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987898; cv=none; b=DjxCszPRgN0eO6S9uNvc5PYjnZ8hQV7vpWQysl+vLFHQuBmIwoBbDiiFTVbBxWZCAL2ivtPH21WPIR2jRE7sJ/CGlZcOIcY8Z9eSdHS22d9BUY97C5DHqbAdAPf0E/Kez7WIDCJwyiCLJRLOlNzY+3/Fvxpv2wwNgVsMNxZ1Stw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987898; c=relaxed/simple;
	bh=jUl8KfwFagSZlpvEancmTQoJOmbKc9C4wmaWDyGTf+4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C8xvrx/xHWwyRs5zPy4shmtZEelPn98I7tkK/iU2QwU46ltPb4qZ2ERamX18sMhpi5eyA4e3WWE6MjLauJ2XqyU+cI92107SES92v6TKPhItcVQhbr+2iSMNl8IlmdqaGBzzOWMkXujOUThao5KF4rSm5EqBGHbBcR11m+/la0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cHdcV219bz14MWN;
	Thu,  4 Sep 2025 20:11:22 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D7E50180488;
	Thu,  4 Sep 2025 20:11:32 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Sep 2025 20:11:32 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Sep 2025 20:11:31 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH] ACPI: processor: Fix function defined but not used warning
Date: Thu, 4 Sep 2025 20:11:31 +0800
Message-ID: <20250904121131.2610989-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)

If CONFIG_ACPI_PROCESSOR=n and CONFIG_ACPI_PROCESSOR_IDLE=n, we may
encounter some compling warnings as the following link said.
So remove these empty function definition because they are just used
in processor_driver.c and if CONFIG_ACPI_PROCESSOR is selected and
CONFIG_ACPI_PROCESSOR_IDLE also be selected automatically.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508300519.tZQHY6HA-lkp@intel.com/

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 include/acpi/processor.h | 34 +++-------------------------------
 1 file changed, 3 insertions(+), 31 deletions(-)

diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 360b673f05e5..a4e1081fd0da 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -417,40 +417,17 @@ static inline void acpi_processor_throttling_init(void) {}
 #endif	/* CONFIG_ACPI_CPU_FREQ_PSS */
 
 /* in processor_idle.c */
-extern struct cpuidle_driver acpi_idle_driver;
 #ifdef CONFIG_ACPI_PROCESSOR_IDLE
+extern struct cpuidle_driver acpi_idle_driver;
 int acpi_processor_power_init(struct acpi_processor *pr);
 int acpi_processor_power_exit(struct acpi_processor *pr);
 int acpi_processor_power_state_has_changed(struct acpi_processor *pr);
 int acpi_processor_hotplug(struct acpi_processor *pr);
 void acpi_processor_register_idle_driver(void);
 void acpi_processor_unregister_idle_driver(void);
-#else
-static inline int acpi_processor_power_init(struct acpi_processor *pr)
-{
-	return -ENODEV;
-}
-
-static inline int acpi_processor_power_exit(struct acpi_processor *pr)
-{
-	return -ENODEV;
-}
-
-static inline int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
-{
-	return -ENODEV;
-}
 
-static inline int acpi_processor_hotplug(struct acpi_processor *pr)
-{
-	return -ENODEV;
-}
-static inline void acpi_processor_register_idle_driver(void)
-{
-}
-static inline void acpi_processor_unregister_idle_driver(void)
-{
-}
+extern int acpi_processor_ffh_lpi_probe(unsigned int cpu);
+extern int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi);
 #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
 
 /* in processor_thermal.c */
@@ -473,11 +450,6 @@ static inline void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
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


