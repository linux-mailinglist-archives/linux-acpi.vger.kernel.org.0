Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C491C857C
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 11:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgEGJQN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 05:16:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56380 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbgEGJQN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 May 2020 05:16:13 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 71965FDA446C35BDA24E;
        Thu,  7 May 2020 17:16:11 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 17:16:02 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, <linux-acpi@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 8/9] ACPI: scan: Put SPCR and STAO table after using it
Date:   Thu, 7 May 2020 17:09:20 +0800
Message-ID: <1588842561-32907-9-git-send-email-guohanjun@huawei.com>
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

The SPCR and STAO table needs to be released after
using it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/scan.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 6d34488..5287ab9 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2157,10 +2157,13 @@ static void __init acpi_get_spcr_uart_addr(void)
 
 	status = acpi_get_table(ACPI_SIG_SPCR, 0,
 				(struct acpi_table_header **)&spcr_ptr);
-	if (ACPI_SUCCESS(status))
-		spcr_uart_addr = spcr_ptr->serial_port.address;
-	else
-		printk(KERN_WARNING PREFIX "STAO table present, but SPCR is missing\n");
+	if (ACPI_FAILURE(status)) {
+		pr_warn(PREFIX "STAO table present, but SPCR is missing\n");
+		return;
+	}
+
+	spcr_uart_addr = spcr_ptr->serial_port.address;
+	acpi_put_table((struct acpi_table_header *)spcr_ptr);
 }
 
 static bool acpi_scan_initialized;
@@ -2196,10 +2199,12 @@ int __init acpi_scan_init(void)
 				(struct acpi_table_header **)&stao_ptr);
 	if (ACPI_SUCCESS(status)) {
 		if (stao_ptr->header.length > sizeof(struct acpi_table_stao))
-			printk(KERN_INFO PREFIX "STAO Name List not yet supported.");
+			pr_info(PREFIX "STAO Name List not yet supported.\n");
 
 		if (stao_ptr->ignore_uart)
 			acpi_get_spcr_uart_addr();
+
+		acpi_put_table((struct acpi_table_header *)stao_ptr);
 	}
 
 	acpi_gpe_apply_masked_gpes();
-- 
1.7.12.4

