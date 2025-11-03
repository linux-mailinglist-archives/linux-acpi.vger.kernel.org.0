Return-Path: <linux-acpi+bounces-18420-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04076C2A9A5
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 09:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4239E3A6027
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 08:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA772E2659;
	Mon,  3 Nov 2025 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="hZS/5hKm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A22E06E6;
	Mon,  3 Nov 2025 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159373; cv=none; b=l77JPTygvMMQVwU5fWY244Y5SWg2AIr16e+fR58MHkCLEu4JPzASNECBdvgDmsYPHrpRJWxJb0U+c1+8CsIaJfvbL1nVSwl39sPRql53vGXgwyn56kvOC4i2nCcDJubA9AugeF7C2E3JTtWJ3Xa8GfPrCV9D8YUUesM5a/ckseg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159373; c=relaxed/simple;
	bh=NnDVBsPc1xQWH6peSJjCz1anLjKXzvW8HHda7nVPfbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQUPbG4LwiZlfVEgUC3C0nKvP8yC1z/iCcg18r4ALcV0poJ6mb32oHzJDObMOM/KNMoxISbh/TdmexYpJnmaMXKZSpXR9R3MONnnd34fvbuhJjsxiHoN6o+QTPlmbdfO+XRzYnZfgywPprJXQ94jZoUdrbEyDXb5yK2NTBmP81o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=hZS/5hKm; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Di08QW/pxyKcxoJEzwov9ToRIKQZrhMMFw3faya4aJY=;
	b=hZS/5hKmeAVVIfHKYq7mwOTrwOPqrnnK+NNfxhHjhelLa2ve97S+u8ZXwpExYgXqKa6lkaMxM
	rT5lT178Un6enUSpdM5xAyO6W91GQRbeOlSwtYBHxLr2incKQ43EbC5OZPwrc4SeE+eRrvqiMoJ
	hj+DFIhrdtIi+tjwquO3DLQ=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4d0Q6L3WV7zLlVC;
	Mon,  3 Nov 2025 16:41:14 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 233A31A0188;
	Mon,  3 Nov 2025 16:42:48 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 16:42:47 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 16:42:47 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v2 6/7] ACPI: processor: idle: Redefine setup idle functions to void
Date: Mon, 3 Nov 2025 16:42:43 +0800
Message-ID: <20251103084244.2654432-7-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251103084244.2654432-1-lihuisong@huawei.com>
References: <20251103084244.2654432-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Notice that the acpi_processor_setup_cpuidle_states() don't need to
return any value because their callers don't check them anyway.
In addition, acpi_processor_setup_lpi_states() wouldn't execute with
failure. So redefine setup idle functions to void.

No intentional functional impact.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 1f332f02d273..46614cf1ae8b 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1185,7 +1185,7 @@ static int acpi_idle_lpi_enter(struct cpuidle_device *dev,
 	return -EINVAL;
 }
 
-static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
+static void acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 {
 	int i;
 	struct acpi_lpi_state *lpi;
@@ -1193,7 +1193,7 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 	struct cpuidle_driver *drv = &acpi_idle_driver;
 
 	if (!pr->flags.has_lpi)
-		return -EOPNOTSUPP;
+		return;
 
 	for (i = 0; i < pr->power.count && i < CPUIDLE_STATE_MAX; i++) {
 		lpi = &pr->power.lpi_states[i];
@@ -1211,8 +1211,6 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 	}
 
 	drv->state_count = i;
-
-	return 0;
 }
 
 /**
@@ -1221,13 +1219,13 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
  *
  * @pr: the ACPI processor
  */
-static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
+static void acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 {
 	int i;
 	struct cpuidle_driver *drv = &acpi_idle_driver;
 
 	if (!pr->flags.power_setup_done || !pr->flags.power)
-		return -EINVAL;
+		return;
 
 	drv->safe_state_index = -1;
 	for (i = ACPI_IDLE_STATE_START; i < CPUIDLE_STATE_MAX; i++) {
@@ -1235,11 +1233,12 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 		drv->states[i].desc[0] = '\0';
 	}
 
-	if (pr->flags.has_lpi)
-		return acpi_processor_setup_lpi_states(pr);
+	if (pr->flags.has_lpi) {
+		acpi_processor_setup_lpi_states(pr);
+		return;
+	}
 
 	acpi_processor_setup_cstates(pr);
-	return 0;
 }
 
 /**
-- 
2.33.0


