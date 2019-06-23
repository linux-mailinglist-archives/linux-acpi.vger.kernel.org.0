Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B524F995
	for <lists+linux-acpi@lfdr.de>; Sun, 23 Jun 2019 04:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfFWCuL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 22 Jun 2019 22:50:11 -0400
Received: from out4437.biz.mail.alibaba.com ([47.88.44.37]:42019 "EHLO
        out4437.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbfFWCuL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 22 Jun 2019 22:50:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TUwfXfq_1561258201;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TUwfXfq_1561258201)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 23 Jun 2019 10:50:09 +0800
From:   luanshi <zhangliguang@linux.alibaba.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH v3] ACPI / APEI: release resources if gen_pool_add fails
Date:   Sun, 23 Jun 2019 10:50:01 +0800
Message-Id: <1561258201-26917-1-git-send-email-zhangliguang@linux.alibaba.com>
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
 drivers/acpi/apei/ghes.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 993940d..5b96d12 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -153,10 +153,11 @@ static void ghes_unmap(void __iomem *vaddr, enum fixed_addresses fixmap_idx)
 int ghes_estatus_pool_init(int num_ghes)
 {
 	unsigned long addr, len;
+	int rc = 0;
 
 	ghes_estatus_pool = gen_pool_create(GHES_ESTATUS_POOL_MIN_ALLOC_ORDER, -1);
 	if (!ghes_estatus_pool)
-		return -ENOMEM;
+		goto nomem;
 
 	len = GHES_ESTATUS_CACHE_AVG_SIZE * GHES_ESTATUS_CACHE_ALLOCED_MAX;
 	len += (num_ghes * GHES_ESOURCE_PREALLOC_MAX_SIZE);
@@ -164,7 +165,7 @@ int ghes_estatus_pool_init(int num_ghes)
 	ghes_estatus_pool_size_request = PAGE_ALIGN(len);
 	addr = (unsigned long)vmalloc(PAGE_ALIGN(len));
 	if (!addr)
-		return -ENOMEM;
+		goto pool_destroy;
 
 	/*
 	 * New allocation must be visible in all pgd before it can be found by
@@ -172,7 +173,17 @@ int ghes_estatus_pool_init(int num_ghes)
 	 */
 	vmalloc_sync_all();
 
-	return gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
+	rc = gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
+	if (rc)
+		goto pool_destroy;
+
+	return 0;
+pool_destroy:
+	gen_pool_destroy(ghes_estatus_pool);
+	if (addr)
+		vfree((void *)addr);
+nomem:
+	return -ENOMEM;
 }
 
 static int map_gen_v2(struct ghes *ghes)
-- 
1.8.3.1

