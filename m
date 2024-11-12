Return-Path: <linux-acpi+bounces-9518-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB66B9C641A
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 23:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7CA1F233C4
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 22:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE78E21A4DE;
	Tue, 12 Nov 2024 22:13:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D029121A710;
	Tue, 12 Nov 2024 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731449623; cv=none; b=Vu6Z/bomYwODZUaQD3NfFABj8aZ7icDHlNpUORmmmext9oIGk0H9ePw2miu+39xvYIXhd3IRQkTrSeExZYTnB/jKBWPg79/RweWebzmMpM7E/zBQJY3XFtI4uhNNz8wKlLBloyacxmgMA4fEj/CZEg+kOkNWCPRg4ZJW2eBBPiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731449623; c=relaxed/simple;
	bh=3Livz62I9Mkdh27m5qVkYNWTFlbZXWnq1s8xDsiAejE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHsI+r4phKuEb0KsSyQUx6GG5Rosf5L3sKVoASQyd8Sm8jE/tbmphG5f0B68gVGRvCvj9PZ+ipD/W15A9NpWU40hlAs1hYCXEC/WvDC5obT2ow/O89v8XpGfdGcFuJg16QFkZN8iquqytovW8Nkgb1ayTuuFOLu8POP1ruBQpGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD79C4CECD;
	Tue, 12 Nov 2024 22:13:43 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: rafael@kernel.org,
	bp@alien8.de,
	dan.j.williams@intel.com,
	tony.luck@intel.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com
Subject: [RFC PATCH v2 4/5] cxl: Add extended linear cache address alias emission for cxl events
Date: Tue, 12 Nov 2024 15:12:36 -0700
Message-ID: <20241112221335.432583-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112221335.432583-1-dave.jiang@intel.com>
References: <20241112221335.432583-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the aliased address of extended linear cache when emitting event
trace for DRAM and general media of CXL events.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Fix spelling errors. (Jonathan)
---
 drivers/cxl/core/acpi.c   | 10 ++++++++++
 drivers/cxl/core/core.h   |  7 +++++++
 drivers/cxl/core/mbox.c   | 42 ++++++++++++++++++++++++++++++++++++---
 drivers/cxl/core/region.c | 12 +++++++++++
 drivers/cxl/core/trace.h  | 24 ++++++++++++++--------
 include/linux/acpi.h      | 36 +++++++++++++--------------------
 6 files changed, 98 insertions(+), 33 deletions(-)

diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
index f13b4dae6ac5..f74136320fc3 100644
--- a/drivers/cxl/core/acpi.c
+++ b/drivers/cxl/core/acpi.c
@@ -9,3 +9,13 @@ int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
 {
 	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
 }
+
+int cxl_acpi_extended_linear_cache_address_xlat(u64 *address, u64 alias, int nid)
+{
+	return hmat_extended_linear_cache_address_xlat(address, alias, nid);
+}
+
+int cxl_acpi_extended_linear_cache_alias_xlat(u64 address, u64 *alias, int nid)
+{
+	return hmat_extended_linear_cache_alias_xlat(address, alias, nid);
+}
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index c4dc9aefe25f..9b10039b0ca7 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -30,8 +30,13 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
 struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa);
+int cxl_region_nid(struct cxl_region *cxlr);
 
 #else
+static inline int cxl_region_nid(struct cxl_region *cxlr)
+{
+	return NUMA_NO_NODE;
+}
 static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
 				 const struct cxl_memdev *cxlmd, u64 dpa)
 {
@@ -112,5 +117,7 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 
 int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
 					    int nid, resource_size_t *size);
+int cxl_acpi_extended_linear_cache_address_xlat(u64 *address, u64 alias, int nid);
+int cxl_acpi_extended_linear_cache_alias_xlat(u64 address, u64 *alias, int nid);
 
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 5175138c4fb7..3fa9c658a253 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -856,6 +856,39 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
 
+static u64 cxlr_hpa_cache_alias(struct cxl_region *cxlr, u64 hpa)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	u64 alias, address;
+	int nid, rc;
+
+	if (!p->cache_size)
+		return ~0ULL;
+
+	nid = cxl_region_nid(cxlr);
+	if (nid == NUMA_NO_NODE)
+		nid = 0;
+
+	if (hpa >= p->res->start + p->cache_size) {
+		address = hpa - p->cache_size;
+		alias = hpa;
+		rc = cxl_acpi_extended_linear_cache_address_xlat(&address,
+								 alias, nid);
+		if (rc)
+			return rc;
+
+		return address;
+	}
+
+	address = hpa;
+	alias = hpa + p->cache_size;
+	rc = cxl_acpi_extended_linear_cache_alias_xlat(address, &alias, nid);
+	if (rc)
+		return rc;
+
+	return alias;
+}
+
 void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 			    enum cxl_event_log_type type,
 			    enum cxl_event_type event_type,
@@ -871,7 +904,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 	}
 
 	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
-		u64 dpa, hpa = ULLONG_MAX;
+		u64 dpa, hpa = ULLONG_MAX, hpa_alias;
 		struct cxl_region *cxlr;
 
 		/*
@@ -887,11 +920,14 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 		if (cxlr)
 			hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
 
+		hpa_alias = cxlr_hpa_cache_alias(cxlr, hpa);
+
 		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
 			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
-						&evt->gen_media);
+						hpa_alias, &evt->gen_media);
 		else if (event_type == CXL_CPER_EVENT_DRAM)
-			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->dram);
+			trace_cxl_dram(cxlmd, type, cxlr, hpa, hpa_alias,
+				       &evt->dram);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a37923c030a3..a7479b4aad8d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2405,6 +2405,18 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
 	return true;
 }
 
+int cxl_region_nid(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct resource *res;
+
+	guard(rwsem_read)(&cxl_region_rwsem);
+	res = p->res;
+	if (!res)
+		return NUMA_NO_NODE;
+	return phys_to_target_node(res->start);
+}
+
 static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
 					  unsigned long action, void *arg)
 {
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 8672b42ee4d1..a63183e23ac8 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -316,9 +316,10 @@ TRACE_EVENT(cxl_generic_event,
 TRACE_EVENT(cxl_general_media,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_gen_media *rec),
+		 struct cxl_region *cxlr, u64 hpa, u64 hpa_alias,
+		 struct cxl_event_gen_media *rec),
 
-	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
+	TP_ARGS(cxlmd, log, cxlr, hpa, hpa_alias, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -332,6 +333,7 @@ TRACE_EVENT(cxl_general_media,
 		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
 		/* Following are out of order to pack trace record */
 		__field(u64, hpa)
+		__field(u64, hpa_alias)
 		__field_struct(uuid_t, region_uuid)
 		__field(u16, validity_flags)
 		__field(u8, rank)
@@ -358,6 +360,7 @@ TRACE_EVENT(cxl_general_media,
 			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
 		__entry->validity_flags = get_unaligned_le16(&rec->media_hdr.validity_flags);
 		__entry->hpa = hpa;
+		__entry->hpa_alias = hpa_alias;
 		if (cxlr) {
 			__assign_str(region_name);
 			uuid_copy(&__entry->region_uuid, &cxlr->params.uuid);
@@ -370,7 +373,7 @@ TRACE_EVENT(cxl_general_media,
 	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' " \
 		"descriptor='%s' type='%s' transaction_type='%s' channel=%u rank=%u " \
 		"device=%x comp_id=%s validity_flags='%s' " \
-		"hpa=%llx region=%s region_uuid=%pUb",
+		"hpa=%llx hpa_alias=%llx region=%s region_uuid=%pUb",
 		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
 		show_event_desc_flags(__entry->descriptor),
 		show_mem_event_type(__entry->type),
@@ -378,7 +381,8 @@ TRACE_EVENT(cxl_general_media,
 		__entry->channel, __entry->rank, __entry->device,
 		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
 		show_valid_flags(__entry->validity_flags),
-		__entry->hpa, __get_str(region_name), &__entry->region_uuid
+		__entry->hpa, __entry->hpa_alias, __get_str(region_name),
+		&__entry->region_uuid
 	)
 );
 
@@ -413,9 +417,10 @@ TRACE_EVENT(cxl_general_media,
 TRACE_EVENT(cxl_dram,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_dram *rec),
+		 struct cxl_region *cxlr, u64 hpa, u64 hpa_alias,
+		 struct cxl_event_dram *rec),
 
-	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
+	TP_ARGS(cxlmd, log, cxlr, hpa, hpa_alias, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -431,6 +436,7 @@ TRACE_EVENT(cxl_dram,
 		__field(u32, row)
 		__array(u8, cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE)
 		__field(u64, hpa)
+		__field(u64, hpa_alias)
 		__field_struct(uuid_t, region_uuid)
 		__field(u8, rank)	/* Out of order to pack trace record */
 		__field(u8, bank_group)	/* Out of order to pack trace record */
@@ -461,6 +467,7 @@ TRACE_EVENT(cxl_dram,
 		memcpy(__entry->cor_mask, &rec->correction_mask,
 			CXL_EVENT_DER_CORRECTION_MASK_SIZE);
 		__entry->hpa = hpa;
+		__entry->hpa_alias = hpa_alias;
 		if (cxlr) {
 			__assign_str(region_name);
 			uuid_copy(&__entry->region_uuid, &cxlr->params.uuid);
@@ -474,7 +481,7 @@ TRACE_EVENT(cxl_dram,
 		"transaction_type='%s' channel=%u rank=%u nibble_mask=%x " \
 		"bank_group=%u bank=%u row=%u column=%u cor_mask=%s " \
 		"validity_flags='%s' " \
-		"hpa=%llx region=%s region_uuid=%pUb",
+		"hpa=%llx hpa_alias=%llx region=%s region_uuid=%pUb",
 		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
 		show_event_desc_flags(__entry->descriptor),
 		show_mem_event_type(__entry->type),
@@ -484,7 +491,8 @@ TRACE_EVENT(cxl_dram,
 		__entry->row, __entry->column,
 		__print_hex(__entry->cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE),
 		show_dram_valid_flags(__entry->validity_flags),
-		__entry->hpa, __get_str(region_name), &__entry->region_uuid
+		__entry->hpa_alias, __entry->hpa, __get_str(region_name),
+		&__entry->region_uuid
 	)
 );
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 18a94d382d40..cdf6d42f5a94 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -436,34 +436,12 @@ int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp);
 
 #ifdef CONFIG_ACPI_HMAT
 int acpi_get_genport_coordinates(u32 uid, struct access_coordinate *coord);
-int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
-					resource_size_t *size);
-int hmat_extended_linear_cache_alias_xlat(u64 address, u64 *alias, int nid);
-int hmat_extended_linear_cache_address_xlat(u64 *address, u64 alias, int nid);
 #else
 static inline int acpi_get_genport_coordinates(u32 uid,
 					       struct access_coordinate *coord)
 {
 	return -EOPNOTSUPP;
 }
-
-static inline int hmat_get_extended_linear_cache_size(struct resource *backing_res,
-						      int nid, resource_size_t *size)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline int hmat_extended_linear_cache_alias_xlat(u64 address,
-							u64 *alias, int nid)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline int hmat_extended_linear_cache_address_xlat(u64 *address,
-							  u64 alias, int nid)
-{
-	return -EOPNOTSUPP;
-}
 #endif
 
 #ifdef CONFIG_ACPI_NUMA
@@ -1115,12 +1093,26 @@ static inline acpi_handle acpi_get_processor_handle(int cpu)
 #ifdef CONFIG_ACPI_HMAT
 int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
 					resource_size_t *size);
+int hmat_extended_linear_cache_alias_xlat(u64 address, u64 *alias, int nid);
+int hmat_extended_linear_cache_address_xlat(u64 *address, u64 alias, int nid);
 #else
 static inline int hmat_get_extended_linear_cache_size(struct resource *backing_res,
 						      int nid, resource_size_t *size)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int hmat_extended_linear_cache_alias_xlat(u64 address,
+							u64 *alias, int nid)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int hmat_extended_linear_cache_address_xlat(u64 *address,
+							  u64 alias, int nid)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 extern void arch_post_acpi_subsys_init(void);
-- 
2.47.0


