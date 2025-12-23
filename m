Return-Path: <linux-acpi+bounces-19804-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB2CCD8D0F
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 11:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9309C302954D
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 10:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1FF362138;
	Tue, 23 Dec 2025 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="FYDvSOty"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F01336212B;
	Tue, 23 Dec 2025 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766484561; cv=none; b=D4TAfGsbmsA6ShHekzS1g7BvJb7pyCqVGesoTWySzn+H/odvy7fnTa8sgGavOFEi1vERSx+rwGCGBPUTaKbSV7vTFPBFGAM8Z1tEYKYpwRVrx/iNAyDtj3EucxwfzfzigUkbBMEnNNqkj/apv7d8EmXwcWVYhAwMJF5NiSiwA2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766484561; c=relaxed/simple;
	bh=XFSrS0I1BodisGjC89RdqcVSlgGH0x1huoF5cUfm+kA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXJ5wMGLTUWiSsFnNP9dA4Z3l2Na6DbUg2TfgCdmBuZCLETPmHhD2wBWjB+re6OOv+s6z73J36bdjOv2HVIWckdOj4miVJgkfYvpt7Kwm+9aZ+4Aw3nDQbhDPSOESeGWuIUGN3of8z+ey5PlUjFpjwdsWodI3oqohjlBbBJoHA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=FYDvSOty; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PfLkNnxEuTD+7h+X8wZSHwVEx8bvihlSpXjEeyaXht4=;
	b=FYDvSOtyLHuuNpA3qdDREBZCQT0WUhjnim1csuCG4o0AoEYUHCvHccvjghHuf5t1bCUNzfZR4
	6+V9OS2h4lFro/3Kr+Yc9JFlIahiBiqghh/iY9MJDQMrGmhmpL+sIrT9tsZExk/AWfaajBNoiGq
	rWE7THuaSLdX5MytrauNVZA=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4db9dD2xv9z1prMt;
	Tue, 23 Dec 2025 18:06:08 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id CADBE40567;
	Tue, 23 Dec 2025 18:09:16 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Dec 2025 18:09:16 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 23 Dec 2025 18:09:15 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>,
	<AmandeepKaur.Longia@amd.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<prime.zeng@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 2/6] ACPI: processor: Remove unused empty stubs of some functions
Date: Tue, 23 Dec 2025 18:09:10 +0800
Message-ID: <20251223100914.2407069-3-lihuisong@huawei.com>
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

Empty stubs are defined in processor.h for some functions provided by
the ACPI processor idle driver, but those functions are only used in
the main ACPI processor driver which requires the ACPI processor idle
driver to be present (selecting CONFIG_ACPI_PROCESSOR causes
CONFIG_ACPI_PROCESSOR_IDLE to be selected too automatically).

This means that the empty stubs in question are not really necessary and
if both CONFIG_ACPI_PROCESSOR and CONFIG_ACPI_PROCESSOR_IDLE are unset,
the compiler complains that they are defined, but not used.  Drop them
to get rid of the compiler warning.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
Link: https://patch.msgid.link/20250911112408.1668431-2-lihuisong@huawei.com
[ rjw: Subject and changelog rewrite ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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


