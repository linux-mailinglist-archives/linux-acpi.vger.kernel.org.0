Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396E526D5FE
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Sep 2020 10:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgIQILv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Sep 2020 04:11:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35396 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbgIQIDu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Sep 2020 04:03:50 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 857ADBF395BA8AA8B886;
        Thu, 17 Sep 2020 15:47:00 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 15:46:52 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 18/25] ACPI: SBS: Simplify the driver init code
Date:   Thu, 17 Sep 2020 15:38:58 +0800
Message-ID: <1600328345-27627-19-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
References: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_bus_register_driver() will check acpi_disable and return
-ENODEV, so the acpi_disable check outside the
acpi_bus_register_driver() is duplicated, can be removed.

Also we can just return from acpi_bus_register_driver() then
we can simplify the code further.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/sbs.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index f158b8c..ee13960 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -714,16 +714,7 @@ static int acpi_sbs_resume(struct device *dev)
 
 static int __init acpi_sbs_init(void)
 {
-	int result = 0;
-
-	if (acpi_disabled)
-		return -ENODEV;
-
-	result = acpi_bus_register_driver(&acpi_sbs_driver);
-	if (result < 0)
-		return -ENODEV;
-
-	return 0;
+	return acpi_bus_register_driver(&acpi_sbs_driver);
 }
 
 static void __exit acpi_sbs_exit(void)
-- 
1.7.12.4

