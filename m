Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F251C8579
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 11:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgEGJQL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 05:16:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36634 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbgEGJQK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 May 2020 05:16:10 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 689D25F86BF5528456AB;
        Thu,  7 May 2020 17:16:06 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 17:15:59 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, <linux-acpi@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 2/9] ACPI: watchdog: Put the watchdog action table after parsing
Date:   Thu, 7 May 2020 17:09:14 +0800
Message-ID: <1588842561-32907-3-git-send-email-guohanjun@huawei.com>
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

The mapped watchdog action table should be released after the
successfully parsing, and the failure path in the driver
initialization.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/acpi_watchdog.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
index 6e9ec6e..5c1e9ea 100644
--- a/drivers/acpi/acpi_watchdog.c
+++ b/drivers/acpi/acpi_watchdog.c
@@ -73,6 +73,7 @@ static const struct acpi_table_wdat *acpi_watchdog_get_wdat(void)
 	}
 
 	if (acpi_watchdog_uses_rtc(wdat)) {
+		acpi_put_table((struct acpi_table_header *)wdat);
 		pr_info("Skipping WDAT on this system because it uses RTC SRAM\n");
 		return NULL;
 	}
@@ -117,12 +118,12 @@ void __init acpi_watchdog_init(void)
 
 	/* Watchdog disabled by BIOS */
 	if (!(wdat->flags & ACPI_WDAT_ENABLED))
-		return;
+		goto fail_put_wdat;
 
 	/* Skip legacy PCI WDT devices */
 	if (wdat->pci_segment != 0xff || wdat->pci_bus != 0xff ||
 	    wdat->pci_device != 0xff || wdat->pci_function != 0xff)
-		return;
+		goto fail_put_wdat;
 
 	INIT_LIST_HEAD(&resource_list);
 
@@ -188,4 +189,6 @@ void __init acpi_watchdog_init(void)
 
 fail_free_resource_list:
 	resource_list_free(&resource_list);
+fail_put_wdat:
+	acpi_put_table((struct acpi_table_header *)wdat);
 }
-- 
1.7.12.4

