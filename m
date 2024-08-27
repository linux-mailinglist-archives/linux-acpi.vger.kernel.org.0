Return-Path: <linux-acpi+bounces-7852-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A9095FF74
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 04:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFF3283726
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 02:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1351F1805E;
	Tue, 27 Aug 2024 02:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMpx4Shc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F3C17C60;
	Tue, 27 Aug 2024 02:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727522; cv=none; b=lE/dNvrXabTuAKXqBVVsqFuEvux1LxvoTbffP3G1yA92iMmB1QbfrU8g1rL+j7xyVym7u80kkVfhepfZnk/aGMrHXQpNqjLomnf8pMt8k7YbX9ZtvoUK84JP0hPb8tzVKaRJEItNIDlQN+0xmZJSD1nGLxKCQPvgAkF5Q3KCXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727522; c=relaxed/simple;
	bh=WfJUUDVtx9x3suQ9UzZSPSwb8qdMas+AphdNlS7Uy1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdj25BMRp1is3NfLWAjMqrvUuRGV+D5uq6OnwEIBJlh0Iv63JmtzHhZKME5Uwo0gV6/tXrcrP8+kTlgmcvDUQiwVLUWGVAPC919Epbn0u7C9hRHMxlBBtsz81fxfxACWofrF+U3aUTVwKnWEKhN5U0bZblioy/zHnKyjagd0ejM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMpx4Shc; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724727520; x=1756263520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WfJUUDVtx9x3suQ9UzZSPSwb8qdMas+AphdNlS7Uy1Q=;
  b=SMpx4ShcDQ2YVIv1VCXTZ49niiIltN9OenV9+GImCRaFDhazz24KmPox
   SQclgtUFQPbTBnwR9VmDlHxqxfTuVMSvKq8mMdX7u7IAaHS5d4HITB4g9
   uEhZ7EvzKhhQYvGncCo2VRSRufEomoCwGq5xTyxU2E7FQdQ3dZ6k7FOw7
   gngf/YWtjzBuznOXIgkV6ux6+NSa96O5fSq930n+/MvOkySMCf1UYgSdt
   Wcn4qn2+cM1uT7WIt8vFA312F8VUPYSXX92V58oLuxRcLnFLh9HUlywqv
   ByhUO05DiJYCMNbPlnppqa6lf327eneUR5qOFhzjV9yJovA2+LuKCxBLm
   w==;
X-CSE-ConnectionGUID: ortNaTNxT1qb5Q/EYHUIcg==
X-CSE-MsgGUID: 9Kr6gp6kSJ6taUR5h22oaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="40654901"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="40654901"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 19:58:40 -0700
X-CSE-ConnectionGUID: +a3cr4TURiOItC/VkfYl5g==
X-CSE-MsgGUID: NK4zVyr2TdqSsB0mv4ROkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="93512984"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.43.235])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 19:58:36 -0700
From: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH v3 1/2] ACPICA: Detect FACS in reduced hardware build
Date: Tue, 27 Aug 2024 02:58:20 +0000
Message-ID: <20240827025821.2099068-2-jiaqing.zhao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827025821.2099068-1-jiaqing.zhao@linux.intel.com>
References: <20240827025821.2099068-1-jiaqing.zhao@linux.intel.com>
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

Link: https://github.com/acpica/acpica/commit/ee53ed6b5452612bb44af542b68d605f8b2b1104
Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
---
 drivers/acpi/acpica/acglobal.h |  6 +-----
 drivers/acpi/acpica/tbutils.c  |  2 --
 drivers/acpi/acpica/utxfinit.c | 24 ++++++++++++------------
 include/acpi/acconfig.h        |  1 -
 4 files changed, 13 insertions(+), 20 deletions(-)

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
index 15fa68a5ea6e..dad7425fce3f 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -18,7 +18,6 @@ ACPI_MODULE_NAME("tbutils")
 static acpi_physical_address
 acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size);
 
-#if (!ACPI_REDUCED_HARDWARE)
 /*******************************************************************************
  *
  * FUNCTION:    acpi_tb_initialize_facs
@@ -56,7 +55,6 @@ acpi_status acpi_tb_initialize_facs(void)
 
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


