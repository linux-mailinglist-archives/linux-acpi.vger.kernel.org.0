Return-Path: <linux-acpi+bounces-16394-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C365B45128
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 10:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565AF3BF645
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 08:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1133043D1;
	Fri,  5 Sep 2025 08:19:13 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B1B25949A;
	Fri,  5 Sep 2025 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060353; cv=none; b=Qad1EkV9jFrIU7tq1hZlOoXfovLhsS3a8JbinHEi5fhVCdQG4a5mp/085iJOflH3t2aYLpVpW2UNfoF/wN8AePgN5uTf1PEhpV640yJJrB6ILwirerxf7ssNfXBzaPBsNw4a/Nh2z0K5CCXIRx3iIgdCZyYGvbpzMuj/gkMqM8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060353; c=relaxed/simple;
	bh=o7B+YiWTDXLS32+gY7wd13a9QP45qCc3OGT8R0QrfYs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kiM3LJ6nW20+5UgfDf0U3mhx4azsN2a4TokChEJDkFGw1GAaOOfvJNyXclyofjU3xv41EXrdmqNi807E9JLk2Xy+H839CjrISQWqrOkcinyLpERXN+hJFa4oLiWOIlrjmdFfcY7Z0oxTUT9/mLYTA3PNj/7Sh8F1nU0jurhTX7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cJ8Jf0vwtzQlLB;
	Fri,  5 Sep 2025 16:14:26 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id CE230140147;
	Fri,  5 Sep 2025 16:19:02 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Sep 2025 16:19:02 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Sep 2025 16:19:01 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v2 2/3] ACPI: processor: Remove unused empty function definition for processor_idle.c
Date: Fri, 5 Sep 2025 16:18:59 +0800
Message-ID: <20250905081900.663869-3-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250905081900.663869-1-lihuisong@huawei.com>
References: <20250905081900.663869-1-lihuisong@huawei.com>
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

If CONFIG_ACPI_PROCESSOR=n and CONFIG_ACPI_PROCESSOR_IDLE=n, we may encounter
some warnings about function defined but not used.
All external functions of processor_idle.c are just used in processor_driver.c.
And if CONFIG_ACPI_PROCESSOR is selected and CONFIG_ACPI_PROCESSOR_IDLE also
be selected automatically. So remove these empty function definitions.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 include/acpi/processor.h | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index ff864c1cee3a..d6a87dc42a9a 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -417,34 +417,14 @@ static inline void acpi_processor_throttling_init(void) {}
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
-
-static inline int acpi_processor_hotplug(struct acpi_processor *pr)
-{
-	return -ENODEV;
-}
 #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
 
 /* in processor_thermal.c */
-- 
2.33.0


