Return-Path: <linux-acpi+bounces-11496-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02691A46676
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 17:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8366D3A984B
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 16:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C247F222568;
	Wed, 26 Feb 2025 16:22:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A511321D599;
	Wed, 26 Feb 2025 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586953; cv=none; b=c7F2ByvRWmbR4lYPQ/z5PWrfvQNj0IE+jiBqIcplaBanTZK0Ox6bhEbCAY/KbEtnoptylA9dDbuTW55Nx3mGOqrrtYG+vMep1Y42fGuWugHEwVNsWiVXyi5fOWiCePSLzxVRHJWWh0I+TMTna0mBRLzmU7UkmuqYV67C8Idh6uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586953; c=relaxed/simple;
	bh=fZUtBvtc9YQ62AqtdGCXZsBhEteAhX3++LnmCKjXmrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ls1nJJJmIfe+8xhJjYqOp7fZefKGs28BxvjczCDHUBeRD3HivIC97CvSPEVBAeMxc0hdH9svvMxtv3XLD4yI31e0TaJXyBsQ4I677N7MexFKiNmuwuqsUAoyqaEsP3hJfBEhYBsO9/40lD1biOlegs6cKL9ZkMiK1ugDa2tHww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1292C4CED6;
	Wed, 26 Feb 2025 16:22:32 +0000 (UTC)
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
Subject: [PATCH v5 3/4] cxl: Add extended linear cache address alias emission for cxl events
Date: Wed, 26 Feb 2025 09:21:20 -0700
Message-ID: <20250226162224.3633792-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226162224.3633792-1-dave.jiang@intel.com>
References: <20250226162224.3633792-1-dave.jiang@intel.com>
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
Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v5:
- Add alias emit for poison event. (Alison)
- Drop cxlr_hpa_cache_alias() and opencode alias caculation. (Alison)
---
 drivers/cxl/core/mbox.c   | 14 ++++++++++----
 drivers/cxl/core/region.c |  2 +-
 drivers/cxl/core/trace.h  | 31 +++++++++++++++++++++----------
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 548564c770c0..f26b96dd7410 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -871,7 +871,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 	}
 
 	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
-		u64 dpa, hpa = ULLONG_MAX;
+		u64 dpa, hpa = ULLONG_MAX, hpa_alias = ULLONG_MAX;
 		struct cxl_region *cxlr;
 
 		/*
@@ -884,14 +884,20 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 
 		dpa = le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_MASK;
 		cxlr = cxl_dpa_to_region(cxlmd, dpa);
-		if (cxlr)
+		if (cxlr) {
+			u64 cache_size = cxlr->params.cache_size;
+
 			hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
+			if (cache_size)
+				hpa_alias = hpa - cache_size;
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
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 69af651a8f46..a20ef3f10fef 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3260,7 +3260,7 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 
 	if (size != cache_size) {
 		dev_warn(&cxlr->dev,
-			 "Extended Linear Cache size %#lld != CXL size %#lld. No Support!",
+			 "Extended Linear Cache size %lld != CXL size %lld. No Support!",
 			 cache_size, size);
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index cea706b683b5..23e5b438c580 100644
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
@@ -870,6 +876,7 @@ TRACE_EVENT(cxl_poison,
 		__string(region, cxlr ? dev_name(&cxlr->dev) : "")
 		__field(u64, overflow_ts)
 		__field(u64, hpa)
+		__field(u64, hpa_alias0)
 		__field(u64, dpa)
 		__field(u32, dpa_length)
 		__array(char, uuid, 16)
@@ -892,16 +899,19 @@ TRACE_EVENT(cxl_poison,
 			memcpy(__entry->uuid, &cxlr->params.uuid, 16);
 			__entry->hpa = cxl_dpa_to_hpa(cxlr, cxlmd,
 						      __entry->dpa);
+			__entry->hpa_alias0 = cxlr->params.cache_size ?
+				__entry->hpa + cxlr->params.cache_size : ULLONG_MAX;
 		} else {
 			__assign_str(region);
 			memset(__entry->uuid, 0, 16);
 			__entry->hpa = ULLONG_MAX;
+			__entry->hpa_alias0 = ULLONG_MAX;
 		}
 	    ),
 
 	TP_printk("memdev=%s host=%s serial=%lld trace_type=%s region=%s "  \
-		"region_uuid=%pU hpa=0x%llx dpa=0x%llx dpa_length=0x%x "    \
-		"source=%s flags=%s overflow_time=%llu",
+		"region_uuid=%pU hpa=0x%llx hpa_alias0=0x%llx dpa=0x%llx " \
+		"dpa_length=0x%x source=%s flags=%s overflow_time=%llu",
 		__get_str(memdev),
 		__get_str(host),
 		__entry->serial,
@@ -909,6 +919,7 @@ TRACE_EVENT(cxl_poison,
 		__get_str(region),
 		__entry->uuid,
 		__entry->hpa,
+		__entry->hpa_alias0,
 		__entry->dpa,
 		__entry->dpa_length,
 		show_poison_source(__entry->source),
-- 
2.48.1


