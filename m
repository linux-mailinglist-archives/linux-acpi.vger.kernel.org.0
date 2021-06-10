Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FE23A288E
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 11:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhFJJmm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 05:42:42 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:58422 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230216AbhFJJml (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Jun 2021 05:42:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UbxKN6e_1623318041;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UbxKN6e_1623318041)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Jun 2021 17:40:43 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rjw@rjwysocki.net
Cc:     lenb@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 1/2] ACPI: processor_throttling: Remove redundant initialization of 'obj'
Date:   Thu, 10 Jun 2021 17:40:38 +0800
Message-Id: <1623318039-57133-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

'obj' is being initialized, however this value is never read as
'obj' is assigned an updated value later. Remove the redundant
initialization.

Clean up clang warning:
drivers/acpi/processor_throttling.c:409:20: warning: Value stored to
'obj' during its initialization is never read
[clang-analyzer-deadcode.DeadStores]

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/acpi/processor_throttling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 0086afe..017fd02 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -406,7 +406,7 @@ static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *ptc = NULL;
-	union acpi_object obj = { 0 };
+	union acpi_object obj;
 	struct acpi_processor_throttling *throttling;
 
 	status = acpi_evaluate_object(pr->handle, "_PTC", NULL, &buffer);
-- 
1.8.3.1

