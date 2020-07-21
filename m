Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF3E227C81
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jul 2020 12:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgGUKGO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Jul 2020 06:06:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45790 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729102AbgGUKGM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 21 Jul 2020 06:06:12 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4D56BEE2BE1EA4F59E8C;
        Tue, 21 Jul 2020 18:06:10 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Jul 2020 18:05:59 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 1/3] ACPI: tables: Remove the duplicated checks for acpi_parse_entries_array()
Date:   Tue, 21 Jul 2020 17:59:04 +0800
Message-ID: <1595325546-63774-2-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1595325546-63774-1-git-send-email-guohanjun@huawei.com>
References: <1595325546-63774-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_disabled, pointer id and table_header are checked in
acpi_table_parse_entries_array(), and acpi_parse_entries_array() is only
called by acpi_table_parse_entries_array(), so those checks in
acpi_parse_entries_array() are duplicate.

Remove those duplicated check and move the table_size check to
function acpi_table_parse_entries_array() as well.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/tables.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 0e905c3..c85e1c6 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -292,20 +292,6 @@ static int __init acpi_parse_entries_array(char *id, unsigned long table_size,
 	int errs = 0;
 	int i;
 
-	if (acpi_disabled)
-		return -ENODEV;
-
-	if (!id)
-		return -EINVAL;
-
-	if (!table_size)
-		return -EINVAL;
-
-	if (!table_header) {
-		pr_warn("%4.4s not present\n", id);
-		return -ENODEV;
-	}
-
 	table_end = (unsigned long)table_header + table_header->length;
 
 	/* Parse all entries looking for a match. */
@@ -371,6 +357,9 @@ int __init acpi_table_parse_entries_array(char *id,
 	if (!id)
 		return -EINVAL;
 
+	if (!table_size)
+		return -EINVAL;
+
 	if (!strncmp(id, ACPI_SIG_MADT, 4))
 		instance = acpi_apic_instance;
 
-- 
1.7.12.4

