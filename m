Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E69D26F914
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Sep 2020 11:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgIRJVO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Sep 2020 05:21:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbgIRJVN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Sep 2020 05:21:13 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A842948885B5904E1977;
        Fri, 18 Sep 2020 17:21:10 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 17:21:04 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] ACPI: configfs: Add the missing config_item_put() to fix refcount leak
Date:   Fri, 18 Sep 2020 17:13:28 +0800
Message-ID: <1600420408-62807-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

config_item_put() should be called in the drop_item callback, to
decrement refcount for the config item.

Fixes: 772bf1e2878ec ("ACPI: configfs: Unload SSDT on configfs entry removal")
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/acpi_configfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
index 88c8af4..cf91f49 100644
--- a/drivers/acpi/acpi_configfs.c
+++ b/drivers/acpi/acpi_configfs.c
@@ -228,6 +228,7 @@ static void acpi_table_drop_item(struct config_group *group,
 
 	ACPI_INFO(("Host-directed Dynamic ACPI Table Unload"));
 	acpi_unload_table(table->index);
+	config_item_put(cfg);
 }
 
 static struct configfs_group_operations acpi_table_group_ops = {
-- 
1.7.12.4

