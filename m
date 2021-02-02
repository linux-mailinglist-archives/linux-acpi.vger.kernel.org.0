Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7605730B806
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 07:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhBBGwk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 01:52:40 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:33072 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232019AbhBBGwk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 01:52:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UNesyd7_1612248704;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNesyd7_1612248704)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Feb 2021 14:51:44 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     keescook@chromium.org
Cc:     anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        rjw@rjwysocki.net, lenb@kernel.org, james.morse@arm.com,
        bp@alien8.de, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] apei: erst: remove unneeded semicolon
Date:   Tue,  2 Feb 2021 14:51:42 +0800
Message-Id: <1612248702-49626-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/acpi/apei/erst.c:691:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/acpi/apei/erst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 2e0b0fc..b959721 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -688,7 +688,7 @@ static int __erst_read_from_storage(u64 record_id, u64 offset)
 			break;
 		if (erst_timedout(&timeout, SPIN_UNIT))
 			return -EIO;
-	};
+	}
 	rc = apei_exec_run(&ctx, ACPI_ERST_GET_COMMAND_STATUS);
 	if (rc)
 		return rc;
-- 
1.8.3.1

