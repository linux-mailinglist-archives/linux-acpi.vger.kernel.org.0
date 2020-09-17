Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B334626D588
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Sep 2020 10:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgIQIDl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Sep 2020 04:03:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13219 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726354AbgIQIC5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Sep 2020 04:02:57 -0400
X-Greylist: delayed 933 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 04:02:56 EDT
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 641B83E1434868385D5F;
        Thu, 17 Sep 2020 15:46:50 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 15:46:43 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 02/25] ACPI: configfs: Decouple with ACPICA
Date:   Thu, 17 Sep 2020 15:38:42 +0800
Message-ID: <1600328345-27627-3-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
References: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Remove the not needed acpica head file inclusions and change
ACPI_INFO() to pr_info() to decouple with ACPICA.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/acpi_configfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
index 88c8af4..21160a3 100644
--- a/drivers/acpi/acpi_configfs.c
+++ b/drivers/acpi/acpi_configfs.c
@@ -13,9 +13,6 @@
 #include <linux/acpi.h>
 #include <linux/security.h>
 
-#include "acpica/accommon.h"
-#include "acpica/actables.h"
-
 static struct config_group *acpi_table_group;
 
 struct acpi_table {
@@ -226,7 +223,7 @@ static void acpi_table_drop_item(struct config_group *group,
 {
 	struct acpi_table *table = container_of(cfg, struct acpi_table, cfg);
 
-	ACPI_INFO(("Host-directed Dynamic ACPI Table Unload"));
+	pr_info("Host-directed Dynamic ACPI Table Unload\n");
 	acpi_unload_table(table->index);
 }
 
-- 
1.7.12.4

