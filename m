Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52501C8578
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 11:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgEGJQK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 05:16:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36626 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbgEGJQK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 May 2020 05:16:10 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 64C4CA3A8AEB6D954CDB;
        Thu,  7 May 2020 17:16:06 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 17:16:00 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, <linux-acpi@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 4/9] ACPI: APEI: Put the error injection table for error path and module exit
Date:   Thu, 7 May 2020 17:09:16 +0800
Message-ID: <1588842561-32907-5-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1588842561-32907-1-git-send-email-guohanjun@huawei.com>
References: <1588842561-32907-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The mapped error injection table will be used after einj_init()
for debugfs, but it should be released for module exit and error
path of einj_init().

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/apei/einj.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 086373f..13315675 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -692,7 +692,7 @@ static int __init einj_init(void)
 	rc = einj_check_table(einj_tab);
 	if (rc) {
 		pr_warn(FW_BUG "Invalid EINJ table.\n");
-		return -EINVAL;
+		goto err_put_table;
 	}
 
 	rc = -ENOMEM;
@@ -760,6 +760,8 @@ static int __init einj_init(void)
 err_fini:
 	apei_resources_fini(&einj_resources);
 	debugfs_remove_recursive(einj_debug_dir);
+err_put_table:
+	acpi_put_table((struct acpi_table_header *)einj_tab);
 
 	return rc;
 }
@@ -780,6 +782,7 @@ static void __exit einj_exit(void)
 	apei_resources_release(&einj_resources);
 	apei_resources_fini(&einj_resources);
 	debugfs_remove_recursive(einj_debug_dir);
+	acpi_put_table((struct acpi_table_header *)einj_tab);
 }
 
 module_init(einj_init);
-- 
1.7.12.4

