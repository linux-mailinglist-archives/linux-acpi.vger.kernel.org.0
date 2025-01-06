Return-Path: <linux-acpi+bounces-10381-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDCAA0250C
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Jan 2025 13:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083F43A5CF4
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Jan 2025 12:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061261DF75A;
	Mon,  6 Jan 2025 12:12:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9291DF270;
	Mon,  6 Jan 2025 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736165531; cv=none; b=l3yb2g3T+I5alx7wEYe7sI0wHaLpHcsUh7Aikuxazq4K4TZdii1bPCs6etkesj04SFcjIdRMzCggd8Fh5uVxDq/BdOtyE1kDSsY5Yz/6BbgzmcEjXv45zTL4bR1iIlZRtgv9CHLVPmh7n6IcZRqB3yAFMG832q2MVmMGjzPKr90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736165531; c=relaxed/simple;
	bh=6UF2qRPO9vELxW8Q/52ILV7vHdamalOKbIMBR0ZDTww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzHNh9+dFdYT/Kyx37E2LTyaLi2eIQswmxXxmswWaPhImLTPm4eQm9DwYejVdNmzMp6VYQiQevrGbkcdlB4SEDIX1ljAuKG/yZxuXI4VjKfjVUcacTAmjpazDszgZBzBIAOR7Bx9naLUNTg3qtr0H0KfcISipc067mg0FC7DG24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YRY0q6wjdz6LD7g;
	Mon,  6 Jan 2025 20:10:35 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id C187114022E;
	Mon,  6 Jan 2025 20:12:07 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.170.95) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 6 Jan 2025 13:12:05 +0100
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
Subject: [PATCH v18 16/19] cxl/memfeature: Add CXL memory device ECS control feature
Date: Mon, 6 Jan 2025 12:10:12 +0000
Message-ID: <20250106121017.1620-17-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250106121017.1620-1-shiju.jose@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 ECS (Error Check
Scrub) control feature.
The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
Specification (JESD79-5) and allows the DRAM to internally read, correct
single-bit errors, and write back corrected data bits to the DRAM array
while providing transparency to error counts.

The ECS control allows the requester to change the log entry type, the ECS
threshold count (provided the request falls within the limits specified in
DDR5 mode registers), switch between codeword mode and row count mode, and
reset the ECS counter.

Register with EDAC device driver, which retrieves the ECS attribute
descriptors from the EDAC ECS and exposes the ECS control attributes to
userspace via sysfs. For example, the ECS control for the memory media FRU0
in CXL mem0 device is located at /sys/bus/edac/devices/cxl_mem0/ecs_fru0/

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/memfeature.c | 372 +++++++++++++++++++++++++++++++++-
 1 file changed, 369 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/memfeature.c b/drivers/cxl/core/memfeature.c
index 77d1bf6ce45f..eed9d57aa691 100644
--- a/drivers/cxl/core/memfeature.c
+++ b/drivers/cxl/core/memfeature.c
@@ -18,7 +18,7 @@
 #include <cxl.h>
 #include <cxlmem.h>
 
-#define CXL_DEV_NUM_RAS_FEATURES	1
+#define CXL_DEV_NUM_RAS_FEATURES	2
 #define CXL_DEV_HOUR_IN_SECS	3600
 
 #define CXL_DEV_NAME_LEN	128
@@ -300,6 +300,311 @@ static const struct edac_scrub_ops cxl_ps_scrub_ops = {
 	.set_cycle_duration = cxl_patrol_scrub_write_scrub_cycle,
 };
 
+/* CXL DDR5 ECS control definitions */
+struct cxl_ecs_context {
+	u16 num_media_frus;
+	u16 get_feat_size;
+	u16 set_feat_size;
+	u8 get_version;
+	u8 set_version;
+	u16 effects;
+	struct cxl_memdev *cxlmd;
+};
+
+enum {
+	CXL_ECS_PARAM_LOG_ENTRY_TYPE,
+	CXL_ECS_PARAM_THRESHOLD,
+	CXL_ECS_PARAM_MODE,
+	CXL_ECS_PARAM_RESET_COUNTER,
+};
+
+#define CXL_ECS_LOG_ENTRY_TYPE_MASK	GENMASK(1, 0)
+#define CXL_ECS_REALTIME_REPORT_CAP_MASK	BIT(0)
+#define CXL_ECS_THRESHOLD_COUNT_MASK	GENMASK(2, 0)
+#define CXL_ECS_COUNT_MODE_MASK	BIT(3)
+#define CXL_ECS_RESET_COUNTER_MASK	BIT(4)
+#define CXL_ECS_RESET_COUNTER	1
+
+enum {
+	ECS_THRESHOLD_256 = 256,
+	ECS_THRESHOLD_1024 = 1024,
+	ECS_THRESHOLD_4096 = 4096,
+};
+
+enum {
+	ECS_THRESHOLD_IDX_256 = 3,
+	ECS_THRESHOLD_IDX_1024 = 4,
+	ECS_THRESHOLD_IDX_4096 = 5,
+};
+
+static const u16 ecs_supp_threshold[] = {
+	[ECS_THRESHOLD_IDX_256] = 256,
+	[ECS_THRESHOLD_IDX_1024] = 1024,
+	[ECS_THRESHOLD_IDX_4096] = 4096,
+};
+
+enum {
+	ECS_LOG_ENTRY_TYPE_DRAM = 0x0,
+	ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU = 0x1,
+};
+
+enum cxl_ecs_count_mode {
+	ECS_MODE_COUNTS_ROWS = 0,
+	ECS_MODE_COUNTS_CODEWORDS = 1,
+};
+
+/**
+ * struct cxl_ecs_params - CXL memory DDR5 ECS parameter data structure.
+ * @log_entry_type: ECS log entry type, per DRAM or per memory media FRU.
+ * @threshold: ECS threshold count per GB of memory cells.
+ * @count_mode: codeword/row count mode
+ *		0 : ECS counts rows with errors
+ *		1 : ECS counts codeword with errors
+ * @reset_counter: [IN] reset ECC counter to default value.
+ */
+struct cxl_ecs_params {
+	u8 log_entry_type;
+	u16 threshold;
+	enum cxl_ecs_count_mode count_mode;
+	u8 reset_counter;
+};
+
+struct cxl_ecs_fru_rd_attrs {
+	u8 ecs_cap;
+	__le16 ecs_config;
+	u8 ecs_flags;
+}  __packed;
+
+struct cxl_ecs_rd_attrs {
+	u8 ecs_log_cap;
+	struct cxl_ecs_fru_rd_attrs fru_attrs[];
+}  __packed;
+
+struct cxl_ecs_fru_wr_attrs {
+	__le16 ecs_config;
+} __packed;
+
+struct cxl_ecs_wr_attrs {
+	u8 ecs_log_cap;
+	struct cxl_ecs_fru_wr_attrs fru_attrs[];
+}  __packed;
+
+/* CXL DDR5 ECS control functions */
+static int cxl_mem_ecs_get_attrs(struct device *dev,
+				 struct cxl_ecs_context *cxl_ecs_ctx,
+				 int fru_id, struct cxl_ecs_params *params)
+{
+	struct cxl_memdev *cxlmd = cxl_ecs_ctx->cxlmd;
+	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
+	struct cxl_ecs_fru_rd_attrs *fru_rd_attrs;
+	size_t rd_data_size;
+	u8 threshold_index;
+	size_t data_size;
+	u16 return_code;
+	u16 ecs_config;
+
+	rd_data_size = cxl_ecs_ctx->get_feat_size;
+
+	struct cxl_ecs_rd_attrs *rd_attrs __free(kfree) =
+					kmalloc(rd_data_size, GFP_KERNEL);
+	if (!rd_attrs)
+		return -ENOMEM;
+
+	params->log_entry_type = 0;
+	params->threshold = 0;
+	params->count_mode = 0;
+	data_size = cxl_get_feature(cxl_mbox->features, CXL_FEAT_ECS_UUID,
+				    CXL_GET_FEAT_SEL_CURRENT_VALUE,
+				    rd_attrs, rd_data_size, 0, &return_code);
+	if (!data_size || return_code != CXL_MBOX_CMD_RC_SUCCESS)
+		return -EIO;
+
+	fru_rd_attrs = rd_attrs->fru_attrs;
+	params->log_entry_type = FIELD_GET(CXL_ECS_LOG_ENTRY_TYPE_MASK,
+					   rd_attrs->ecs_log_cap);
+	ecs_config = le16_to_cpu(fru_rd_attrs[fru_id].ecs_config);
+	threshold_index = FIELD_GET(CXL_ECS_THRESHOLD_COUNT_MASK,
+				    ecs_config);
+	params->threshold = ecs_supp_threshold[threshold_index];
+	params->count_mode = FIELD_GET(CXL_ECS_COUNT_MODE_MASK,
+				       ecs_config);
+	return 0;
+}
+
+static int cxl_mem_ecs_set_attrs(struct device *dev,
+				 struct cxl_ecs_context *cxl_ecs_ctx,
+				 int fru_id, struct cxl_ecs_params *params,
+				 u8 param_type)
+{
+	struct cxl_memdev *cxlmd = cxl_ecs_ctx->cxlmd;
+	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
+	struct cxl_ecs_fru_rd_attrs *fru_rd_attrs;
+	struct cxl_ecs_fru_wr_attrs *fru_wr_attrs;
+	size_t rd_data_size, wr_data_size;
+	u16 num_media_frus, count;
+	size_t data_size;
+	u16 return_code;
+	u16 ecs_config;
+	int ret;
+
+	num_media_frus = cxl_ecs_ctx->num_media_frus;
+	rd_data_size = cxl_ecs_ctx->get_feat_size;
+	wr_data_size = cxl_ecs_ctx->set_feat_size;
+	struct cxl_ecs_rd_attrs *rd_attrs __free(kfree) =
+				kmalloc(rd_data_size, GFP_KERNEL);
+	if (!rd_attrs)
+		return -ENOMEM;
+
+	data_size = cxl_get_feature(cxl_mbox->features, CXL_FEAT_ECS_UUID,
+				    CXL_GET_FEAT_SEL_CURRENT_VALUE,
+				    rd_attrs, rd_data_size, 0, &return_code);
+	if (!data_size || return_code != CXL_MBOX_CMD_RC_SUCCESS)
+		return -EIO;
+
+	struct cxl_ecs_wr_attrs *wr_attrs __free(kfree) =
+					kmalloc(wr_data_size, GFP_KERNEL);
+	if (!wr_attrs)
+		return -ENOMEM;
+
+	/*
+	 * Fill writable attributes from the current attributes read
+	 * for all the media FRUs.
+	 */
+	fru_rd_attrs = rd_attrs->fru_attrs;
+	fru_wr_attrs = wr_attrs->fru_attrs;
+	wr_attrs->ecs_log_cap = rd_attrs->ecs_log_cap;
+	for (count = 0; count < num_media_frus; count++)
+		fru_wr_attrs[count].ecs_config = fru_rd_attrs[count].ecs_config;
+
+	/* Fill attribute to be set for the media FRU */
+	ecs_config = le16_to_cpu(fru_rd_attrs[fru_id].ecs_config);
+	switch (param_type) {
+	case CXL_ECS_PARAM_LOG_ENTRY_TYPE:
+		if (params->log_entry_type != ECS_LOG_ENTRY_TYPE_DRAM &&
+		    params->log_entry_type != ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU) {
+			dev_err(dev,
+				"Invalid CXL ECS scrub log entry type(%d) to set\n",
+			       params->log_entry_type);
+			dev_err(dev,
+				"Log Entry Type 0: per DRAM  1: per Memory Media FRU\n");
+			return -EINVAL;
+		}
+		wr_attrs->ecs_log_cap = FIELD_PREP(CXL_ECS_LOG_ENTRY_TYPE_MASK,
+						   params->log_entry_type);
+		break;
+	case CXL_ECS_PARAM_THRESHOLD:
+		ecs_config &= ~CXL_ECS_THRESHOLD_COUNT_MASK;
+		switch (params->threshold) {
+		case ECS_THRESHOLD_256:
+			ecs_config |= FIELD_PREP(CXL_ECS_THRESHOLD_COUNT_MASK,
+						 ECS_THRESHOLD_IDX_256);
+			break;
+		case ECS_THRESHOLD_1024:
+			ecs_config |= FIELD_PREP(CXL_ECS_THRESHOLD_COUNT_MASK,
+						 ECS_THRESHOLD_IDX_1024);
+			break;
+		case ECS_THRESHOLD_4096:
+			ecs_config |= FIELD_PREP(CXL_ECS_THRESHOLD_COUNT_MASK,
+						 ECS_THRESHOLD_IDX_4096);
+			break;
+		default:
+			dev_err(dev,
+				"Invalid CXL ECS scrub threshold count(%d) to set\n",
+				params->threshold);
+			dev_err(dev,
+				"Supported scrub threshold counts: %u, %u, %u\n",
+				ECS_THRESHOLD_256, ECS_THRESHOLD_1024, ECS_THRESHOLD_4096);
+			return -EINVAL;
+		}
+		break;
+	case CXL_ECS_PARAM_MODE:
+		if (params->count_mode != ECS_MODE_COUNTS_ROWS &&
+		    params->count_mode != ECS_MODE_COUNTS_CODEWORDS) {
+			dev_err(dev,
+				"Invalid CXL ECS scrub mode(%d) to set\n",
+				params->count_mode);
+			dev_err(dev,
+				"Supported ECS Modes: 0: ECS counts rows with errors,"
+				" 1: ECS counts codewords with errors\n");
+			return -EINVAL;
+		}
+		ecs_config &= ~CXL_ECS_COUNT_MODE_MASK;
+		ecs_config |= FIELD_PREP(CXL_ECS_COUNT_MODE_MASK, params->count_mode);
+		break;
+	case CXL_ECS_PARAM_RESET_COUNTER:
+		if (params->reset_counter != CXL_ECS_RESET_COUNTER)
+			return -EINVAL;
+
+		ecs_config &= ~CXL_ECS_RESET_COUNTER_MASK;
+		ecs_config |= FIELD_PREP(CXL_ECS_RESET_COUNTER_MASK, params->reset_counter);
+		break;
+	default:
+		dev_err(dev, "Invalid CXL ECS parameter to set\n");
+		return -EINVAL;
+	}
+	fru_wr_attrs[fru_id].ecs_config = cpu_to_le16(ecs_config);
+
+	ret = cxl_set_feature(cxl_mbox->features, CXL_FEAT_ECS_UUID,
+			      cxl_ecs_ctx->set_version,
+			      wr_attrs, wr_data_size,
+			      CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET,
+			      0, &return_code);
+	if (ret || return_code != CXL_MBOX_CMD_RC_SUCCESS) {
+		dev_err(dev, "CXL ECS set feature failed ret=%d return_code=%u\n",
+			ret, return_code);
+		return ret;
+	}
+
+	return 0;
+}
+
+#define CXL_ECS_GET_ATTR(attrib)						\
+static int cxl_ecs_get_##attrib(struct device *dev, void *drv_data,		\
+				int fru_id, u32 *val)				\
+{										\
+	struct cxl_ecs_context *ctx = drv_data;					\
+	struct cxl_ecs_params params;						\
+	int ret;								\
+										\
+	ret = cxl_mem_ecs_get_attrs(dev, ctx, fru_id, &params);			\
+	if (ret)								\
+		return ret;							\
+										\
+	*val = params.attrib;							\
+										\
+	return 0;								\
+}
+
+CXL_ECS_GET_ATTR(log_entry_type)
+CXL_ECS_GET_ATTR(count_mode)
+CXL_ECS_GET_ATTR(threshold)
+
+#define CXL_ECS_SET_ATTR(attrib, param_type)						\
+static int cxl_ecs_set_##attrib(struct device *dev, void *drv_data,			\
+				int fru_id, u32 val)					\
+{											\
+	struct cxl_ecs_context *ctx = drv_data;						\
+	struct cxl_ecs_params params = {						\
+		.attrib = val,								\
+	};										\
+											\
+	return cxl_mem_ecs_set_attrs(dev, ctx, fru_id, &params, (param_type));		\
+}
+CXL_ECS_SET_ATTR(log_entry_type, CXL_ECS_PARAM_LOG_ENTRY_TYPE)
+CXL_ECS_SET_ATTR(count_mode, CXL_ECS_PARAM_MODE)
+CXL_ECS_SET_ATTR(reset_counter, CXL_ECS_PARAM_RESET_COUNTER)
+CXL_ECS_SET_ATTR(threshold, CXL_ECS_PARAM_THRESHOLD)
+
+static const struct edac_ecs_ops cxl_ecs_ops = {
+	.get_log_entry_type = cxl_ecs_get_log_entry_type,
+	.set_log_entry_type = cxl_ecs_set_log_entry_type,
+	.get_mode = cxl_ecs_get_count_mode,
+	.set_mode = cxl_ecs_set_count_mode,
+	.reset = cxl_ecs_set_reset_counter,
+	.get_threshold = cxl_ecs_get_threshold,
+	.set_threshold = cxl_ecs_set_threshold,
+};
+
 static int cxl_memdev_scrub_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr,
 				 struct edac_dev_feature *ras_feature, u8 scrub_inst)
 {
@@ -363,6 +668,52 @@ static int cxl_memdev_scrub_init(struct cxl_memdev *cxlmd, struct cxl_region *cx
 	return 0;
 }
 
+static int cxl_memdev_ecs_init(struct cxl_memdev *cxlmd,
+			       struct edac_dev_feature *ras_feature)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
+	struct cxl_ecs_context *cxl_ecs_ctx;
+	struct cxl_feat_entry *feat_entry;
+	int num_media_frus;
+
+	feat_entry = cxl_get_supported_feature_entry(cxl_mbox->features,
+						     &CXL_FEAT_ECS_UUID);
+	if (IS_ERR(feat_entry))
+		return -EOPNOTSUPP;
+
+	if (!(le32_to_cpu(feat_entry->flags) & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
+		return -EOPNOTSUPP;
+
+	num_media_frus = (le16_to_cpu(feat_entry->get_feat_size) -
+				sizeof(struct cxl_ecs_rd_attrs)) /
+				sizeof(struct cxl_ecs_fru_rd_attrs);
+	if (!num_media_frus)
+		return -EOPNOTSUPP;
+
+	cxl_ecs_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ecs_ctx),
+				   GFP_KERNEL);
+	if (!cxl_ecs_ctx)
+		return -ENOMEM;
+
+	*cxl_ecs_ctx = (struct cxl_ecs_context) {
+		.get_feat_size = le16_to_cpu(feat_entry->get_feat_size),
+		.set_feat_size = le16_to_cpu(feat_entry->set_feat_size),
+		.get_version = feat_entry->get_feat_ver,
+		.set_version = feat_entry->set_feat_ver,
+		.effects = le16_to_cpu(feat_entry->effects),
+		.num_media_frus = num_media_frus,
+		.cxlmd = cxlmd,
+	};
+
+	ras_feature->ft_type = RAS_FEAT_ECS;
+	ras_feature->ecs_ops = &cxl_ecs_ops;
+	ras_feature->ctx = cxl_ecs_ctx;
+	ras_feature->ecs_info.num_media_frus = num_media_frus;
+
+	return 0;
+}
+
 int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
 {
 	struct edac_dev_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
@@ -373,19 +724,34 @@ int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
 
 	rc = cxl_memdev_scrub_init(cxlmd, cxlr, &ras_features[num_ras_features],
 				   scrub_inst);
+	if (rc == -EOPNOTSUPP)
+		goto feat_scrub_done;
 	if (rc < 0)
 		return rc;
 
 	scrub_inst++;
 	num_ras_features++;
 
-	if (cxlr)
+feat_scrub_done:
+	if (cxlr) {
 		snprintf(cxl_dev_name, sizeof(cxl_dev_name),
 			 "cxl_region%d", cxlr->id);
-	else
+		goto feat_register;
+	} else {
 		snprintf(cxl_dev_name, sizeof(cxl_dev_name),
 			 "%s_%s", "cxl", dev_name(&cxlmd->dev));
+	}
+
+	rc = cxl_memdev_ecs_init(cxlmd, &ras_features[num_ras_features]);
+	if (rc == -EOPNOTSUPP)
+		goto feat_ecs_done;
+	if (rc < 0)
+		return rc;
+
+	num_ras_features++;
 
+feat_ecs_done:
+feat_register:
 	return edac_dev_register(&cxlmd->dev, cxl_dev_name, NULL,
 				 num_ras_features, ras_features);
 }
-- 
2.43.0


