Return-Path: <linux-acpi+bounces-8246-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FBB974E29
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Sep 2024 11:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE6B289E16
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Sep 2024 09:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0088419CC0D;
	Wed, 11 Sep 2024 09:08:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75719AA75;
	Wed, 11 Sep 2024 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045684; cv=none; b=PgxobOAiTEgzEgNi0iB2V2v7B3ZAAU0UT1M6cmrmMgMG5Xp/xu6+y/ByWdmrw9gdGxP4Vp8cz7sSUhrSfdUhat0BkVR+Ys1VbyoTJ3ZJBsCgNOHZMOBkXOgJKYHDRyZQCZBGyW+BKUwZZbtD2cZTSu+uwi+xdlc9F/0hxoxyW7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045684; c=relaxed/simple;
	bh=Hgnu/H6PTERArFWCUjzLLzoTFeFa32jy5z0VnGftOoc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsTP6LpvP+ER4O3vZ4+ibu797tzJcHkbdQxxqvuLDXsCxb2Oj9xw79tlLwyOtSy798oXC1rLK7CrG53gIEtsYLkVx2nuHuNDrEdJkQOBPPlekLH4qvR0Y8B6feX4iuofp/R2ArRO/8cJbnnBlcPk/eigmZNXsFAalHxtxNNuMKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X3ZNX2LWfz6K6pK;
	Wed, 11 Sep 2024 17:03:08 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 4235E140F63;
	Wed, 11 Sep 2024 17:07:55 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.245.151) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 11:07:52 +0200
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
	<duenwen@google.com>, <mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>,
	<jgroves@micron.com>, <vsalve@micron.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v12 17/17] cxl/memfeature: Add CXL memory device PPR control feature
Date: Wed, 11 Sep 2024 10:04:46 +0100
Message-ID: <20240911090447.751-18-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240911090447.751-1-shiju.jose@huawei.com>
References: <20240911090447.751-1-shiju.jose@huawei.com>
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

CXL spec 3.1 section 8.2.9.7.2.12 describes the hPPR feature discovery and
configuration.

Add support for CXL memory device PPR control.
Register with EDAC driver, which gets the PPR attr descriptors from the
EDAC PPR and expose sysfs PPR control attributes to the userspace.
For example CXL PPR control for the CXL mem0 device is
exposed in /sys/bus/edac/devices/cxl_mem0/pprX/

Tested with QEMU patch for CXL PPR feature.
https://lore.kernel.org/all/20240730045722.71482-1-dave@stgolabs.net/

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/memfeature.c | 277 +++++++++++++++++++++++++++++++++-
 1 file changed, 276 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/memfeature.c b/drivers/cxl/core/memfeature.c
index 5d4057fa304c..ad0b4a616d9d 100644
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
@@ -702,6 +703,247 @@ static const struct edac_ecs_ops cxl_ecs_ops = {
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
+	uuid_t ppr_uuid;
+	u8 instance;
+	u16 get_feat_size;
+	u16 set_feat_size;
+	u8 get_version;
+	u8 set_version;
+	u16 set_effects;
+	struct cxl_memdev *cxlmd;
+	enum edac_ppr_type ppr_type;
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
+	size_t rd_data_size = sizeof(struct cxl_memdev_ppr_rd_attrs);
+	size_t data_size;
+	struct cxl_memdev_ppr_rd_attrs *rd_attrs __free(kfree) =
+				kmalloc(rd_data_size, GFP_KERNEL);
+	if (!rd_attrs)
+		return -ENOMEM;
+
+	data_size = cxl_get_feature(cxlds, cxl_ppr_ctx->ppr_uuid,
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
+				 struct cxl_memdev_ppr_params *params,
+				 enum cxl_ppr_param param_type)
+{
+	struct cxl_memdev_ppr_maintenance_attrs maintenance_attrs;
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
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
+		maintenance_attrs.flags = CXL_MEMDEV_PPR_QUERY_RESOURCE_FLAG;
+		maintenance_attrs.dpa = params->dpa;
+		/* May need to get the nibble mask from the CXL dram error record via
+		 * trace dram event. Presently all nibble masks bits set to 1.
+		 */
+		maintenance_attrs.nibble_mask[0] = 0xFF;
+		maintenance_attrs.nibble_mask[1] = 0xFF;
+		maintenance_attrs.nibble_mask[2] = 0xFF;
+		ret = cxl_do_maintenance(cxlds, rd_params.op_class, rd_params.op_subclass,
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
+static int cxl_ppr_get_persist_mode_avail(struct device *dev, void *drv_data,
+					  char *buf)
+{
+	return sysfs_emit(buf, "Soft PPR Hard PPR\n");
+}
+
+static int cxl_ppr_get_persist_mode(struct device *dev, void *drv_data,
+				    u32 *persist_mode)
+{
+	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+
+	*persist_mode = cxl_ppr_ctx->ppr_type;
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
+static int cxl_do_ppr(struct device *dev, void *drv_data, bool hpa, u64 pa)
+{
+	struct cxl_memdev_ppr_params params = {
+		.dpa = pa,
+	};
+
+	/* CXL mem perform PPR, need support for HPA? */
+	if (hpa)
+		return -EOPNOTSUPP;
+
+	return cxl_mem_ppr_set_attrs(dev, drv_data, &params,
+				     CXL_PPR_PARAM_DO_PPR);
+}
+
+static const struct edac_ppr_ops cxl_sppr_ops = {
+	.get_persist_mode_avail = cxl_ppr_get_persist_mode_avail,
+	.get_persist_mode = cxl_ppr_get_persist_mode,
+	.get_dpa_support = cxl_ppr_get_dpa_support,
+	.get_ppr_safe_when_in_use = cxl_get_ppr_safe_when_in_use,
+	.do_ppr = cxl_do_ppr,
+};
+
 int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
 {
 	struct edac_dev_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
@@ -710,8 +952,10 @@ int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
 	struct cxl_feat_entry feat_entry;
 	char cxl_dev_name[CXL_SCRUB_NAME_LEN];
 	struct cxl_ecs_context *cxl_ecs_ctx;
+	struct cxl_ppr_context *cxl_sppr_ctx;
 	int rc, i, num_ras_features = 0;
 	int num_media_frus;
+	u8 ppr_inst = 0;
 
 	if (cxlr) {
 		struct cxl_region_params *p = &cxlr->params;
@@ -800,6 +1044,37 @@ int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
 		ras_features[num_ras_features].ecs_info.num_media_frus =
 								num_media_frus;
 		num_ras_features++;
+
+		/* CXL sPPR */
+		rc = cxl_get_supported_feature_entry(cxlds, &cxl_sppr_uuid,
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
+			.ppr_uuid = cxl_sppr_uuid,
+			.get_feat_size = feat_entry.get_feat_size,
+			.set_feat_size = feat_entry.set_feat_size,
+			.get_version = feat_entry.get_feat_ver,
+			.set_version = feat_entry.set_feat_ver,
+			.set_effects = feat_entry.set_effects,
+			.cxlmd = cxlmd,
+			.ppr_type = EDAC_TYPE_SPPR,
+			.instance = ppr_inst++,
+		};
+
+		ras_features[num_ras_features].ft_type = RAS_FEAT_PPR;
+		ras_features[num_ras_features].instance = cxl_sppr_ctx->instance;
+		ras_features[num_ras_features].ppr_ops = &cxl_sppr_ops;
+		ras_features[num_ras_features].ctx = cxl_sppr_ctx;
+		num_ras_features++;
 	}
 
 feat_register:
-- 
2.34.1


