Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD0F54C58D
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jun 2022 12:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240143AbiFOKMK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jun 2022 06:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiFOKMJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jun 2022 06:12:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B534C4AE0E
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jun 2022 03:12:08 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LNLbr3FH7z6H8Wj;
        Wed, 15 Jun 2022 18:08:24 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 12:12:06 +0200
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 11:11:59 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>, <will@kernel.org>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <laurentiu.tudor@nxp.com>, <hch@infradead.org>
Subject: [PATCH v13 4/9] ACPI/IORT: Add support to retrieve IORT RMR reserved regions
Date:   Wed, 15 Jun 2022 11:10:39 +0100
Message-ID: <20220615101044.1972-5-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
References: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.178]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Parse through the IORT RMR nodes and populate the reserve region list
corresponding to a given IOMMU and device(optional). Also, go through
the ID mappings of the RMR node and retrieve all the SIDs associated
with it.

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Steven Price <steven.price@arm.com>
Tested-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c | 291 ++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h     |   8 ++
 2 files changed, 299 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index cd5d1d7823cb..b6273af316c6 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -788,6 +788,294 @@ void acpi_configure_pmsi_domain(struct device *dev)
 }
 
 #ifdef CONFIG_IOMMU_API
+static void iort_rmr_free(struct device *dev,
+			  struct iommu_resv_region *region)
+{
+	struct iommu_iort_rmr_data *rmr_data;
+
+	rmr_data = container_of(region, struct iommu_iort_rmr_data, rr);
+	kfree(rmr_data->sids);
+	kfree(rmr_data);
+}
+
+static struct iommu_iort_rmr_data *iort_rmr_alloc(
+					struct acpi_iort_rmr_desc *rmr_desc,
+					int prot, enum iommu_resv_type type,
+					u32 *sids, u32 num_sids)
+{
+	struct iommu_iort_rmr_data *rmr_data;
+	struct iommu_resv_region *region;
+	u32 *sids_copy;
+	u64 addr = rmr_desc->base_address, size = rmr_desc->length;
+
+	rmr_data = kmalloc(sizeof(*rmr_data), GFP_KERNEL);
+	if (!rmr_data)
+		return NULL;
+
+	/* Create a copy of SIDs array to associate with this rmr_data */
+	sids_copy = kmemdup(sids, num_sids * sizeof(*sids), GFP_KERNEL);
+	if (!sids_copy) {
+		kfree(rmr_data);
+		return NULL;
+	}
+	rmr_data->sids = sids_copy;
+	rmr_data->num_sids = num_sids;
+
+	if (!IS_ALIGNED(addr, SZ_64K) || !IS_ALIGNED(size, SZ_64K)) {
+		/* PAGE align base addr and size */
+		addr &= PAGE_MASK;
+		size = PAGE_ALIGN(size + offset_in_page(rmr_desc->base_address));
+
+		pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] not aligned to 64K, continue with [0x%llx - 0x%llx]\n",
+		       rmr_desc->base_address,
+		       rmr_desc->base_address + rmr_desc->length - 1,
+		       addr, addr + size - 1);
+	}
+
+	region = &rmr_data->rr;
+	INIT_LIST_HEAD(&region->list);
+	region->start = addr;
+	region->length = size;
+	region->prot = prot;
+	region->type = type;
+	region->free = iort_rmr_free;
+
+	return rmr_data;
+}
+
+static void iort_rmr_desc_check_overlap(struct acpi_iort_rmr_desc *desc,
+					u32 count)
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
+		struct iommu_iort_rmr_data *rmr_data;
+		enum iommu_resv_type type;
+		int prot = IOMMU_READ | IOMMU_WRITE;
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
+		rmr_data = iort_rmr_alloc(rmr_desc, prot, type,
+					  sids, num_sids);
+		if (!rmr_data)
+			return;
+
+		list_add_tail(&rmr_data->rr.list, head);
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
+static void iort_iommu_rmr_get_resv_regions(struct fwnode_handle *iommu_fwnode,
+					    struct device *dev,
+					    struct list_head *head)
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
@@ -868,7 +1156,10 @@ static void iort_iommu_msi_get_resv_regions(struct device *dev,
  */
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
 	iort_iommu_msi_get_resv_regions(dev, head);
+	iort_iommu_rmr_get_resv_regions(fwspec->iommu_fwnode, dev, head);
 }
 
 static inline bool iort_iommu_driver_enabled(u8 type)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b22ffa6bc4a9..e6abd998dbe7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -146,6 +146,14 @@ struct iommu_resv_region {
 	void (*free)(struct device *dev, struct iommu_resv_region *region);
 };
 
+struct iommu_iort_rmr_data {
+	struct iommu_resv_region rr;
+
+	/* Stream IDs associated with IORT RMR entry */
+	const u32 *sids;
+	u32 num_sids;
+};
+
 /**
  * enum iommu_dev_features - Per device IOMMU features
  * @IOMMU_DEV_FEAT_SVA: Shared Virtual Addresses
-- 
2.25.1

