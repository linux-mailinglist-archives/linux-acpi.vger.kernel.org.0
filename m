Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D977150A14
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2019 13:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfFXLsP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Jun 2019 07:48:15 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:34589 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726334AbfFXLsP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Jun 2019 07:48:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TV4FHQU_1561376883;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TV4FHQU_1561376883)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Jun 2019 19:48:11 +0800
From:   luanshi <zhangliguang@linux.alibaba.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH v2] ACPI / APEI: Remove needless __ghes_check_estatus() calls
Date:   Mon, 24 Jun 2019 19:48:03 +0800
Message-Id: <1561376883-95788-1-git-send-email-zhangliguang@linux.alibaba.com>
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
 drivers/acpi/apei/ghes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 993940d..a66e00f 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -345,7 +345,7 @@ static int __ghes_peek_estatus(struct ghes *ghes,
 		return -ENOENT;
 	}
 
-	return __ghes_check_estatus(ghes, estatus);
+	return 0;
 }
 
 static int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
-- 
1.8.3.1

