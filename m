Return-Path: <linux-acpi+bounces-19808-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC32CD8D15
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 11:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50AD6302BD85
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 10:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B30364025;
	Tue, 23 Dec 2025 10:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="bKlUMS4h"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B63624D3;
	Tue, 23 Dec 2025 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766484565; cv=none; b=ZW2wDFoDAnykR3Zp6M21dp79tlJSV62q0WVmu8IS0SoINh+XGy/JVBvpQepBoIKDEbKPk5YJzVhflkY0grI8I77DOVc1Arp+cRXbaf/ZEREmPwecwyqNafLhnD1pTt5lzelFf+96lSh3A5awL+uR2X1aKJTysd+nRfSCV4/F4+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766484565; c=relaxed/simple;
	bh=CCaujARh7mq+1vMTQ4Rq79P0abyZ3wRcPhhBzLYWbhw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bunpWsf+HPPrE8PNBCmpIexe089OK5iagX8IDUFH4UujbNak9Mj48d+SycVdwhz08+W/89eEjXYYiU3U8wal3HM0sEbN9MVcXm9cG3vi8DWgk30jkqxWtaoeUmWAJFHn/t8J7aeWgILWQ6nneV0TCnNMvAgNwzsR9gNiLHifF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=bKlUMS4h; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Rw0xCM6rJJdcKaA8C1jrtrwLbYRGWYElsDj57aNkmY0=;
	b=bKlUMS4hqG1yAk1MPW3bPpQRc6MId8bVzRRAEmv5jFeGt9pxALXnZrKBfxNDtNdpxImnTr6Yc
	A4jlZC4ZvoK4eBk1D4yzBvEOPVITIZ89pktqlCZmfriBx//sskS3y/Iylt1QKzASpyeWPoCTtmA
	WA7QQrsy09wzDIYNBCorkIk=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4db9dL1Q2XzKm77;
	Tue, 23 Dec 2025 18:06:14 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 373C74056D;
	Tue, 23 Dec 2025 18:09:21 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Dec 2025 18:09:17 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 23 Dec 2025 18:09:16 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>,
	<AmandeepKaur.Longia@amd.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<prime.zeng@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 3/6] ACPI: processor: Update cpuidle driver check in __acpi_processor_start()
Date: Tue, 23 Dec 2025 18:09:11 +0800
Message-ID: <20251223100914.2407069-4-lihuisong@huawei.com>
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

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Commit 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle
driver registration") moved the ACPI idle driver registration to
acpi_processor_driver_init() and acpi_processor_power_init() does
not register an idle driver any more.

Accordingly, the cpuidle driver check in __acpi_processor_start() needs
to be updated to avoid calling acpi_processor_power_init() without a
cpuidle driver, in which case the registration of the cpuidle device
in that function would lead to a NULL pointer dereference in
__cpuidle_register_device().

Fixes: 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle driver registration")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Link: https://patch.msgid.link/5044465.31r3eYUQgx@rafael.j.wysocki
[ rjw: Changelog update ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 311863e00ffd..f5b4f6a29143 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -166,7 +166,7 @@ static int __acpi_processor_start(struct acpi_device *device)
 	if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
 		dev_dbg(&device->dev, "CPPC data invalid or not present\n");
 
-	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
+	if (cpuidle_get_driver() == &acpi_idle_driver)
 		acpi_processor_power_init(pr);
 
 	acpi_pss_perf_init(pr);
-- 
2.33.0


