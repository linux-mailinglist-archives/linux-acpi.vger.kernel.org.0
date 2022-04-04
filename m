Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEC44F1521
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Apr 2022 14:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347542AbiDDMpz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Apr 2022 08:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347701AbiDDMpy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Apr 2022 08:45:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1204D30565
        for <linux-acpi@vger.kernel.org>; Mon,  4 Apr 2022 05:43:58 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KX9QZ6ZTbz685ZZ;
        Mon,  4 Apr 2022 20:42:14 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 14:43:56 +0200
Received: from A2006125610.china.huawei.com (10.47.93.34) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 13:43:48 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>, <will@kernel.org>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <laurentiu.tudor@nxp.com>, <yangyicong@huawei.com>
Subject: [PATCH v9 06/11] ACPI/IORT: Add support to retrieve IORT RMR reserved regions
Date:   Mon, 4 Apr 2022 13:42:04 +0100
Message-ID: <20220404124209.1086-7-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.93.34]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Parse through the IORT RMR nodes and populate the reserve region list
corresponding to a given IOMMU and device(optional). Also, go through
the ID mappings of the RMR node and retrieve all the SIDs associated
with it.

Now that we have this support, update iommu_dma_get/_put_resv_regions()
paths to include the RMR reserve regions.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c | 275 ++++++++++++++++++++++++++++++++++++++
 drivers/iommu/dma-iommu.c |   3 +
 include/linux/acpi_iort.h |   4 +
 3 files changed, 282 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 63acc3c5b275..1147387cfddb 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -812,6 +812,259 @@ void acpi_configure_pmsi_domain(struct device *dev)
 }
 
 #ifdef CONFIG_IOMMU_API
+static void iort_rmr_desc_check_overlap(struct acpi_iort_rmr_desc *desc, u32 count)
+{
+	int i, j;
+
+	for (i = 0; i < count; i++) {
+		u64 end, start = desc[i].base_address, length = desc[i].length;
+
+		if (!length) {
+			pr_err(FW_BUG "RMR descriptor[0x%llx] with zero length, continue anyway\n",
+			       start);
+			continue;
+		}
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
+/*
+ * Please note, we will keep the already allocated RMR reserve
+ * regions in case of a memory allocation failure.
+ */
+static void iort_get_rmrs(struct acpi_iort_node *node,
+			  struct acpi_iort_node *smmu,
+			  u32 *sids, u32 num_sids,
+			  struct list_head *head)
+{
+	struct acpi_iort_rmr *rmr = (struct acpi_iort_rmr *)node->node_data;
+	struct acpi_iort_rmr_desc *rmr_desc;
+	int i;
+
+	rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, node,
+				rmr->rmr_offset);
+
+	iort_rmr_desc_check_overlap(rmr_desc, rmr->rmr_count);
+
+	for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
+		struct iommu_resv_region *region;
+		enum iommu_resv_type type;
+		u32  *sids_copy;
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
+
+		if (rmr->flags & ACPI_IORT_RMR_REMAP_PERMITTED)
+			type = IOMMU_RESV_DIRECT_RELAXABLE;
+		else
+			type = IOMMU_RESV_DIRECT;
+
+		if (rmr->flags & ACPI_IORT_RMR_ACCESS_PRIVILEGE)
+			prot |= IOMMU_PRIV;
+
+		/* Attributes 0x00 - 0x03 represents device memory */
+		if (ACPI_IORT_RMR_ACCESS_ATTRIBUTES(rmr->flags) <=
+				ACPI_IORT_RMR_ATTR_DEVICE_GRE)
+			prot |= IOMMU_MMIO;
+		else if (ACPI_IORT_RMR_ACCESS_ATTRIBUTES(rmr->flags) ==
+				ACPI_IORT_RMR_ATTR_NORMAL_IWB_OWB)
+			prot |= IOMMU_CACHE;
+
+		/* Create a copy of SIDs array to associate with this resv region */
+		sids_copy = kmemdup(sids, num_sids * sizeof(*sids), GFP_KERNEL);
+		if (!sids_copy)
+			return;
+
+		region = iommu_alloc_resv_region(addr, size, prot, type);
+		if (!region) {
+			kfree(sids_copy);
+			return;
+		}
+
+		region->fw_data.rmr.sids = sids_copy;
+		region->fw_data.rmr.num_sids = num_sids;
+		list_add_tail(&region->list, head);
+	}
+}
+
+static u32 *iort_rmr_alloc_sids(u32 *sids, u32 count, u32 id_start,
+				u32 new_count)
+{
+	u32 *new_sids;
+	u32 total_count = count + new_count;
+	int i;
+
+	new_sids = krealloc_array(sids, count + new_count,
+				  sizeof(*new_sids), GFP_KERNEL);
+	if (!new_sids)
+		return NULL;
+
+	for (i = count; i < total_count; i++)
+		new_sids[i] = id_start++;
+
+	return new_sids;
+}
+
+static bool iort_rmr_has_dev(struct device *dev, u32 id_start,
+			     u32 id_count)
+{
+	int i;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	/*
+	 * Make sure the kernel has preserved the boot firmware PCIe
+	 * configuration. This is required to ensure that the RMR PCIe
+	 * StreamIDs are still valid (Refer: ARM DEN 0049E.d Section 3.1.1.5).
+	 */
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
+
+		if (!host->preserve_config)
+			return false;
+	}
+
+	for (i = 0; i < fwspec->num_ids; i++) {
+		if (fwspec->ids[i] >= id_start &&
+		    fwspec->ids[i] <= id_start + id_count)
+			return true;
+	}
+
+	return false;
+}
+
+static void iort_node_get_rmr_info(struct acpi_iort_node *node,
+				   struct acpi_iort_node *iommu,
+				   struct device *dev, struct list_head *head)
+{
+	struct acpi_iort_node *smmu = NULL;
+	struct acpi_iort_rmr *rmr;
+	struct acpi_iort_id_mapping *map;
+	u32 *sids = NULL;
+	u32 num_sids = 0;
+	int i;
+
+	if (!node->mapping_offset || !node->mapping_count) {
+		pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
+		       node);
+		return;
+	}
+
+	rmr = (struct acpi_iort_rmr *)node->node_data;
+	if (!rmr->rmr_offset || !rmr->rmr_count)
+		return;
+
+	map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
+			   node->mapping_offset);
+
+	/*
+	 * Go through the ID mappings and see if we have a match for SMMU
+	 * and dev(if !NULL). If found, get the sids for the Node.
+	 * Please note, id_count is equal to the number of IDs  in the
+	 * range minus one.
+	 */
+	for (i = 0; i < node->mapping_count; i++, map++) {
+		struct acpi_iort_node *parent;
+
+		if (!map->id_count)
+			continue;
+
+		parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
+				      map->output_reference);
+		if (parent != iommu)
+			continue;
+
+		/* If dev is valid, check RMR node corresponds to the dev SID */
+		if (dev && !iort_rmr_has_dev(dev, map->output_base,
+					     map->id_count))
+			continue;
+
+		/* Retrieve SIDs associated with the Node. */
+		sids = iort_rmr_alloc_sids(sids, num_sids, map->output_base,
+					   map->id_count + 1);
+		if (!sids)
+			return;
+
+		num_sids += map->id_count + 1;
+	}
+
+	if (!sids)
+		return;
+
+	iort_get_rmrs(node, smmu, sids, num_sids, head);
+	kfree(sids);
+}
+
+static void iort_find_rmrs(struct acpi_iort_node *iommu, struct device *dev,
+			   struct list_head *head)
+{
+	struct acpi_table_iort *iort;
+	struct acpi_iort_node *iort_node, *iort_end;
+	int i;
+
+	/* Only supports ARM DEN 0049E.d onwards */
+	if (iort_table->revision < 5)
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
+			iort_node_get_rmr_info(iort_node, iommu, dev, head);
+
+		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
+					 iort_node->length);
+	}
+}
+
+/*
+ * Populate the RMR list associated with a given IOMMU and dev(if provided).
+ * If dev is NULL, the function populates all the RMRs associated with the
+ * given IOMMU.
+ */
+static void
+iort_iommu_rmr_get_resv_regions(struct fwnode_handle *iommu_fwnode,
+				struct device *dev, struct list_head *head)
+{
+	struct acpi_iort_node *iommu;
+
+	iommu = iort_get_iort_node(iommu_fwnode);
+	if (!iommu)
+		return;
+
+	iort_find_rmrs(iommu, dev, head);
+}
+
 static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
 {
 	struct acpi_iort_node *iommu;
@@ -892,7 +1145,27 @@ iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
  */
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
 	iort_iommu_msi_get_resv_regions(dev, head);
+	iort_iommu_rmr_get_resv_regions(fwspec->iommu_fwnode, dev, head);
+}
+
+/**
+ * iort_iommu_put_resv_regions - Free any IORT specific memory allocations
+ *                               associated with reserve regions.
+ * @dev: Associated device(Optional)
+ * @head: Resereved region list
+ */
+void iort_iommu_put_resv_regions(struct device *dev, struct list_head *head)
+{
+	struct iommu_resv_region *e, *tmp;
+
+	/* RMR entries will have mem allocated for fw_data.rmr.sids. */
+	list_for_each_entry_safe(e, tmp, head, list) {
+		if (e->fw_data.rmr.sids)
+			kfree(e->fw_data.rmr.sids);
+	}
 }
 
 static inline bool iort_iommu_driver_enabled(u8 type)
@@ -1061,6 +1334,8 @@ int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
 #else
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
 { }
+void iort_iommu_put_resv_regions(struct device *dev, struct list_head *head)
+{ }
 int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
 { return -ENODEV; }
 #endif
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 44e3f3feaab6..5811233dc9fb 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -391,6 +391,9 @@ EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
 void iommu_dma_put_resv_regions(struct device *dev, struct list_head *list)
 {
+	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
+		iort_iommu_put_resv_regions(dev, list);
+
 	generic_iommu_put_resv_regions(dev, list);
 }
 EXPORT_SYMBOL(iommu_dma_put_resv_regions);
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index e5d2de9caf7f..eb3c28853110 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -37,6 +37,7 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 int iort_dma_get_ranges(struct device *dev, u64 *size);
 int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head);
+void iort_iommu_put_resv_regions(struct device *dev, struct list_head *head);
 phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
 #else
 static inline void acpi_iort_init(void) { }
@@ -54,6 +55,9 @@ static inline int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
 static inline
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
 { }
+static inline
+void iort_iommu_put_resv_regions(struct device *dev, struct list_head *head)
+{ }
 
 static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
 { return PHYS_ADDR_MAX; }
-- 
2.25.1

