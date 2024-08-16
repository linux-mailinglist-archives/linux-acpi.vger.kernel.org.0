Return-Path: <linux-acpi+bounces-7624-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E626E954F2E
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2024 18:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8621C24509
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2024 16:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676C81C4617;
	Fri, 16 Aug 2024 16:43:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAED1C3F26;
	Fri, 16 Aug 2024 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723826627; cv=none; b=kpMvFf1rOXM/V70Sl0LRIfuLlj4OIs2LpCgX7JXN/Q5CH84nkYFqvY7TLLDAFZUue3bpMn4b9EP3Fnr004B7Dv2uVEaQqgYUGx3ZvSiyaRRygTWio6oaYQY6nGjz5wljAn/1cqKB6LjJ009RgkfRmRO9Nz5xWTLoYTDAffslIJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723826627; c=relaxed/simple;
	bh=bzwtOyYoFpdK9RYtdCCwt7XqcSZqWxDbhXvH2XhFlYs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EHORK2WcZZKadGFueqb0VNVmmQZJilyG+T/zHY/h6fAEAvcOJNEvgtKg7CicayfKzd0wz7mNaTb8wYFYmpDsRK85iuQQaarzI8kcRUC65bH0NMk3a0iPyNlelyBmOa1u0GgWHs75paGD87o0rH8Ko86TAszNfSD/H1YL0QLruh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wlnm35jkWz6K5q4;
	Sat, 17 Aug 2024 00:40:19 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id BE23C1400C9;
	Sat, 17 Aug 2024 00:43:42 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.148.43) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 17:43:41 +0100
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
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <jgroves@micron.com>,
	<vsalve@micron.com>, <yazen.ghannam@amd.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v11 08/14] cxl/memfeature: Add CXL memory device ECS control feature
Date: Fri, 16 Aug 2024 17:42:31 +0100
Message-ID: <20240816164238.1902-9-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240816164238.1902-1-shiju.jose@huawei.com>
References: <20240816164238.1902-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 ECS (Error Check
Scrub) control feature.
The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
Specification (JESD79-5) and allows the DRAM to internally read, correct
single-bit errors, and write back corrected data bits to the DRAM array
while providing transparency to error counts.

The ECS control allows the requester to change the log entry type, the ECS
threshold count provided that the request is within the definition
specified in DDR5 mode registers, change mode between codeword mode and
row count mode, and reset the ECS counter.

Register with EDAC RAS control feature driver, which gets the ECS attr
descriptors from the EDAC ECS and expose sysfs ECS control attributes
to the userspace.
For example ECS control for the memory media FRU 0 in CXL mem0 device is
in /sys/bus/edac/devices/cxl_mem0/ecs_fru0/

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/memfeature.c | 441 +++++++++++++++++++++++++++++++++-
 1 file changed, 440 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/memfeature.c b/drivers/cxl/core/memfeature.c
index 71dd0bd27b8a..ee7fd2f58d01 100644
--- a/drivers/cxl/core/memfeature.c
+++ b/drivers/cxl/core/memfeature.c
@@ -19,7 +19,7 @@
 #include <cxl.h>
 #include <linux/edac.h>
 
-#define CXL_DEV_NUM_RAS_FEATURES	1
+#define CXL_DEV_NUM_RAS_FEATURES	2
 #define CXL_DEV_HOUR_IN_SECS	3600
 
 #define CXL_SCRUB_NAME_LEN	128
@@ -307,6 +307,407 @@ static const struct edac_scrub_ops cxl_ps_scrub_ops = {
 	.cycle_duration_write = cxl_patrol_scrub_write_scrub_cycle,
 };
 
+/* CXL DDR5 ECS control definitions */
+static const uuid_t cxl_ecs_uuid =
+	UUID_INIT(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba, 0xb9, 0x69, 0x1e,     \
+		  0x89, 0x33, 0x86);
+
+struct cxl_ecs_context {
+	u16 num_media_frus;
+	u16 get_feat_size;
+	u16 set_feat_size;
+	u8 get_version;
+	u8 set_version;
+	u16 set_effects;
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
+#define	CXL_ECS_LOG_ENTRY_TYPE_MASK	GENMASK(1, 0)
+#define	CXL_ECS_REALTIME_REPORT_CAP_MASK	BIT(0)
+#define	CXL_ECS_THRESHOLD_COUNT_MASK	GENMASK(2, 0)
+#define	CXL_ECS_MODE_MASK	BIT(3)
+#define	CXL_ECS_RESET_COUNTER_MASK	BIT(4)
+
+static const u16 ecs_supp_threshold[] = { 0, 0, 0, 256, 1024, 4096 };
+
+enum {
+	ECS_LOG_ENTRY_TYPE_DRAM = 0x0,
+	ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU = 0x1,
+};
+
+enum {
+	ECS_THRESHOLD_256 = 3,
+	ECS_THRESHOLD_1024 = 4,
+	ECS_THRESHOLD_4096 = 5,
+};
+
+enum cxl_ecs_mode {
+	ECS_MODE_COUNTS_ROWS = 0,
+	ECS_MODE_COUNTS_CODEWORDS = 1,
+};
+
+/**
+ * struct cxl_ecs_params - CXL memory DDR5 ECS parameter data structure.
+ * @log_entry_type: ECS log entry type, per DRAM or per memory media FRU.
+ * @threshold: ECS threshold count per GB of memory cells.
+ * @mode:	codeword/row count mode
+ *		0 : ECS counts rows with errors
+ *		1 : ECS counts codeword with errors
+ * @reset_counter: [IN] reset ECC counter to default value.
+ */
+struct cxl_ecs_params {
+	u8 log_entry_type;
+	u16 threshold;
+	enum cxl_ecs_mode mode;
+	bool reset_counter;
+};
+
+struct cxl_ecs_rd_attrs {
+	u8 ecs_log_cap;
+	u8 ecs_cap;
+	__le16 ecs_config;
+	u8 ecs_flags;
+}  __packed;
+
+struct cxl_ecs_wr_attrs {
+	u8 ecs_log_cap;
+	__le16 ecs_config;
+}  __packed;
+
+/* CXL DDR5 ECS control functions */
+static int cxl_mem_ecs_get_attrs(struct device *dev, void *drv_data, int fru_id,
+				 struct cxl_ecs_params *params)
+{
+	struct cxl_ecs_context *cxl_ecs_ctx = drv_data;
+	struct cxl_memdev *cxlmd = cxl_ecs_ctx->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	size_t rd_data_size;
+	u8 threshold_index;
+	size_t data_size;
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
+	params->mode = 0;
+	data_size = cxl_get_feature(mds, cxl_ecs_uuid,
+				    CXL_GET_FEAT_SEL_CURRENT_VALUE,
+				    rd_attrs, rd_data_size);
+	if (!data_size)
+		return -EIO;
+
+	params->log_entry_type = FIELD_GET(CXL_ECS_LOG_ENTRY_TYPE_MASK,
+					   rd_attrs[fru_id].ecs_log_cap);
+	threshold_index = FIELD_GET(CXL_ECS_THRESHOLD_COUNT_MASK,
+				    rd_attrs[fru_id].ecs_config);
+	params->threshold = ecs_supp_threshold[threshold_index];
+	params->mode = FIELD_GET(CXL_ECS_MODE_MASK,
+				 rd_attrs[fru_id].ecs_config);
+	return 0;
+}
+
+static int cxl_mem_ecs_set_attrs(struct device *dev, void *drv_data, int fru_id,
+				 struct cxl_ecs_params *params, u8 param_type)
+{
+	struct cxl_ecs_context *cxl_ecs_ctx = drv_data;
+	struct cxl_memdev *cxlmd = cxl_ecs_ctx->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	size_t rd_data_size, wr_data_size;
+	u16 num_media_frus, count;
+	size_t data_size;
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
+	data_size = cxl_get_feature(mds, cxl_ecs_uuid,
+				    CXL_GET_FEAT_SEL_CURRENT_VALUE,
+				    rd_attrs, rd_data_size);
+	if (!data_size)
+		return -EIO;
+	struct cxl_ecs_wr_attrs *wr_attrs __free(kfree) =
+					kmalloc(wr_data_size, GFP_KERNEL);
+	if (!wr_attrs)
+		return -ENOMEM;
+
+	/* Fill writable attributes from the current attributes
+	 * read for all the media FRUs.
+	 */
+	for (count = 0; count < num_media_frus; count++) {
+		wr_attrs[count].ecs_log_cap = rd_attrs[count].ecs_log_cap;
+	wr_attrs[count].ecs_config = rd_attrs[count].ecs_config;
+	}
+
+	/* Fill attribute to be set for the media FRU */
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
+		wr_attrs[fru_id].ecs_log_cap = FIELD_PREP(CXL_ECS_LOG_ENTRY_TYPE_MASK,
+							  params->log_entry_type);
+		break;
+	case CXL_ECS_PARAM_THRESHOLD:
+		wr_attrs[fru_id].ecs_config &= ~CXL_ECS_THRESHOLD_COUNT_MASK;
+		switch (params->threshold) {
+		case 256:
+			wr_attrs[fru_id].ecs_config |= FIELD_PREP(CXL_ECS_THRESHOLD_COUNT_MASK,
+								  ECS_THRESHOLD_256);
+			break;
+		case 1024:
+			wr_attrs[fru_id].ecs_config |= FIELD_PREP(CXL_ECS_THRESHOLD_COUNT_MASK,
+								  ECS_THRESHOLD_1024);
+			break;
+		case 4096:
+			wr_attrs[fru_id].ecs_config |= FIELD_PREP(CXL_ECS_THRESHOLD_COUNT_MASK,
+								  ECS_THRESHOLD_4096);
+			break;
+		default:
+			dev_err(dev,
+				"Invalid CXL ECS scrub threshold count(%d) to set\n",
+				params->threshold);
+			dev_err(dev,
+				"Supported scrub threshold count: 256,1024,4096\n");
+			return -EINVAL;
+		}
+		break;
+	case CXL_ECS_PARAM_MODE:
+		if (params->mode != ECS_MODE_COUNTS_ROWS &&
+		    params->mode != ECS_MODE_COUNTS_CODEWORDS) {
+			dev_err(dev,
+				"Invalid CXL ECS scrub mode(%d) to set\n",
+				params->mode);
+			dev_err(dev,
+				"Mode 0: ECS counts rows with errors"
+				" 1: ECS counts codewords with errors\n");
+			return -EINVAL;
+		}
+		wr_attrs[fru_id].ecs_config &= ~CXL_ECS_MODE_MASK;
+		wr_attrs[fru_id].ecs_config |= FIELD_PREP(CXL_ECS_MODE_MASK,
+							  params->mode);
+		break;
+	case CXL_ECS_PARAM_RESET_COUNTER:
+		wr_attrs[fru_id].ecs_config &= ~CXL_ECS_RESET_COUNTER_MASK;
+		wr_attrs[fru_id].ecs_config |= FIELD_PREP(CXL_ECS_RESET_COUNTER_MASK,
+							  params->reset_counter);
+		break;
+	default:
+		dev_err(dev, "Invalid CXL ECS parameter to set\n");
+		return -EINVAL;
+	}
+
+	ret = cxl_set_feature(mds, cxl_ecs_uuid, cxl_ecs_ctx->set_version,
+			      wr_attrs, wr_data_size,
+			      CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET);
+	if (ret) {
+		dev_err(dev, "CXL ECS set feature failed ret=%d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cxl_ecs_get_log_entry_type(struct device *dev, void *drv_data,
+				      int fru_id, u32 *val)
+{
+	struct cxl_ecs_params params;
+	int ret;
+
+	ret = cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
+	if (ret)
+		return ret;
+
+	*val = params.log_entry_type;
+
+	return 0;
+}
+
+static int cxl_ecs_set_log_entry_type(struct device *dev, void *drv_data,
+				      int fru_id, u32 val)
+{
+	struct cxl_ecs_params params = {
+		.log_entry_type = val,
+	};
+
+	return cxl_mem_ecs_set_attrs(dev, drv_data, fru_id,
+				     &params, CXL_ECS_PARAM_LOG_ENTRY_TYPE);
+}
+
+static int cxl_ecs_get_log_entry_type_per_dram(struct device *dev, void *drv_data,
+					       int fru_id, u32 *val)
+{
+	struct cxl_ecs_params params;
+	int ret;
+
+	ret = cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
+	if (ret)
+		return ret;
+
+	if (params.log_entry_type == ECS_LOG_ENTRY_TYPE_DRAM)
+		*val = 1;
+	else
+		*val = 0;
+
+	return 0;
+}
+
+static int cxl_ecs_get_log_entry_type_per_memory_media(struct device *dev,
+						       void *drv_data,
+						       int fru_id, u32 *val)
+{
+	struct cxl_ecs_params params;
+	int ret;
+
+	ret = cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
+	if (ret)
+		return ret;
+
+	if (params.log_entry_type == ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU)
+		*val = 1;
+	else
+		*val = 0;
+
+	return 0;
+}
+
+static int cxl_ecs_get_mode(struct device *dev, void *drv_data,
+			    int fru_id, u32 *val)
+{
+	struct cxl_ecs_params params;
+	int ret;
+
+	ret = cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
+	if (ret)
+		return ret;
+
+	*val = params.mode;
+
+	return 0;
+}
+
+static int cxl_ecs_set_mode(struct device *dev, void *drv_data,
+			    int fru_id, u32 val)
+{
+	struct cxl_ecs_params params = {
+		.mode = val,
+	};
+
+	return cxl_mem_ecs_set_attrs(dev, drv_data, fru_id,
+				     &params, CXL_ECS_PARAM_MODE);
+}
+
+static int cxl_ecs_get_mode_counts_rows(struct device *dev, void *drv_data,
+					int fru_id, u32 *val)
+{
+	struct cxl_ecs_params params;
+	int ret;
+
+	ret = cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
+	if (ret)
+		return ret;
+
+	if (params.mode == ECS_MODE_COUNTS_ROWS)
+		*val = 1;
+	else
+		*val = 0;
+
+	return 0;
+}
+
+static int cxl_ecs_get_mode_counts_codewords(struct device *dev, void *drv_data,
+					     int fru_id, u32 *val)
+{
+	struct cxl_ecs_params params;
+	int ret;
+
+	ret = cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
+	if (ret)
+		return ret;
+
+	if (params.mode == ECS_MODE_COUNTS_CODEWORDS)
+		*val = 1;
+	else
+		*val = 0;
+
+	return 0;
+}
+
+static int cxl_ecs_reset(struct device *dev, void *drv_data, int fru_id, u32 val)
+{
+	struct cxl_ecs_params params = {
+		.reset_counter = val,
+	};
+
+	return cxl_mem_ecs_set_attrs(dev, drv_data, fru_id,
+				     &params, CXL_ECS_PARAM_RESET_COUNTER);
+}
+
+static int cxl_ecs_get_threshold(struct device *dev, void *drv_data,
+				 int fru_id, u32 *val)
+{
+	struct cxl_ecs_params params;
+	int ret;
+
+	ret = cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
+	if (ret)
+		return ret;
+
+	*val = params.threshold;
+
+	return 0;
+}
+
+static int cxl_ecs_set_threshold(struct device *dev, void *drv_data,
+				 int fru_id, u32 val)
+{
+	struct cxl_ecs_params params = {
+		.threshold = val,
+	};
+
+	return cxl_mem_ecs_set_attrs(dev, drv_data, fru_id,
+				     &params, CXL_ECS_PARAM_THRESHOLD);
+}
+
+static const struct edac_ecs_ops cxl_ecs_ops = {
+	.get_log_entry_type = cxl_ecs_get_log_entry_type,
+	.set_log_entry_type = cxl_ecs_set_log_entry_type,
+	.get_log_entry_type_per_dram = cxl_ecs_get_log_entry_type_per_dram,
+	.get_log_entry_type_per_memory_media =
+				cxl_ecs_get_log_entry_type_per_memory_media,
+	.get_mode = cxl_ecs_get_mode,
+	.set_mode = cxl_ecs_set_mode,
+	.get_mode_counts_codewords = cxl_ecs_get_mode_counts_codewords,
+	.get_mode_counts_rows = cxl_ecs_get_mode_counts_rows,
+	.reset = cxl_ecs_reset,
+	.get_threshold = cxl_ecs_get_threshold,
+	.set_threshold = cxl_ecs_set_threshold,
+};
+
 int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
 {
 	struct edac_dev_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
@@ -315,7 +716,9 @@ int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
 	struct cxl_patrol_scrub_context *cxl_ps_ctx;
 	struct cxl_mbox_supp_feat_entry feat_entry;
 	char cxl_dev_name[CXL_SCRUB_NAME_LEN];
+	struct cxl_ecs_context *cxl_ecs_ctx;
 	int rc, i, num_ras_features = 0;
+	int num_media_frus;
 
 	if (cxlr) {
 		struct cxl_region_params *p = &cxlr->params;
@@ -368,6 +771,42 @@ int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
 	ras_features[num_ras_features].scrub_ctx = cxl_ps_ctx;
 	num_ras_features++;
 
+	if (!cxlr) {
+		rc = cxl_get_supported_feature_entry(mds, &cxl_ecs_uuid,
+						     &feat_entry);
+		if (rc < 0)
+			goto feat_register;
+
+		if (!(feat_entry.attr_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
+			goto feat_register;
+		num_media_frus = feat_entry.get_size /
+					sizeof(struct cxl_ecs_rd_attrs);
+		if (!num_media_frus)
+			goto feat_register;
+
+		cxl_ecs_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ecs_ctx),
+					   GFP_KERNEL);
+		if (!cxl_ecs_ctx)
+			goto feat_register;
+		*cxl_ecs_ctx = (struct cxl_ecs_context) {
+			.get_feat_size = feat_entry.get_size,
+			.set_feat_size = feat_entry.set_size,
+			.get_version = feat_entry.get_version,
+			.set_version = feat_entry.set_version,
+			.set_effects = feat_entry.set_effects,
+			.num_media_frus = num_media_frus,
+			.cxlmd = cxlmd,
+		};
+
+		ras_features[num_ras_features].feat = RAS_FEAT_ECS;
+		ras_features[num_ras_features].ecs_ops = &cxl_ecs_ops;
+		ras_features[num_ras_features].ecs_ctx = cxl_ecs_ctx;
+		ras_features[num_ras_features].ecs_info.num_media_frus =
+								num_media_frus;
+		num_ras_features++;
+	}
+
+feat_register:
 	return edac_dev_register(&cxlmd->dev, cxl_dev_name, NULL,
 				 num_ras_features, ras_features);
 }
-- 
2.34.1


