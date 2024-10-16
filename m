Return-Path: <linux-acpi+bounces-8810-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 538839A0543
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 11:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152CD285CBB
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 09:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D961E204934;
	Wed, 16 Oct 2024 09:21:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB5D1D90DD;
	Wed, 16 Oct 2024 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070495; cv=none; b=L5lx18YhiNvAOCR1BAzYHs9S2bNm0Scn4uPUQZWzZX5xgPsPJ5DdqoLiF1qSrwJxxgkq6pN6w55RLL2iTfFzPw/h4Jd2cE869vrEPpEiGDwPnKzl3jNcTHWDRHRxmnwQeCapqof8H2GazrgZRFPfIChFcyMVg8Wc/GnIYFHAyLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070495; c=relaxed/simple;
	bh=re5iF3yVOjF2BgRHj3pjVBxIhCLycoiqhjrd3dLPAvA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VEZO9uhRG7t76266zyHEhSAcxKk7SZME/udVFzt3kyW71vRxnqjlUBEgAc/jxEkgntoNjytmrt3+E5XD6iqHJtgKpTr7Cuj/qVxh6OrV9FSMNigxlgvsRbZYSy6STv/rMq2/0FM/WQhEwMRY3RtYY51VJWa8cqeuqTEbORZywWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XT55J22WtzpX4f;
	Wed, 16 Oct 2024 17:19:32 +0800 (CST)
Received: from kwepemd200010.china.huawei.com (unknown [7.221.188.124])
	by mail.maildlp.com (Postfix) with ESMTPS id A30DD1402C8;
	Wed, 16 Oct 2024 17:21:30 +0800 (CST)
Received: from huawei.com (10.175.113.25) by kwepemd200010.china.huawei.com
 (7.221.188.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 16 Oct
 2024 17:21:29 +0800
From: Zheng Zengkai <zhengzengkai@huawei.com>
To: <lpieralisi@kernel.org>, <guohanjun@huawei.com>, <sudeep.holla@arm.com>,
	<mark.rutland@arm.com>, <maz@kernel.org>, <rafael@kernel.org>,
	<lenb@kernel.org>
CC: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <zhengzengkai@huawei.com>
Subject: [PATCH v4] ACPI: GTDT: Tighten the check for the array of platform timer structures
Date: Wed, 16 Oct 2024 17:54:58 +0800
Message-ID: <20241016095458.34126-1-zhengzengkai@huawei.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200010.china.huawei.com (7.221.188.124)

As suggested by Marc and Lorenzo, first we need to check whether the
platform_timer entry pointer is within gtdt bounds (< gtdt_end) before
de-referencing what it points at to detect the length of the platform
timer struct and then check that the length of current platform_timer
struct is also valid, i.e. the length is not zero and within gtdt_end.
Now next_platform_timer() only checks against gtdt_end for the entry of
subsequent platform timer without checking the length of it and will
not report error if the check failed and the existing check in function
acpi_gtdt_init() is also not enough.

Modify the for_each_platform_timer() iterator and use it combined with
a dedicated check function platform_timer_valid() to do the check
against table length (gtdt_end) for each element of platform timer
array in function acpi_gtdt_init(), making sure that both their entry
and length actually fit in the table.

Suggested-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Co-developed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
---
Changes in v4:
- remove the tmp pointer to make the code more concise.

Changes in v3:
- based on Marc's patch and reuse the for_each_platform_timer() loop
Link to v3: https://lore.kernel.org/linux-arm-kernel/20241015152602.184108-1-zhengzengkai@huawei.com/

Changes in v2:
- Check against gtdt_end for both entry and len of each array element
Link to v2: https://lore.kernel.org/linux-arm-kernel/20241012085343.6594-1-zhengzengkai@huawei.com/

Link to v1: https://lore.kernel.org/all/20241010144703.113728-1-zhengzengkai@huawei.com/

Link to previous related patches:
https://lore.kernel.org/all/20241008082429.33646-1-zhengzengkai@huawei.com/
https://lore.kernel.org/all/20240930030716.179992-1-zhengzengkai@huawei.com/
---
 drivers/acpi/arm64/gtdt.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index c0e77c1c8e09..d7c4e1b9915b 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -36,19 +36,25 @@ struct acpi_gtdt_descriptor {
 
 static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
 
-static inline __init void *next_platform_timer(void *platform_timer)
+static __init bool platform_timer_valid(void *platform_timer)
 {
 	struct acpi_gtdt_header *gh = platform_timer;
 
-	platform_timer += gh->length;
-	if (platform_timer < acpi_gtdt_desc.gtdt_end)
-		return platform_timer;
+	return (platform_timer >= (void *)(acpi_gtdt_desc.gtdt + 1) &&
+		platform_timer < acpi_gtdt_desc.gtdt_end &&
+		gh->length != 0 &&
+		platform_timer + gh->length <= acpi_gtdt_desc.gtdt_end);
+}
+
+static __init void *next_platform_timer(void *platform_timer)
+{
+	struct acpi_gtdt_header *gh = platform_timer;
 
-	return NULL;
+	return platform_timer + gh->length;
 }
 
 #define for_each_platform_timer(_g)				\
-	for (_g = acpi_gtdt_desc.platform_timer; _g;	\
+	for (_g = acpi_gtdt_desc.platform_timer; platform_timer_valid(_g);\
 	     _g = next_platform_timer(_g))
 
 static inline bool is_timer_block(void *platform_timer)
@@ -157,6 +163,7 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
 {
 	void *platform_timer;
 	struct acpi_table_gtdt *gtdt;
+	int cnt = 0;
 
 	gtdt = container_of(table, struct acpi_table_gtdt, header);
 	acpi_gtdt_desc.gtdt = gtdt;
@@ -176,12 +183,16 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
 		return 0;
 	}
 
-	platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
-	if (platform_timer < (void *)table + sizeof(struct acpi_table_gtdt)) {
+	acpi_gtdt_desc.platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
+	for_each_platform_timer(platform_timer)
+		cnt++;
+
+	if (cnt != gtdt->platform_timer_count) {
+		acpi_gtdt_desc.platform_timer = NULL;
 		pr_err(FW_BUG "invalid timer data.\n");
 		return -EINVAL;
 	}
-	acpi_gtdt_desc.platform_timer = platform_timer;
+
 	if (platform_timer_count)
 		*platform_timer_count = gtdt->platform_timer_count;
 
-- 
2.20.1


