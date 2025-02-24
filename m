Return-Path: <linux-acpi+bounces-11408-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AB1A42B45
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 19:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96FC77A4C58
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 18:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DFC267397;
	Mon, 24 Feb 2025 18:22:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF082267391;
	Mon, 24 Feb 2025 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421330; cv=none; b=POoAug2ydQfzyar5cMY/crHdL1YOkG4/qTGPDVy2/kOxxz7GULH7q60biAqUUn0293T/HvLCPE+hIPiVHsstcQaP4BxqTDXNJI0TmGSdoH7aPn+7s0AeUwc5d98WrQHt2e2fvSeN8s2JAjUPyYcfMjsmXDjW4aGvnpizf1Jp0JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421330; c=relaxed/simple;
	bh=NW9/Pvnp9gqIy4hzcqOoggPoL9xsFbeZvw4vA/zDk8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=er8P/Qwua4k0wTa0hXm9Ia7YeJwbF6MZyRbEgOJteP78zirAPea/d/njKVc/ZLVgGzJf9zuml+zYcjjk9LJTP8rkdWOTzOODtBgFM8oWFR0WJGvDnSjU5Y4ki91IZZtsq+7Rmc0YmaKwDXYRidwuNmQLpzwR8arREs+WJZaEQn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1789CC4CED6;
	Mon, 24 Feb 2025 18:22:09 +0000 (UTC)
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
	ira.weiny@intel.com,
	ming.li@zohomail.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 3/4] cxl: Add extended linear cache address alias emission for cxl events
Date: Mon, 24 Feb 2025 11:21:01 -0700
Message-ID: <20250224182202.1683380-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224182202.1683380-1-dave.jiang@intel.com>
References: <20250224182202.1683380-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the aliased address of extended linear cache when emitting event
trace for DRAM and general media of CXL events.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Make error using ULLONG_MAX consistently. (Alison)
- Make hpa_alias0 naming consistent. (Alison)
- Swap incorrect position of hpa and hpa_alias0. (Alison)
---
 drivers/cxl/core/mbox.c  | 28 ++++++++++++++++++++++++----
 drivers/cxl/core/trace.h | 22 ++++++++++++++--------
 2 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 548564c770c0..808b6a3c577b 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -856,6 +856,23 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, "CXL");
 
+static u64 cxlr_hpa_cache_alias(struct cxl_region *cxlr, u64 hpa)
+{
+	struct cxl_region_params *p;
+
+	if (!cxlr)
+		return ULLONG_MAX;
+
+	p = &cxlr->params;
+	if (!p->cache_size)
+		return ULLONG_MAX;
+
+	if (hpa >= p->res->start + p->cache_size)
+		return hpa - p->cache_size;
+
+	return hpa + p->cache_size;
+}
+
 void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 			    enum cxl_event_log_type type,
 			    enum cxl_event_type event_type,
@@ -871,7 +888,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 	}
 
 	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
-		u64 dpa, hpa = ULLONG_MAX;
+		u64 dpa, hpa = ULLONG_MAX, hpa_alias = ULLONG_MAX;
 		struct cxl_region *cxlr;
 
 		/*
@@ -884,14 +901,17 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 
 		dpa = le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_MASK;
 		cxlr = cxl_dpa_to_region(cxlmd, dpa);
-		if (cxlr)
+		if (cxlr) {
 			hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
+			hpa_alias = cxlr_hpa_cache_alias(cxlr, hpa);
+		}
 
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
 EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, "CXL");
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index cea706b683b5..dc32c08c044e 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -392,9 +392,10 @@ TRACE_EVENT(cxl_generic_event,
 TRACE_EVENT(cxl_general_media,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_gen_media *rec),
+		 struct cxl_region *cxlr, u64 hpa, u64 hpa_alias0,
+		 struct cxl_event_gen_media *rec),
 
-	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
+	TP_ARGS(cxlmd, log, cxlr, hpa, hpa_alias0, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -408,6 +409,7 @@ TRACE_EVENT(cxl_general_media,
 		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
 		/* Following are out of order to pack trace record */
 		__field(u64, hpa)
+		__field(u64, hpa_alias0)
 		__field_struct(uuid_t, region_uuid)
 		__field(u16, validity_flags)
 		__field(u8, rank)
@@ -438,6 +440,7 @@ TRACE_EVENT(cxl_general_media,
 			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
 		__entry->validity_flags = get_unaligned_le16(&rec->media_hdr.validity_flags);
 		__entry->hpa = hpa;
+		__entry->hpa_alias0 = hpa_alias0;
 		if (cxlr) {
 			__assign_str(region_name);
 			uuid_copy(&__entry->region_uuid, &cxlr->params.uuid);
@@ -455,7 +458,7 @@ TRACE_EVENT(cxl_general_media,
 		"device=%x validity_flags='%s' " \
 		"comp_id=%s comp_id_pldm_valid_flags='%s' " \
 		"pldm_entity_id=%s pldm_resource_id=%s " \
-		"hpa=%llx region=%s region_uuid=%pUb " \
+		"hpa=%llx hpa_alias0=%llx region=%s region_uuid=%pUb " \
 		"cme_threshold_ev_flags='%s' cme_count=%u",
 		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
 		show_event_desc_flags(__entry->descriptor),
@@ -470,7 +473,7 @@ TRACE_EVENT(cxl_general_media,
 				    CXL_GMER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id),
 		show_pldm_resource_id(__entry->validity_flags, CXL_GMER_VALID_COMPONENT,
 				      CXL_GMER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id),
-		__entry->hpa, __get_str(region_name), &__entry->region_uuid,
+		__entry->hpa, __entry->hpa_alias0, __get_str(region_name), &__entry->region_uuid,
 		show_cme_threshold_ev_flags(__entry->cme_threshold_ev_flags), __entry->cme_count
 	)
 );
@@ -529,9 +532,10 @@ TRACE_EVENT(cxl_general_media,
 TRACE_EVENT(cxl_dram,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_dram *rec),
+		 struct cxl_region *cxlr, u64 hpa, u64 hpa_alias0,
+		 struct cxl_event_dram *rec),
 
-	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
+	TP_ARGS(cxlmd, log, cxlr, hpa, hpa_alias0, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -547,6 +551,7 @@ TRACE_EVENT(cxl_dram,
 		__field(u32, row)
 		__array(u8, cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE)
 		__field(u64, hpa)
+		__field(u64, hpa_alias0)
 		__field_struct(uuid_t, region_uuid)
 		__field(u8, rank)	/* Out of order to pack trace record */
 		__field(u8, bank_group)	/* Out of order to pack trace record */
@@ -584,6 +589,7 @@ TRACE_EVENT(cxl_dram,
 		memcpy(__entry->cor_mask, &rec->correction_mask,
 			CXL_EVENT_DER_CORRECTION_MASK_SIZE);
 		__entry->hpa = hpa;
+		__entry->hpa_alias0 = hpa_alias0;
 		if (cxlr) {
 			__assign_str(region_name);
 			uuid_copy(&__entry->region_uuid, &cxlr->params.uuid);
@@ -604,7 +610,7 @@ TRACE_EVENT(cxl_dram,
 		"validity_flags='%s' " \
 		"comp_id=%s comp_id_pldm_valid_flags='%s' " \
 		"pldm_entity_id=%s pldm_resource_id=%s " \
-		"hpa=%llx region=%s region_uuid=%pUb " \
+		"hpa=%llx hpa_alias0=%llx region=%s region_uuid=%pUb " \
 		"sub_channel=%u cme_threshold_ev_flags='%s' cvme_count=%u",
 		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
 		show_event_desc_flags(__entry->descriptor),
@@ -622,7 +628,7 @@ TRACE_EVENT(cxl_dram,
 				    CXL_DER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id),
 		show_pldm_resource_id(__entry->validity_flags, CXL_DER_VALID_COMPONENT,
 				      CXL_DER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id),
-		__entry->hpa, __get_str(region_name), &__entry->region_uuid,
+		__entry->hpa, __entry->hpa_alias0, __get_str(region_name), &__entry->region_uuid,
 		__entry->sub_channel, show_cme_threshold_ev_flags(__entry->cme_threshold_ev_flags),
 		__entry->cvme_count
 	)
-- 
2.48.1


