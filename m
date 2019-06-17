Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6330479B4
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2019 07:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbfFQFZj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Jun 2019 01:25:39 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:57915 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725280AbfFQFZj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Jun 2019 01:25:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TUOOomu_1560749129;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TUOOomu_1560749129)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Jun 2019 13:25:36 +0800
From:   luanshi <zhangliguang@linux.alibaba.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH] ACPI / APEI: Remove needless __ghes_check_estatus() calls
Date:   Mon, 17 Jun 2019 13:25:29 +0800
Message-Id: <1560749129-26288-1-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Function __ghes_check_estatus() is called after __ghes_peek_estatus(),
but it is already called in __ghes_peek_estatus(). So we should remove
some needless __ghes_check_estatus() calls.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 993940d..1041a4d 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -372,10 +372,6 @@ static int ghes_read_estatus(struct ghes *ghes,
 	if (rc)
 		return rc;
 
-	rc = __ghes_check_estatus(ghes, estatus);
-	if (rc)
-		return rc;
-
 	return __ghes_read_estatus(estatus, *buf_paddr, fixmap_idx,
 				   cper_estatus_len(estatus));
 }
@@ -882,12 +878,6 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 		return rc;
 	}
 
-	rc = __ghes_check_estatus(ghes, &tmp_header);
-	if (rc) {
-		ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
-		return rc;
-	}
-
 	len = cper_estatus_len(&tmp_header);
 	node_len = GHES_ESTATUS_NODE_LEN(len);
 	estatus_node = (void *)gen_pool_alloc(ghes_estatus_pool, node_len);
-- 
1.8.3.1

