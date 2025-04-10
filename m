Return-Path: <linux-acpi+bounces-12957-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22986A84FAE
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 00:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F2519E3C3D
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 22:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9738F20E03C;
	Thu, 10 Apr 2025 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfH0WyLW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE381E1041;
	Thu, 10 Apr 2025 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744324340; cv=none; b=GdUA4MaFAW22bSwNA9hcha+x9vqVs8664qEr1b4dPIeP2BIrdgC/5v4/MYrUcNZWEi9qxUHCZ/8njmVZup524W7og4FkFW37jVGnfmsQsXbPS8p6cyV09rkzHz3EBgWAZt1NQYIf+elih/v4Hjdwe/cLvpObGbpXtl7Za9v16Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744324340; c=relaxed/simple;
	bh=je4PX87/pOXLlsfa4Mz89lMVrtgvdaQj3AqWmieL8Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7/LPhGCjDZk4j8UmtENd6Rgo/Xak9oDwj+dzAT5Ft8ny/AVNKB5nARcNOeRiWBhOYB7ZWvAbrRfaW8xSd/oWgzfc/52HXRUdvcA64X6a3o6WzywdOUfUL/QZnFnPLljFb2SM0yvnUT2NWO+vwRlOhZUlnfMpMdnFKZfkiW0Zys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfH0WyLW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744324339; x=1775860339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=je4PX87/pOXLlsfa4Mz89lMVrtgvdaQj3AqWmieL8Qo=;
  b=nfH0WyLWAeUi+eXX8J5LefWKf3UiraMv5Vq7lWmVdzoyf4Xgl8Xzc5yx
   PtvWV6rhMown1c72Y47b1N+dZN5jdDKma3DVnK4PJ/1uPFQWnxkAg4inf
   WcMTH28KqoPRK0mYftSt4uXHEXKxF9xURGhbZWmmFOkr6VSZ14SlpbL2K
   fsaFE+iYt6ocymlSUVgOuvaaV5DI4vDxylJ5vOIMpq6K8gR/57g3RWwqM
   7sMvFX24evcY6DM2bSt5vsLoEWD3wR2Me3SKoMpdg0TJ2kryxOYAYRklj
   9pax9rQtOKZM4+Hp760hG5J+vgsnaEHTxHgvtJPHH5ES0r7ulkcCeuu07
   g==;
X-CSE-ConnectionGUID: ewVe5Ey/TTCPdQ6HQ8fOdA==
X-CSE-MsgGUID: EbCyHarRQEaNoYkzpR1uJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56845629"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="56845629"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 15:32:17 -0700
X-CSE-ConnectionGUID: pQkjhSwaR1akJ5NHG91UNg==
X-CSE-MsgGUID: JIu3knYsRFSfi/ixon2BAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="128988749"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 15:32:16 -0700
From: Tony Luck <tony.luck@intel.com>
To: rafael.j.wysocki@intel.com
Cc: lenb@kernel.org,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 1/4] ACPICA: Define MRRM ACPI table
Date: Thu, 10 Apr 2025 15:32:04 -0700
Message-ID: <20250410223207.257722-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250410223207.257722-1-tony.luck@intel.com>
References: <20250410223207.257722-1-tony.luck@intel.com>
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


