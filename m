Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2254E45936
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2019 11:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfFNJtz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Jun 2019 05:49:55 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:33814 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726900AbfFNJtz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Jun 2019 05:49:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TU8e0w4_1560505783;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TU8e0w4_1560505783)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 Jun 2019 17:49:51 +0800
From:   luanshi <zhangliguang@linux.alibaba.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH] ACPI / APEI: release resources if gen_pool_add fails
Date:   Fri, 14 Jun 2019 17:49:43 +0800
Message-Id: <1560505783-130606-1-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

To avoid memory leaks, destroy ghes_estatus_pool and release memory
allocated via vmalloc() on errors in ghes_estatus_pool_init().

Signed-off-by: liguang.zlg <zhangliguang@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 993940d..8472c96 100644
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
+		vfree(addr);
+		gen_pool_destroy(ghes_estatus_pool);
+	}
+	return rc;
 }
 
 static int map_gen_v2(struct ghes *ghes)
-- 
1.8.3.1

