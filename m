Return-Path: <linux-acpi+bounces-19619-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E22E4CC7614
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 12:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8204B3045C14
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 11:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65712F12D4;
	Wed, 17 Dec 2025 11:30:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD63229C321;
	Wed, 17 Dec 2025 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765971045; cv=none; b=Z/ic3+lm89jK5L4fMt0R5vKLpzann8QfvvrCYQced1kRKXZTW4iQtjt6dhFpvxalRkBM/r5xS3KNKDfFLSh6bJhOidDF6dy5TYMNsBzCn3B/xiGjJf4WM5JXHmMwJLcotylVuezCmMWpMSHTAIyTedckmxdJbj3UnQ35XNDteRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765971045; c=relaxed/simple;
	bh=YpxkTOy+AqLe8aTEE2gMmsU+mUocDmb2PBt8J/OmNkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aw7NVvy/6ODg75vYehJkuFzpNteO+PmK9N1D9sYF5CJhSiK8S6LSu9i5+vHBAOZ6QXXz7JPwMSyN8zbGIeH0Zh5hK8BotLgtmUEJeIq/iqGFsD5y5gU4gqDgsDSdjnLc9/MYeltThCKnRx5yaaOQRkSpIzP/ZNuLec8kCXatZb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 043F31684;
	Wed, 17 Dec 2025 03:30:36 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A6B83F73B;
	Wed, 17 Dec 2025 03:30:41 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
To: linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: tony.luck@intel.com,
	bp@alien8.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	linux-doc@vger.kernel.org,
	Dmitry.Lamerov@arm.com,
	Michael.Zhao2@arm.com,
	ahmed.tiba@arm.com
Subject: [PATCH 07/12] ghes: prepare estatus hooks for shared handling
Date: Wed, 17 Dec 2025 11:28:40 +0000
Message-ID: <20251217112845.1814119-8-ahmed.tiba@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217112845.1814119-1-ahmed.tiba@arm.com>
References: <20251217112845.1814119-1-ahmed.tiba@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce struct estatus_source inside struct ghes and export thin
wrappers around the existing GHES estatus helpers. These helpers are
not ACPI-specific, so moving them behind a common interface is the
first step toward reusing the logic for other firmware providers.
Behaviour stays the same for GHES in this patch.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/acpi/apei/Kconfig      |  1 +
 drivers/firmware/efi/estatus.c |  3 +--
 include/acpi/ghes.h            | 17 +++++++++++++----
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 070c07d68dfb..90cb8360988b 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -24,6 +24,7 @@ config ACPI_APEI_GHES
 	select IRQ_WORK
 	select GENERIC_ALLOCATOR
 	select ARM_SDE_INTERFACE if ARM64
+	select RAS_ESTATUS_CORE
 	help
 	  Generic Hardware Error Source provides a way to report
 	  platform hardware errors (such as that from chipset). It
diff --git a/drivers/firmware/efi/estatus.c b/drivers/firmware/efi/estatus.c
index 8043d68f907b..259122730303 100644
--- a/drivers/firmware/efi/estatus.c
+++ b/drivers/firmware/efi/estatus.c
@@ -654,9 +654,8 @@ static bool estatus_handle_arm_hw_error(estatus_generic_data *gdata, int sev, bo
 	int sec_sev, i;
 	char *p;
 
-	log_arm_hw_error(err);
-
 	sec_sev = estatus_severity(gdata->error_severity);
+	log_arm_hw_error(err, sec_sev);
 	if (sev != ESTATUS_SEV_RECOVERABLE || sec_sev != ESTATUS_SEV_RECOVERABLE)
 		return false;
 
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 022c0325f1e0..7dc6acde3e2e 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -5,6 +5,7 @@
 #include <acpi/apei.h>
 #include <acpi/hed.h>
 #include <linux/estatus.h>
+#include <linux/notifier.h>
 
 /*
  * One struct ghes is created for each generic hardware error source.
@@ -22,6 +23,7 @@ struct ghes {
 		struct acpi_hest_generic_v2 *generic_v2;
 	};
 	struct acpi_hest_generic_status *estatus;
+	struct estatus_source estatus_src;
 	unsigned long flags;
 	union {
 		struct list_head list;
@@ -30,6 +32,7 @@ struct ghes {
 	};
 	struct device *dev;
 	struct list_head elist;
+	char name[32];
 };
 
 struct ghes_estatus_node {
@@ -47,10 +50,10 @@ struct ghes_estatus_cache {
 };
 
 enum {
-	GHES_SEV_NO = 0x0,
-	GHES_SEV_CORRECTED = 0x1,
-	GHES_SEV_RECOVERABLE = 0x2,
-	GHES_SEV_PANIC = 0x3,
+	GHES_SEV_NO = ESTATUS_SEV_NO,
+	GHES_SEV_CORRECTED = ESTATUS_SEV_CORRECTED,
+	GHES_SEV_RECOVERABLE = ESTATUS_SEV_RECOVERABLE,
+	GHES_SEV_PANIC = ESTATUS_SEV_PANIC,
 };
 
 #ifdef CONFIG_ACPI_APEI_GHES
@@ -73,6 +76,12 @@ void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
 struct list_head *ghes_get_devices(void);
 
 void ghes_estatus_pool_region_free(unsigned long addr, u32 size);
+int ghes_register_vendor_record_notifier(struct notifier_block *nb);
+void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
+void ghes_register_report_chain(struct notifier_block *nb);
+void ghes_unregister_report_chain(struct notifier_block *nb);
+
+void estatus_pool_region_free(unsigned long addr, u32 size);
 #else
 static inline struct list_head *ghes_get_devices(void) { return NULL; }
 
-- 
2.43.0


