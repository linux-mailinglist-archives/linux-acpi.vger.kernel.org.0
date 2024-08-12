Return-Path: <linux-acpi+bounces-7528-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA98C94E641
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 07:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A3A1F2248B
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 05:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234ED1509A2;
	Mon, 12 Aug 2024 05:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VeB5K6rd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C0514F131;
	Mon, 12 Aug 2024 05:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723441627; cv=none; b=GQyEbBXpzYjoX5N9j9+McBjEB6qhSVFa1jSsjVhSUBlhCtWounEhyDV4vljNUHQh0J9zubuEhyN9MlF3Rbvs9VmvuhsjKZnT7+KFAqCgyRAgE/CH55XBdtAW2OLN9g9u0MKyEN/Q57N1z+rx4Q6nVuxI0TwLf8J6CqS2dNARReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723441627; c=relaxed/simple;
	bh=crxt8dmFsPgKdyP6mbp9TYJDYR3hAaakUYEXKMWUPYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvytrtZhRQlcICZjJT4azpShJ21H8VdWjFlwsitn90VfGtFqzrKBhzO9rf3aLa40kWE0rmrA1KgM22jUjYFJnrIPDkXWm/KF61DY08pV6xifqWkiUjMS7XE3rcezbB+dRVh+4BYjvBMCip7c8+VSv0Ur/P/MCVM+2bBRTmP/S7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VeB5K6rd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723441625; x=1754977625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=crxt8dmFsPgKdyP6mbp9TYJDYR3hAaakUYEXKMWUPYs=;
  b=VeB5K6rdyxSvyshQv+lKh8ZiMwqMveXsqMjtkQf7TWPpRL5TCDqeKd07
   db7HU9fj219rdbBBVhpZeRyTkCUPCi6Iiw4vUBf8uKl1g2oPthvk1uHPG
   x8wQHmqYPQakSqnipm7dXM6X7DGjaXaziWlgo+Y1uZ5YvFORFR6EbgbrZ
   0YcF96qKWQ3SCK8kK1iVKNs7gmJwMyBbd6Q4KbIi5b79zpsRUo/jjb7X+
   BB3m6bS7GqrrE2bad4+Tb7E9ykYQOtnU0l5gOjPFh4Bu0P1z5M7b1Tn70
   GKIPtGyvB/pmW5+f+UISy9jBd6r3qHWsTGWdDk8tMiv7bWdTzj/0AJhta
   w==;
X-CSE-ConnectionGUID: efK0C0z1TEKcxDeyBhnx8g==
X-CSE-MsgGUID: IA2e+s+vRsOv7necLaKR/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="32925984"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="32925984"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 22:47:05 -0700
X-CSE-ConnectionGUID: 594OI087SbmGbFCAPMeIUw==
X-CSE-MsgGUID: mvthOu9nR56r9wcOzd9XlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="57800736"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.43.235])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 22:47:03 -0700
From: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH v2 2/2] ACPICA: Allow setting waking vector on reduced hardware platforms
Date: Mon, 12 Aug 2024 05:46:47 +0000
Message-ID: <20240812054647.1194716-3-jiaqing.zhao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812054647.1194716-1-jiaqing.zhao@linux.intel.com>
References: <20240812054647.1194716-1-jiaqing.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow setting waking vector in FACS table on reduced hardware platforms
to support S3 wakeup.

Link: https://github.com/acpica/acpica/commit/ee53ed6b5452612bb44af542b68d605f8b2b1104
Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
---
 drivers/acpi/acpica/hwxfsleep.c | 15 ++++++---------
 include/acpi/acpixf.h           |  8 ++++----
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index 36ea48f64110..8dbf83aeb455 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -16,20 +16,11 @@
 ACPI_MODULE_NAME("hwxfsleep")
 
 /* Local prototypes */
-#if (!ACPI_REDUCED_HARDWARE)
 static acpi_status
 acpi_hw_set_firmware_waking_vector(struct acpi_table_facs *facs,
 				   acpi_physical_address physical_address,
 				   acpi_physical_address physical_address64);
-#endif
-
-/*
- * These functions are removed for the ACPI_REDUCED_HARDWARE case:
- *      acpi_set_firmware_waking_vector
- *      acpi_enter_sleep_state_s4bios
- */
 
-#if (!ACPI_REDUCED_HARDWARE)
 /*******************************************************************************
  *
  * FUNCTION:    acpi_hw_set_firmware_waking_vector
@@ -115,6 +106,12 @@ acpi_set_firmware_waking_vector(acpi_physical_address physical_address,
 
 ACPI_EXPORT_SYMBOL(acpi_set_firmware_waking_vector)
 
+/*
+ * These functions are removed for the ACPI_REDUCED_HARDWARE case:
+ *      acpi_enter_sleep_state_s4bios
+ */
+
+#if (!ACPI_REDUCED_HARDWARE)
 /*******************************************************************************
  *
  * FUNCTION:    acpi_enter_sleep_state_s4bios
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 80dc36f9d527..99bb45a46600 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -881,10 +881,10 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_leave_sleep_state_prep(u8 sleep_state))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status acpi_leave_sleep_state(u8 sleep_state))
 
-ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				acpi_set_firmware_waking_vector
-				(acpi_physical_address physical_address,
-				 acpi_physical_address physical_address64))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status
+			    acpi_set_firmware_waking_vector
+			    (acpi_physical_address physical_address,
+			     acpi_physical_address physical_address64))
 /*
  * ACPI Timer interfaces
  */
-- 
2.43.0


