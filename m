Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE853984EC
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 11:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhFBJIZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 05:08:25 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:4282 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhFBJIX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 05:08:23 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fw31c2bNlz19Tcp;
        Wed,  2 Jun 2021 17:01:56 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:42 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:42 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 04/18] ACPI: event: Use pr_*() macros to replace printk()
Date:   Wed, 2 Jun 2021 16:54:26 +0800
Message-ID: <1622624080-56025-5-git-send-email-guohanjun@huawei.com>
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

Introduce pr_fmt() and replace direct printk() invocation with
the matching pr_*() call to prepare for removing PREFIX.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/event.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index bfb16cf..d199a19 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -7,6 +7,8 @@
  *
  */
 
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/spinlock.h>
 #include <linux/export.h>
 #include <linux/proc_fs.h>
@@ -173,8 +175,8 @@ static int __init acpi_event_init(void)
 	/* create genetlink for acpi event */
 	error = acpi_event_genetlink_init();
 	if (error)
-		printk(KERN_WARNING PREFIX
-		       "Failed to create genetlink family for ACPI event\n");
+		pr_warn("Failed to create genetlink family for ACPI event\n");
+
 	return 0;
 }
 
-- 
1.7.12.4

