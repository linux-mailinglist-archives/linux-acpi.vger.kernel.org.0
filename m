Return-Path: <linux-acpi+bounces-7277-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2546894750E
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 08:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D565428140F
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 06:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A519148FE3;
	Mon,  5 Aug 2024 06:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mEtV1RFs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F66145B2C;
	Mon,  5 Aug 2024 06:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722838127; cv=none; b=GI5+/8EzO3o85/YdQGb03ZFdxVuK4JUPhNURjU6bbJPnQXf5HU3GMeEe2PVGZW2hoiyxJdopVuaoqYDv8UM739wgrdxYrN4wNGDmHktd4XPwoDChjzrvr36vpFhHLgAVNCHO8bdiXxcPxElcw4amYshYo0l6AmBLp8Otfd7uUsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722838127; c=relaxed/simple;
	bh=MGahE53/xciKSDi5AfqYOyKwYWzKT+vXGLdiEURlXFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tnnav9mOxJBFUaYujHC+L+9Axv8+OUOykpysCdHgjSzaui0+afNeDlQXRMGEOcZJVRzLOuNR1d5iTGhuhwZe4x33T+Gqc0aC7nD56xBCUlGSVCCqfvKDwjz/4PMUMBiFls8H+6XMJJTRhOErAGFDPfDqORct1UMuyLi29V2Pjnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mEtV1RFs; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722838126; x=1754374126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MGahE53/xciKSDi5AfqYOyKwYWzKT+vXGLdiEURlXFg=;
  b=mEtV1RFsxAw8CxAm4vBRjE6ErZCqD3ekus2t+7K0uNWbVZLSbW9XwUO4
   AE5nHhaf+I+xeveHy2ZPD1LwTYbm8LbwfgcSByUKv+6bUy+7tE71EDLJh
   sFD/cXJ1XhNwIf3gnn3Y32PPVqI9l0yZtq+PCF9IUSm/70FPK336BWPa1
   M0VimBCkrwtIxC24gA4U7YCtUcJav0aOhza5HCYUc14y0eoQT1sqOi/Sb
   6s3WhfumKb/4bJ9QWiCifPBb4PhCmcXrRXsJz2+xWD7OHJI+oEzdSg9Xl
   l6R+xbqpUUE+jk8v9GdkPN8Mwd6Fk/kmTW9z8tAO0/OfvokpD+3h4X6kC
   Q==;
X-CSE-ConnectionGUID: Owyo2DQiTlS8lH+EhDEr/g==
X-CSE-MsgGUID: U7+XzWdeQSylxc+Q46m8EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="31360138"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="31360138"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 23:08:45 -0700
X-CSE-ConnectionGUID: 1dUzj8iCREy30I467iieQQ==
X-CSE-MsgGUID: Rg46K8n+TTKsTzVXcwE7Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="61028957"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.43.235])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 23:08:43 -0700
From: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH 2/2] ACPICA: Allow setting waking vector in reduced hardware model
Date: Mon,  5 Aug 2024 06:08:13 +0000
Message-ID: <20240805060812.1002004-4-jiaqing.zhao@linux.intel.com>
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

Allow setting waking vector in FACS table on hardware-reduced
platforms to support S3 wakeup on such platform.

Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
---
 drivers/acpi/acpica/hwxfsleep.c | 21 ++++++---------------
 include/acpi/acpixf.h           |  8 ++++----
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index 36ea48f64110..1bf7520a0b18 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -15,21 +15,6 @@
 #define _COMPONENT          ACPI_HARDWARE
 ACPI_MODULE_NAME("hwxfsleep")
 
-/* Local prototypes */
-#if (!ACPI_REDUCED_HARDWARE)
-static acpi_status
-acpi_hw_set_firmware_waking_vector(struct acpi_table_facs *facs,
-				   acpi_physical_address physical_address,
-				   acpi_physical_address physical_address64);
-#endif
-
-/*
- * These functions are removed for the ACPI_REDUCED_HARDWARE case:
- *      acpi_set_firmware_waking_vector
- *      acpi_enter_sleep_state_s4bios
- */
-
-#if (!ACPI_REDUCED_HARDWARE)
 /*******************************************************************************
  *
  * FUNCTION:    acpi_hw_set_firmware_waking_vector
@@ -115,6 +100,12 @@ acpi_set_firmware_waking_vector(acpi_physical_address physical_address,
 
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


