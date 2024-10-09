Return-Path: <linux-acpi+bounces-8652-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F13C4996A94
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2024 14:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2DFC288D9A
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2024 12:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791741E009C;
	Wed,  9 Oct 2024 12:43:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9EC1DFDA2;
	Wed,  9 Oct 2024 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477832; cv=none; b=YqRfL70HFdJyWpsuAAuYMAiJFOeOnNh3wq/y+rKnnXv5wyZHBt/DDBg9FEg9KzOt1pDywfr/K/FCvF3i4pA2J51W7M7jMos+0mkSZGeLm/cgu2Zd9//fnt+zjRU34TgO4wP2VXaxksfu5d2GK9KflAeUoglZgsWfzJtMj6eb2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477832; c=relaxed/simple;
	bh=G3gYPyZdicSAlLT7JhUDWsOU4EpI/GJFyJDbEAqSsLQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3e5moQsaYqPqhbMN1CBGpGF5pxQFyQp7wsVjDiDAXeknncawpYNUqrk1DdWCtfm2YHc6t6y3xp/BoKUESx6ozbrp/vE2mQuyBfJ+xXaH4EVYDHRPNsU52+Pbr/VRocbtZ5J8gdAnkJLRNkMjlgm2rQOeMF/q8VMh1PFitFDbrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNswk4Zcpz6K71Z;
	Wed,  9 Oct 2024 20:42:30 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D9D4140B3C;
	Wed,  9 Oct 2024 20:43:48 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.152.209) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 14:43:46 +0200
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <mchehab@kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
	<leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v13 17/18] cxl/memfeature: Add CXL memory device PPR control feature
Date: Wed, 9 Oct 2024 13:41:18 +0100
Message-ID: <20241009124120.1124-18-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241009124120.1124-1-shiju.jose@huawei.com>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Post Package Repair (PPR) maintenance operations may be supported by CXL
devices that implement CXL.mem protocol. A PPR maintenance operation
requests the CXL device to perform a repair operation on its media.
For example, a CXL device with DRAM components that support PPR features
may implement PPR Maintenance operations. DRAM components may support two
types of PPR: Hard PPR (hPPR), for a permanent row repair, and Soft PPR
(sPPR), for a temporary row repair. sPPR is much faster than hPPR, but the
repair is lost with a power cycle.

During the execution of a PPR Maintenance operation, a CXL memory device:
- May or may not retain data
- May or may not be able to process CXL.mem requests correctly, including
the ones that target the DPA involved in the repair.
These CXL Memory Device capabilities are specified by Restriction Flags
in the sPPR Feature and hPPR Feature.

sPPR maintenance operation may be executed at runtime, if data is retained
and CXL.mem requests are correctly processed. For CXL devices with DRAM
components, hPPR maintenance operation may be executed only at boot because
data would not be retained.
When a CXL device identifies a failure on a memory component, the device
may inform the host about the need for a PPR maintenance operation by using
an Event Record, where the Maintenance Needed flag is set. The Event Record
specifies the DPA that should be repaired. A CXL device may not keep track
of the requests that have already been sent and the information on which
DPA should be repaired may be lost upon power cycle.
The userspace tool requests for maintenance operation if the number of
corrected error reported on a CXL.mem media exceeds error threshold.

CXL spec 3.1 section 8.2.9.7.1.2 describes the device's sPPR (soft PPR)
maintenance operation and section 8.2.9.7.1.3 describes the device's
hPPR (hard PPR) maintenance operation feature.

CXL spec 3.1 section 8.2.9.7.2.1 describes the sPPR feature discovery and
configuration.

CXL spec 3.1 section 8.2.9.7.2.2 describes the hPPR feature discovery and
configuration.

Add support for controlling CXL memory device PPR feature.
Register with EDAC driver, which gets the memory repair attr descriptors
from the EDAC memory repair driver and exposes sysfs repair control
attributes for PRR to the userspace. For example CXL PPR control for the
CXL mem0 device is exposed in /sys/bus/edac/devices/cxl_mem0/mem_repairX/

Tested with QEMU patch for CXL PPR feature.
https://lore.kernel.org/all/20240730045722.71482-1-dave@stgolabs.net/

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/memfeature.c | 335 +++++++++++++++++++++++++++++++++-
 1 file changed, 329 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/memfeature.c b/drivers/cxl/core/memfeature.c
index 567406566c77..a0c9a6bd73c0 100644
--- a/drivers/cxl/core/memfeature.c
+++ b/drivers/cxl/core/memfeature.c
@@ -18,8 +18,9 @@
 #include <linux/limits.h>
 #include <cxl.h>
 #include <linux/edac.h>
+#include "core.h"
 
-#define CXL_DEV_NUM_RAS_FEATURES	2
+#define CXL_DEV_NUM_RAS_FEATURES	3
 #define CXL_DEV_HOUR_IN_SECS	3600
 
 #define CXL_SCRUB_NAME_LEN	128
@@ -723,6 +724,294 @@ static const struct edac_ecs_ops cxl_ecs_ops = {
 	.set_threshold = cxl_ecs_set_threshold,
 };
 
+/* CXL memory soft PPR & hard PPR control definitions */
+static const uuid_t cxl_sppr_uuid =
+	UUID_INIT(0x892ba475, 0xfad8, 0x474e, 0x9d, 0x3e, 0x69, 0x2c, 0x91,     \
+		  0x75, 0x68, 0xbb);
+
+static const uuid_t cxl_hppr_uuid =
+	UUID_INIT(0x80ea4521, 0x786f, 0x4127, 0xaf, 0xb1, 0xec, 0x74, 0x59,     \
+		  0xfb, 0x0e, 0x24);
+
+struct cxl_ppr_context {
+	uuid_t repair_uuid;
+	u8 instance;
+	u16 get_feat_size;
+	u16 set_feat_size;
+	u8 get_version;
+	u8 set_version;
+	u16 set_effects;
+	struct cxl_memdev *cxlmd;
+	enum edac_mem_repair_type repair_type;
+	enum edac_mem_repair_persist_mode persist_mode;
+	u64 dpa;
+	u32 nibble_mask;
+};
+
+/**
+ * struct cxl_memdev_ppr_params - CXL memory PPR parameter data structure.
+ * @op_class[OUT]: PPR operation class.
+ * @op_subclass[OUT]: PPR operation subclass.
+ * @dpa_support[OUT]: device physical address for PPR support.
+ * @media_accessible[OUT]: memory media is accessible or not during PPR operation.
+ * @data_retained[OUT]: data is retained or not during PPR operation.
+ * @dpa:[IN]: device physical address.
+ */
+struct cxl_memdev_ppr_params {
+	u8 op_class;
+	u8 op_subclass;
+	bool dpa_support;
+	bool media_accessible;
+	bool data_retained;
+	u64 dpa;
+};
+
+enum cxl_ppr_param {
+	CXL_PPR_PARAM_DO_QUERY,
+	CXL_PPR_PARAM_DO_PPR,
+};
+
+#define	CXL_MEMDEV_PPR_QUERY_RESOURCE_FLAG BIT(0)
+
+#define CXL_MEMDEV_PPR_DEVICE_INITIATED_MASK BIT(0)
+#define CXL_MEMDEV_PPR_FLAG_DPA_SUPPORT_MASK BIT(0)
+#define CXL_MEMDEV_PPR_FLAG_NIBBLE_SUPPORT_MASK BIT(1)
+#define CXL_MEMDEV_PPR_FLAG_MEM_SPARING_EV_REC_SUPPORT_MASK BIT(2)
+
+#define CXL_MEMDEV_PPR_RESTRICTION_FLAG_MEDIA_ACCESSIBLE_MASK BIT(0)
+#define CXL_MEMDEV_PPR_RESTRICTION_FLAG_DATA_RETAINED_MASK BIT(2)
+
+#define CXL_MEMDEV_PPR_SPARING_EV_REC_EN_MASK BIT(0)
+
+struct cxl_memdev_ppr_rd_attrs {
+	u8 max_op_latency;
+	__le16 op_cap;
+	__le16 op_mode;
+	u8 op_class;
+	u8 op_subclass;
+	u8 rsvd[9];
+	u8 ppr_flags;
+	__le16 restriction_flags;
+	u8 ppr_op_mode;
+}  __packed;
+
+struct cxl_memdev_ppr_wr_attrs {
+	__le16 op_mode;
+	u8 ppr_op_mode;
+}  __packed;
+
+struct cxl_memdev_ppr_maintenance_attrs {
+	u8 flags;
+	__le64 dpa;
+	u8 nibble_mask[3];
+}  __packed;
+
+static int cxl_mem_ppr_get_attrs(struct device *dev, void *drv_data,
+				 struct cxl_memdev_ppr_params *params)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	size_t rd_data_size = sizeof(struct cxl_memdev_ppr_rd_attrs);
+	size_t data_size;
+	struct cxl_memdev_ppr_rd_attrs *rd_attrs __free(kfree) =
+				kmalloc(rd_data_size, GFP_KERNEL);
+	if (!rd_attrs)
+		return -ENOMEM;
+
+	data_size = cxl_get_feature(mds, cxl_ppr_ctx->repair_uuid,
+				    CXL_GET_FEAT_SEL_CURRENT_VALUE,
+				    rd_attrs, rd_data_size);
+	if (!data_size)
+		return -EIO;
+
+	params->op_class = rd_attrs->op_class;
+	params->op_subclass = rd_attrs->op_subclass;
+	params->dpa_support = FIELD_GET(CXL_MEMDEV_PPR_FLAG_DPA_SUPPORT_MASK,
+					rd_attrs->ppr_flags);
+	params->media_accessible = FIELD_GET(CXL_MEMDEV_PPR_RESTRICTION_FLAG_MEDIA_ACCESSIBLE_MASK,
+					     rd_attrs->restriction_flags) ^ 1;
+	params->data_retained = FIELD_GET(CXL_MEMDEV_PPR_RESTRICTION_FLAG_DATA_RETAINED_MASK,
+					  rd_attrs->restriction_flags) ^ 1;
+
+	return 0;
+}
+
+static int cxl_mem_ppr_set_attrs(struct device *dev, void *drv_data,
+				 enum cxl_ppr_param param_type)
+{
+	struct cxl_memdev_ppr_maintenance_attrs maintenance_attrs;
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct cxl_memdev_ppr_params rd_params;
+	struct cxl_region *cxlr;
+	int ret;
+
+	ret = cxl_mem_ppr_get_attrs(dev, drv_data, &rd_params);
+	if (ret) {
+		dev_err(dev, "Get cxlmemdev PPR params failed ret=%d\n",
+			ret);
+		return ret;
+	}
+
+	switch (param_type) {
+	case CXL_PPR_PARAM_DO_QUERY:
+	case CXL_PPR_PARAM_DO_PPR:
+		ret = down_read_interruptible(&cxl_region_rwsem);
+		if (ret)
+			return ret;
+		if (!rd_params.media_accessible || !rd_params.data_retained) {
+			/* Check if DPA is mapped */
+			ret = down_read_interruptible(&cxl_dpa_rwsem);
+			if (ret) {
+				up_read(&cxl_region_rwsem);
+				return ret;
+			}
+
+			cxlr = cxl_dpa_to_region(cxlmd, cxl_ppr_ctx->dpa);
+			up_read(&cxl_dpa_rwsem);
+			if (cxlr) {
+				dev_err(dev, "CXL can't do PPR as DPA is mapped\n");
+				up_read(&cxl_region_rwsem);
+				return -EBUSY;
+			}
+		}
+
+		memset(&maintenance_attrs, 0, sizeof(maintenance_attrs));
+		if (param_type == CXL_PPR_PARAM_DO_QUERY)
+			maintenance_attrs.flags = CXL_MEMDEV_PPR_QUERY_RESOURCE_FLAG;
+		else
+			maintenance_attrs.flags = 0;
+		maintenance_attrs.dpa = cxl_ppr_ctx->dpa;
+		*((u32 *)&maintenance_attrs.nibble_mask[0]) = cxl_ppr_ctx->nibble_mask;
+		ret = cxl_do_maintenance(mds, rd_params.op_class, rd_params.op_subclass,
+					 &maintenance_attrs, sizeof(maintenance_attrs));
+		if (ret) {
+			dev_err(dev, "CXL do PPR maintenance failed ret=%d\n", ret);
+			up_read(&cxl_region_rwsem);
+			return ret;
+		}
+		up_read(&cxl_region_rwsem);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int cxl_ppr_get_repair_type(struct device *dev, void *drv_data,
+				   u32 *repair_type)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+
+	*repair_type = cxl_ppr_ctx->repair_type;
+
+	return 0;
+}
+
+static int cxl_ppr_get_persist_mode_avail(struct device *dev, void *drv_data,
+					  char *buf)
+{
+	return sysfs_emit(buf, "%u\n", EDAC_MEM_REPAIR_SOFT);
+}
+
+static int cxl_ppr_get_persist_mode(struct device *dev, void *drv_data,
+				    u32 *persist_mode)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+
+	*persist_mode = cxl_ppr_ctx->persist_mode;
+
+	return 0;
+}
+
+static int cxl_ppr_get_dpa_support(struct device *dev, void *drv_data,
+				   u32 *dpa_support)
+{
+	struct cxl_memdev_ppr_params params;
+	int ret;
+
+	ret = cxl_mem_ppr_get_attrs(dev, drv_data, &params);
+	if (ret)
+		return ret;
+
+	*dpa_support = params.dpa_support;
+
+	return 0;
+}
+
+static int cxl_get_ppr_safe_when_in_use(struct device *dev, void *drv_data,
+					u32 *safe)
+{
+	struct cxl_memdev_ppr_params params;
+	int ret;
+
+	ret = cxl_mem_ppr_get_attrs(dev, drv_data, &params);
+	if (ret)
+		return ret;
+
+	*safe = params.media_accessible & params.data_retained;
+
+	return 0;
+}
+
+static int cxl_set_ppr_dpa(struct device *dev, void *drv_data, u64 dpa)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+
+	if (!dpa)
+		return -EINVAL;
+
+	cxl_ppr_ctx->dpa = dpa;
+
+	return 0;
+}
+
+static int cxl_set_ppr_nibble_mask(struct device *dev, void *drv_data, u64 nibble_mask)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+
+	cxl_ppr_ctx->nibble_mask = nibble_mask;
+
+	return 0;
+}
+
+static int cxl_do_query_ppr(struct device *dev, void *drv_data)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+
+	if (!cxl_ppr_ctx->dpa)
+		return -EINVAL;
+
+	return cxl_mem_ppr_set_attrs(dev, drv_data, CXL_PPR_PARAM_DO_QUERY);
+}
+
+static int cxl_do_ppr(struct device *dev, void *drv_data)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+	int ret;
+
+	if (!cxl_ppr_ctx->dpa)
+		return -EINVAL;
+	ret = cxl_mem_ppr_set_attrs(dev, drv_data, CXL_PPR_PARAM_DO_PPR);
+
+	return ret;
+}
+
+static const struct edac_mem_repair_ops cxl_sppr_ops = {
+	.get_repair_type = cxl_ppr_get_repair_type,
+	.get_persist_mode_avail = cxl_ppr_get_persist_mode_avail,
+	.get_persist_mode = cxl_ppr_get_persist_mode,
+	.get_dpa_support = cxl_ppr_get_dpa_support,
+	.get_repair_safe_when_in_use = cxl_get_ppr_safe_when_in_use,
+	.set_dpa = cxl_set_ppr_dpa,
+	.set_nibble_mask = cxl_set_ppr_nibble_mask,
+	.do_query = cxl_do_query_ppr,
+	.do_repair = cxl_do_ppr,
+};
+
 int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
 {
 	struct edac_dev_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
@@ -732,9 +1021,10 @@ int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
 	struct cxl_feat_entry feat_entry;
 	char cxl_dev_name[CXL_SCRUB_NAME_LEN];
 	struct cxl_ecs_context *cxl_ecs_ctx;
+	struct cxl_ppr_context *cxl_sppr_ctx;
 	int rc, i, num_ras_features = 0;
 	int num_media_frus;
-	u8 scrub_inst = 0;
+	u8 scrub_inst = 0, repair_inst = 0;
 
 	if (cxlr) {
 		struct cxl_region_params *p = &cxlr->params;
@@ -800,19 +1090,19 @@ int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
 		rc = cxl_get_supported_feature_entry(mds, &cxl_ecs_uuid,
 						     &feat_entry);
 		if (rc < 0)
-			goto feat_register;
+			goto feat_ppr;
 
 		if (!(feat_entry.attr_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
-			goto feat_register;
+			goto feat_ppr;
 		num_media_frus = (feat_entry.get_feat_size - sizeof(struct cxl_ecs_rd_attrs)) /
 					sizeof(struct cxl_ecs_fru_rd_attrs);
 		if (!num_media_frus)
-			goto feat_register;
+			goto feat_ppr;
 
 		cxl_ecs_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ecs_ctx),
 					   GFP_KERNEL);
 		if (!cxl_ecs_ctx)
-			goto feat_register;
+			goto feat_ppr;
 		*cxl_ecs_ctx = (struct cxl_ecs_context) {
 			.get_feat_size = feat_entry.get_feat_size,
 			.set_feat_size = feat_entry.set_feat_size,
@@ -829,6 +1119,39 @@ int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
 		ras_features[num_ras_features].ecs_info.num_media_frus =
 								num_media_frus;
 		num_ras_features++;
+
+		/* CXL sPPR */
+feat_ppr:
+		rc = cxl_get_supported_feature_entry(mds, &cxl_sppr_uuid,
+						     &feat_entry);
+		if (rc < 0)
+			goto feat_register;
+
+		if (!(feat_entry.attr_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
+			goto feat_register;
+
+		cxl_sppr_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_sppr_ctx),
+					    GFP_KERNEL);
+		if (!cxl_sppr_ctx)
+			goto feat_register;
+		*cxl_sppr_ctx = (struct cxl_ppr_context) {
+			.repair_uuid = cxl_sppr_uuid,
+			.get_feat_size = feat_entry.get_feat_size,
+			.set_feat_size = feat_entry.set_feat_size,
+			.get_version = feat_entry.get_feat_ver,
+			.set_version = feat_entry.set_feat_ver,
+			.set_effects = feat_entry.set_effects,
+			.cxlmd = cxlmd,
+			.repair_type = EDAC_TYPE_SPPR,
+			.persist_mode = EDAC_MEM_REPAIR_SOFT,
+			.instance = repair_inst++,
+		};
+
+		ras_features[num_ras_features].ft_type = RAS_FEAT_MEM_REPAIR;
+		ras_features[num_ras_features].instance = cxl_sppr_ctx->instance;
+		ras_features[num_ras_features].mem_repair_ops = &cxl_sppr_ops;
+		ras_features[num_ras_features].ctx = cxl_sppr_ctx;
+		num_ras_features++;
 	}
 
 feat_register:
-- 
2.34.1


