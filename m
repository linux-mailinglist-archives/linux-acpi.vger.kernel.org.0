Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80548105EB9
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 03:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfKVCwf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Nov 2019 21:52:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:41322 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726270AbfKVCwf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 Nov 2019 21:52:35 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A0621802B5DE541AF98F;
        Fri, 22 Nov 2019 10:52:33 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Fri, 22 Nov 2019 10:52:25 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <rjw@rjwysocki.net>, <yeyunfeng@huawei.com>
CC:     <linuxarm@huawei.com>, <linux-acpi@vger.kernel.org>,
        <john.garry@huawei.com>, Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH] ACPI: sysfs: Define the variable gpe from u8 to u16 to avoid endless loop in function apci_gpe_apply_masked_gpes()
Date:   Fri, 22 Nov 2019 10:49:17 +0800
Message-ID: <1574390957-6313-1-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

After the patch (eb09878e1301 ("ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100")),
the macro ACPI_MASKABLE_GPE_MAX is changed from 0xFF to 0x100. So in function
apci_gpe_apply_masked_gpes(), the variable gpe may reach 0x100 but it is
defined as u8, so it will be 0 when reaching 0x100. If the bitmap
acpi_masked_gpes_map are all 0s, it will loop all the times.

To solve endless loop in the function, define the variable gpe from u8 to u16.

Fixes: eb09878e1301 ("ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100")
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 drivers/acpi/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 0a83ce1..c60d2c6 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -838,7 +838,7 @@ void __init acpi_gpe_apply_masked_gpes(void)
 {
 	acpi_handle handle;
 	acpi_status status;
-	u8 gpe;
+	u16 gpe;
 
 	for_each_set_bit(gpe, acpi_masked_gpes_map, ACPI_MASKABLE_GPE_MAX) {
 		status = acpi_get_gpe_device(gpe, &handle);
-- 
2.8.1

