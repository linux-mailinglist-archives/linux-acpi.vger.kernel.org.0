Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888F43984F2
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 11:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhFBJIl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 05:08:41 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2954 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhFBJIi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 05:08:38 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw33w0D9jz693t;
        Wed,  2 Jun 2021 17:03:56 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:42 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:41 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 02/18] ACPI: blacklist: Unify the message printing
Date:   Wed, 2 Jun 2021 16:54:24 +0800
Message-ID: <1622624080-56025-3-git-send-email-guohanjun@huawei.com>
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

Intoduce pr_fmt() and use pr_*() macros to replace printk(), to generate
a unified format string for prefix, then remove the PREFIX.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/blacklist.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index a86a770..a558d24 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -10,6 +10,8 @@
  *  Copyright (C) 2002 Andy Grover <andrew.grover@intel.com>
  */
 
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
@@ -49,12 +51,12 @@ int __init acpi_blacklisted(void)
 
 	i = acpi_match_platform_list(acpi_blacklist);
 	if (i >= 0) {
-		pr_err(PREFIX "Vendor \"%6.6s\" System \"%8.8s\" Revision 0x%x has a known ACPI BIOS problem.\n",
+		pr_err("Vendor \"%6.6s\" System \"%8.8s\" Revision 0x%x has a known ACPI BIOS problem.\n",
 		       acpi_blacklist[i].oem_id,
 		       acpi_blacklist[i].oem_table_id,
 		       acpi_blacklist[i].oem_revision);
 
-		pr_err(PREFIX "Reason: %s. This is a %s error\n",
+		pr_err("Reason: %s. This is a %s error\n",
 		       acpi_blacklist[i].reason,
 		       (acpi_blacklist[i].data ?
 			"non-recoverable" : "recoverable"));
@@ -73,8 +75,7 @@ int __init acpi_blacklisted(void)
 #ifdef CONFIG_ACPI_REV_OVERRIDE_POSSIBLE
 static int __init dmi_enable_rev_override(const struct dmi_system_id *d)
 {
-	printk(KERN_NOTICE PREFIX "DMI detected: %s (force ACPI _REV to 5)\n",
-	       d->ident);
+	pr_notice("DMI detected: %s (force ACPI _REV to 5)\n", d->ident);
 	acpi_rev_override_setup(NULL);
 	return 0;
 }
-- 
1.7.12.4

