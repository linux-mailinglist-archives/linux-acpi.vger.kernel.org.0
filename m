Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0471C8577
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 11:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgEGJQK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 05:16:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36508 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbgEGJQK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 May 2020 05:16:10 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5909F2A0D55836450B63;
        Thu,  7 May 2020 17:16:06 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 17:15:59 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, <linux-acpi@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 3/9] ACPI: APEI: Put the boot error record table after parsing
Date:   Thu, 7 May 2020 17:09:15 +0800
Message-ID: <1588842561-32907-4-git-send-email-guohanjun@huawei.com>
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

The mapped boot error record table is not used after
bert_init(), release it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/apei/bert.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
index 1155fb9..19e50fc 100644
--- a/drivers/acpi/apei/bert.c
+++ b/drivers/acpi/apei/bert.c
@@ -119,7 +119,7 @@ static int __init bert_init(void)
 	rc = bert_check_table(bert_tab);
 	if (rc) {
 		pr_err(FW_BUG "table invalid.\n");
-		return rc;
+		goto out_put_bert_tab;
 	}
 
 	region_len = bert_tab->region_length;
@@ -127,7 +127,7 @@ static int __init bert_init(void)
 	rc = apei_resources_add(&bert_resources, bert_tab->address,
 				region_len, true);
 	if (rc)
-		return rc;
+		goto out_put_bert_tab;
 	rc = apei_resources_request(&bert_resources, "APEI BERT");
 	if (rc)
 		goto out_fini;
@@ -142,6 +142,8 @@ static int __init bert_init(void)
 	apei_resources_release(&bert_resources);
 out_fini:
 	apei_resources_fini(&bert_resources);
+out_put_bert_tab:
+	acpi_put_table((struct acpi_table_header *)bert_tab);
 
 	return rc;
 }
-- 
1.7.12.4

