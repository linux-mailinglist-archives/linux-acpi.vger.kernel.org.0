Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2B029AA88
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 12:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1749880AbgJ0L2M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Oct 2020 07:28:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:6000 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1749895AbgJ0L2K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2020 07:28:10 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CL8Zz4nPpzhcP9;
        Tue, 27 Oct 2020 19:28:11 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.24.15) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 27 Oct 2020 19:27:59 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <devel@acpica.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <jonathan.cameron@huawei.com>
Subject: [RFC PATCH 2/4] ACPI/IORT: Add support for RMR node parsing
Date:   Tue, 27 Oct 2020 11:26:44 +0000
Message-ID: <20201027112646.44680-3-shameerali.kolothum.thodi@huawei.com>
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

Add support for parsing RMR node information from ACPI.
Find associated stream ids and smmu node info from the
RMR node and populate a linked list with RMR memory
descriptors.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c | 119 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 9929ff50c0c0..b32cd53cca08 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -40,6 +40,25 @@ struct iort_fwnode {
 static LIST_HEAD(iort_fwnode_list);
 static DEFINE_SPINLOCK(iort_fwnode_lock);
 
+struct iort_rmr_id {
+	u32  sid;
+	struct acpi_iort_node *smmu;
+};
+
+/*
+ * One entry for IORT RMR.
+ */
+struct iort_rmr_entry {
+	struct list_head list;
+
+	unsigned int rmr_ids_num;
+	struct iort_rmr_id *rmr_ids;
+
+	struct acpi_iort_rmr_desc *rmr_desc;
+};
+
+static LIST_HEAD(iort_rmr_list);         /* list of RMR regions from ACPI */
+
 /**
  * iort_set_fwnode() - Create iort_fwnode and use it to register
  *		       iommu data in the iort_fwnode_list
@@ -393,7 +412,8 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
 		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
 		    node->type == ACPI_IORT_NODE_SMMU_V3 ||
-		    node->type == ACPI_IORT_NODE_PMCG) {
+		    node->type == ACPI_IORT_NODE_PMCG ||
+		    node->type == ACPI_IORT_NODE_RMR) {
 			*id_out = map->output_base;
 			return parent;
 		}
@@ -1647,6 +1667,100 @@ static void __init iort_enable_acs(struct acpi_iort_node *iort_node)
 #else
 static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
 #endif
+static int iort_rmr_desc_valid(struct acpi_iort_rmr_desc *desc)
+{
+	struct iort_rmr_entry *e;
+	u64 end, start = desc->base_address, length = desc->length;
+
+	if ((!IS_ALIGNED(start, SZ_64K)) || (length % SZ_64K != 0))
+		return -EINVAL;
+
+	end = start + length - 1;
+
+	/* Check for address overlap */
+	list_for_each_entry(e, &iort_rmr_list, list) {
+		u64 e_start = e->rmr_desc->base_address;
+		u64 e_end = e_start + e->rmr_desc->length - 1;
+
+		if (start <= e_end && end >= e_start)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int __init iort_parse_rmr(struct acpi_iort_node *iort_node)
+{
+	struct iort_rmr_id *rmr_ids, *ids;
+	struct iort_rmr_entry *e;
+	struct acpi_iort_rmr *rmr;
+	struct acpi_iort_rmr_desc *rmr_desc;
+	u32 map_count = iort_node->mapping_count;
+	int i, ret = 0, desc_count = 0;
+
+	if (iort_node->type != ACPI_IORT_NODE_RMR)
+		return 0;
+
+	if (!iort_node->mapping_offset || !map_count) {
+		pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
+		       iort_node);
+		return -EINVAL;
+	}
+
+	rmr_ids = kmalloc(sizeof(*rmr_ids) * map_count, GFP_KERNEL);
+	if (!rmr_ids)
+		return -ENOMEM;
+
+	/* Retrieve associated smmu and stream id */
+	ids = rmr_ids;
+	for (i = 0; i < map_count; i++, ids++) {
+		ids->smmu = iort_node_get_id(iort_node, &ids->sid, i);
+		if (!ids->smmu) {
+			pr_err(FW_BUG "Invalid SMMU reference, skipping RMR node %p\n",
+			       iort_node);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	/* Retrieve RMR data */
+	rmr = (struct acpi_iort_rmr *)iort_node->node_data;
+	if (!rmr->rmr_offset || !rmr->rmr_count) {
+		pr_err(FW_BUG "Invalid RMR descriptor array, skipping RMR node %p\n",
+		       iort_node);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, iort_node,
+				rmr->rmr_offset);
+
+	for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
+		ret = iort_rmr_desc_valid(rmr_desc);
+		if (ret) {
+			pr_err(FW_BUG "Invalid RMR descriptor[%d] for node %p, skipping...\n",
+			       i, iort_node);
+			goto out;
+		}
+
+		e = kmalloc(sizeof(*e), GFP_KERNEL);
+		if (!e)
+			goto out;
+		e->rmr_ids_num = map_count;
+		e->rmr_ids = rmr_ids;
+		e->rmr_desc = rmr_desc;
+
+		list_add_tail(&e->list, &iort_rmr_list);
+		desc_count++;
+	}
+
+	return 0;
+
+out:
+	if (!desc_count)
+		kfree(rmr_ids);
+	return ret;
+}
 
 static void __init iort_init_platform_devices(void)
 {
@@ -1676,6 +1790,9 @@ static void __init iort_init_platform_devices(void)
 
 		iort_enable_acs(iort_node);
 
+		if (iort_table->revision == 1)
+			iort_parse_rmr(iort_node);
+
 		ops = iort_get_dev_cfg(iort_node);
 		if (ops) {
 			fwnode = acpi_alloc_fwnode_static();
-- 
2.17.1

