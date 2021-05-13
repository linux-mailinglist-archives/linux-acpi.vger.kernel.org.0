Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF4037F903
	for <lists+linux-acpi@lfdr.de>; Thu, 13 May 2021 15:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhEMNrz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 May 2021 09:47:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2590 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbhEMNru (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 May 2021 09:47:50 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FgtD400ydzsRCP;
        Thu, 13 May 2021 21:43:47 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.47.81.63) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 21:46:22 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <yangyicong@huawei.com>
Subject: [PATCH v4 1/8] ACPI/IORT: Add support for RMR node parsing
Date:   Thu, 13 May 2021 14:45:43 +0100
Message-ID: <20210513134550.2117-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210513134550.2117-1-shameerali.kolothum.thodi@huawei.com>
References: <20210513134550.2117-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.81.63]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add support for parsing RMR node information from ACPI.
Find associated stream id and smmu node info from the
RMR node and populate a linked list with RMR memory
descriptors.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c | 104 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 3912a1f6058e..fea1ffaedf3b 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -40,6 +40,19 @@ struct iort_fwnode {
 static LIST_HEAD(iort_fwnode_list);
 static DEFINE_SPINLOCK(iort_fwnode_lock);
 
+/*
+ * One entry for IORT RMR.
+ */
+struct iort_rmr_entry {
+	struct list_head list;
+	u32 sid;
+	struct acpi_iort_node *smmu;
+	struct acpi_iort_rmr_desc *rmr_desc;
+	u32 flags;
+};
+
+static LIST_HEAD(iort_rmr_list);         /* list of RMR regions from ACPI */
+
 /**
  * iort_set_fwnode() - Create iort_fwnode and use it to register
  *		       iommu data in the iort_fwnode_list
@@ -393,7 +406,8 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
 		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
 		    node->type == ACPI_IORT_NODE_SMMU_V3 ||
-		    node->type == ACPI_IORT_NODE_PMCG) {
+		    node->type == ACPI_IORT_NODE_PMCG ||
+		    node->type == ACPI_IORT_NODE_RMR) {
 			*id_out = map->output_base;
 			return parent;
 		}
@@ -1660,6 +1674,91 @@ static void __init iort_enable_acs(struct acpi_iort_node *iort_node)
 #else
 static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
 #endif
+static int iort_rmr_desc_valid(struct acpi_iort_rmr_desc *desc, u32 count)
+{
+	int i, j;
+
+	for (i = 0; i < count; i++) {
+		u64 end, start = desc[i].base_address, length = desc[i].length;
+
+		if (!IS_ALIGNED(start, SZ_64K) || !IS_ALIGNED(length, SZ_64K))
+			return -EINVAL;
+
+		end = start + length - 1;
+
+		/* Check for address overlap */
+		for (j = i + 1; j < count; j++) {
+			u64 e_start = desc[j].base_address;
+			u64 e_end = e_start + desc[j].length - 1;
+
+			if (start <= e_end && end >= e_start)
+				return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int __init iort_parse_rmr(struct acpi_iort_node *iort_node)
+{
+	struct acpi_iort_node *smmu;
+	struct iort_rmr_entry *e;
+	struct acpi_iort_rmr *rmr;
+	struct acpi_iort_rmr_desc *rmr_desc;
+	u32 map_count = iort_node->mapping_count;
+	u32  sid;
+	int i, ret = 0;
+
+	if (iort_node->type != ACPI_IORT_NODE_RMR)
+		return 0;
+
+	if (!iort_node->mapping_offset || map_count != 1) {
+		pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
+		       iort_node);
+		return -EINVAL;
+	}
+
+	/* Retrieve associated smmu and stream id */
+	smmu = iort_node_get_id(iort_node, &sid, 0);
+	if (!smmu) {
+		pr_err(FW_BUG "Invalid SMMU reference, skipping RMR node %p\n",
+		       iort_node);
+		return -EINVAL;
+	}
+
+	/* Retrieve RMR data */
+	rmr = (struct acpi_iort_rmr *)iort_node->node_data;
+	if (!rmr->rmr_offset || !rmr->rmr_count) {
+		pr_err(FW_BUG "Invalid RMR descriptor array, skipping RMR node %p\n",
+		       iort_node);
+		return -EINVAL;
+	}
+
+	rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, iort_node,
+				rmr->rmr_offset);
+
+	ret = iort_rmr_desc_valid(rmr_desc, rmr->rmr_count);
+	if (ret) {
+		pr_err(FW_BUG "Invalid RMR descriptor[%d] for node %p, skipping...\n",
+		       i, iort_node);
+		return ret;
+	}
+
+	for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
+		e = kmalloc(sizeof(*e), GFP_KERNEL);
+		if (!e)
+			return -ENOMEM;
+
+		e->sid = sid;
+		e->smmu = smmu;
+		e->rmr_desc = rmr_desc;
+		e->flags = rmr->flags;
+
+		list_add_tail(&e->list, &iort_rmr_list);
+	}
+
+	return 0;
+}
 
 static void __init iort_init_platform_devices(void)
 {
@@ -1689,6 +1788,9 @@ static void __init iort_init_platform_devices(void)
 
 		iort_enable_acs(iort_node);
 
+		if (iort_table->revision == 3)
+			iort_parse_rmr(iort_node);
+
 		ops = iort_get_dev_cfg(iort_node);
 		if (ops) {
 			fwnode = acpi_alloc_fwnode_static();
-- 
2.17.1

