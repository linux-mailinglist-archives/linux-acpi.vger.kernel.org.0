Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36150355E74
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 00:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243477AbhDFWFv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 18:05:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:54929 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243501AbhDFWFj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Apr 2021 18:05:39 -0400
IronPort-SDR: IfqlS5UHzdYlCitPYe+dHYtLqWocFzNoXlpvNzb2aqOpD4VXzQKuB8BP7M4pBVIfYlEaGf3p1z
 zcUic3g1bhcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="172640472"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="172640472"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 15:05:10 -0700
IronPort-SDR: nyKuTZ+6Xlva63mOZ23w7pMoRJ3x8dgbtom/fSZqGgmA6KUPXkSacxoO8tO4NG7fqdR7saR9vk
 ahIg6Anh88KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="379581777"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2021 15:05:09 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v2 21/22] ACPICA: IORT: Updates for revision E.b
Date:   Tue,  6 Apr 2021 14:30:27 -0700
Message-Id: <20210406213028.718796-22-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406213028.718796-1-erik.kaneda@intel.com>
References: <20210406213028.718796-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

ACPICA commit 8710a708faed728ea2672b8da842b2e9af1cf5bd

IORT revision E.b (ARM DEN 0049E.b) contains a few additions like,
    -Added an identifier field in the node descriptors to aid table
     cross-referencing.
    -Introduced the Reserved Memory Range(RMR) node. This is used
     to describe memory ranges that are used by endpoints and require
     a unity mapping in SMMU.
    -Introduced a flag in the RC node to express support for PRI.
    -Added a flag in the RC node to declare support for PASID forward
     information.

Please note that IORT Rev E and E.a have known issues and are not
supported.

Link: https://github.com/acpica/acpica/commit/8710a708
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl2.h | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 8383446295a5..18cafe3ebddc 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -68,7 +68,7 @@
  * IORT - IO Remapping Table
  *
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
- * Document number: ARM DEN 0049D, March 2018
+ * Document number: ARM DEN 0049E.b, Feb 2021
  *
  ******************************************************************************/
 
@@ -86,7 +86,7 @@ struct acpi_iort_node {
 	u8 type;
 	u16 length;
 	u8 revision;
-	u32 reserved;
+	u32 identifier;
 	u32 mapping_count;
 	u32 mapping_offset;
 	char node_data[1];
@@ -100,7 +100,8 @@ enum acpi_iort_node_type {
 	ACPI_IORT_NODE_PCI_ROOT_COMPLEX = 0x02,
 	ACPI_IORT_NODE_SMMU = 0x03,
 	ACPI_IORT_NODE_SMMU_V3 = 0x04,
-	ACPI_IORT_NODE_PMCG = 0x05
+	ACPI_IORT_NODE_PMCG = 0x05,
+	ACPI_IORT_NODE_RMR = 0x06,
 };
 
 struct acpi_iort_id_mapping {
@@ -167,10 +168,11 @@ struct acpi_iort_root_complex {
 	u8 reserved[3];		/* Reserved, must be zero */
 };
 
-/* Values for ats_attribute field above */
+/* Masks for ats_attribute field above */
 
-#define ACPI_IORT_ATS_SUPPORTED         0x00000001	/* The root complex supports ATS */
-#define ACPI_IORT_ATS_UNSUPPORTED       0x00000000	/* The root complex doesn't support ATS */
+#define ACPI_IORT_ATS_SUPPORTED         (1)	/* The root complex ATS support */
+#define ACPI_IORT_PRI_SUPPORTED         (1<<1)	/* The root complex PRI support */
+#define ACPI_IORT_PASID_FWD_SUPPORTED   (1<<2)	/* The root complex PASID forward support */
 
 struct acpi_iort_smmu {
 	u64 base_address;	/* SMMU base address */
@@ -241,6 +243,18 @@ struct acpi_iort_pmcg {
 	u64 page1_base_address;
 };
 
+struct acpi_iort_rmr {
+	u32 flags;
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
2.29.2

