Return-Path: <linux-acpi+bounces-1664-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FB17F2AA4
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 11:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652151C20B0D
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 10:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A2447771
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0068C1732;
	Tue, 21 Nov 2023 02:19:09 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SZL0n0nswz6K8tD;
	Tue, 21 Nov 2023 18:17:45 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 21 Nov 2023 10:19:07 +0000
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 09/10] cxl/memscrub: Register CXL device DDR5 ECS with scrub configure driver
Date: Tue, 21 Nov 2023 18:18:42 +0800
Message-ID: <20231121101844.1161-10-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20231121101844.1161-1-shiju.jose@huawei.com>
References: <20231121101844.1161-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected

From: Shiju Jose <shiju.jose@huawei.com>

Register with the scrub configure driver to expose the sysfs attributes
to the user for configuring the CXL memory device's ECS feature. Add
the callback functions to support configuring the CXL memory device ECS.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/memscrub.c | 234 ++++++++++++++++++++++++++++++++++++
 1 file changed, 234 insertions(+)

diff --git a/drivers/cxl/core/memscrub.c b/drivers/cxl/core/memscrub.c
index 213be4396b98..52fc0af20664 100644
--- a/drivers/cxl/core/memscrub.c
+++ b/drivers/cxl/core/memscrub.c
@@ -464,6 +464,11 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_patrol_scrub_init, CXL);
 #define CXL_MEMDEV_ECS_GET_FEAT_VERSION	0x01
 #define CXL_MEMDEV_ECS_SET_FEAT_VERSION	0x01
 
+#define CXL_DDR5_ECS	"cxl_ecs"
+
+/* The default number of regions for CXL memory device ECS */
+#define CXL_MEMDEV_ECS_NUM_REGIONS	1
+
 static const uuid_t cxl_ecs_uuid =
 	UUID_INIT(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba, 0xb9, 0x69, 0x1e,     \
 		  0x89, 0x33, 0x86);
@@ -729,10 +734,231 @@ static int cxl_mem_ecs_set_attrbs(struct device *dev, int fru_id,
 	return 0;
 }
 
+static int cxl_mem_ecs_log_entry_type_write(struct device *dev, int region_id, long val)
+{
+	struct cxl_memdev_ecs_params params;
+	int ret;
+
+	params.log_entry_type = val;
+	ret = cxl_mem_ecs_set_attrbs(dev, region_id, &params,
+				     CXL_MEMDEV_ECS_PARAM_LOG_ENTRY_TYPE);
+	if (ret) {
+		dev_err(dev->parent, "Set CXL ECS params for log entry type fail ret=%d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cxl_mem_ecs_threshold_write(struct device *dev, int region_id, long val)
+{
+	struct cxl_memdev_ecs_params params;
+	int ret;
+
+	params.threshold = val;
+	ret = cxl_mem_ecs_set_attrbs(dev, region_id, &params,
+				     CXL_MEMDEV_ECS_PARAM_THRESHOLD);
+	if (ret) {
+		dev_err(dev->parent, "Set CXL ECS params for threshold fail ret=%d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cxl_mem_ecs_mode_write(struct device *dev, int region_id, long val)
+{
+	struct cxl_memdev_ecs_params params;
+	int ret;
+
+	params.mode = val;
+	ret = cxl_mem_ecs_set_attrbs(dev, region_id, &params,
+				     CXL_MEMDEV_ECS_PARAM_MODE);
+	if (ret) {
+		dev_err(dev->parent, "Set CXL ECS params for mode fail ret=%d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cxl_mem_ecs_reset_counter_write(struct device *dev, int region_id, long val)
+{
+	struct cxl_memdev_ecs_params params;
+	int ret;
+
+	params.reset_counter = val;
+	ret = cxl_mem_ecs_set_attrbs(dev, region_id, &params,
+				     CXL_MEMDEV_ECS_PARAM_RESET_COUNTER);
+	if (ret) {
+		dev_err(dev->parent, "Set CXL ECS params for reset ECC counter fail ret=%d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * cxl_mem_ecs_is_visible() - Callback to return attribute visibility
+ * @drv_data: Pointer to driver-private data structure passed
+ *	      as argument to devm_scrub_device_register().
+ * @attr: Scrub attribute
+ * @region_id: ID of the memory region
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+static umode_t cxl_mem_ecs_is_visible(const void *drv_data, u32 attr, int region_id)
+{
+	switch (attr) {
+	case scrub_reset_counter:
+		return 0200;
+	case scrub_ecs_log_entry_type_per_dram:
+	case scrub_ecs_log_entry_type_per_memory_media:
+	case scrub_mode_counts_rows:
+	case scrub_mode_counts_codewords:
+	case scrub_threshold_available:
+		return 0444;
+	case scrub_ecs_log_entry_type:
+	case scrub_mode:
+	case scrub_threshold:
+		return 0644;
+	default:
+		return 0;
+	}
+}
+
+/**
+ * cxl_mem_ecs_read() - Read callback for data attributes
+ * @dev: Pointer to scrub device
+ * @attr: Scrub attribute
+ * @region_id: ID of the memory region
+ * @val: Pointer to the returned data
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+static int cxl_mem_ecs_read(struct device *dev, u32 attr, int region_id, u64 *val)
+{
+	struct cxl_memdev_ecs_params params;
+	int ret;
+
+	if (attr == scrub_ecs_log_entry_type ||
+	    attr == scrub_ecs_log_entry_type_per_dram ||
+	    attr == scrub_ecs_log_entry_type_per_memory_media ||
+	    attr == scrub_mode ||
+	    attr == scrub_mode_counts_rows ||
+	    attr == scrub_mode_counts_codewords ||
+	    attr == scrub_threshold) {
+		ret = cxl_mem_ecs_get_attrbs(dev, region_id, &params);
+		if (ret) {
+			dev_err(dev->parent, "Get CXL ECS params fail ret=%d\n", ret);
+			return ret;
+		}
+	}
+
+	switch (attr) {
+	case scrub_ecs_log_entry_type:
+		*val = params.log_entry_type;
+		break;
+	case scrub_ecs_log_entry_type_per_dram:
+		if (params.log_entry_type == ECS_LOG_ENTRY_TYPE_DRAM)
+			*val = 1;
+		else
+			*val = 0;
+		break;
+	case scrub_ecs_log_entry_type_per_memory_media:
+		if (params.log_entry_type == ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU)
+			*val = 1;
+		else
+			*val = 0;
+		break;
+	case scrub_mode:
+		*val = params.mode;
+		break;
+	case scrub_mode_counts_rows:
+		if (params.mode == ECS_MODE_COUNTS_ROWS)
+			*val = 1;
+		else
+			*val = 0;
+		break;
+	case scrub_mode_counts_codewords:
+		if (params.mode == ECS_MODE_COUNTS_CODEWORDS)
+			*val = 1;
+		else
+			*val = 0;
+		break;
+	case scrub_threshold:
+		*val = params.threshold;
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	return 0;
+}
+
+/**
+ * cxl_mem_ecs_write() - Write callback for data attributes
+ * @dev: Pointer to scrub device
+ * @attr: Scrub attribute
+ * @region_id: ID of the memory region
+ * @val: Value to write
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+static int cxl_mem_ecs_write(struct device *dev, u32 attr, int region_id, u64 val)
+{
+	switch (attr) {
+	case scrub_ecs_log_entry_type:
+		return cxl_mem_ecs_log_entry_type_write(dev, region_id, val);
+	case scrub_mode:
+		return cxl_mem_ecs_mode_write(dev, region_id, val);
+	case scrub_reset_counter:
+		return cxl_mem_ecs_reset_counter_write(dev, region_id, val);
+	case scrub_threshold:
+		return cxl_mem_ecs_threshold_write(dev, region_id, val);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+/**
+ * cxl_mem_ecs_read_strings() - Read callback for DDR5 ECS string attributes
+ * @dev: Pointer to ECS scrub device
+ * @attr: ECS scrub attribute
+ * @region_id: ID of the memory media FRU.
+ * @buf: Pointer to the buffer for copying returned string
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+static int cxl_mem_ecs_read_strings(struct device *dev, u32 attr,
+				    int region_id, char *buf)
+{
+
+	switch (attr) {
+	case scrub_threshold_available:
+		return sysfs_emit(buf, "256,1024,4096\n");
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static const struct scrub_ops cxl_ecs_ops = {
+	.is_visible = cxl_mem_ecs_is_visible,
+	.read = cxl_mem_ecs_read,
+	.write = cxl_mem_ecs_write,
+	.read_string = cxl_mem_ecs_read_strings,
+};
+
 int cxl_mem_ddr5_ecs_init(struct cxl_memdev *cxlmd)
 {
+	char scrub_name[CXL_MEMDEV_MAX_NAME_LENGTH];
 	struct cxl_mbox_supp_feat_entry feat_entry;
 	struct cxl_ecs_context *cxl_ecs_ctx;
+	struct device *cxl_scrub_dev;
 	int nmedia_frus;
 	int ret;
 
@@ -752,6 +978,14 @@ int cxl_mem_ddr5_ecs_init(struct cxl_memdev *cxlmd)
 		cxl_ecs_ctx->nregions = nmedia_frus;
 		cxl_ecs_ctx->get_feat_size = feat_entry.get_feat_size;
 		cxl_ecs_ctx->set_feat_size = feat_entry.set_feat_size;
+
+		snprintf(scrub_name, sizeof(scrub_name), "%s_%s",
+			 CXL_DDR5_ECS, dev_name(&cxlmd->dev));
+		cxl_scrub_dev = devm_scrub_device_register(&cxlmd->dev, scrub_name,
+							  cxl_ecs_ctx, &cxl_ecs_ops,
+							  cxl_ecs_ctx->nregions);
+		if (IS_ERR(cxl_scrub_dev))
+			return PTR_ERR(cxl_scrub_dev);
 	}
 
 	return 0;
-- 
2.34.1


