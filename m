Return-Path: <linux-acpi+bounces-19237-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA921C83BA1
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 08:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C47F3ADEA2
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 07:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58972D9EC5;
	Tue, 25 Nov 2025 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="JjwnHsMd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD6B2D73A9;
	Tue, 25 Nov 2025 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055781; cv=none; b=YJOCK7BoOG3u7qOu6hm8aR4m6x2hw39k3UBvfvVsbIZmQvZe6wa5um1x3pevi2p5nf+fPcT3FNgyaw9tgiV9sS1bKoGmM6kN3sA4V6EFeRUUsFqehg4cjsGpTCC9orK5WyzWxA15uYOinZadA42ZHBiqXCLaEs9yDE6KI5JWfAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055781; c=relaxed/simple;
	bh=teSNBsRwcRRwniPEDYSxcu3kWy7IPtFhJxEjSGZwADo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oas5F7LF+uX+XHEruSekO+a2XttMo6XhH8BKodURiweg+ckvuAKMnGk3lrxy49VJIdMP9HMBuSolePXeORuYUU91sJhi5DcWdjgS5FpE8fQBT96tc3rNyM7zK2jxickvTYriRBL5KJa44beXtN8LSN8zLoTYjqXEtGqTWPVTRZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=JjwnHsMd; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=F4LQMeD2kHahQ+1nrC+W98OH/wc9EAR9nP6PI06pBgQ=;
	b=JjwnHsMd/YQmZmbQAerSzyVF7La1XUJTn3RjVH/oo2ECvqBGnyz/5vNmT4mhLn5nrEKMi3bwK
	xSnosaN+KYmTQ55sZbCZAvo3C5nBF1hb1hAnvSwft4J64W+njuFlYM7TB5kYmfHjccvASFEBXn2
	tWp2o/RQ8iwZ0Z6ZpYTm1zg=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dFvQz4lBRzcZxk;
	Tue, 25 Nov 2025 15:27:23 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id BD8241402C1;
	Tue, 25 Nov 2025 15:29:36 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Nov 2025 15:29:36 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 25 Nov 2025 15:29:35 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH 3/3] ACPI: processor: idle: Update idle states from avaiable power information
Date: Tue, 25 Nov 2025 15:29:33 +0800
Message-ID: <20251125072933.3706006-4-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251125072933.3706006-1-lihuisong@huawei.com>
References: <20251125072933.3706006-1-lihuisong@huawei.com>
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

Currently, the ACPI power notify makes it once per system instead of once per-cpu.
And driver selects the notify on CPU0 to update idle states.

The same idle state is used for all CPUs. An avaiable power information
is obtained successfully from any CPUs can be used to populate the ACPI idle
states as acpi_processor_register_idle_driver() did.
So keep the same logical to get avaiable power information from online CPUs
instead of CPU0 to update idle states in power notify.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index cd4d1d8d70b0..8d3122a4e6d0 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1332,19 +1332,26 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
 		 *
 		 * The same idle state is used for all CPUs.
 		 * The old idle state may not be usable anymore if fail to get
-		 * ACPI power information of CPU0.
+		 * available ACPI power information from any online CPU.
 		 * The cpuidle of all CPUs should be disabled.
 		 */
-		ret = acpi_processor_get_power_info(pr);
+		ret = -ENODEV;
+		for_each_online_cpu(cpu) {
+			_pr = per_cpu(processors, cpu);
+			if (!_pr && !_pr->flags.power_setup_done)
+				continue;
+			ret = acpi_processor_get_power_info(_pr);
+			if (!ret) {
+				acpi_processor_setup_cpuidle_states(_pr);
+				break;
+			}
+		}
 		if (ret) {
 			/* Ensure cpuidle of offline CPUs are inavaliable. */
 			disable_cpuidle();
-			pr_err("Get processor-%u power information failed, disable cpuidle of all CPUs\n",
-			       pr->id);
+			pr_err("No available ACPI power information, disable cpuidle of all CPUs.\n");
 			goto release_lock;
 		}
-
-		acpi_processor_setup_cpuidle_states(pr);
 		enable_cpuidle();
 
 		/* Enable all cpuidle devices */
-- 
2.33.0


