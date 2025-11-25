Return-Path: <linux-acpi+bounces-19238-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8464C83BA4
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 08:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383303AEC92
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 07:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57372E8E06;
	Tue, 25 Nov 2025 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="o+6dKQ+k"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00A7277C9D;
	Tue, 25 Nov 2025 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055782; cv=none; b=B/uA0jdrVuDGiSroAOfRD2tRWk6mJcjchhY+/UUVpiZE0rHdFvqtS8K/8rOYwQMxteSA6FEuTMIjdZ6SOqVzUNMTsV7MSVyeJshqIC2FKNp4W4N8T7Nn6mAqKpvsehGRPlzjHbCePUyqqNY7uoZMWkNVvyKM76kIvHSJMJOrfik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055782; c=relaxed/simple;
	bh=DtIRHZYQlefCOCKKA1gI9C2LJXsiG17trnRZFBgYGNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQJopDaiEKDK5ptllNpATxxBCzaPa7hsHciH4FdNfeN7TYVKcSTfCG+XmQvwB/o/YGEXpE+Sy79mVtcFA/uhb6tLB8dvoZisXO1fNzZYaznlQPoXYz5PfxFVQEFHdgfJw63zRiW6P8EPLvx6eiEmbyVnuJFvdqNYI/IbCNIxqVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=o+6dKQ+k; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zlMmNKdqNyikz+CDppi5yO3MNdJ8QEte/0cAyLq9xNo=;
	b=o+6dKQ+kkHtp1xYwh/l4ggKyGH6s2WjcDvOefr/YKQWeXgRN6lq12szPJR82Z7zQn6p+do2E/
	OODVeHR3rrtk6F1RSdN4qKvJc3YrSsMLZ+HLgi8WLaZh45Md3bu/i1FRGc3hh9OnCdFeoaBRuwk
	2tihbSz1PZJkTyRD37o91aQ=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dFvRS233KzKm4X;
	Tue, 25 Nov 2025 15:27:48 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 393E2140230;
	Tue, 25 Nov 2025 15:29:36 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
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
Subject: [PATCH 2/3] ACPI: processor: idle: Disable ACPI idle if get power information failed in power notify
Date: Tue, 25 Nov 2025 15:29:32 +0800
Message-ID: <20251125072933.3706006-3-lihuisong@huawei.com>
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

The old states may not be usable any more if get power information
failed in power notify. The ACPI idle should be disabled entirely.

Fixes: f427e5f1cf75 ("ACPI / processor: Get power info before updating the C-states")
Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 5f86297c8b23..cd4d1d8d70b0 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1298,6 +1298,7 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
 	int cpu;
 	struct acpi_processor *_pr;
 	struct cpuidle_device *dev;
+	int ret = 0;
 
 	if (disabled_by_idle_boot_param())
 		return 0;
@@ -1326,27 +1327,44 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
 			cpuidle_disable_device(dev);
 		}
 
-		/* Populate Updated C-state information */
-		acpi_processor_get_power_info(pr);
+		/*
+		 * Update C-state information based on new power information.
+		 *
+		 * The same idle state is used for all CPUs.
+		 * The old idle state may not be usable anymore if fail to get
+		 * ACPI power information of CPU0.
+		 * The cpuidle of all CPUs should be disabled.
+		 */
+		ret = acpi_processor_get_power_info(pr);
+		if (ret) {
+			/* Ensure cpuidle of offline CPUs are inavaliable. */
+			disable_cpuidle();
+			pr_err("Get processor-%u power information failed, disable cpuidle of all CPUs\n",
+			       pr->id);
+			goto release_lock;
+		}
+
 		acpi_processor_setup_cpuidle_states(pr);
+		enable_cpuidle();
 
 		/* Enable all cpuidle devices */
 		for_each_online_cpu(cpu) {
 			_pr = per_cpu(processors, cpu);
 			if (!_pr || !_pr->flags.power_setup_done)
 				continue;
-			acpi_processor_get_power_info(_pr);
-			if (_pr->flags.power) {
+			ret = acpi_processor_get_power_info(_pr);
+			if (!ret && _pr->flags.power) {
 				dev = per_cpu(acpi_cpuidle_device, cpu);
 				acpi_processor_setup_cpuidle_dev(_pr, dev);
 				cpuidle_enable_device(dev);
 			}
 		}
+release_lock:
 		cpuidle_resume_and_unlock();
 		cpus_read_unlock();
 	}
 
-	return 0;
+	return ret;
 }
 
 void acpi_processor_register_idle_driver(void)
-- 
2.33.0


