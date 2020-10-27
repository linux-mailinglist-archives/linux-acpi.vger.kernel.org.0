Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23C429AA87
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 12:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1749900AbgJ0L2M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Oct 2020 07:28:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:6396 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1749880AbgJ0L2I (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2020 07:28:08 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CL8Zt1Yshz6wN3;
        Tue, 27 Oct 2020 19:28:06 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.24.15) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 27 Oct 2020 19:27:54 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <devel@acpica.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <jonathan.cameron@huawei.com>
Subject: [RFC PATCH 1/4] ACPICA: IORT: Update for revision E
Date:   Tue, 27 Oct 2020 11:26:43 +0000
Message-ID: <20201027112646.44680-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
References: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.24.15]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

IORT revision E contains a few additions like,
    -Added an identifier field in the node descriptors to aid table
     cross-referencing.
    -Introduced the Reserved Memory Range(RMR) node. This is used
     to describe memory ranges that are used by endpoints and requires
     a unity mapping in SMMU.
    -Introduced a flag in the RC node to express support for PRI.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 -This should be updated through acpica git. I have sent out a pull
  request for the same here,
  https://github.com/acpica/acpica/pull/638

Please help to review.
---
 include/acpi/actbl2.h | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index ec66779cb193..274fce7b5c01 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -68,7 +68,7 @@
  * IORT - IO Remapping Table
  *
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
- * Document number: ARM DEN 0049D, March 2018
+ * Document number: ARM DEN 0049E, June 2020
  *
  ******************************************************************************/
 
@@ -86,7 +86,8 @@ struct acpi_iort_node {
 	u8 type;
 	u16 length;
 	u8 revision;
-	u32 reserved;
+	u16 reserved;
+	u16 identifier;
 	u32 mapping_count;
 	u32 mapping_offset;
 	char node_data[1];
@@ -100,7 +101,8 @@ enum acpi_iort_node_type {
 	ACPI_IORT_NODE_PCI_ROOT_COMPLEX = 0x02,
 	ACPI_IORT_NODE_SMMU = 0x03,
 	ACPI_IORT_NODE_SMMU_V3 = 0x04,
-	ACPI_IORT_NODE_PMCG = 0x05
+	ACPI_IORT_NODE_PMCG = 0x05,
+	ACPI_IORT_NODE_RMR = 0x06,
 };
 
 struct acpi_iort_id_mapping {
@@ -167,10 +169,10 @@ struct acpi_iort_root_complex {
 	u8 reserved[3];		/* Reserved, must be zero */
 };
 
-/* Values for ats_attribute field above */
+/* Masks for ats_attribute field above */
 
-#define ACPI_IORT_ATS_SUPPORTED         0x00000001	/* The root complex supports ATS */
-#define ACPI_IORT_ATS_UNSUPPORTED       0x00000000	/* The root complex doesn't support ATS */
+#define ACPI_IORT_ATS_SUPPORTED         (1)	/* The root complex supports ATS */
+#define ACPI_IORT_PRI_SUPPORTED         (1<<1)	/* The root complex supports PRI */
 
 struct acpi_iort_smmu {
 	u64 base_address;	/* SMMU base address */
@@ -241,6 +243,17 @@ struct acpi_iort_pmcg {
 	u64 page1_base_address;
 };
 
+struct acpi_iort_rmr {
+	u32 rmr_count;
+	u32 rmr_offset;
+};
+
+struct acpi_iort_rmr_desc {
+	u64 base_address;
+	u64 length;
+	u32 reserved;
+};
+
 /*******************************************************************************
  *
  * IVRS - I/O Virtualization Reporting Structure
-- 
2.17.1

