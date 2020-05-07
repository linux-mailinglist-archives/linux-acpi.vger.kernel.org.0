Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E63E1C857E
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 11:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgEGJQP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 05:16:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3838 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726267AbgEGJQO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 May 2020 05:16:14 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 66260A9B29B2CF0C9E34;
        Thu,  7 May 2020 17:16:11 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 17:16:01 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, <linux-acpi@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 7/9] ACPI: EC: Put the ACPI table after using it
Date:   Thu, 7 May 2020 17:09:19 +0800
Message-ID: <1588842561-32907-8-git-send-email-guohanjun@huawei.com>
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

The embedded controller boot resources table needs to be
released after using it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/ec.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index b4c0152e..281a9bf 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1784,12 +1784,15 @@ static void __init acpi_ec_ecdt_start(void)
 
 	status = acpi_get_handle(NULL, ecdt_ptr->id, &handle);
 	if (ACPI_FAILURE(status))
-		return;
+		goto out;
 
 	boot_ec->handle = handle;
 
 	/* Add a special ACPI device object to represent the boot EC. */
 	acpi_bus_register_early_device(ACPI_BUS_TYPE_ECDT_EC);
+
+out:
+	acpi_put_table((struct acpi_table_header *)ecdt_ptr);
 }
 
 /*
@@ -1891,12 +1894,12 @@ void __init acpi_ec_ecdt_probe(void)
 		 * Asus X50GL:
 		 * https://bugzilla.kernel.org/show_bug.cgi?id=11880
 		 */
-		return;
+		goto out;
 	}
 
 	ec = acpi_ec_alloc();
 	if (!ec)
-		return;
+		goto out;
 
 	if (EC_FLAGS_CORRECT_ECDT) {
 		ec->command_addr = ecdt_ptr->data.address;
@@ -1922,13 +1925,16 @@ void __init acpi_ec_ecdt_probe(void)
 	ret = acpi_ec_setup(ec, NULL);
 	if (ret) {
 		acpi_ec_free(ec);
-		return;
+		goto out;
 	}
 
 	boot_ec = ec;
 	boot_ec_is_ecdt = true;
 
 	pr_info("Boot ECDT EC used to handle transactions\n");
+
+out:
+	acpi_put_table((struct acpi_table_header *)ecdt_ptr);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
1.7.12.4

