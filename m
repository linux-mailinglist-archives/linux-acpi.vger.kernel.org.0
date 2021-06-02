Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE72F3984F4
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 11:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhFBJIn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 05:08:43 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2957 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhFBJIi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 05:08:38 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw33w1M8Fz694J;
        Wed,  2 Jun 2021 17:03:56 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:44 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:43 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 08/18] ACPI: pci_root: Unify the message printing
Date:   Wed, 2 Jun 2021 16:54:30 +0800
Message-ID: <1622624080-56025-9-git-send-email-guohanjun@huawei.com>
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

In acpi_pci_root_add(), pr_info() is added with PREFIX, but
in acpi_pci_root_remap_iospace() the pr_info() with no
PREFIX.

Introduce pr_fmt() to unify the message printing and remove
the PREFIX.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/pci_root.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index dcd5937..d7deedf 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -6,6 +6,8 @@
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
  */
 
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -574,7 +576,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 		goto end;
 	}
 
-	pr_info(PREFIX "%s [%s] (domain %04x %pR)\n",
+	pr_info("%s [%s] (domain %04x %pR)\n",
 	       acpi_device_name(device), acpi_device_bid(device),
 	       root->segment, &root->secondary);
 
-- 
1.7.12.4

