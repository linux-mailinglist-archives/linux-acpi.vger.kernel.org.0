Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3457279D4A
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Sep 2020 03:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgI0BRF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Sep 2020 21:17:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14283 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726311AbgI0BRF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 26 Sep 2020 21:17:05 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B7AAEA30A48EDC055628;
        Sun, 27 Sep 2020 09:17:02 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sun, 27 Sep 2020 09:16:57 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v2] ACPI: scan: Use pr_debug replace ACPI_DEBUG_PRINT()
Date:   Sun, 27 Sep 2020 09:14:28 +0800
Message-ID: <1601169268-12062-1-git-send-email-tiantao6@hisilicon.com>
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
v2:rewrite the patch and change the patch name.
---
 drivers/acpi/scan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 2142f15..684c726 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -898,8 +898,7 @@ static void acpi_bus_get_wakeup_device_flags(struct acpi_device *device)
 	 */
 	err = acpi_device_sleep_wake(device, 0, 0, 0);
 	if (err)
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				"error in _DSW or _PSW evaluation\n"));
+		pr_debug("error in _DSW or _PSW evaluation\n");
 }
 
 static void acpi_bus_init_power_state(struct acpi_device *device, int state)
-- 
2.7.4

