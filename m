Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11023984F1
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 11:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhFBJIl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 05:08:41 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2953 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhFBJIi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 05:08:38 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw33w1863z694G;
        Wed,  2 Jun 2021 17:03:56 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:43 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:42 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 05/18] ACPI: glue: Clean up the printing messages
Date:   Wed, 2 Jun 2021 16:54:27 +0800
Message-ID: <1622624080-56025-6-git-send-email-guohanjun@huawei.com>
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

Remove the in house ACPI_GLUE_DEBUG and its related debug message
printing, using pr_debug() instead.

While at it, replace printk() with pr_* to simplify the code.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/glue.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 0715e3b..fce3f3b 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -6,6 +6,8 @@
  * Copyright (c) 2005 Intel Corp.
  */
 
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/acpi_iort.h>
 #include <linux/export.h>
 #include <linux/init.h>
@@ -19,17 +21,6 @@
 
 #include "internal.h"
 
-#define ACPI_GLUE_DEBUG	0
-#if ACPI_GLUE_DEBUG
-#define DBG(fmt, ...)						\
-	printk(KERN_DEBUG PREFIX fmt, ##__VA_ARGS__)
-#else
-#define DBG(fmt, ...)						\
-do {								\
-	if (0)							\
-		printk(KERN_DEBUG PREFIX fmt, ##__VA_ARGS__);	\
-} while (0)
-#endif
 static LIST_HEAD(bus_type_list);
 static DECLARE_RWSEM(bus_type_sem);
 
@@ -44,7 +35,7 @@ int register_acpi_bus_type(struct acpi_bus_type *type)
 		down_write(&bus_type_sem);
 		list_add_tail(&type->list, &bus_type_list);
 		up_write(&bus_type_sem);
-		printk(KERN_INFO PREFIX "bus type %s registered\n", type->name);
+		pr_info("bus type %s registered\n", type->name);
 		return 0;
 	}
 	return -ENODEV;
@@ -59,8 +50,7 @@ int unregister_acpi_bus_type(struct acpi_bus_type *type)
 		down_write(&bus_type_sem);
 		list_del_init(&type->list);
 		up_write(&bus_type_sem);
-		printk(KERN_INFO PREFIX "bus type %s unregistered\n",
-		       type->name);
+		pr_info("bus type %s unregistered\n", type->name);
 		return 0;
 	}
 	return -ENODEV;
@@ -307,7 +297,7 @@ static int acpi_device_notify(struct device *dev)
 
 		adev = type->find_companion(dev);
 		if (!adev) {
-			DBG("Unable to get handle for %s\n", dev_name(dev));
+			pr_debug("Unable to get handle for %s\n", dev_name(dev));
 			ret = -ENODEV;
 			goto out;
 		}
@@ -328,16 +318,15 @@ static int acpi_device_notify(struct device *dev)
 		adev->handler->bind(dev);
 
  out:
-#if ACPI_GLUE_DEBUG
 	if (!ret) {
 		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
 		acpi_get_name(ACPI_HANDLE(dev), ACPI_FULL_PATHNAME, &buffer);
-		DBG("Device %s -> %s\n", dev_name(dev), (char *)buffer.pointer);
+		pr_debug("Device %s -> %s\n", dev_name(dev), (char *)buffer.pointer);
 		kfree(buffer.pointer);
-	} else
-		DBG("Device %s -> No ACPI support\n", dev_name(dev));
-#endif
+	} else {
+		pr_debug("Device %s -> No ACPI support\n", dev_name(dev));
+	}
 
 	return ret;
 }
-- 
1.7.12.4

