Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9210D27700D
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 13:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgIXLhF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Sep 2020 07:37:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53590 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726701AbgIXLhF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 24 Sep 2020 07:37:05 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id ADF1EE2A92E3FC39C628;
        Thu, 24 Sep 2020 19:37:01 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 19:36:51 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] ACPI: scan: Add braces around empty statements
Date:   Thu, 24 Sep 2020 19:34:23 +0800
Message-ID: <1600947263-43551-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fixes the following W=1 kernel build warning(s):
drivers/acpi/scan.c: In function ‘acpi_bus_get_wakeup_device_flags’:
drivers/acpi/scan.c:902:43: warning: suggest braces around empty body in
an ‘if’ statement [-Wempty-body]

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/acpi/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 2142f15..8340965 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -897,9 +897,10 @@ static void acpi_bus_get_wakeup_device_flags(struct acpi_device *device)
 	 * present will the _PSW object used.
 	 */
 	err = acpi_device_sleep_wake(device, 0, 0, 0);
-	if (err)
+	if (err) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				"error in _DSW or _PSW evaluation\n"));
+	}
 }
 
 static void acpi_bus_init_power_state(struct acpi_device *device, int state)
-- 
2.7.4

