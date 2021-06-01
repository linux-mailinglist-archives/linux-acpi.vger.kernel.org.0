Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD3A39720A
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jun 2021 13:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhFALHu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Jun 2021 07:07:50 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:54392 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231219AbhFALHu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Jun 2021 07:07:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UavSAwh_1622545559;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UavSAwh_1622545559)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Jun 2021 19:06:06 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     keescook@chromium.org
Cc:     anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        james.morse@arm.com, bp@alien8.de, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ACPI: APEI: ERST: Fix missing error code in erst_init()
Date:   Tue,  1 Jun 2021 19:05:53 +0800
Message-Id: <1622545553-19160-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The error code is missing in this code scenario, add the error code
'-EINVAL' to the return value 'rc'.

Eliminate the follow smatch warning:

drivers/acpi/apei/erst.c:1114 erst_init() warn: missing error code 'rc'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/acpi/apei/erst.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 242f3c2..492d499 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -1110,9 +1110,10 @@ static int __init erst_init(void)
 
 	status = acpi_get_table(ACPI_SIG_ERST, 0,
 				(struct acpi_table_header **)&erst_tab);
-	if (status == AE_NOT_FOUND)
+	if (status == AE_NOT_FOUND) {
+		rc = -EINVAL;
 		goto err;
-	else if (ACPI_FAILURE(status)) {
+	} else if (ACPI_FAILURE(status)) {
 		const char *msg = acpi_format_exception(status);
 		pr_err("Failed to get table, %s\n", msg);
 		rc = -EINVAL;
-- 
1.8.3.1

