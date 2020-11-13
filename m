Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAC02B149F
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 04:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgKMDTt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 22:19:49 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7187 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgKMDTt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 22:19:49 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CXNxN1FRtz15Vv4;
        Fri, 13 Nov 2020 11:19:36 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Nov 2020 11:19:39 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v3 2/2] drm/amdkfd: Put ACPI table after using it
Date:   Fri, 13 Nov 2020 11:11:14 +0800
Message-ID: <1605237074-58920-2-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1605237074-58920-1-git-send-email-guohanjun@huawei.com>
References: <1605237074-58920-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The acpi_get_table() should be coupled with acpi_put_table() if
the mapped table is not used at runtime to release the table
mapping which can prevent the memory leak.

In kfd_create_crat_image_acpi(), crat_table is copied to pcrat_image,
and in kfd_create_vcrat_image_cpu(), the acpi_table is only used to
get the OEM information, so those two table mappings need to be released
after using it.

Fixes: 174de876d6d0 ("drm/amdkfd: Group up CRAT related functions")
Fixes: 520b8fb755cc ("drm/amdkfd: Add topology support for CPUs")
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index c23e571..0dc8de0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -774,6 +774,7 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 	struct acpi_table_header *crat_table;
 	acpi_status status;
 	void *pcrat_image;
+	int rc = 0;
 
 	if (!crat_image)
 		return -EINVAL;
@@ -798,14 +799,17 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 	}
 
 	pcrat_image = kvmalloc(crat_table->length, GFP_KERNEL);
-	if (!pcrat_image)
-		return -ENOMEM;
+	if (!pcrat_image) {
+		rc = -ENOMEM;
+		goto out;
+	}
 
 	memcpy(pcrat_image, crat_table, crat_table->length);
 	*crat_image = pcrat_image;
 	*size = crat_table->length;
-
-	return 0;
+out:
+	acpi_put_table(crat_table);
+	return rc;
 }
 
 /* Memory required to create Virtual CRAT.
@@ -988,6 +992,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 				CRAT_OEMID_LENGTH);
 		memcpy(crat_table->oem_table_id, acpi_table->oem_table_id,
 				CRAT_OEMTABLEID_LENGTH);
+		acpi_put_table(acpi_table);
 	}
 	crat_table->total_entries = 0;
 	crat_table->num_domains = 0;
-- 
1.7.12.4

