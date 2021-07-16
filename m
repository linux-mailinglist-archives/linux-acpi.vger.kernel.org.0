Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F1D3CB479
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 10:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbhGPIiK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 04:38:10 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3419 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237980AbhGPIiF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jul 2021 04:38:05 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GR48T6Jdbz6FDGr;
        Fri, 16 Jul 2021 16:26:33 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 10:35:09 +0200
Received: from A2006125610.china.huawei.com (10.47.80.222) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 09:35:02 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <yangyicong@huawei.com>
Subject: [PATCH v6 2/9] ACPI/IORT: Add support for RMR node parsing
Date:   Fri, 16 Jul 2021 09:34:35 +0100
Message-ID: <20210716083442.1708-3-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
References: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.80.222]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add support for parsing RMR node information from ACPI.

Find the associated streamid and smmu node info from the
RMR node and populate a linked list with RMR memory
descriptors.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c | 134 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 3b23fb775ac4..d76ba46ebe67 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -40,6 +40,8 @@ struct iort_fwnode {
 static LIST_HEAD(iort_fwnode_list);
 static DEFINE_SPINLOCK(iort_fwnode_lock);
 
+static LIST_HEAD(iort_rmr_list);	/* list of RMR regions from ACPI */
+
 /**
  * iort_set_fwnode() - Create iort_fwnode and use it to register
  *		       iommu data in the iort_fwnode_list
@@ -393,7 +395,8 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
 		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
 		    node->type == ACPI_IORT_NODE_SMMU_V3 ||
-		    node->type == ACPI_IORT_NODE_PMCG) {
+		    node->type == ACPI_IORT_NODE_PMCG ||
+		    node->type == ACPI_IORT_NODE_RMR) {
 			*id_out = map->output_base;
 			return parent;
 		}
@@ -1566,6 +1569,134 @@ static void __init iort_enable_acs(struct acpi_iort_node *iort_node)
 #else
 static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
 #endif
+static void iort_rmr_desc_check_overlap(struct acpi_iort_rmr_desc *desc, u32 count)
+{
+	int i, j;
+
+	for (i = 0; i < count; i++) {
+		u64 end, start = desc[i].base_address, length = desc[i].length;
+
+		end = start + length - 1;
+
+		/* Check for address overlap */
+		for (j = i + 1; j < count; j++) {
+			u64 e_start = desc[j].base_address;
+			u64 e_end = e_start + desc[j].length - 1;
+
+			if (start <= e_end && end >= e_start)
+				pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] overlaps, continue anyway\n",
+				       start, end);
+		}
+	}
+}
+
+static void __init iort_node_get_rmr_info(struct acpi_iort_node *iort_node)
+{
+	struct acpi_iort_node *smmu;
+	struct acpi_iort_rmr *rmr;
+	struct acpi_iort_rmr_desc *rmr_desc;
+	u32 map_count = iort_node->mapping_count;
+	u32 sid;
+	int i;
+
+	if (!iort_node->mapping_offset || map_count != 1) {
+		pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
+		       iort_node);
+		return;
+	}
+
+	/* Retrieve associated smmu and stream id */
+	smmu = iort_node_get_id(iort_node, &sid, 0);
+	if (!smmu) {
+		pr_err(FW_BUG "Invalid SMMU reference, skipping RMR node %p\n",
+		       iort_node);
+		return;
+	}
+
+	/* Retrieve RMR data */
+	rmr = (struct acpi_iort_rmr *)iort_node->node_data;
+	if (!rmr->rmr_offset || !rmr->rmr_count) {
+		pr_err(FW_BUG "Invalid RMR descriptor array, skipping RMR node %p\n",
+		       iort_node);
+		return;
+	}
+
+	rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, iort_node,
+				rmr->rmr_offset);
+
+	iort_rmr_desc_check_overlap(rmr_desc, rmr->rmr_count);
+
+	for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
+		struct iommu_resv_region *region;
+		enum iommu_resv_type type;
+		int prot = IOMMU_READ | IOMMU_WRITE;
+		u64 addr = rmr_desc->base_address, size = rmr_desc->length;
+
+		if (!IS_ALIGNED(addr, SZ_64K) || !IS_ALIGNED(size, SZ_64K)) {
+			/* PAGE align base addr and size */
+			addr &= PAGE_MASK;
+			size = PAGE_ALIGN(size + offset_in_page(rmr_desc->base_address));
+
+			pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] not aligned to 64K, continue with [0x%llx - 0x%llx]\n",
+			       rmr_desc->base_address,
+			       rmr_desc->base_address + rmr_desc->length - 1,
+			       addr, addr + size - 1);
+		}
+		if (rmr->flags & IOMMU_RMR_REMAP_PERMITTED) {
+			type = IOMMU_RESV_DIRECT_RELAXABLE;
+			/*
+			 * Set IOMMU_CACHE as IOMMU_RESV_DIRECT_RELAXABLE is
+			 * normally used for allocated system memory that is
+			 * then used for device specific reserved regions.
+			 */
+			prot |= IOMMU_CACHE;
+		} else {
+			type = IOMMU_RESV_DIRECT;
+			/*
+			 * Set IOMMU_MMIO as IOMMU_RESV_DIRECT is normally used
+			 * for device memory like MSI doorbell.
+			 */
+			prot |= IOMMU_MMIO;
+		}
+
+		region = iommu_alloc_resv_region(addr, size, prot, type);
+		if (region) {
+			region->fw_data.rmr.flags = rmr->flags;
+			region->fw_data.rmr.sid = sid;
+			region->fw_data.rmr.smmu = smmu;
+			list_add_tail(&region->list, &iort_rmr_list);
+		}
+	}
+}
+
+static void __init iort_parse_rmr(void)
+{
+	struct acpi_iort_node *iort_node, *iort_end;
+	struct acpi_table_iort *iort;
+	int i;
+
+	if (iort_table->revision < 3)
+		return;
+
+	iort = (struct acpi_table_iort *)iort_table;
+
+	iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
+				 iort->node_offset);
+	iort_end = ACPI_ADD_PTR(struct acpi_iort_node, iort,
+				iort_table->length);
+
+	for (i = 0; i < iort->node_count; i++) {
+		if (WARN_TAINT(iort_node >= iort_end, TAINT_FIRMWARE_WORKAROUND,
+			       "IORT node pointer overflows, bad table!\n"))
+			return;
+
+		if (iort_node->type == ACPI_IORT_NODE_RMR)
+			iort_node_get_rmr_info(iort_node);
+
+		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
+					 iort_node->length);
+	}
+}
 
 static void __init iort_init_platform_devices(void)
 {
@@ -1636,6 +1767,7 @@ void __init acpi_iort_init(void)
 	}
 
 	iort_init_platform_devices();
+	iort_parse_rmr();
 }
 
 #ifdef CONFIG_ZONE_DMA
-- 
2.17.1

