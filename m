Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858DD3B7150
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 13:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhF2La1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 07:30:27 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:59676 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233281AbhF2La1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Jun 2021 07:30:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Ue4wqmP_1624966071;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0Ue4wqmP_1624966071)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 29 Jun 2021 19:27:58 +0800
From:   Liguang Zhang <zhangliguang@linux.alibaba.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liguang Zhang <zhangliguang@linux.alibaba.com>
Subject: [PATCH] ACPI / amba: Fix resource name in /proc/iomem
Date:   Tue, 29 Jun 2021 19:27:48 +0800
Message-Id: <20210629112748.23734-1-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In function amba_handler_attach(), dev->res.name is initialized by
amba_device_alloc. But when address_found is false, dev->res.name is
assigned to null value, which leads to wrong resource name display in
/proc/iomem, "<BAD>" is seen for those resources.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 drivers/acpi/acpi_amba.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
index 49b781a9cd97..ab8a4e0191b1 100644
--- a/drivers/acpi/acpi_amba.c
+++ b/drivers/acpi/acpi_amba.c
@@ -76,6 +76,7 @@ static int amba_handler_attach(struct acpi_device *adev,
 		case IORESOURCE_MEM:
 			if (!address_found) {
 				dev->res = *rentry->res;
+				dev->res.name = dev_name(&dev->dev);
 				address_found = true;
 			}
 			break;
-- 
2.19.1.6.gb485710b

