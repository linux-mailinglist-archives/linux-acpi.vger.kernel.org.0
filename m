Return-Path: <linux-acpi+bounces-16391-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13909B45123
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 10:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7AD01C2619D
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 08:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BCB26F2BC;
	Fri,  5 Sep 2025 08:19:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA425949A;
	Fri,  5 Sep 2025 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060349; cv=none; b=t2XMPd+2BV7czc9GlREJkfVPKlC2WMenlxsvvUG4jaNMRkOAd4WPIGgo4pmJeEHjdtY9C8aw1Vpeos40UrFBtjHSIywOEIXlEkyGzA0B+eYCXsRJ5UPJmIDvwr9J+J+Xyf9g9IwIRQFRs6qDauePfpBi5qCZbdD55A1Tw2r2bB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060349; c=relaxed/simple;
	bh=9yoRVIvhk5C1PfPAObd14uUpbtbJ+f9TA3IATTlSm3w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cskY0HUYt2qphwfV0fPHZFR5pnuoSDRCkuT17ukhJwIrPAGk3GDSkG4tlKuw4mVf8SbgKqko9lFUS2Qx4rlUjyozBN4i4DI2azj4aN32rHOdk7ZtnGg9AxBHc6Rwg/GHNMzX/E/Xb/TEaenA5UE4U14KuBsvl1AuibivJKIYP/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cJ8RH6jgLz3tZVQ;
	Fri,  5 Sep 2025 16:20:11 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id B74601A0188;
	Fri,  5 Sep 2025 16:19:03 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
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
Subject: [PATCH v2 1/3] ACPI: processor: Fix function defined but not used warning
Date: Fri, 5 Sep 2025 16:18:58 +0800
Message-ID: <20250905081900.663869-2-lihuisong@huawei.com>
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

If CONFIG_ACPI_PROCESSOR=n and CONFIG_ACPI_PROCESSOR_IDLE=n, we may
encounter some compling warnings as the following link said.
The acpi_processor_register/unregister_idle_driver() would not be
used when CONFIG_ACPI_PROCESSOR_IDLE is n. So remove these empty
function definition.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508300519.tZQHY6HA-lkp@intel.com/
Fixes: 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle driver registration")
Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 include/acpi/processor.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 360b673f05e5..ff864c1cee3a 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -445,12 +445,6 @@ static inline int acpi_processor_hotplug(struct acpi_processor *pr)
 {
 	return -ENODEV;
 }
-static inline void acpi_processor_register_idle_driver(void)
-{
-}
-static inline void acpi_processor_unregister_idle_driver(void)
-{
-}
 #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
 
 /* in processor_thermal.c */
-- 
2.33.0


