Return-Path: <linux-acpi+bounces-19233-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2A4C8395C
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 07:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66A8434D28D
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 06:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FD92D4B6D;
	Tue, 25 Nov 2025 06:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="cebckWTP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1972C21C7;
	Tue, 25 Nov 2025 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764053538; cv=none; b=byvjDNM1h+6QhqhlLATD+dciVV8MvMDOUY9fs5fSGzDTC9ZBbAaeSnP7VKdTMdVde/uGhBHFdqe3Q2QNa4etxH8jU83PwrODiQJj8t6odb2X8utQd3BhbT7OhvMqDjGvfQnWkant2srqihnV/ybrLQn2NteHWKeqvaKlDMwNDGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764053538; c=relaxed/simple;
	bh=rGBAlt8OJ2bjKgg2RkkpV/q3nlQDT8cdUWv40v9UMQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTqaQ1bl/++mXMofp3O6eZ9wtfHwkeQqb7PFy3630xzAK+WrxSvUGjPsE79QLGU6/15zkt3p+6NgnpUcp3eGJeo5nm1x5BN44W5USr3Z9cY12VwEy+zhtnislofK7dBGZsZHGXUfUcPO6UjnLEs2CrVDXSBuWLd6/XDaODDqliI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=cebckWTP; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=krug79HeojaAfNB3caI6md9HquGK2NT19tkhxjhLbOE=;
	b=cebckWTPqPMjiy3hCo6mPKY4dwBLtbuO8HB6wUwUvElFLIY/qPLLjoK+G/ptDADwRvAz7bOpB
	zG/ZTzFBKAaujmZYZa+M/I57ZSJzVE7UYcw5HimQTqbUNhQUrbR/SighR948IW5UCrTzgq5P9PO
	DwdhJBcw+nkytVrtt8o1YIg=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dFtcK4Y8HzLlTw;
	Tue, 25 Nov 2025 14:50:25 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9846D14027A;
	Tue, 25 Nov 2025 14:52:12 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Nov 2025 14:52:12 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 25 Nov 2025 14:52:11 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH 3/3] ACPI: processor: idle: Redefine acpi_processor_setup_cpuidle_states to void
Date: Tue, 25 Nov 2025 14:52:10 +0800
Message-ID: <20251125065210.3670266-4-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251125065210.3670266-1-lihuisong@huawei.com>
References: <20251125065210.3670266-1-lihuisong@huawei.com>
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
index 2804fa91c1ec..686aa18bbcd2 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1180,7 +1180,7 @@ static int acpi_idle_lpi_enter(struct cpuidle_device *dev,
 	return -EINVAL;
 }
 
-static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
+static void acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 {
 	int i;
 	struct acpi_lpi_state *lpi;
@@ -1188,7 +1188,7 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 	struct cpuidle_driver *drv = &acpi_idle_driver;
 
 	if (!pr->flags.has_lpi)
-		return -EOPNOTSUPP;
+		return;
 
 	for (i = 0; i < pr->power.count && i < CPUIDLE_STATE_MAX; i++) {
 		lpi = &pr->power.lpi_states[i];
@@ -1206,8 +1206,6 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 	}
 
 	drv->state_count = i;
-
-	return 0;
 }
 
 /**
@@ -1216,13 +1214,13 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
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
@@ -1230,11 +1228,12 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
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


