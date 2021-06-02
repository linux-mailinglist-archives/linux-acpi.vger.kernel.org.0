Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DD03984F3
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 11:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhFBJIm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 05:08:42 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2955 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbhFBJIi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 05:08:38 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw33w2SMcz694P;
        Wed,  2 Jun 2021 17:03:56 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:46 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:45 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 14/18] ACPI: sbshc: Unify the message printing
Date:   Wed, 2 Jun 2021 16:54:36 +0800
Message-ID: <1622624080-56025-15-git-send-email-guohanjun@huawei.com>
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

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/sbshc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index 5c021c3..7c62e14 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -5,6 +5,8 @@
  * Copyright (c) 2007 Alexey Starikovskiy
  */
 
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/acpi.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
@@ -13,8 +15,6 @@
 #include <linux/interrupt.h>
 #include "sbshc.h"
 
-#define PREFIX "ACPI: "
-
 #define ACPI_SMB_HC_CLASS	"smbus_host_ctl"
 #define ACPI_SMB_HC_DEVICE_NAME	"ACPI SMBus HC"
 
@@ -109,7 +109,7 @@ static int acpi_smbus_transaction(struct acpi_smb_hc *hc, u8 protocol,
 	u8 temp, sz = 0;
 
 	if (!hc) {
-		printk(KERN_ERR PREFIX "host controller is not configured\n");
+		pr_err("host controller is not configured\n");
 		return ret;
 	}
 
@@ -253,7 +253,7 @@ static int acpi_smbus_hc_add(struct acpi_device *device)
 
 	status = acpi_evaluate_integer(device->handle, "_EC", NULL, &val);
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX "error obtaining _EC.\n");
+		pr_err("error obtaining _EC.\n");
 		return -EIO;
 	}
 
-- 
1.7.12.4

