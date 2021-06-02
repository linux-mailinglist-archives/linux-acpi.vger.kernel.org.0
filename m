Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D113984ED
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 11:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhFBJI0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 05:08:26 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3510 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhFBJIX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 05:08:23 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw33v2tDfzYrmX;
        Wed,  2 Jun 2021 17:03:55 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
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
Subject: [PATCH 16/18] ACPI: sbs: Unify the message printing
Date:   Wed, 2 Jun 2021 16:54:38 +0800
Message-ID: <1622624080-56025-17-git-send-email-guohanjun@huawei.com>
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

Using pr_fmt() and pr_*() macros to unify the message printing.

While at it, fix the obvious coding style issue when scanning
the code.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/sbs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 3b0b6dd..4938010 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -7,6 +7,8 @@
  *  Copyright (c) 2005 Rich Townsend <rhdt@bartol.udel.edu>
  */
 
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -23,8 +25,6 @@
 
 #include "sbshc.h"
 
-#define PREFIX "ACPI: "
-
 #define ACPI_SBS_CLASS			"sbs"
 #define ACPI_AC_CLASS			"ac_adapter"
 #define ACPI_SBS_DEVICE_NAME		"Smart Battery System"
@@ -544,7 +544,7 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 		goto end;
 	battery->have_sysfs_alarm = 1;
       end:
-	printk(KERN_INFO PREFIX "%s [%s]: Battery Slot [%s] (battery %s)\n",
+	pr_info("%s [%s]: Battery Slot [%s] (battery %s)\n",
 	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
 	       battery->name, battery->present ? "present" : "absent");
 	return result;
@@ -577,10 +577,10 @@ static int acpi_charger_add(struct acpi_sbs *sbs)
 		result = PTR_ERR(sbs->charger);
 		sbs->charger = NULL;
 	}
-	printk(KERN_INFO PREFIX "%s [%s]: AC Adapter [%s] (%s)\n",
+	pr_info("%s [%s]: AC Adapter [%s] (%s)\n",
 	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
 	       ACPI_AC_DIR_NAME, sbs->charger_present ? "on-line" : "off-line");
-      end:
+end:
 	return result;
 }
 
@@ -658,7 +658,7 @@ static int acpi_sbs_add(struct acpi_device *device)
 		acpi_battery_add(sbs, 0);
 
 	acpi_smbus_register_callback(sbs->hc, acpi_sbs_callback, sbs);
-      end:
+end:
 	if (result)
 		acpi_sbs_remove(device);
 	return result;
-- 
1.7.12.4

