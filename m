Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C30AB4779B
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2019 03:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfFQB2A (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 16 Jun 2019 21:28:00 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:36375 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727382AbfFQB2A (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 16 Jun 2019 21:28:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TUNARfg_1560734870;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TUNARfg_1560734870)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Jun 2019 09:27:57 +0800
From:   luanshi <zhangliguang@linux.alibaba.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH v2] ACPI / APEI: release resources if gen_pool_add fails
Date:   Mon, 17 Jun 2019 09:27:50 +0800
Message-Id: <1560734870-27742-1-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

To avoid memory leaks, destroy ghes_estatus_pool and release memory
allocated via vmalloc() on errors in ghes_estatus_pool_init().

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
Reviewed-by: James Morse <james.morse@arm.com>
Tested-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/apei/ghes.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 993940d..4e5de30 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -153,6 +153,7 @@ static void ghes_unmap(void __iomem *vaddr, enum fixed_addresses fixmap_idx)
 int ghes_estatus_pool_init(int num_ghes)
 {
 	unsigned long addr, len;
+	int rc = 0;
 
 	ghes_estatus_pool = gen_pool_create(GHES_ESTATUS_POOL_MIN_ALLOC_ORDER, -1);
 	if (!ghes_estatus_pool)
@@ -163,8 +164,10 @@ int ghes_estatus_pool_init(int num_ghes)
 
 	ghes_estatus_pool_size_request = PAGE_ALIGN(len);
 	addr = (unsigned long)vmalloc(PAGE_ALIGN(len));
-	if (!addr)
+	if (!addr) {
+		gen_pool_destroy(ghes_estatus_pool);
 		return -ENOMEM;
+	}
 
 	/*
 	 * New allocation must be visible in all pgd before it can be found by
@@ -172,7 +175,12 @@ int ghes_estatus_pool_init(int num_ghes)
 	 */
 	vmalloc_sync_all();
 
-	return gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
+	rc = gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
+	if (rc) {
+		gen_pool_destroy(ghes_estatus_pool);
+		vfree((void *)addr);
+	}
+	return rc;
 }
 
 static int map_gen_v2(struct ghes *ghes)
-- 
1.8.3.1

