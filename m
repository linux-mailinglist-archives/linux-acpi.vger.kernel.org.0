Return-Path: <linux-acpi+bounces-16667-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F26B5302A
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 13:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E60B61D20
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 11:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9303191CE;
	Thu, 11 Sep 2025 11:24:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E2C1CAA4;
	Thu, 11 Sep 2025 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589856; cv=none; b=rkDvEosiL2Qk3mJfTrXZVGqPZ8/PEhM3P67BVfiHHW9PMCgpLZUmR/uFY5X8gRKRhHAHzKtcIsKOYZLpyoNTDycEapolo0eNb/XnEUQZ20M5KKpF0toQbHUylMwbCYAK+4y17sC3iDelPu0PRilJLMEhDl9raiBASCuqGTxz/24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589856; c=relaxed/simple;
	bh=R4EExJk24GEfY/8r2nfKYYXjBuAHTGzVqbkOoGpOdzc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1nXIp+FZVWdzWuN/8m1VRTnGKG/UQf7+hr7OJ8QyChB9itl8yZoDOIZUuZ8P3Nh1vY55jG/z5DTUa7Fr3rIXr6jzr5AtG2nPVLkCV4W95IlZVf/tTajwrxnnyTyfrY2MjKQpB+3m9RnwrB2i7Agu/xWf/Be8oYJiY5liRIdBjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cMw7Y4q5lzdd0h;
	Thu, 11 Sep 2025 19:19:37 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 99D3F140278;
	Thu, 11 Sep 2025 19:24:10 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Sep 2025 19:24:10 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Sep 2025 19:24:09 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v3 1/3] ACPI: processor: Remove unused empty function definition for processor_idle.c
Date: Thu, 11 Sep 2025 19:24:06 +0800
Message-ID: <20250911112408.1668431-2-lihuisong@huawei.com>
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

If CONFIG_ACPI_PROCESSOR=n and CONFIG_ACPI_PROCESSOR_IDLE=n,
we may encounter some warnings about function defined but not
used. All external functions of processor_idle.c are just used
in processor_driver.c. And if CONFIG_ACPI_PROCESSOR is selected
and CONFIG_ACPI_PROCESSOR_IDLE also be selected automatically.
So remove these empty function definitions.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 include/acpi/processor.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index ff864c1cee3a..2976a6d0c54f 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -425,26 +425,6 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr);
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


