Return-Path: <linux-acpi+bounces-19806-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD97CD8D3C
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 11:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAE96307DBA7
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 10:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBC236215C;
	Tue, 23 Dec 2025 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="qBnxG2D8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF94036212E;
	Tue, 23 Dec 2025 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766484562; cv=none; b=LGfcAbRDXk0IEfTWZdg7gYVBrkToXw6KPNJAq2n51K3owUW16Dmwk9MDRLqa0guMXZrxaSxP3Mq6vMwFsZ6LAhSOoZPf9aAPSRVDvSZIKFo+KvQi0dC5QQbb7HNewNRdAqAus0wDwkuedVu2F4IotT1eElCy8yAtAiKWqWIvzw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766484562; c=relaxed/simple;
	bh=LUHDsVVld2PY978m7mnSW446hPq+y4jQ4M0oE/Drr9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DpNS5BEyrztZMkk8ck7NHyyyRlB6kzvfMfPXWPfc5yjQjUYnK3EpSe/ks/x9kHZNyBTkZCo6+LCXE3RBojMscVrJkNb7zGk8Uygk/OzBq/q7hg3svMutRw6HtJjtsZ80NaBBGnjIh/kKkdOY1kkxfSjJeewtL3UEcKWSar5XGbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=qBnxG2D8; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vdRG+Js1xkq5/sO5SUPz4u2gc/Q6Jqzn8FQkwaHi1Mw=;
	b=qBnxG2D8+F/sJlHTr8SZhEYz7aDX5ggpuISA6NSlnGs4rS7oLuU6PqBMe/CgUZOREoXi19aqq
	ioTsEZFfjZd47nVX0x/1/hnBSs3eXtmItZ5JS2xqUPvD6HRf03W93nBC1OxvlYshgQOwA5+VD+n
	9QHee1z7sa9jCq9MakC7shg=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4db9dJ1b5KzLlVp;
	Tue, 23 Dec 2025 18:06:12 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id E239540539;
	Tue, 23 Dec 2025 18:09:17 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
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
Subject: [PATCH v1 4/6] ACPI: processor: idle: Redefine two functions as void
Date: Tue, 23 Dec 2025 18:09:12 +0800
Message-ID: <20251223100914.2407069-5-lihuisong@huawei.com>
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

Notice that acpi_processor_power_init() and acpi_processor_power_exit()
don't need to return any values because their callers don't check them
anyway, so redefine those functions as void.

While at it, rearrange the code in acpi_processor_power_init() to
reduce the indentation level, get rid of a redundant local variable
in that function, and rephrase a code comment in it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/acpi/processor_idle.c | 41 ++++++++++++++++-------------------
 include/acpi/processor.h      |  4 ++--
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index ca7ae64def73..05425d1b3ef7 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1391,47 +1391,45 @@ void acpi_processor_unregister_idle_driver(void)
 	cpuidle_unregister_driver(&acpi_idle_driver);
 }
 
-int acpi_processor_power_init(struct acpi_processor *pr)
+void acpi_processor_power_init(struct acpi_processor *pr)
 {
-	int retval;
 	struct cpuidle_device *dev;
 
 	if (disabled_by_idle_boot_param())
-		return 0;
+		return;
 
 	acpi_processor_cstate_first_run_checks();
 
 	if (!acpi_processor_get_power_info(pr))
 		pr->flags.power_setup_done = 1;
 
-	if (pr->flags.power) {
-		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-		if (!dev)
-			return -ENOMEM;
-		per_cpu(acpi_cpuidle_device, pr->id) = dev;
+	if (!pr->flags.power)
+		return;
 
-		acpi_processor_setup_cpuidle_dev(pr, dev);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return;
 
-		/* Register per-cpu cpuidle_device. Cpuidle driver
-		 * must already be registered before registering device
-		 */
-		retval = cpuidle_register_device(dev);
-		if (retval) {
+	per_cpu(acpi_cpuidle_device, pr->id) = dev;
 
-			per_cpu(acpi_cpuidle_device, pr->id) = NULL;
-			kfree(dev);
-			return retval;
-		}
+	acpi_processor_setup_cpuidle_dev(pr, dev);
+
+	/*
+	 * Register a cpuidle device for this CPU.  The cpuidle driver using
+	 * this device is expected to be registered.
+	 */
+	if (cpuidle_register_device(dev)) {
+		per_cpu(acpi_cpuidle_device, pr->id) = NULL;
+		kfree(dev);
 	}
-	return 0;
 }
 
-int acpi_processor_power_exit(struct acpi_processor *pr)
+void acpi_processor_power_exit(struct acpi_processor *pr)
 {
 	struct cpuidle_device *dev = per_cpu(acpi_cpuidle_device, pr->id);
 
 	if (disabled_by_idle_boot_param())
-		return 0;
+		return;
 
 	if (pr->flags.power) {
 		cpuidle_unregister_device(dev);
@@ -1439,7 +1437,6 @@ int acpi_processor_power_exit(struct acpi_processor *pr)
 	}
 
 	pr->flags.power_setup_done = 0;
-	return 0;
 }
 
 MODULE_IMPORT_NS("ACPI_PROCESSOR_IDLE");
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 2976a6d0c54f..0200aef6e754 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -419,8 +419,8 @@ static inline void acpi_processor_throttling_init(void) {}
 /* in processor_idle.c */
 extern struct cpuidle_driver acpi_idle_driver;
 #ifdef CONFIG_ACPI_PROCESSOR_IDLE
-int acpi_processor_power_init(struct acpi_processor *pr);
-int acpi_processor_power_exit(struct acpi_processor *pr);
+void acpi_processor_power_init(struct acpi_processor *pr);
+void acpi_processor_power_exit(struct acpi_processor *pr);
 int acpi_processor_power_state_has_changed(struct acpi_processor *pr);
 int acpi_processor_hotplug(struct acpi_processor *pr);
 void acpi_processor_register_idle_driver(void);
-- 
2.33.0


