Return-Path: <linux-acpi+bounces-14463-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C009BADFD81
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jun 2025 08:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B97C177063
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jun 2025 06:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB8A243367;
	Thu, 19 Jun 2025 06:13:40 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB5A20E711;
	Thu, 19 Jun 2025 06:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750313620; cv=none; b=Gqa9SQaB3dgnpqcGUrXF1to2l/hzH7QPFNpAgBKDhLeLcVZS1hqPvc9uz2X/nQs5dWvJAvkWaX0BKkCSUH6AtHrVEv8tWog09WKetMj89PLMfHj12wHyYAT5drfhRzOqld9XX7EMTfDQ8FbW+JeTMXzvhTehSWBsupb3/H7zc84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750313620; c=relaxed/simple;
	bh=OpafWeqS4EE6Q5MwzNRjHo+tTTzb5JMvCsImCJYOgXU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rl5VE8WLqO0NzLZT75U6QZeszGO1G40KqHgivELU+nSVPxA4MGJiZHy4DHOhFARkU8ySNXHKrYYY8ODC+/zuyqtQsEObFsBeqcVwHW/vpdGuT2S5ETkhg96cE0yL4swWX+6TJPw6LV7YhqRf+1vVYITxv4aE8ytxZF2/Ng3BRJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bN9HM6wvyz2BdgY;
	Thu, 19 Jun 2025 14:11:59 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id E71CD1401E9;
	Thu, 19 Jun 2025 14:13:28 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Jun 2025 14:13:28 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Jun 2025 14:13:28 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH] ACPI: processor: idle: Fix resource rollback in acpi_processor_power_init
Date: Thu, 19 Jun 2025 14:13:27 +0800
Message-ID: <20250619061327.1674384-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn100009.china.huawei.com (7.202.194.112)

There are two resource rollback issues in acpi_processor_power_init:
1> Do not unregister acpi_idle_driver when do kzalloc failed.
2> Do not free cpuidle device memory when register cpuidle device failed.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 2c2dc559e0f8..3548ab9dac9e 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1392,8 +1392,10 @@ int acpi_processor_power_init(struct acpi_processor *pr)
 		}
 
 		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-		if (!dev)
-			return -ENOMEM;
+		if (!dev) {
+			retval = -ENOMEM;
+			goto unregister_driver;
+		}
 		per_cpu(acpi_cpuidle_device, pr->id) = dev;
 
 		acpi_processor_setup_cpuidle_dev(pr, dev);
@@ -1402,14 +1404,22 @@ int acpi_processor_power_init(struct acpi_processor *pr)
 		 * must already be registered before registering device
 		 */
 		retval = cpuidle_register_device(dev);
-		if (retval) {
-			if (acpi_processor_registered == 0)
-				cpuidle_unregister_driver(&acpi_idle_driver);
-			return retval;
-		}
+		if (retval)
+			goto free_cpuidle_device;
+
 		acpi_processor_registered++;
 	}
 	return 0;
+
+free_cpuidle_device:
+	per_cpu(acpi_cpuidle_device, pr->id) = NULL;
+	kfree(dev);
+
+unregister_driver:
+	if (acpi_processor_registered == 0)
+		cpuidle_unregister_driver(&acpi_idle_driver);
+
+	return retval;
 }
 
 int acpi_processor_power_exit(struct acpi_processor *pr)
-- 
2.33.0


