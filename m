Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29142B144B
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 03:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgKMCdj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 21:33:39 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7529 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgKMCdi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 21:33:38 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CXMw53QH8zhl1s;
        Fri, 13 Nov 2020 10:33:25 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Nov 2020 10:33:29 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <linux-acpi@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 2/2] ACPI: SBS: Simplify the code using module_acpi_driver()
Date:   Fri, 13 Nov 2020 10:25:11 +0800
Message-ID: <1605234311-29912-2-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1605234311-29912-1-git-send-email-guohanjun@huawei.com>
References: <1605234311-29912-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Using the module_acpi_driver() to simplify the code.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/sbs.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index cbd1af7..3b0b6dd 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -711,17 +711,4 @@ static int acpi_sbs_resume(struct device *dev)
 		},
 	.drv.pm = &acpi_sbs_pm,
 };
-
-static int __init acpi_sbs_init(void)
-{
-	return acpi_bus_register_driver(&acpi_sbs_driver);
-}
-
-static void __exit acpi_sbs_exit(void)
-{
-	acpi_bus_unregister_driver(&acpi_sbs_driver);
-	return;
-}
-
-module_init(acpi_sbs_init);
-module_exit(acpi_sbs_exit);
+module_acpi_driver(acpi_sbs_driver);
-- 
1.7.12.4

