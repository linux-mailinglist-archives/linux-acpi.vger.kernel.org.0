Return-Path: <linux-acpi+bounces-6310-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF36390425A
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 19:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4E7281CBD
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 17:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5A454720;
	Tue, 11 Jun 2024 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cNvweMGG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74D850288;
	Tue, 11 Jun 2024 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126737; cv=none; b=rNCF59uIcM+UoliusPdXsjkkyStswdeIOKXRTFbJeVuju7CKOkFleWKzCnOFvZ9jKDsMN9HYDvlub2W3otkh35EQIhnI5QZKJk4fSJ3Lk5B+AcsDS87B8Pl22+CJ9QHyLeTlaGVNoQtjRuguzJ9I7RtZWjh2b+96fjupEHxiufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126737; c=relaxed/simple;
	bh=Ax+Gp/MznoP8ncT7MOItWpqVDlmCy0Tg6yCTbxEjpJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ca1tjlnrXv8+LryA9adBq0SWF/Ar0PiAloTuxMavKJ5VpA41E08DBhowa3pZldiREkRXvlw2DkonVeK4T1fiMBT/UyG5GxWhI/e23XlZF4ZQMuT29T9HYp2yztIYdonedu1bWrKkDwfneI0zWusx5s7EpbbRSgbXzseQaf6FrqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cNvweMGG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718126736; x=1749662736;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ax+Gp/MznoP8ncT7MOItWpqVDlmCy0Tg6yCTbxEjpJw=;
  b=cNvweMGGX4xsYWMqc27oap8dl0bR4Cyc5cJSUD1h1D7yeDkIhTI0QQmT
   hWnxA06dL44w1fRv0XWk+eFQVZHV9Wy5XRkWxC7HRpyW2nVkZW/aTTI6j
   VotTMlqa/jukphQ+wPIWKIjpCUBhzXI0pMqxGHIPiaiKoZKBcRYu+Gh6L
   lIxwKHhMRt/AyduDmL6wEF4xK5XkhymvO8rie251B0yhbngWYdZpmNxUZ
   q4tc5XJmN39E5VFQt87ghpFzc/ZAVbdImZMCdEPqPMBiNOIhBnajKDLTI
   LVLC2UcH0gf0MbqP7/cb+3bJw8RD/ktJD75pJRKXM23srkm15zMITKgQy
   A==;
X-CSE-ConnectionGUID: XD6paR1yT9GxGz+df82Txw==
X-CSE-MsgGUID: CZOrfa81TCynQ0oeV9jXhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="26255081"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="26255081"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 10:25:35 -0700
X-CSE-ConnectionGUID: pz7D09vgT96Knz/m7OZ71w==
X-CSE-MsgGUID: RiEpF7grThmC/ONuyoCzZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="39360864"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 10:25:35 -0700
From: Tony Luck <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v6 41/49 RESEND] ACPI: x86: Switch to new Intel CPU model defines
Date: Tue, 11 Jun 2024 10:25:28 -0700
Message-ID: <20240611172528.352782-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---

Rafael: I missed this one when picking out ACPI/pm patches to send
to you from the patch bomb. Can you check it over and apply please?

-Tony

 drivers/acpi/x86/utils.c | 44 ++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 7dca73417e2b..e628d969d613 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -45,37 +45,37 @@ struct override_status_id {
 	unsigned long long status;
 };
 
-#define ENTRY(status, hid, uid, path, cpu_model, dmi...) {		\
+#define ENTRY(status, hid, uid, path, cpu_vfm, dmi...) {		\
 	{ { hid, }, {} },						\
-	{ X86_MATCH_INTEL_FAM6_MODEL(cpu_model, NULL), {} },		\
+	{ X86_MATCH_VFM(cpu_vfm, NULL), {} },				\
 	{ { .matches = dmi }, {} },					\
 	uid,								\
 	path,								\
 	status,								\
 }
 
-#define PRESENT_ENTRY_HID(hid, uid, cpu_model, dmi...) \
-	ENTRY(ACPI_STA_DEFAULT, hid, uid, NULL, cpu_model, dmi)
+#define PRESENT_ENTRY_HID(hid, uid, cpu_vfm, dmi...) \
+	ENTRY(ACPI_STA_DEFAULT, hid, uid, NULL, cpu_vfm, dmi)
 
-#define NOT_PRESENT_ENTRY_HID(hid, uid, cpu_model, dmi...) \
-	ENTRY(0, hid, uid, NULL, cpu_model, dmi)
+#define NOT_PRESENT_ENTRY_HID(hid, uid, cpu_vfm, dmi...) \
+	ENTRY(0, hid, uid, NULL, cpu_vfm, dmi)
 
-#define PRESENT_ENTRY_PATH(path, cpu_model, dmi...) \
-	ENTRY(ACPI_STA_DEFAULT, "", NULL, path, cpu_model, dmi)
+#define PRESENT_ENTRY_PATH(path, cpu_vfm, dmi...) \
+	ENTRY(ACPI_STA_DEFAULT, "", NULL, path, cpu_vfm, dmi)
 
-#define NOT_PRESENT_ENTRY_PATH(path, cpu_model, dmi...) \
-	ENTRY(0, "", NULL, path, cpu_model, dmi)
+#define NOT_PRESENT_ENTRY_PATH(path, cpu_vfm, dmi...) \
+	ENTRY(0, "", NULL, path, cpu_vfm, dmi)
 
 static const struct override_status_id override_status_ids[] = {
 	/*
 	 * Bay / Cherry Trail PWM directly poked by GPU driver in win10,
 	 * but Linux uses a separate PWM driver, harmless if not used.
 	 */
-	PRESENT_ENTRY_HID("80860F09", "1", ATOM_SILVERMONT, {}),
-	PRESENT_ENTRY_HID("80862288", "1", ATOM_AIRMONT, {}),
+	PRESENT_ENTRY_HID("80860F09", "1", INTEL_ATOM_SILVERMONT, {}),
+	PRESENT_ENTRY_HID("80862288", "1", INTEL_ATOM_AIRMONT, {}),
 
 	/* The Xiaomi Mi Pad 2 uses PWM2 for touchkeys backlight control */
-	PRESENT_ENTRY_HID("80862289", "2", ATOM_AIRMONT, {
+	PRESENT_ENTRY_HID("80862289", "2", INTEL_ATOM_AIRMONT, {
 		DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
 	      }),
@@ -84,18 +84,18 @@ static const struct override_status_id override_status_ids[] = {
 	 * The INT0002 device is necessary to clear wakeup interrupt sources
 	 * on Cherry Trail devices, without it we get nobody cared IRQ msgs.
 	 */
-	PRESENT_ENTRY_HID("INT0002", "1", ATOM_AIRMONT, {}),
+	PRESENT_ENTRY_HID("INT0002", "1", INTEL_ATOM_AIRMONT, {}),
 	/*
 	 * On the Dell Venue 11 Pro 7130 and 7139, the DSDT hides
 	 * the touchscreen ACPI device until a certain time
 	 * after _SB.PCI0.GFX0.LCD.LCD1._ON gets called has passed
 	 * *and* _STA has been called at least 3 times since.
 	 */
-	PRESENT_ENTRY_HID("SYNA7500", "1", HASWELL_L, {
+	PRESENT_ENTRY_HID("SYNA7500", "1", INTEL_HASWELL_L, {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7130"),
 	      }),
-	PRESENT_ENTRY_HID("SYNA7500", "1", HASWELL_L, {
+	PRESENT_ENTRY_HID("SYNA7500", "1", INTEL_HASWELL_L, {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7139"),
 	      }),
@@ -104,7 +104,7 @@ static const struct override_status_id override_status_ids[] = {
 	 * The Dell XPS 15 9550 has a SMO8110 accelerometer /
 	 * HDD freefall sensor which is wrongly marked as not present.
 	 */
-	PRESENT_ENTRY_HID("SMO8810", "1", SKYLAKE, {
+	PRESENT_ENTRY_HID("SMO8810", "1", INTEL_SKYLAKE, {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9550"),
 	      }),
@@ -121,19 +121,19 @@ static const struct override_status_id override_status_ids[] = {
 	 * was copy-pasted from the GPD win, so it has a disabled KIOX000A
 	 * node which we should not enable, thus we also check the BIOS date.
 	 */
-	PRESENT_ENTRY_HID("KIOX000A", "1", ATOM_AIRMONT, {
+	PRESENT_ENTRY_HID("KIOX000A", "1", INTEL_ATOM_AIRMONT, {
 		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
 		DMI_MATCH(DMI_BIOS_DATE, "02/21/2017")
 	      }),
-	PRESENT_ENTRY_HID("KIOX000A", "1", ATOM_AIRMONT, {
+	PRESENT_ENTRY_HID("KIOX000A", "1", INTEL_ATOM_AIRMONT, {
 		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
 		DMI_MATCH(DMI_BIOS_DATE, "03/20/2017")
 	      }),
-	PRESENT_ENTRY_HID("KIOX000A", "1", ATOM_AIRMONT, {
+	PRESENT_ENTRY_HID("KIOX000A", "1", INTEL_ATOM_AIRMONT, {
 		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
@@ -146,7 +146,7 @@ static const struct override_status_id override_status_ids[] = {
 	 * method sets a GPIO causing the PCI wifi card to turn off.
 	 * See above remark about uniqueness of the DMI match.
 	 */
-	NOT_PRESENT_ENTRY_PATH("\\_SB_.PCI0.SDHB.BRC1", ATOM_AIRMONT, {
+	NOT_PRESENT_ENTRY_PATH("\\_SB_.PCI0.SDHB.BRC1", INTEL_ATOM_AIRMONT, {
 		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
 		DMI_EXACT_MATCH(DMI_BOARD_SERIAL, "Default string"),
@@ -158,7 +158,7 @@ static const struct override_status_id override_status_ids[] = {
 	 * as both ACCL0001 and MAGN0001. As we can only ever register an
 	 * i2c client for one of them, ignore MAGN0001.
 	 */
-	NOT_PRESENT_ENTRY_HID("MAGN0001", "1", ATOM_SILVERMONT, {
+	NOT_PRESENT_ENTRY_HID("MAGN0001", "1", INTEL_ATOM_SILVERMONT, {
 		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 		DMI_MATCH(DMI_PRODUCT_FAMILY, "YOGATablet2"),
 	      }),
-- 
2.45.0


