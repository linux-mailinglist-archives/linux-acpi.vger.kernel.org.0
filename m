Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBBB619327
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Nov 2022 10:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiKDJJo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Nov 2022 05:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiKDJJn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Nov 2022 05:09:43 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B9A1D0D2
        for <linux-acpi@vger.kernel.org>; Fri,  4 Nov 2022 02:09:43 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N3ZZQ62jfz15MN9;
        Fri,  4 Nov 2022 17:09:34 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 17:09:40 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 17:09:40 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] ACPI: tables: Fix the stale comments for acpi_locate_initial_tables()
Date:   Fri, 4 Nov 2022 16:54:38 +0800
Message-ID: <1667552078-48344-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

sdt_entry[] is long gone by commit ceb6c4683902 ("ACPICA: Remove
duplicate table manager"), update the comments to avoid confusion.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/tables.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 47ec11d..afb365a 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -838,12 +838,11 @@ acpi_status acpi_os_table_override(struct acpi_table_header *existing_table,
 /*
  * acpi_locate_initial_tables()
  *
- * find RSDP, find and checksum SDT/XSDT.
- * checksum all tables, print SDT/XSDT
+ * Get the RSDP, then find and checksum all the ACPI tables.
  *
- * result: sdt_entry[] is initialized
+ * result: initial_tables[] is initialized, and points to
+ * a list of ACPI tables.
  */
-
 int __init acpi_locate_initial_tables(void)
 {
 	acpi_status status;
-- 
1.7.12.4

