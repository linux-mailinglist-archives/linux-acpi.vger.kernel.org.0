Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADCC399CBF
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jun 2021 10:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhFCIlX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Jun 2021 04:41:23 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:4292 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFCIlX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jun 2021 04:41:23 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FwfMw71MMz1BHZH;
        Thu,  3 Jun 2021 16:34:52 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 16:39:36 +0800
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 3 Jun 2021
 16:39:35 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next v2] ACPI: LPSS: Replaced simple_strtol() with kstrtol()
Date:   Thu, 3 Jun 2021 17:12:04 +0800
Message-ID: <20210603091204.355720-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The simple_strtol() function is deprecated in some situation since
it does not check for the range overflow. Use kstrtol() instead.

As the variables status and shared_host are valid only when the uid
is not zero(default to zero). If uid_str is NULL or kstrtol() failed
or uid is assigned to zero, related operations can be skipped.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
v1->v2: The previous description is inaccurate, so modified it.

 drivers/acpi/acpi_lpss.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index ca742f16a507..1b46e00cad3a 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -186,13 +186,12 @@ static void byt_i2c_setup(struct lpss_private_data *pdata)
 	long uid = 0;
 
 	/* Expected to always be true, but better safe then sorry */
-	if (uid_str)
-		uid = simple_strtol(uid_str, NULL, 10);
-
-	/* Detect I2C bus shared with PUNIT and ignore its d3 status */
-	status = acpi_evaluate_integer(handle, "_SEM", NULL, &shared_host);
-	if (ACPI_SUCCESS(status) && shared_host && uid)
-		pmc_atom_d3_mask &= ~(BIT_LPSS2_F1_I2C1 << (uid - 1));
+	if (uid_str && !kstrtol(uid_str, 10, &uid)) {
+		/* Detect I2C bus shared with PUNIT and ignore its d3 status */
+		status = acpi_evaluate_integer(handle, "_SEM", NULL, &shared_host);
+		if (ACPI_SUCCESS(status) && shared_host && uid)
+			pmc_atom_d3_mask &= ~(BIT_LPSS2_F1_I2C1 << (uid - 1));
+	}
 
 	lpss_deassert_reset(pdata);
 
-- 
2.18.0.huawei.25

