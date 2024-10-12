Return-Path: <linux-acpi+bounces-8726-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF0999B20E
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2024 10:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FBC51F215F3
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2024 08:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C3C146599;
	Sat, 12 Oct 2024 08:20:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51B2145B0F;
	Sat, 12 Oct 2024 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728721222; cv=none; b=sy9iBs13e7fY+faKOSowwUaG1RCG0d+IkpODKlYTZuGy40wTaz8r4jlbr37iN1lKdThWnAqGGAsWCl2LgrWxNtS7q8740OqUaHLFaiSNPzlPZjaRfEVBlB35V7iobwTBWPvl4n0EvkgJ+9TdhlwHsMSZRjxhw3Xxz0ZI4x0dN3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728721222; c=relaxed/simple;
	bh=9wa2bJh2biaS1qUjXKCo5Jv/750/vTldRH50evS7ekE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TCz0vCypEF9akwE3Nily+x4NsQI7Wl9yYuR1uauyJBQsieU+Cb+vZGWwqyPizYu09+qwrLQZ8PIr448kh41E62f1uYulDw4u2eXUqN1TRadvBJlp8cWazciluxKQxSA1MMfBnJipiKVGbCRSQ7EyhlpUtjY1TrTfJZRkXbO2Dzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XQbt033J8z1HKrB;
	Sat, 12 Oct 2024 16:16:08 +0800 (CST)
Received: from kwepemd200010.china.huawei.com (unknown [7.221.188.124])
	by mail.maildlp.com (Postfix) with ESMTPS id 4AA741403D2;
	Sat, 12 Oct 2024 16:20:17 +0800 (CST)
Received: from huawei.com (10.175.113.25) by kwepemd200010.china.huawei.com
 (7.221.188.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Sat, 12 Oct
 2024 16:20:00 +0800
From: Zheng Zengkai <zhengzengkai@huawei.com>
To: <lpieralisi@kernel.org>, <guohanjun@huawei.com>, <sudeep.holla@arm.com>,
	<mark.rutland@arm.com>, <maz@kernel.org>, <rafael@kernel.org>,
	<lenb@kernel.org>
CC: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <zhengzengkai@huawei.com>
Subject: [PATCH v2] ACPI: GTDT: Tighten the check for the array of platform timer structures
Date: Sat, 12 Oct 2024 16:53:43 +0800
Message-ID: <20241012085343.6594-1-zhengzengkai@huawei.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200010.china.huawei.com (7.221.188.124)

As suggested by Marc and Lorenzo, first we need to check whether the
platform_timer entry pointer is within gtdt bounds (< gtdt_end) before
de-referencing what it points at to detect the length of the platform
timer struct and then check that the length of current platform_timer
struct is within gtdt_end too. Now next_platform_timer() only checks
against gtdt_end for the entry of subsequent platform timer without
checking the length of it and will not report error if the check failed.

Add check against table length (gtdt_end) for each element of platform
timer array in acpi_gtdt_init() early, making sure that both their entry
and length actually fit in the table.

For the first platform timer, keep the check against the end of the
acpi_table_gtdt struct, it is unnecessary for subsequent platform timer.

Suggested-by: Marc Zyngier <maz@kernel.org>
Suggested-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
---
Changes in v2:
- Check against gtdt_end for both entry and len of each array element

v1: https://lore.kernel.org/all/20241010144703.113728-1-zhengzengkai@huawei.com/
---
 drivers/acpi/arm64/gtdt.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index c0e77c1c8e09..f5f62643899d 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -157,6 +157,8 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
 {
 	void *platform_timer;
 	struct acpi_table_gtdt *gtdt;
+	struct acpi_gtdt_header *gh;
+	void *struct_end;
 
 	gtdt = container_of(table, struct acpi_table_gtdt, header);
 	acpi_gtdt_desc.gtdt = gtdt;
@@ -177,11 +179,20 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
 	}
 
 	platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
-	if (platform_timer < (void *)table + sizeof(struct acpi_table_gtdt)) {
-		pr_err(FW_BUG "invalid timer data.\n");
-		return -EINVAL;
+	struct_end = (void *)table + sizeof(struct acpi_table_gtdt);
+	for (int i = 0; i < gtdt->platform_timer_count; i++) {
+		gh = platform_timer;
+		if (((i == 0 && platform_timer >= struct_end) || i != 0) &&
+			platform_timer < acpi_gtdt_desc.gtdt_end &&
+			platform_timer + gh->length <= acpi_gtdt_desc.gtdt_end) {
+			platform_timer += gh->length;
+		} else {
+			pr_err(FW_BUG "invalid timer data.\n");
+			return -EINVAL;
+		}
 	}
-	acpi_gtdt_desc.platform_timer = platform_timer;
+
+	acpi_gtdt_desc.platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
 	if (platform_timer_count)
 		*platform_timer_count = gtdt->platform_timer_count;
 
-- 
2.20.1


