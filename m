Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4113A2891
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 11:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFJJmp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 05:42:45 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:60979 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230252AbhFJJmp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Jun 2021 05:42:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UbxKN6e_1623318041;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UbxKN6e_1623318041)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Jun 2021 17:40:46 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rjw@rjwysocki.net
Cc:     lenb@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 2/2] ACPI: sleep: Fix kernel-doc
Date:   Thu, 10 Jun 2021 17:40:39 +0800
Message-Id: <1623318039-57133-2-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1623318039-57133-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1623318039-57133-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix function name in sleep.c kernel-doc comment
to remove a warning found by running make W=1 LLVM=1.

drivers/acpi/sleep.c:413: warning: expecting prototype for
acpi_pre_suspend(). Prototype was for acpi_pm_pre_suspend() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/acpi/sleep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index aaea10d..3023224 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -407,7 +407,7 @@ static int acpi_pm_freeze(void)
 }
 
 /**
- * acpi_pre_suspend - Enable wakeup devices, "freeze" EC and save NVS.
+ * acpi_pm_pre_suspend - Enable wakeup devices, "freeze" EC and save NVS.
  */
 static int acpi_pm_pre_suspend(void)
 {
-- 
1.8.3.1

