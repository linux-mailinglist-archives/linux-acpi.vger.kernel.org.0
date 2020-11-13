Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5BC2B14A1
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 04:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgKMDTv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 22:19:51 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7530 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgKMDTu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 22:19:50 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CXNxN0V1Zzhl1l;
        Fri, 13 Nov 2020 11:19:36 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Nov 2020 11:19:39 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v3 1/2] drm/amdkfd: Move the ignore_crat check before the CRAT table get
Date:   Fri, 13 Nov 2020 11:11:13 +0800
Message-ID: <1605237074-58920-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

If the ignore_crat is set to non-zero value, it's no point getting
the CRAT table, so just move the ignore_crat check before we get the
CRAT table.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 3de5e14..c23e571 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -780,6 +780,11 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 
 	*crat_image = NULL;
 
+	if (kfd_ignore_crat()) {
+		pr_info("CRAT table disabled by module option\n");
+		return -ENODATA;
+	}
+
 	/* Fetch the CRAT table from ACPI */
 	status = acpi_get_table(CRAT_SIGNATURE, 0, &crat_table);
 	if (status == AE_NOT_FOUND) {
@@ -792,11 +797,6 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 		return -EINVAL;
 	}
 
-	if (kfd_ignore_crat()) {
-		pr_info("CRAT table disabled by module option\n");
-		return -ENODATA;
-	}
-
 	pcrat_image = kvmalloc(crat_table->length, GFP_KERNEL);
 	if (!pcrat_image)
 		return -ENOMEM;
-- 
1.7.12.4

