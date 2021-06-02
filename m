Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEDD3984E8
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 11:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhFBJIX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 05:08:23 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2848 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhFBJIW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 05:08:22 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fw31Z6QZszWqlw;
        Wed,  2 Jun 2021 17:01:54 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:41 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:41 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 01/18] ACPI: cmos_rtc: Using pr_fmt() and remove PREFIX
Date:   Wed, 2 Jun 2021 16:54:23 +0800
Message-ID: <1622624080-56025-2-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1622624080-56025-1-git-send-email-guohanjun@huawei.com>
References: <1622624080-56025-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Introduce pr_fmt() and remove printk PREFIX to unify the
log message printing.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/acpi_cmos_rtc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_cmos_rtc.c b/drivers/acpi/acpi_cmos_rtc.c
index 67f1d33..4cf4aef 100644
--- a/drivers/acpi/acpi_cmos_rtc.c
+++ b/drivers/acpi/acpi_cmos_rtc.c
@@ -6,6 +6,8 @@
  * Authors: Lan Tianyu <tianyu.lan@intel.com>
  */
 
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -59,7 +61,7 @@ static int acpi_install_cmos_rtc_space_handler(struct acpi_device *adev,
 			&acpi_cmos_rtc_space_handler,
 			NULL, NULL);
 	if (ACPI_FAILURE(status)) {
-		pr_err(PREFIX "Error installing CMOS-RTC region handler\n");
+		pr_err("Error installing CMOS-RTC region handler\n");
 		return -ENODEV;
 	}
 
@@ -70,7 +72,7 @@ static void acpi_remove_cmos_rtc_space_handler(struct acpi_device *adev)
 {
 	if (ACPI_FAILURE(acpi_remove_address_space_handler(adev->handle,
 			ACPI_ADR_SPACE_CMOS, &acpi_cmos_rtc_space_handler)))
-		pr_err(PREFIX "Error removing CMOS-RTC region handler\n");
+		pr_err("Error removing CMOS-RTC region handler\n");
 }
 
 static struct acpi_scan_handler cmos_rtc_handler = {
-- 
1.7.12.4

