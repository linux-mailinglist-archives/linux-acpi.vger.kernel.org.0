Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D905B1068CC
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 10:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfKVJZv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 04:25:51 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52064 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726568AbfKVJZu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Nov 2019 04:25:50 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CB0036C79CB7C1BF1E23;
        Fri, 22 Nov 2019 17:25:48 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 22 Nov 2019
 17:25:41 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <robert.moore@intel.com>, <erik.schmauss@intel.com>,
        <rafael.j.wysocki@intel.com>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <devel@acpica.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] ACPICA: Use ARRAY_SIZE for 'fadt_info_table','fadt_pm_info_table'
Date:   Fri, 22 Nov 2019 17:33:03 +0800
Message-ID: <1574415183-19322-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fixes coccicheck warning:

drivers/acpi/acpica/tbfadt.c:107:27-28: WARNING: Use ARRAY_SIZE
drivers/acpi/acpica/tbfadt.c:137:30-31: WARNING: Use ARRAY_SIZE

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/acpi/acpica/tbfadt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 0041bfb..324a804 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -103,8 +103,7 @@ static struct acpi_fadt_info fadt_info_table[] = {
 	 ACPI_FADT_SEPARATE_LENGTH | ACPI_FADT_GPE_REGISTER}
 };

-#define ACPI_FADT_INFO_ENTRIES \
-			(sizeof (fadt_info_table) / sizeof (struct acpi_fadt_info))
+#define ACPI_FADT_INFO_ENTRIES (ARRAY_SIZE(fadt_info_table))

 /* Table used to split Event Blocks into separate status/enable registers */

@@ -133,8 +132,7 @@ static struct acpi_fadt_pm_info fadt_pm_info_table[] = {
 	 1}
 };

-#define ACPI_FADT_PM_INFO_ENTRIES \
-			(sizeof (fadt_pm_info_table) / sizeof (struct acpi_fadt_pm_info))
+#define ACPI_FADT_PM_INFO_ENTRIES (ARRAY_SIZE(fadt_pm_info_table))

 /*******************************************************************************
  *
--
2.7.4

