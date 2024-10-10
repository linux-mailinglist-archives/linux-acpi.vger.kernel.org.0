Return-Path: <linux-acpi+bounces-8683-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CA799893C
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2024 16:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915181C24E40
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2024 14:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAFD1CC141;
	Thu, 10 Oct 2024 14:13:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542E71CB304;
	Thu, 10 Oct 2024 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569599; cv=none; b=mbU7j+tIm3N/ootSoTo60hY+yRrQCNWajeBLaBV9i+iuXTNYvplMVol71EMkm9aeTAcd8l7EQrtKrIiG51LYsw4QjutA/4tnQ3tYy3msHylGnMBX5N0c6WuhEu/oVTfAW9bn6czcL/J7ZC4e4pGsb4cqJlNLILGYsA+sgQhxa4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569599; c=relaxed/simple;
	bh=OmcG443twSS/Osefolp7j0mGiMFmTvpws3iTcgLTkzA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q1DRq+zH8RDkeLuzx91hTBwWDKF2pdK35Iayxgh2UTc/iRiC3W5vCV53aVSiUhxstA4E9wZ1VEiau64fFmWVbkj7AnFkdNikjmsWFjoT3nzZGZXvQwVGCBEz1Ik537uwrh8aFkmMvahqPAFVTBX5iJnL0mgoI7Q9V+n5wYjqqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XPWsj3RVDz1j9ND;
	Thu, 10 Oct 2024 22:12:09 +0800 (CST)
Received: from kwepemd200010.china.huawei.com (unknown [7.221.188.124])
	by mail.maildlp.com (Postfix) with ESMTPS id 04708140120;
	Thu, 10 Oct 2024 22:13:16 +0800 (CST)
Received: from huawei.com (10.175.113.25) by kwepemd200010.china.huawei.com
 (7.221.188.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 10 Oct
 2024 22:13:14 +0800
From: Zheng Zengkai <zhengzengkai@huawei.com>
To: <lpieralisi@kernel.org>, <guohanjun@huawei.com>, <sudeep.holla@arm.com>,
	<mark.rutland@arm.com>, <maz@kernel.org>, <rafael@kernel.org>,
	<lenb@kernel.org>
CC: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <zhengzengkai@huawei.com>
Subject: [PATCH] ACPI: GTDT: Tighten the check for the first platform timer entry
Date: Thu, 10 Oct 2024 22:47:03 +0800
Message-ID: <20241010144703.113728-1-zhengzengkai@huawei.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200010.china.huawei.com (7.221.188.124)

As suggested by Marc and Lorenzo, first we need to check whether
the platform_timer pointer is within gtdt bounds (< gtdt_end) before
de-referencing what it points at to detect the (first) platform
timer entry length and check that next platform_timer pointer is
within gtdt_end too. Now we do that only in next_platform_timer()
for subsequent platform timers.

So add check against table length (gtdt_end) for the first platform
timer entry.

Suggested-by: Marc Zyngier <maz@kernel.org>
Suggested-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
---
 drivers/acpi/arm64/gtdt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index c0e77c1c8e09..f249af1ed1cd 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -177,7 +177,8 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
 	}
 
 	platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
-	if (platform_timer < (void *)table + sizeof(struct acpi_table_gtdt)) {
+	if (platform_timer < (void *)table + sizeof(struct acpi_table_gtdt) ||
+			platform_timer >= acpi_gtdt_desc.gtdt_end) {
 		pr_err(FW_BUG "invalid timer data.\n");
 		return -EINVAL;
 	}
-- 
2.20.1


