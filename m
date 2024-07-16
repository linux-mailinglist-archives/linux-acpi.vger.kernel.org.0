Return-Path: <linux-acpi+bounces-6911-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 089519329F6
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2024 17:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B99A1F21B5F
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2024 15:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B29F19E7E5;
	Tue, 16 Jul 2024 15:04:36 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFE419DF78;
	Tue, 16 Jul 2024 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721142276; cv=none; b=IKpqCVowIsbcfSzVOFfokVpcENf54nP6jjueGwjn5eDrsgqXuGCIK2w+m6a1xtA9XmWjBhYo8qcXbtYVuWp03KUDKEBzMSLUcNLEFla3P8Ed85oK6KKFu6BLHzp7mXsxwFzCt0ZvzVC9tdnB8YDEqJD/YQ4rqkE1lKDjiaLTteQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721142276; c=relaxed/simple;
	bh=3IWnKHBnTVkyA6NuU9p8JII69VMHxQcgvHISVe8rWrE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVsiys4ZnyEcqCKs/AjieJQNo8PwFAEpS2PcUDES6s3dsyJlM8yEuAYRgidKo8qJyvCDHjXemRluZCZJqLtovdR2w0cXBoW8/5dNgTNAGfBeSZaaf0Xt1MSEGaobK18q7Lb2taIIjGDUHLQSB4aB4eMbztp7ukwssw+vuPz+ArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WNj4N23ljz6JB8B;
	Tue, 16 Jul 2024 23:03:16 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 14F661406AE;
	Tue, 16 Jul 2024 23:04:32 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.159.153) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 16:04:30 +0100
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
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH v9 04/11] cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox command
Date: Tue, 16 Jul 2024 16:03:28 +0100
Message-ID: <20240716150336.2042-5-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240716150336.2042-1-shiju.jose@huawei.com>
References: <20240716150336.2042-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Add support for GET_SUPPORTED_FEATURES mailbox command.

CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
CXL devices supports features with changeable attributes.
Get Supported Features retrieves the list of supported device specific
features. The settings of a feature can be retrieved using Get Feature
and optionally modified using Set Feature.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/mbox.c | 27 ++++++++++++++++++
 drivers/cxl/cxlmem.h    | 61 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 2626f3fff201..9b9b1d26454e 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1324,6 +1324,33 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
 
+int cxl_get_supported_features(struct cxl_memdev_state *mds,
+			       u32 count, u16 start_index,
+			       struct cxl_mbox_get_supp_feats_out *feats_out)
+{
+	struct cxl_mbox_get_supp_feats_in pi;
+	struct cxl_mbox_cmd mbox_cmd;
+	int rc;
+
+	pi.count = cpu_to_le32(count);
+	pi.start_index = cpu_to_le16(start_index);
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
+		.size_in = sizeof(pi),
+		.payload_in = &pi,
+		.size_out = count,
+		.payload_out = feats_out,
+		.min_out = sizeof(*feats_out),
+	};
+	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
+
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 19aba81cdf13..b0e1565b9d2e 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -530,6 +530,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
 	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
 	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
+	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
@@ -699,6 +700,63 @@ struct cxl_mbox_set_timestamp_in {
 
 } __packed;
 
+/*
+ * Get Supported Features CXL 3.1 Spec 8.2.9.6.1
+ */
+
+/*
+ * Get Supported Features input payload
+ * CXL rev 3.1 section 8.2.9.6.1 Table 8-95
+ */
+struct cxl_mbox_get_supp_feats_in {
+	__le32 count;
+	__le16 start_index;
+	u8 rsvd[2];
+} __packed;
+
+/*
+ * Get Supported Features Supported Feature Entry
+ * CXL rev 3.1 section 8.2.9.6.1 Table 8-97
+ */
+/* Supported Feature Entry : Payload out attribute flags */
+#define CXL_FEAT_ENTRY_FLAG_CHANGABLE	BIT(0)
+#define CXL_FEAT_ENTRY_FLAG_DEEPEST_RESET_PERSISTENCE_MASK	GENMASK(3, 1)
+#define CXL_FEAT_ENTRY_FLAG_PERSIST_ACROSS_FIRMWARE_UPDATE	BIT(4)
+#define CXL_FEAT_ENTRY_FLAG_SUPPORT_DEFAULT_SELECTION	BIT(5)
+#define CXL_FEAT_ENTRY_FLAG_SUPPORT_SAVED_SELECTION	BIT(6)
+
+enum cxl_feat_attr_value_persistence {
+	CXL_FEAT_ATTR_VALUE_PERSISTENCE_NONE,
+	CXL_FEAT_ATTR_VALUE_PERSISTENCE_CXL_RESET,
+	CXL_FEAT_ATTR_VALUE_PERSISTENCE_HOT_RESET,
+	CXL_FEAT_ATTR_VALUE_PERSISTENCE_WARM_RESET,
+	CXL_FEAT_ATTR_VALUE_PERSISTENCE_COLD_RESET,
+	CXL_FEAT_ATTR_VALUE_PERSISTENCE_MAX
+};
+
+struct cxl_mbox_supp_feat_entry {
+	uuid_t uuid;
+	__le16 index;
+	__le16 get_size;
+	__le16 set_size;
+	__le32 attr_flags;
+	u8 get_version;
+	u8 set_version;
+	__le16 set_effects;
+	u8 rsvd[18];
+}  __packed;
+
+/*
+ * Get Supported Features output payload
+ * CXL rev 3.1 section 8.2.9.6.1 Table 8-96
+ */
+struct cxl_mbox_get_supp_feats_out {
+	__le16 nr_entries;
+	__le16 nr_supported;
+	u8 rsvd[4];
+	struct cxl_mbox_supp_feat_entry feat_entries[];
+} __packed;
+
 /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
 struct cxl_mbox_poison_in {
 	__le64 offset;
@@ -830,6 +888,9 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 			    enum cxl_event_type event_type,
 			    const uuid_t *uuid, union cxl_event *evt);
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
+int cxl_get_supported_features(struct cxl_memdev_state *mds,
+			       u32 count, u16 start_index,
+			       struct cxl_mbox_get_supp_feats_out *feats_out);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr);
-- 
2.34.1


