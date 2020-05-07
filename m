Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9B61C857A
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 11:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgEGJQL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 05:16:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbgEGJQK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 May 2020 05:16:10 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 611AE698B10285790588;
        Thu,  7 May 2020 17:16:06 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 17:16:00 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, <linux-acpi@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 5/9] ACPI: APEI: Put the error record serialization table for error path
Date:   Thu, 7 May 2020 17:09:17 +0800
Message-ID: <1588842561-32907-6-git-send-email-guohanjun@huawei.com>
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

The mapped error record serialization table needs to be
released for error path of erst_init().

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/apei/erst.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 2015a09..2e0b0fc 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -1122,7 +1122,7 @@ static int __init erst_init(void)
 	rc = erst_check_table(erst_tab);
 	if (rc) {
 		pr_err(FW_BUG "ERST table is invalid.\n");
-		goto err;
+		goto err_put_erst_tab;
 	}
 
 	apei_resources_init(&erst_resources);
@@ -1196,6 +1196,8 @@ static int __init erst_init(void)
 	apei_resources_release(&erst_resources);
 err_fini:
 	apei_resources_fini(&erst_resources);
+err_put_erst_tab:
+	acpi_put_table((struct acpi_table_header *)erst_tab);
 err:
 	erst_disable = 1;
 	return rc;
-- 
1.7.12.4

