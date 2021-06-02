Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC073984EB
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 11:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhFBJIY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 05:08:24 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:4280 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhFBJIW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 05:08:22 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fw31c2nFXz19Tk1;
        Wed,  2 Jun 2021 17:01:56 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:43 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:43 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 07/18] ACPI: osl: Remove the duplicated PREFIX for message printing
Date:   Wed, 2 Jun 2021 16:54:29 +0800
Message-ID: <1622624080-56025-8-git-send-email-guohanjun@huawei.com>
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

We have pr_fmt() in osl.c, so pr_err(PREFIX ...) is duplicated
and wrong, fix it by removing the PREFIX.

Also remove the using of PREFIX in WARN() and just add the plain
"ACPI: " in message to keep it unchanged.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/osl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 327e1b4..1207490 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -212,7 +212,7 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 			return efi.acpi20;
 		if (efi.acpi != EFI_INVALID_TABLE_ADDR)
 			return efi.acpi;
-		pr_err(PREFIX "System description tables not found\n");
+		pr_err("System description tables not found\n");
 	} else if (IS_ENABLED(CONFIG_ACPI_LEGACY_TABLES_LOOKUP)) {
 		acpi_find_root_pointer(&pa);
 	}
@@ -430,7 +430,7 @@ void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
 	map = acpi_map_lookup_virt(virt, size);
 	if (!map) {
 		mutex_unlock(&acpi_ioremap_lock);
-		WARN(true, PREFIX "%s: bad address %p\n", __func__, virt);
+		WARN(true, "ACPI: %s: bad address %p\n", __func__, virt);
 		return;
 	}
 	acpi_os_drop_map_ref(map);
-- 
1.7.12.4

