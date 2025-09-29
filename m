Return-Path: <linux-acpi+bounces-17397-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6BBBA8AA7
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 11:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FA7189DA96
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 09:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3362C2376;
	Mon, 29 Sep 2025 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="URFpKcM2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55BF2C21F9;
	Mon, 29 Sep 2025 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138689; cv=none; b=Ae2lQVFf7/QKgStTLKSt7Qtrxj3YJ9qIuelGF2QedhAOGXwfyEv/HHGYtJvJRFRGbYuYKKD/yvpneMQMTJw4bk9OCXcq8C1ylQsn/B5k+eHesE6AzQyQGbzTDiiRchFMufTJFBB3ZoDDPDqGS2Tm9KWFz6l54CZmzPG3dkdsuj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138689; c=relaxed/simple;
	bh=zH1x339kthy7EbwSWXzqpQhEMlMBNP0qpMpcpW6PQHU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbSQ3NDhw/EewqqxSqm1BWTzCxlxJ4V/PagJG1TGQYs16RPJMc2le49qG28AOgVyhUqxbxZat+qN+VVe96UkWqXE6XOYpZiBoU4SwJT9i9fvDa0D/yWuA3W9ouWaFBNKfW2gVOA1h/QQXlgbK7H7SN/Nr5QL4F/a3y6wwFHT/T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=URFpKcM2; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qTJs2ZpOerQeXEWOV9Z/f0oBIE1p3YB1jRJO+1Qveaw=;
	b=URFpKcM2HBF7Kcqlu3jc0EEoGikZumVcOlqvoTOddgUbmZPHkvf92ElHuIWHhCqB8qXmu3oP4
	Hpi9tcEptmp7BiLwcbnVif10hfItsYWjuayiAlQCFGy5qivfFzvsGlU4ikJV7bkZ13AZLYUQQ3w
	lqm/8jIXtrx5ncUqeXTlS7A=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cZx1Q1vxjzcbZX;
	Mon, 29 Sep 2025 17:37:30 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 651DD180B5F;
	Mon, 29 Sep 2025 17:37:59 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 17:37:59 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 17:37:58 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v1 8/9] ACPI: processor: idle: Redefine setup idle functions to void
Date: Mon, 29 Sep 2025 17:37:53 +0800
Message-ID: <20250929093754.3998136-9-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250929093754.3998136-1-lihuisong@huawei.com>
References: <20250929093754.3998136-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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
index 2d672afc7498..9f456a6fa584 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1183,7 +1183,7 @@ static int acpi_idle_lpi_enter(struct cpuidle_device *dev,
 	return -EINVAL;
 }
 
-static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
+static void acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 {
 	int i;
 	struct acpi_lpi_state *lpi;
@@ -1191,7 +1191,7 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 	struct cpuidle_driver *drv = &acpi_idle_driver;
 
 	if (!pr->flags.has_lpi)
-		return -EOPNOTSUPP;
+		return;
 
 	for (i = 0; i < pr->power.count && i < CPUIDLE_STATE_MAX; i++) {
 		lpi = &pr->power.lpi_states[i];
@@ -1209,8 +1209,6 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 	}
 
 	drv->state_count = i;
-
-	return 0;
 }
 
 /**
@@ -1219,13 +1217,13 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
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
@@ -1233,11 +1231,12 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
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


