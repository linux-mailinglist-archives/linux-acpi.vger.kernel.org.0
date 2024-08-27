Return-Path: <linux-acpi+bounces-7853-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFD395FF76
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 04:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9083E1C21FA2
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 02:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ED7175BF;
	Tue, 27 Aug 2024 02:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AIi3QoE+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C028684;
	Tue, 27 Aug 2024 02:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727533; cv=none; b=bgMdUbr81tqOON1Y1k6rFqVgb5wpsYE745f0VkrHYJR4jWOc8b3ef/l0u0o2/zbTrEgGHqApY97FYm9bekUFHmfnIWoMZVCbCJT2fyTQreuLzzcO65wfI2qboZIEWyweDz70J8b8JsZPQDkg+f5o3v9dDuzmh8xiW5POV4t1+G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727533; c=relaxed/simple;
	bh=crxt8dmFsPgKdyP6mbp9TYJDYR3hAaakUYEXKMWUPYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4KY9xsBaxksG3e8UUXf7ZhSyozRnyzCvtMALzDqVgBZSkLfQe60tlgNJAbjq8K4bqQm75UedyJwbldoWgL2lA+BO1tWszk+RdQp57vK8cny+lK2nbXAsYq0y+85PnVQ7FGo5q6JwoccfYIKRu5pu/J9SzBlIOlAJPQpvnvi6HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AIi3QoE+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724727532; x=1756263532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=crxt8dmFsPgKdyP6mbp9TYJDYR3hAaakUYEXKMWUPYs=;
  b=AIi3QoE+HnY6RVxSLRUSNWQSVA74V92JlH2PNAYjLNUFnq3R8Ad1j2Lz
   QezLf+8e3QFZiTe4pZPBeSOIW/NV3eVwLJiOAQFjL5oor+6xnus4I8N0Y
   FdLHLZLRKJQ1XAWKyryT5+rrNsDcd7Fk1CaObf4BP7mVndv1SsMJwYFBY
   tgcpRy6p9vnWsYExnp7Qwng/HGUeHP9ssb9PpN15Mt1FGI88Ox+ZA+qxi
   S+WdoLzufqf/9jEHTf3xf00yLB3Z2Z7ykCavug0leVmdtoivHE0RquIQu
   ZlFTMiHoKUsfB7d/pK82PSwKc6+opDavkPjAnxeQoHTcR7EvRvWUR/p7f
   Q==;
X-CSE-ConnectionGUID: Z4kmO4UiT2Gmoy/PPykD/A==
X-CSE-MsgGUID: XxudvORoTGSDMLowOTgwfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="40654908"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="40654908"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 19:58:43 -0700
X-CSE-ConnectionGUID: kXG9+WoHTa6uqmBk1r9sgw==
X-CSE-MsgGUID: DThzFemyRHKivmG6zTAoDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="93512996"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.43.235])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 19:58:38 -0700
From: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH v3 2/2] ACPICA: Allow setting waking vector on reduced hardware platforms
Date: Tue, 27 Aug 2024 02:58:21 +0000
Message-ID: <20240827025821.2099068-3-jiaqing.zhao@linux.intel.com>
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


