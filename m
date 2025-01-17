Return-Path: <linux-acpi+bounces-10745-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6937A155C4
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 18:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B086188D637
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 17:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180751A23B1;
	Fri, 17 Jan 2025 17:31:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F019B1A23AC;
	Fri, 17 Jan 2025 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737135062; cv=none; b=dIajCO3joYc/nIMOIogJDYb/NyLkIyrXqeyf28bq70c4uRbpwQvpLGLRMomNQXM951rbBBijIcox47Dl6dLBEXAuSEL1qGrBwqEoESj+CfJI84VnRjbte1H4B35QDoK3ep4xXKFUk0KbS8yxR7nn4k2Ov1PhoYO3cGrgVCzGiBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737135062; c=relaxed/simple;
	bh=e7zyuSK5aljFGVPoACEDdmo/6H16Wo7iaNAVgFyj1G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XURWMmsZBNAEf+009tdsJrJ5rsOXgIP1YotcG7RBwEdZGYZa7Z9ksiu41coica+Jk/jxRJ9hYbsGlGqhvlCLTTWSP/BtHoyVzcy6HHSKgiqUZhV479FNLK2kQsSRU3beAXywx+3lTEYEwkBOspGkXyF+dUY7avYa3xaJeEJKhsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA4AC4CEDD;
	Fri, 17 Jan 2025 17:31:01 +0000 (UTC)
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
	ming.li@zohomail.com
Subject: [PATCH v3 3/4] cxl: Add extended linear cache address alias emission for cxl events
Date: Fri, 17 Jan 2025 10:28:32 -0700
Message-ID: <20250117173054.4147877-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117173054.4147877-1-dave.jiang@intel.com>
References: <20250117173054.4147877-1-dave.jiang@intel.com>
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
v3:
- Drop unused region to nid function
- Make sure hpa_alias defaults to ~0ULL. (Jonathan)
---
 drivers/cxl/core/mbox.c  | 28 ++++++++++++++++++++++++----
 drivers/cxl/core/trace.h | 24 ++++++++++++++++--------
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 548564c770c0..f42c4c56dc43 100644
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
+		return ~0ULL;
+
+	p = &cxlr->params;
+	if (!p->cache_size)
+		return ~0ULL;
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
+		u64 dpa, hpa = ULLONG_MAX, hpa_alias = ~0ULL;
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
index 8389a94adb1a..257f60f16e4c 100644
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
+		"hpa=%llx hpa_alias0=%llx region=%s region_uuid=%pUb",
 		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
 		show_event_desc_flags(__entry->descriptor),
 		show_gmer_mem_event_type(__entry->type),
@@ -378,7 +381,8 @@ TRACE_EVENT(cxl_general_media,
 		__entry->channel, __entry->rank, __entry->device,
 		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
 		show_valid_flags(__entry->validity_flags),
-		__entry->hpa, __get_str(region_name), &__entry->region_uuid
+		__entry->hpa, __entry->hpa_alias, __get_str(region_name),
+		&__entry->region_uuid
 	)
 );
 
@@ -424,9 +428,10 @@ TRACE_EVENT(cxl_general_media,
 TRACE_EVENT(cxl_dram,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_dram *rec),
+		 struct cxl_region *cxlr, u64 hpa, u64 hpa_alias,
+		 struct cxl_event_dram *rec),
 
-	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
+	TP_ARGS(cxlmd, log, cxlr, hpa, hpa_alias, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -442,6 +447,7 @@ TRACE_EVENT(cxl_dram,
 		__field(u32, row)
 		__array(u8, cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE)
 		__field(u64, hpa)
+		__field(u64, hpa_alias)
 		__field_struct(uuid_t, region_uuid)
 		__field(u8, rank)	/* Out of order to pack trace record */
 		__field(u8, bank_group)	/* Out of order to pack trace record */
@@ -472,6 +478,7 @@ TRACE_EVENT(cxl_dram,
 		memcpy(__entry->cor_mask, &rec->correction_mask,
 			CXL_EVENT_DER_CORRECTION_MASK_SIZE);
 		__entry->hpa = hpa;
+		__entry->hpa_alias = hpa_alias;
 		if (cxlr) {
 			__assign_str(region_name);
 			uuid_copy(&__entry->region_uuid, &cxlr->params.uuid);
@@ -485,7 +492,7 @@ TRACE_EVENT(cxl_dram,
 		"transaction_type='%s' channel=%u rank=%u nibble_mask=%x " \
 		"bank_group=%u bank=%u row=%u column=%u cor_mask=%s " \
 		"validity_flags='%s' " \
-		"hpa=%llx region=%s region_uuid=%pUb",
+		"hpa=%llx hpa_alias0=%llx region=%s region_uuid=%pUb",
 		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
 		show_event_desc_flags(__entry->descriptor),
 		show_dram_mem_event_type(__entry->type),
@@ -495,7 +502,8 @@ TRACE_EVENT(cxl_dram,
 		__entry->row, __entry->column,
 		__print_hex(__entry->cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE),
 		show_dram_valid_flags(__entry->validity_flags),
-		__entry->hpa, __get_str(region_name), &__entry->region_uuid
+		__entry->hpa_alias, __entry->hpa, __get_str(region_name),
+		&__entry->region_uuid
 	)
 );
 
-- 
2.47.1


