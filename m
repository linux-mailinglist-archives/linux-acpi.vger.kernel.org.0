Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C2E26D6C3
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Sep 2020 10:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgIQIfJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Sep 2020 04:35:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39932 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726285AbgIQIfF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Sep 2020 04:35:05 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 65C125DE6DA30FACBE5D;
        Thu, 17 Sep 2020 15:46:55 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 15:46:46 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 07/25] ACPI: memhotplug: Remove the state for memory device
Date:   Thu, 17 Sep 2020 15:38:47 +0800
Message-ID: <1600328345-27627-8-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
References: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

After commit ("315bbae9c5cb ACPI / memhotplug: deal with eject request
in hotplug queue"), the state for struct acpi_memory_device is not
actually useful, it can be removed.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/acpi_memhotplug.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 9cd987d..c8344b9 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -29,11 +29,6 @@
 
 #ifdef CONFIG_ACPI_HOTPLUG_MEMORY
 
-/* Memory Device States */
-#define MEMORY_INVALID_STATE	0
-#define MEMORY_POWER_ON_STATE	1
-#define MEMORY_POWER_OFF_STATE	2
-
 static int acpi_memory_device_add(struct acpi_device *device,
 				  const struct acpi_device_id *not_used);
 static void acpi_memory_device_remove(struct acpi_device *device);
@@ -58,7 +53,6 @@ struct acpi_memory_info {
 
 struct acpi_memory_device {
 	struct acpi_device * device;
-	unsigned int state;	/* State of the memory device */
 	struct list_head res_list;
 };
 
@@ -226,7 +220,6 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 	}
 	if (!num_enabled) {
 		dev_err(&mem_device->device->dev, "add_memory failed\n");
-		mem_device->state = MEMORY_INVALID_STATE;
 		return -EINVAL;
 	}
 	/*
@@ -297,9 +290,6 @@ static int acpi_memory_device_add(struct acpi_device *device,
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

