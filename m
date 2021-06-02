Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607DF3984E4
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 11:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhFBJIT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 05:08:19 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3508 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhFBJIQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 05:08:16 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw33m1wK9zYsRb;
        Wed,  2 Jun 2021 17:03:48 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:46 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:46 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 15/18] ACPI: scan: Unify the log message printing
Date:   Wed, 2 Jun 2021 16:54:37 +0800
Message-ID: <1622624080-56025-16-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1622624080-56025-1-git-send-email-guohanjun@huawei.com>
References: <1622624080-56025-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The log messages in scan.c is not in consistency, some pr_*() calls
have PREFIX, but some don't.

Using pr_fmt() and remove PREFIX, also replace printk() with pr_*()
macro to unify the message printing.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/scan.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 438df8d..e031b6e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -3,6 +3,8 @@
  * scan.c - support for transforming the ACPI namespace into individual objects
  */
 
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -729,7 +731,7 @@ int acpi_device_add(struct acpi_device *device,
 
 	result = acpi_device_setup_files(device);
 	if (result)
-		printk(KERN_ERR PREFIX "Error creating sysfs interface for device %s\n",
+		pr_err("Error creating sysfs interface for device %s\n",
 		       dev_name(&device->dev));
 
 	return 0;
@@ -1320,8 +1322,7 @@ static void acpi_set_pnp_ids(acpi_handle handle, struct acpi_device_pnp *pnp,
 
 		acpi_get_object_info(handle, &info);
 		if (!info) {
-			pr_err(PREFIX "%s: Error reading device info\n",
-					__func__);
+			pr_err("%s: Error reading device info\n", __func__);
 			return;
 		}
 
@@ -2274,7 +2275,7 @@ static void __init acpi_get_spcr_uart_addr(void)
 	status = acpi_get_table(ACPI_SIG_SPCR, 0,
 				(struct acpi_table_header **)&spcr_ptr);
 	if (ACPI_FAILURE(status)) {
-		pr_warn(PREFIX "STAO table present, but SPCR is missing\n");
+		pr_warn("STAO table present, but SPCR is missing\n");
 		return;
 	}
 
@@ -2315,7 +2316,7 @@ int __init acpi_scan_init(void)
 				(struct acpi_table_header **)&stao_ptr);
 	if (ACPI_SUCCESS(status)) {
 		if (stao_ptr->header.length > sizeof(struct acpi_table_stao))
-			pr_info(PREFIX "STAO Name List not yet supported.\n");
+			pr_info("STAO Name List not yet supported.\n");
 
 		if (stao_ptr->ignore_uart)
 			acpi_get_spcr_uart_addr();
-- 
1.7.12.4

