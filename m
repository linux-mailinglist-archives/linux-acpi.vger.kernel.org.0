Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4245530749C
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Jan 2021 12:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhA1LVK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Jan 2021 06:21:10 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11526 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA1LVJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jan 2021 06:21:09 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DRHzj3Sg9zjFSQ;
        Thu, 28 Jan 2021 19:19:13 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 28 Jan 2021 19:20:19 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <rui.zhang@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] ACPI: tables: Mark acpi_init_fpdt with static keyword
Date:   Thu, 28 Jan 2021 19:31:19 +0800
Message-ID: <1611833479-87653-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix the following sparse warning:

drivers/acpi/acpi_fpdt.c:230:6: warning: symbol 'acpi_init_fpdt' was not declared. Should it be static?

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/acpi/acpi_fpdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
index b810811..968f9cc 100644
--- a/drivers/acpi/acpi_fpdt.c
+++ b/drivers/acpi/acpi_fpdt.c
@@ -227,7 +227,7 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
 	return 0;
 }
 
-void acpi_init_fpdt(void)
+static void acpi_init_fpdt(void)
 {
 	acpi_status status;
 	struct acpi_table_header *header;
-- 
2.6.2

