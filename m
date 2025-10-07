Return-Path: <linux-acpi+bounces-17642-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1ABBC1014
	for <lists+linux-acpi@lfdr.de>; Tue, 07 Oct 2025 12:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B0F6634E156
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Oct 2025 10:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810932D7DCF;
	Tue,  7 Oct 2025 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wv1pIsMO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA81B264609
	for <linux-acpi@vger.kernel.org>; Tue,  7 Oct 2025 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832675; cv=none; b=pPtRD1Oq8DITw9CwUntReVmBhMGDOhVvUAHR2FJvbbEjMilFgPYe0QWD/aGjyjt0WR0tUE+VQfqU25FL9jlcCSGdPGpDnKPEcTl9iJc3hD2eX0M/e5gUm7WIlsbNBJd1df+rvxKGRfalG2dN/cBWyQIW6cUNSUCCMCOHsvhLvEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832675; c=relaxed/simple;
	bh=M0PQxdD4kfBrpf+fDO5XPNx6IK/CL88IBi3LScANzSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=auVe/JtsoiLFAImM2LiyQXw4ZGTEvANE+GcKs9dtZVWUoegNHHgky/+TXUgsEC0+RGjpWg9+PEQ7s4RnsTEGD3Au+YCj44Yc+Bozxvw8oyzRoiZh9sKooILOTBOsZ92T4O7WSBSh6/Ncx5c3XR+iZTHMOZacyxDVMaEF1lnlO/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wv1pIsMO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759832674; x=1791368674;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M0PQxdD4kfBrpf+fDO5XPNx6IK/CL88IBi3LScANzSU=;
  b=Wv1pIsMOMS82rF6uqxEiEa/NMnm8yTzL1+5LgVYWw2YpVr3dOgOxG3jl
   Yl4P2fHmwxPDx6tDoGCoeYvIoeuDoowkDs3IA5v+fbAzUk60zf/YYsYTG
   I88jAnaXt5OpeGg6Y36QpFAGefaPU/gjMBh9ov1Ly+yoXvs+h9VFyWf7o
   rgwpKZ4XUn8pmXEenNRLWBQWri0elsPcwqdMo8znYDzRWCvc9FEWfQYyf
   9Sy5JDwmRsYI2fmlQwOdH0MayPs7Jzv3z/RoQex96vhn/fI/VNxjIdzCS
   F9HHRnuIWvq9nQpViPF5E+VlorzVb5xY0HKkTTlXo+jihHQDuwqRQJ4g8
   w==;
X-CSE-ConnectionGUID: wHgFOstxTEG5WSvolIVP1Q==
X-CSE-MsgGUID: OA63hwpqQyCE0FI/v78LAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65841920"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65841920"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 03:24:32 -0700
X-CSE-ConnectionGUID: WGwRBoJZRmaKLNrxdkdgVQ==
X-CSE-MsgGUID: oEqJ/SlqT8WhoOptrxq42g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="180046970"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa006.fm.intel.com with ESMTP; 07 Oct 2025 03:24:31 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] ACPI: mrrm: Fix memory leaks and improve error handling
Date: Tue,  7 Oct 2025 15:52:37 +0530
Message-Id: <20251007102237.1015610-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add proper error handling and resource cleanup to prevent memory leaks
in add_boot_memory_ranges(). The function now checks for NULL return
from kobject_create_and_add(), frees allocated names after use, and
implements a cleanup path that removes previously created sysfs groups
and kobjects on failure.

This prevents resource leaks when kobject creation or sysfs group
creation fails during boot memory range initialization.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/acpi/acpi_mrrm.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
index 47ea3ccc2142..6ec42eb48783 100644
--- a/drivers/acpi/acpi_mrrm.c
+++ b/drivers/acpi/acpi_mrrm.c
@@ -152,23 +152,48 @@ static __init int add_boot_memory_ranges(void)
 	struct kobject *pkobj, *kobj;
 	int ret = -EINVAL;
 	char *name;
+	int i;
 
 	pkobj = kobject_create_and_add("memory_ranges", acpi_kobj);
+	if (!pkobj)
+		return -ENOMEM;
 
-	for (int i = 0; i < mrrm_mem_entry_num; i++) {
+	for (i = 0; i < mrrm_mem_entry_num; i++) {
 		name = kasprintf(GFP_KERNEL, "range%d", i);
 		if (!name) {
 			ret = -ENOMEM;
-			break;
+			goto cleanup;
 		}
 
 		kobj = kobject_create_and_add(name, pkobj);
+		kfree(name);
+		if (!kobj) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
 
 		ret = sysfs_create_groups(kobj, memory_range_groups);
-		if (ret)
-			return ret;
+		if (ret) {
+			kobject_put(kobj);
+			goto cleanup;
+		}
 	}
 
+	return 0;
+
+cleanup:
+	for (int j = 0; j < i; j++) {
+		char cleanup_name[32];
+		struct kobject *cleanup_kobj;
+
+		snprintf(cleanup_name, sizeof(cleanup_name), "range%d", j);
+		cleanup_kobj = kobject_get(pkobj);
+		if (cleanup_kobj) {
+			sysfs_remove_groups(cleanup_kobj, memory_range_groups);
+			kobject_put(cleanup_kobj);
+		}
+	}
+	kobject_put(pkobj);
 	return ret;
 }
 
-- 
2.34.1


