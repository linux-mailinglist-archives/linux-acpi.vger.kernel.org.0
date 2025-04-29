Return-Path: <linux-acpi+bounces-13373-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95687AA1C11
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Apr 2025 22:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619D946813E
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Apr 2025 20:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464FC267AE4;
	Tue, 29 Apr 2025 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kaWXsEP2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D9B25F78C;
	Tue, 29 Apr 2025 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745958264; cv=none; b=kGbb169GZlsS4yx52YdXNHPVl0GRYux7Rb9bgS41gWhHWPIMfyElK6CvnpX/OUl2piv+GrDBT3r8Y9jo2X8o1WMIArD8bjWBia453HZ6JnT+o+bclkWg64zTXk17oE0dAQdCPGpFDzBMmcw4ySDU2Be55m8t/VGpNtxO4rV+A9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745958264; c=relaxed/simple;
	bh=je4PX87/pOXLlsfa4Mz89lMVrtgvdaQj3AqWmieL8Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCNbewZjynhL3PFturELM/u9NDVBgpgjin/+SKiW+np0qXrMpxoYUlrSoDcYvC2WbIU7KjAEzbB5gQhFtXVKEKeFmKu/JJZOo5/sQUJKwbERhx4qIWrXhOzahKvinu2o+moI/TH8M+jDzEqz2e6xG60gPUnxYYh5ZOz+tnfwSmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kaWXsEP2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745958262; x=1777494262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=je4PX87/pOXLlsfa4Mz89lMVrtgvdaQj3AqWmieL8Qo=;
  b=kaWXsEP2PBUaFEcF9+bH9Zh9lAxSOLeh+MvlpkKHgncZMZybhma5g7nL
   0KVlA609kDNdWRs8m+OTVVmY5z5rXypyl9K0S0jQTwJVs31zoinc3WyRz
   A6Iz+2N9auhT5KsfUBFVge7RI+OrxmpTlNWKml9dUqOrSKRVsOUsJ5iul
   naotOuxeP1v6bnRCRgSMwhF+yjr5lGugMpEg7UiV5kFQvbOD3tKSJ/Rgl
   rsnH/63ouoPBZvM1fM4pm6XjKXoQ3jJ0QbzxxFQta9JNSALPii35Om/u6
   DAEjZTLLnCDH/FPglvZp5zDWUngEp46lxW3n8kGNCkfmnjzwGKpwp95ZA
   Q==;
X-CSE-ConnectionGUID: sFPWMF7pTmuWCzqHG4AiWw==
X-CSE-MsgGUID: 1FGRKaKdQhaJELgqImkqeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47314067"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="47314067"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 13:24:19 -0700
X-CSE-ConnectionGUID: YY9wJV3mSQGYQTGitr9kgg==
X-CSE-MsgGUID: wPtOYY0mQmKt6lRiZKmmiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="139036127"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 13:24:18 -0700
From: Tony Luck <tony.luck@intel.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 1/4] ACPICA: Define MRRM ACPI table
Date: Tue, 29 Apr 2025 13:24:08 -0700
Message-ID: <20250429202412.380637-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429202412.380637-1-tony.luck@intel.com>
References: <20250429202412.380637-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch for reference, this has already been applied to
https://github.com/acpica/acpica and will in due course make its way
into Linux when the next ACPICA release is ported over.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/acpi/actbl1.h |  7 +++++++
 include/acpi/actbl2.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 387fc821703a..4cb36392e9e9 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -110,6 +110,13 @@ struct acpi_whea_header {
 	u64 mask;		/* Bitmask required for this register instruction */
 };
 
+/* Larger subtable header (when Length can exceed 255) */
+
+struct acpi_subtbl_hdr_16 {
+	u16 type;
+	u16 length;
+};
+
 /* https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/acpitabl/ns-acpitabl-aspt_table */
 #define ASPT_REVISION_ID 0x01
 struct acpi_table_aspt {
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 2e917a8f8bca..e7423db6e24b 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -37,6 +37,7 @@
 #define ACPI_SIG_MCHI           "MCHI"	/* Management Controller Host Interface table */
 #define ACPI_SIG_MPAM           "MPAM"	/* Memory System Resource Partitioning and Monitoring Table */
 #define ACPI_SIG_MPST           "MPST"	/* Memory Power State Table */
+#define ACPI_SIG_MRRM           "MRRM"      /* Memory Range and Region Mapping table */
 #define ACPI_SIG_MSDM           "MSDM"	/* Microsoft Data Management Table */
 #define ACPI_SIG_NFIT           "NFIT"	/* NVDIMM Firmware Interface Table */
 #define ACPI_SIG_NHLT           "NHLT"	/* Non HD Audio Link Table */
@@ -1736,6 +1737,47 @@ struct acpi_msct_proximity {
 	u64 memory_capacity;	/* In bytes */
 };
 
+/*******************************************************************************
+ *
+ * MRRM - Memory Range and Region Mapping (MRRM) table
+ * Conforms to "Intel Resource Director Technology Architecture Specification"
+ * Version 1.1, January 2025
+ *
+ ******************************************************************************/
+
+struct acpi_table_mrrm {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u8 max_mem_region;			/* Max Memory Regions supported */
+	u8 flags;				/* Region assignment type */
+	u8 reserved[26];
+	u8 memory_range_entry[];
+};
+
+/* Flags */
+#define ACPI_MRRM_FLAGS_REGION_ASSIGNMENT_OS (1<<0)
+
+/*******************************************************************************
+	*
+	* Memory Range entry - Memory Range entry in MRRM table
+	*
+	******************************************************************************/
+
+struct acpi_mrrm_mem_range_entry {
+	struct acpi_subtbl_hdr_16 header;
+	u32 reserved0;		/* Reserved */
+	u64 addr_base;		/* Base addr of the mem range */
+	u64 addr_len;		/* Length of the mem range */
+	u16 region_id_flags;	/* Valid local or remote Region-ID */
+	u8 local_region_id;	/* Platform-assigned static local Region-ID */
+	u8 remote_region_id;	/* Platform-assigned static remote Region-ID */
+	u32 reserved1;		/* Reserved */
+	/* Region-ID Programming Registers[] */
+};
+
+/* Values for region_id_flags above */
+#define ACPI_MRRM_VALID_REGION_ID_FLAGS_LOCAL   (1<<0)
+#define ACPI_MRRM_VALID_REGION_ID_FLAGS_REMOTE  (1<<1)
+
 /*******************************************************************************
  *
  * MSDM - Microsoft Data Management table
-- 
2.48.1


