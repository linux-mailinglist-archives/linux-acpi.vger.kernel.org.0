Return-Path: <linux-acpi+bounces-10975-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEE3A2FB85
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 22:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09264166C78
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 21:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C577024CEDB;
	Mon, 10 Feb 2025 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k11DC9S2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082124C695;
	Mon, 10 Feb 2025 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739221955; cv=none; b=ryYXXunlZSL7h3k2TojZud+NGtmJyTtI91tsW7lVbAYoa9gZ0VaMvPd9O9CrN1EfyOC4qv61gpCTBHv1hfcHbwXvQC4J8hkrIaJBQ+vaGOqKGvxUCS/4tB6k1UjDrpgngZqaldjxnSfDijN+QxCn/OPRQBxq6PmkzewD2MSx1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739221955; c=relaxed/simple;
	bh=aJAmjDnrPg2HWKPCN+W545IuNK6kBBz+2H4Vz/bwqpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eso/laQIUxUBwpw7WZHjqCSS1Z7JS6fqmT/xcag0lAXsvEBTiDMOYNDZP2fpqzBFM8lmynV0o47M5DF2HBPWNCsHXthHSfhHAetp8xd4dma2n7pkfaCSgHEOG7qXpyCnvHay2oc/46rZ4uJZMhcnZJv9ziGpeNMX7vxup8vSozA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k11DC9S2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739221954; x=1770757954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aJAmjDnrPg2HWKPCN+W545IuNK6kBBz+2H4Vz/bwqpE=;
  b=k11DC9S2LWcXxYMhMpDaEJ5TdPqGGev34znlRfqCI2wobnaMZbj5kqGu
   mDGvm7jMkQjIU45VJFkJmZx9S7bXcfVEW1C/GndzAnGtpnk9X5su/e6qb
   z8XF/LjnJSLQvKdiJ7Mv/IB7jKqdDPnizDcmOtCRTVHB7Ye2cUUAJSrOf
   hS38dfr5MOQJSxVRt2rJMhSRtL9o3S4PF1wXKxQ531xQMdc5h+yDZrFil
   ruwP6dAhjvTB1Q2lFtoM7LYvvXn7MI7H4pO49DQrzJ0ryXTsnglGn3CF6
   yETBMlrdK9L5bU4sTGBD1OVBXpbeiH7WmK+SvU8gXpCFeUj3ZFOGxeJ7I
   Q==;
X-CSE-ConnectionGUID: 0kzXfoSHQJiZz7sCHxhHvg==
X-CSE-MsgGUID: gvc/2KhMSPSyWqz6fD3FFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39969738"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="39969738"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 13:12:31 -0800
X-CSE-ConnectionGUID: UWzPXJeEQs+KHVpefmiK9g==
X-CSE-MsgGUID: MXIaOGq1Se2SpcNwO9ZK+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116393880"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 13:12:30 -0800
From: Tony Luck <tony.luck@intel.com>
To: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH 1/4] ACPICA: Define MRRM ACPI table
Date: Mon, 10 Feb 2025 13:12:20 -0800
Message-ID: <20250210211223.6139-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210211223.6139-1-tony.luck@intel.com>
References: <20250210211223.6139-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fenghua Yu <fenghua.yu@intel.com>

The MRRM table describes association between physical address ranges
and "region numbers". This is used by:

1) The /sys/fs/resctrl filesystem to report memory traffic per-RMID for
each region.
2) Perf subsystem to report memory related uncore events per region.

Structure defined in the Intel Resource Director Technology (RDT)
Architecture specification downloadable from www.intel.com/sdm

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/acpi/actbl3.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 5cd755143b7d..1b9a03ff73ba 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -42,6 +42,7 @@
 #define ACPI_SIG_WSMT           "WSMT"	/* Windows SMM Security Mitigations Table */
 #define ACPI_SIG_XENV           "XENV"	/* Xen Environment table */
 #define ACPI_SIG_XXXX           "XXXX"	/* Intermediate AML header for ASL/ASL+ converter */
+#define ACPI_SIG_MRRM           "MRRM"	/* Memory Range and Region Mapping table */
 
 /*
  * All tables must be byte-packed to match the ACPI specification, since
@@ -793,6 +794,45 @@ struct acpi_table_xenv {
 	u8 event_flags;
 };
 
+/*******************************************************************************
+ *
+ * MRRM - Memory Range and Region Mapping (MRRM) table
+ *
+ ******************************************************************************/
+
+struct acpi_table_mrrm {
+	struct acpi_table_header header;
+	u8 max_mem_region;	/* Max Memory Regions supported */
+	u8 flags;		/* Region assignment type */
+	u8 reserved[26];
+	/* Memory range entry array */
+};
+#define ACPI_MRRM_FLAGS_REGION_ASSIGNMENT_OS	(1<<0)
+
+/*******************************************************************************
+ *
+ * Memory Range entry - Memory Range entry in MRRM table
+ *
+ ******************************************************************************/
+
+struct acpi_table_mrrm_mem_range_entry {
+	u16 type;		/* Type 0="MRRM" */
+	u16 length;		/* 32B + sizeof(Region-ID Programming Reg[]) */
+	u32 reserved;		/* Reserved */
+	u32 base_addr_low;	/* Low 32 bits of base addr of the mem range */
+	u32 base_addr_high;	/* High 32 bits of base addr of the mem range */
+	u32 len_low;		/* Low 32 bits of length of the mem range */
+	u32 len_high;		/* High 32 bits of length of the mem range */
+	u16 region_id_flags;	/* Valid local or remote Region-ID */
+	u8  local_region_id;	/* Platform-assigned static local Region-ID */
+	u8  remote_region_id;	/* Platform-assigned static remote Region-ID */
+	u32 reserved1;		/* Reserved */
+	/* Region-ID Programming Registers[] */
+};
+
+#define ACPI_MRRM_VALID_REGION_ID_FLAGS_LOCAL 	(1<<0)
+#define ACPI_MRRM_VALID_REGION_ID_FLAGS_REMOTE	(1<<1)
+
 /* Reset to default packing */
 
 #pragma pack()
-- 
2.48.1


