Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801ED2B1452
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 03:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgKMCfI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 21:35:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8077 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgKMCfI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 21:35:08 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CXMxm5dcxzLsKy;
        Fri, 13 Nov 2020 10:34:52 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Nov 2020 10:34:59 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <linux-acpi@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] ACPI: tiny-power-button: Simplify the code using module_acpi_driver()
Date:   Fri, 13 Nov 2020 10:26:44 +0800
Message-ID: <1605234404-31600-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Using module_acpi_driver() to simplify the code.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/tiny-power-button.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/tiny-power-button.c b/drivers/acpi/tiny-power-button.c
index 420e61b..a19f0e4 100644
--- a/drivers/acpi/tiny-power-button.c
+++ b/drivers/acpi/tiny-power-button.c
@@ -40,6 +40,4 @@ static void acpi_tiny_power_button_notify(struct acpi_device *device, u32 event)
 	},
 };
 
-module_driver(acpi_tiny_power_button_driver,
-		acpi_bus_register_driver,
-		acpi_bus_unregister_driver);
+module_acpi_driver(acpi_tiny_power_button_driver);
-- 
1.7.12.4

