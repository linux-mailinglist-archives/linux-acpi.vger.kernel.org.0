Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9372F7073
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 03:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbhAOCSH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jan 2021 21:18:07 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:10969 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbhAOCSH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jan 2021 21:18:07 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DH4YZ5Pwnzj6mR;
        Fri, 15 Jan 2021 10:16:34 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Fri, 15 Jan 2021 10:17:17 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Hanjun Guo <guohanjun@huawei.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH v2] ACPI: configfs: add missing check after configfs_register_default_group
Date:   Fri, 15 Jan 2021 10:22:50 +0800
Message-ID: <20210115022250.160645-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

A list_add corruption is reported by Hulk Robot like this:
==============
list_add corruption.
Call Trace:
link_obj+0xc0/0x1c0
link_group+0x21/0x140
configfs_register_subsystem+0xdb/0x380
acpi_configfs_init+0x25/0x1000 [acpi_configfs]
do_one_initcall+0x149/0x820
do_init_module+0x1ef/0x720
load_module+0x35c8/0x4380
__do_sys_finit_module+0x10d/0x1a0
do_syscall_64+0x34/0x80

It's because of the missing check after configfs_register_default_group,
where configfs_unregister_subsystem should be called once failure.

Fixes: 612bd01fc6e0 ("ACPI: add support for loading SSDTs via configfs")
Reported-by: Hulk Robot <hulkci@huawei.com>
Suggested-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
v1->v2: fix 'register' to 'unregister' which is typo.

 drivers/acpi/acpi_configfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
index cf91f4910..3a14859db 100644
--- a/drivers/acpi/acpi_configfs.c
+++ b/drivers/acpi/acpi_configfs.c
@@ -268,7 +268,12 @@ static int __init acpi_configfs_init(void)
 
 	acpi_table_group = configfs_register_default_group(root, "table",
 							   &acpi_tables_type);
-	return PTR_ERR_OR_ZERO(acpi_table_group);
+	if (IS_ERR(acpi_table_group)) {
+		configfs_unregister_subsystem(&acpi_configfs);
+		return PTR_ERR(acpi_table_group);
+	}
+
+	return 0;
 }
 module_init(acpi_configfs_init);
 
-- 
2.23.0

