Return-Path: <linux-acpi+bounces-1657-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 457667F2A86
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 11:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFD3281B58
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 10:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1FB1FBF
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4099F171E;
	Tue, 21 Nov 2023 02:19:04 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SZKwY56B8z67nhP;
	Tue, 21 Nov 2023 18:14:05 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 21 Nov 2023 10:19:01 +0000
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
Subject: [PATCH v2 03/10] cxl/mbox: Add SET_FEATURE mailbox command
Date: Tue, 21 Nov 2023 18:18:36 +0800
Message-ID: <20231121101844.1161-4-shiju.jose@huawei.com>
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

Add support for SET_FEATURE mailbox command.

CXL spec 3.0 section 8.2.9.6 describes optional device specific features.
CXL devices supports features with changeable attributes.
The settings of a feature can be optionally modified using Set Feature
command.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/mbox.c      | 15 +++++++++++++++
 drivers/cxl/cxlmem.h         | 27 +++++++++++++++++++++++++++
 include/uapi/linux/cxl_mem.h |  1 +
 3 files changed, 43 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 2675c616caec..d892b07446ca 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -65,6 +65,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
 	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),
 	CXL_CMD(GET_FEATURE, 0x15, CXL_VARIABLE_PAYLOAD, 0),
+	CXL_CMD(SET_FEATURE, CXL_VARIABLE_PAYLOAD, 0, 0),
 };
 
 /*
@@ -1350,6 +1351,20 @@ int cxl_get_feature(struct cxl_memdev_state *mds,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
 
+int cxl_set_feature(struct cxl_memdev_state *mds, void *feat_in, size_t size)
+{
+	struct cxl_mbox_cmd mbox_cmd;
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_SET_FEATURE,
+		.size_in = size,
+		.payload_in = feat_in,
+	};
+
+	return cxl_internal_send_cmd(mds, &mbox_cmd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_feature, CXL);
+
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 92c1f2a44713..46131dcd0900 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -508,6 +508,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_LOG		= 0x0401,
 	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
 	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
+	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
@@ -817,6 +818,31 @@ struct cxl_mbox_get_feat_in {
 	u8 selection;
 }  __packed;
 
+/* Set Feature CXL 3.0 Spec 8.2.9.6.3 */
+/*
+ * Set Feature input payload
+ * CXL rev 3.0 section 8.2.9.6.3; Table 8-81
+ */
+/* Set Feature : Payload in flags */
+#define CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK	GENMASK(2, 0)
+enum cxl_set_feat_flag_data_transfer {
+	CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER = 0x0,
+	CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER = 0x1,
+	CXL_SET_FEAT_FLAG_CONTINUE_DATA_TRANSFER = 0x2,
+	CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER = 0x3,
+	CXL_SET_FEAT_FLAG_ABORT_DATA_TRANSFER = 0x4,
+	CXL_SET_FEAT_FLAG_DATA_TRANSFER_MAX
+};
+#define CXL_SET_FEAT_FLAG_MOD_VALUE_SAVED_ACROSS_RESET	BIT(3)
+
+struct cxl_mbox_set_feat_in {
+	uuid_t uuid;
+	__le32 flags;
+	__le16 offset;
+	u8 version;
+	u8 rsvd[9];
+}  __packed;
+
 /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
 struct cxl_mbox_poison_in {
 	__le64 offset;
@@ -949,6 +975,7 @@ int cxl_get_supported_features(struct cxl_memdev_state *mds,
 			       void *feats_out);
 int cxl_get_feature(struct cxl_memdev_state *mds,
 		    struct cxl_mbox_get_feat_in *pi, void *feat_out);
+int cxl_set_feature(struct cxl_memdev_state *mds, void *feat_in, size_t size);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr);
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index b20de60bfc71..8c89d323cc41 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -48,6 +48,7 @@
 	___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),          \
 	___C(GET_SUPPORTED_FEATURES, "Get Supported Features"),           \
 	___C(GET_FEATURE, "Get Feature"),                                 \
+	___C(SET_FEATURE, "Set Feature"),                                 \
 	___C(MAX, "invalid / last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
-- 
2.34.1


