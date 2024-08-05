Return-Path: <linux-acpi+bounces-7276-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2BB94750C
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 08:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303E61C20D18
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 06:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC821448EF;
	Mon,  5 Aug 2024 06:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZu9O1Bw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ECB38385;
	Mon,  5 Aug 2024 06:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722838125; cv=none; b=HxTcXdnVtPibrmaY+RiBe+FkgQGIZSGMCwM7SvqycS40DCDHC7EZsXtETZhaAaA/zIV4fgM5dBLujFQZUMrCTWnDXUB3/7l4fCwB8c5lpQFljuWmwHTX+gSmVlDuQ1jZAcRlqOalVqldtWJpPYLAPmk20cRlEsvEjufG4ec2TbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722838125; c=relaxed/simple;
	bh=I5rn0gZJfSjx9FVF+npEArcFtQead6gawu43H7Jv0gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nz97ej9qesEltB/Akf5TGkVtMR03WjAP2jlKqVHq//xgYEh6sTqNg67N7WtTOBvUPihXFQJQTakX+6dF83/CMzuzJHXc78HPaVN4ic1C8DjV1JW0BqP7bNPbX29WvsruiMMiCNcgMaDgzyvy912/sGUO597f7gu0bI5/1z9ejzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZu9O1Bw; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722838124; x=1754374124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I5rn0gZJfSjx9FVF+npEArcFtQead6gawu43H7Jv0gM=;
  b=JZu9O1Bw5kJgc94vhNyIKzeOVwkbFzkqV6MEqkJNbRXvf7nqj507gflv
   s9sGOSr+qx4AJUAAYFpp1YFuMSoUe+fZAGmAaAYV5UqY5JY6tNrFwNEQZ
   9sFsmiA7VK1lAse0gP10WmZ2KxS9xEBDyJrkcjkDSqSv6r1CQyMnCFofZ
   MNGCrxxO/3i7ODZwMwaBfqj4I46I5Lv3253CWQjAPFXBZw8+Qt9Xs6nPv
   T7LHWm/5mS/OPgV14hJtZ8S7QBNgrGaZTq+A5HkhsXKGQQII9UGmZgfxF
   06+YvRggNzziJruSpxTC5lbYOREcyTcUTL9tajFBKPJlrMZdciAEe1XR2
   Q==;
X-CSE-ConnectionGUID: QQ2Dr/cCTTOvqk1VhU9stg==
X-CSE-MsgGUID: FD3rRM3LQOmlr1szy/NY2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="31360134"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="31360134"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 23:08:43 -0700
X-CSE-ConnectionGUID: z/RH9liMT7OlPxXLKzlJFw==
X-CSE-MsgGUID: CxL5VrkQStmT8TuLmwWcqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="61028949"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.43.235])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 23:08:41 -0700
From: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH 1/2] ACPICA: Detect FACS in reduced hardware model
Date: Mon,  5 Aug 2024 06:08:12 +0000
Message-ID: <20240805060812.1002004-3-jiaqing.zhao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805060812.1002004-2-jiaqing.zhao@linux.intel.com>
References: <20240805060812.1002004-2-jiaqing.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Section 5.2.10 of ACPI Specification, FACS is optional
in reduced hardware model. Enable the detection for "Hardware-reduced
ACPI support only" build (CONFIG_ACPI_REDUCED_HARDWARE_ONLY=y) also.

Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
---
 drivers/acpi/acpica/acglobal.h |  6 +-----
 drivers/acpi/acpica/tbutils.c  |  5 +----
 drivers/acpi/acpica/utxfinit.c | 24 ++++++++++++------------
 include/acpi/acconfig.h        |  1 -
 4 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index f4c90fc99be2..309ce8efb4f6 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -29,11 +29,7 @@ ACPI_INIT_GLOBAL(u32, acpi_gbl_dsdt_index, ACPI_INVALID_TABLE_INDEX);
 ACPI_INIT_GLOBAL(u32, acpi_gbl_facs_index, ACPI_INVALID_TABLE_INDEX);
 ACPI_INIT_GLOBAL(u32, acpi_gbl_xfacs_index, ACPI_INVALID_TABLE_INDEX);
 ACPI_INIT_GLOBAL(u32, acpi_gbl_fadt_index, ACPI_INVALID_TABLE_INDEX);
-
-#if (!ACPI_REDUCED_HARDWARE)
-ACPI_GLOBAL(struct acpi_table_facs *, acpi_gbl_FACS);
-
-#endif				/* !ACPI_REDUCED_HARDWARE */
+ACPI_INIT_GLOBAL(struct acpi_table_facs *, acpi_gbl_FACS, NULL);
 
 /* These addresses are calculated from the FADT Event Block addresses */
 
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 15fa68a5ea6e..356700349b45 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -18,7 +18,6 @@ ACPI_MODULE_NAME("tbutils")
 static acpi_physical_address
 acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size);
 
-#if (!ACPI_REDUCED_HARDWARE)
 /*******************************************************************************
  *
  * FUNCTION:    acpi_tb_initialize_facs
@@ -37,8 +36,7 @@ acpi_status acpi_tb_initialize_facs(void)
 	struct acpi_table_facs *facs;
 
 	if (acpi_gbl_FADT.Xfacs &&
-		   (!acpi_gbl_FADT.facs
-		    || !acpi_gbl_use32_bit_facs_addresses)) {
+	    (!acpi_gbl_FADT.facs || !acpi_gbl_use32_bit_facs_addresses)) {
 		(void)acpi_get_table_by_index(acpi_gbl_xfacs_index,
 					      ACPI_CAST_INDIRECT_PTR(struct
 								     acpi_table_header,
@@ -56,7 +54,6 @@ acpi_status acpi_tb_initialize_facs(void)
 
 	return (AE_OK);
 }
-#endif				/* !ACPI_REDUCED_HARDWARE */
 
 /*******************************************************************************
  *
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 1915bec2b279..70ae0afa7939 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -120,6 +120,18 @@ acpi_status ACPI_INIT_FUNCTION acpi_enable_subsystem(u32 flags)
 	 */
 	acpi_gbl_early_initialization = FALSE;
 
+	/*
+	 * Obtain a permanent mapping for the FACS. This is required for the
+	 * Global Lock and the Firmware Waking Vector
+	 */
+	if (!(flags & ACPI_NO_FACS_INIT)) {
+		status = acpi_tb_initialize_facs();
+		if (ACPI_FAILURE(status)) {
+			ACPI_WARNING((AE_INFO, "Could not map the FACS table"));
+			return_ACPI_STATUS(status);
+		}
+	}
+
 #if (!ACPI_REDUCED_HARDWARE)
 
 	/* Enable ACPI mode */
@@ -137,18 +149,6 @@ acpi_status ACPI_INIT_FUNCTION acpi_enable_subsystem(u32 flags)
 		}
 	}
 
-	/*
-	 * Obtain a permanent mapping for the FACS. This is required for the
-	 * Global Lock and the Firmware Waking Vector
-	 */
-	if (!(flags & ACPI_NO_FACS_INIT)) {
-		status = acpi_tb_initialize_facs();
-		if (ACPI_FAILURE(status)) {
-			ACPI_WARNING((AE_INFO, "Could not map the FACS table"));
-			return_ACPI_STATUS(status);
-		}
-	}
-
 	/*
 	 * Initialize ACPI Event handling (Fixed and General Purpose)
 	 *
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index d768d9c568cf..2da5f4a6e814 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -67,7 +67,6 @@
  *      General Purpose Events (GPEs)
  *      Global Lock
  *      ACPI PM timer
- *      FACS table (Waking vectors and Global Lock)
  */
 #ifndef ACPI_REDUCED_HARDWARE
 #define ACPI_REDUCED_HARDWARE           FALSE
-- 
2.43.0


