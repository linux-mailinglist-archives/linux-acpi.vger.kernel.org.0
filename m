Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB79E27A06A
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Sep 2020 12:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgI0KDt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 27 Sep 2020 06:03:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59532 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbgI0KDs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 27 Sep 2020 06:03:48 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B860BEED604F6DFDFB84;
        Sun, 27 Sep 2020 18:03:46 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Sun, 27 Sep 2020 18:03:37 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2] ACPI: memhotplug: Remove the 'state' from struct acpi_memory_device
Date:   Sun, 27 Sep 2020 17:55:49 +0800
Message-ID: <1601200549-8518-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

After commit 315bbae9c5cb ("ACPI / memhotplug: deal with eject request
in hotplug queue"), the memory device state which is defined in struct
acpi_memory_device is not actually useful, so remove it along with
symbols related to it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
v1->v2:
- Make it as a sparate cleanup patch.

 drivers/acpi/acpi_memhotplug.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index e294f44..468ebb7 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -36,11 +36,6 @@
 
 #ifdef CONFIG_ACPI_HOTPLUG_MEMORY
 
-/* Memory Device States */
-#define MEMORY_INVALID_STATE	0
-#define MEMORY_POWER_ON_STATE	1
-#define MEMORY_POWER_OFF_STATE	2
-
 static int acpi_memory_device_add(struct acpi_device *device,
 				  const struct acpi_device_id *not_used);
 static void acpi_memory_device_remove(struct acpi_device *device);
@@ -64,8 +59,7 @@ struct acpi_memory_info {
 };
 
 struct acpi_memory_device {
-	struct acpi_device * device;
-	unsigned int state;	/* State of the memory device */
+	struct acpi_device *device;
 	struct list_head res_list;
 };
 
@@ -233,7 +227,6 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 	}
 	if (!num_enabled) {
 		dev_err(&mem_device->device->dev, "add_memory failed\n");
-		mem_device->state = MEMORY_INVALID_STATE;
 		return -EINVAL;
 	}
 	/*
@@ -304,9 +297,6 @@ static int acpi_memory_device_add(struct acpi_device *device,
 		return result;
 	}
 
-	/* Set the device state */
-	mem_device->state = MEMORY_POWER_ON_STATE;
-
 	result = acpi_memory_check_device(mem_device);
 	if (result) {
 		acpi_memory_device_free(mem_device);
-- 
1.7.12.4

