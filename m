Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BDE3984E9
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 11:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhFBJIY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 05:08:24 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:4281 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhFBJIW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 05:08:22 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fw31c3MWZz19V00;
        Wed,  2 Jun 2021 17:01:56 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:45 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:45 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 13/18] ACPI: sysfs: Cleanup message printing
Date:   Wed, 2 Jun 2021 16:54:35 +0800
Message-ID: <1622624080-56025-14-git-send-email-guohanjun@huawei.com>
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

We have pr_fmt() in sysfs.c but we still use pr_err(PREFIX ...) which
is wrong, remove the duplicated PREFIX and also using pr_* to replace
printk to simlify the code.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/sysfs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index d259271..88629d2 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -359,8 +359,7 @@ static int acpi_table_attr_init(struct kobject *tables_obj,
 	}
 	table_attr->instance++;
 	if (table_attr->instance > ACPI_MAX_TABLE_INSTANCES) {
-		pr_warn("%4.4s: too many table instances\n",
-			table_attr->name);
+		pr_warn("%4.4s: too many table instances\n", table_attr->name);
 		return -ERANGE;
 	}
 
@@ -737,8 +736,7 @@ static ssize_t counter_set(struct kobject *kobj,
 		goto end;
 
 	if (!(status & ACPI_EVENT_FLAG_HAS_HANDLER)) {
-		printk(KERN_WARNING PREFIX
-		       "Can not change Invalid GPE/Fixed Event status\n");
+		pr_warn("Can not change Invalid GPE/Fixed Event status\n");
 		return -EINVAL;
 	}
 
@@ -983,7 +981,7 @@ void acpi_sysfs_add_hotplug_profile(struct acpi_hotplug_profile *hotplug,
 	return;
 
  err_out:
-	pr_err(PREFIX "Unable to add hotplug profile '%s'\n", name);
+	pr_err("Unable to add hotplug profile '%s'\n", name);
 }
 
 static ssize_t force_remove_show(struct kobject *kobj,
-- 
1.7.12.4

