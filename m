Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE1338E583
	for <lists+linux-acpi@lfdr.de>; Mon, 24 May 2021 13:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhEXLhJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 May 2021 07:37:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5678 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhEXLhJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 May 2021 07:37:09 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpZns30Nsz1BMhv;
        Mon, 24 May 2021 19:32:49 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:35:39 +0800
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 24 May
 2021 19:35:39 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] ACPI: LPSS: Replaced simple_strtol() with kstrtol()
Date:   Mon, 24 May 2021 20:08:32 +0800
Message-ID: <20210524120832.1580247-1-liushixin2@huawei.com>
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

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
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

