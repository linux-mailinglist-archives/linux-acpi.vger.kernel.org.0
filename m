Return-Path: <linux-acpi+bounces-19618-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90204CC763E
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 12:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 611373099BD6
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 11:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6056338592;
	Wed, 17 Dec 2025 11:30:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6AA33A6F0;
	Wed, 17 Dec 2025 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765971027; cv=none; b=VYYQIPC1kUnwjTR69gimaXp6H5GFNm/XP1to5etZIqA6ZPe3RQrt8KQ0s7BOQe75p20URB7VFGdlnNyVkD+U0lUmiphtCgm5TYh06Gwz3ix1kieg6eXNzftAvt2gkYs6xz86p6NklaeWOPiHAS4gIUSyStJm9LWOQkBDh3JVJ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765971027; c=relaxed/simple;
	bh=+7P5h9Ik3p5S9iSC4ED70yu5zqLfW2d72BGeNbLmLd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJyKERhCSpFpg+Bj2S1wEkweAgw2el6vuhdVTWXk72nRrK19+mtXJZpYCoWdFI1kUFUShB0P2495xxPKVASVv3u67HzmGsRqTbfivzUyHFlac/DDLgN2MkXJ5CL72fQJ4qhM6Q4uYvMIjCFrrnJPU000Wj8mxpuVp395b7vpsrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A1DD1517;
	Wed, 17 Dec 2025 03:30:18 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D61B53F73B;
	Wed, 17 Dec 2025 03:30:23 -0800 (PST)
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
Subject: [PATCH 06/12] efi/cper: adopt estatus iteration helpers
Date: Wed, 17 Dec 2025 11:28:39 +0000
Message-ID: <20251217112845.1814119-7-ahmed.tiba@arm.com>
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

Switch the CPER printer and validator to the estatus_*() accessor
wrappers introduced by the new core. This is a mechanical change that
replaces the local acpi_hest_*() helpers with their aliases and keeps
the section iteration code shared ahead of the GHES conversion.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/firmware/efi/cper.c | 29 +++++++++++++-------------
 include/acpi/ghes.h         | 41 ++-----------------------------------
 2 files changed, 17 insertions(+), 53 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 0232bd040f61..07119940486a 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -26,6 +26,7 @@
 #include <acpi/ghes.h>
 #include <ras/ras_event.h>
 #include <cxl/event.h>
+#include <linux/estatus.h>
 
 /*
  * CPER record ID need to be unique even after reboot, because record
@@ -525,7 +526,7 @@ static void cper_print_fw_err(const char *pfx,
 			      struct acpi_hest_generic_data *gdata,
 			      const struct cper_sec_fw_err_rec_ref *fw_err)
 {
-	void *buf = acpi_hest_get_payload(gdata);
+	void *buf = estatus_get_payload(gdata);
 	u32 offset, length = gdata->error_data_length;
 
 	printk("%s""Firmware Error Record Type: %s\n", pfx,
@@ -607,7 +608,7 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 	__u16 severity;
 	char newpfx[64];
 
-	if (acpi_hest_get_version(gdata) >= 3)
+	if (estatus_get_version(gdata) >= 3)
 		cper_print_tstamp(pfx, (struct acpi_hest_generic_data_v300 *)gdata);
 
 	severity = gdata->error_severity;
@@ -628,7 +629,7 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 	}
 
 	if (guid_equal(sec_type, &CPER_SEC_PROC_GENERIC)) {
-		struct cper_sec_proc_generic *proc_err = acpi_hest_get_payload(gdata);
+		struct cper_sec_proc_generic *proc_err = estatus_get_payload(gdata);
 
 		printk("%s""section_type: general processor error\n", newpfx);
 		if (gdata->error_data_length >= sizeof(*proc_err))
@@ -636,7 +637,7 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 		else
 			goto err_section_too_small;
 	} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
-		struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
+		struct cper_sec_mem_err *mem_err = estatus_get_payload(gdata);
 
 		printk("%s""section_type: memory error\n", newpfx);
 		if (gdata->error_data_length >=
@@ -646,7 +647,7 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 		else
 			goto err_section_too_small;
 	} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
-		struct cper_sec_pcie *pcie = acpi_hest_get_payload(gdata);
+		struct cper_sec_pcie *pcie = estatus_get_payload(gdata);
 
 		printk("%s""section_type: PCIe error\n", newpfx);
 		if (gdata->error_data_length >= sizeof(*pcie))
@@ -655,7 +656,7 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 			goto err_section_too_small;
 #if defined(CONFIG_ARM64) || defined(CONFIG_ARM)
 	} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-		struct cper_sec_proc_arm *arm_err = acpi_hest_get_payload(gdata);
+		struct cper_sec_proc_arm *arm_err = estatus_get_payload(gdata);
 
 		printk("%ssection_type: ARM processor error\n", newpfx);
 		if (gdata->error_data_length >= sizeof(*arm_err))
@@ -665,7 +666,7 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 #endif
 #if defined(CONFIG_UEFI_CPER_X86)
 	} else if (guid_equal(sec_type, &CPER_SEC_PROC_IA)) {
-		struct cper_sec_proc_ia *ia_err = acpi_hest_get_payload(gdata);
+		struct cper_sec_proc_ia *ia_err = estatus_get_payload(gdata);
 
 		printk("%ssection_type: IA32/X64 processor error\n", newpfx);
 		if (gdata->error_data_length >= sizeof(*ia_err))
@@ -674,7 +675,7 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 			goto err_section_too_small;
 #endif
 	} else if (guid_equal(sec_type, &CPER_SEC_FW_ERR_REC_REF)) {
-		struct cper_sec_fw_err_rec_ref *fw_err = acpi_hest_get_payload(gdata);
+		struct cper_sec_fw_err_rec_ref *fw_err = estatus_get_payload(gdata);
 
 		printk("%ssection_type: Firmware Error Record Reference\n",
 		       newpfx);
@@ -684,7 +685,7 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 		else
 			goto err_section_too_small;
 	} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
-		struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
+		struct cxl_cper_sec_prot_err *prot_err = estatus_get_payload(gdata);
 
 		printk("%ssection_type: CXL Protocol Error\n", newpfx);
 		if (gdata->error_data_length >= sizeof(*prot_err))
@@ -692,7 +693,7 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 		else
 			goto err_section_too_small;
 	} else {
-		const void *err = acpi_hest_get_payload(gdata);
+		const void *err = estatus_get_payload(gdata);
 
 		printk("%ssection type: unknown, %pUl\n", newpfx, sec_type);
 		printk("%ssection length: %#x\n", newpfx,
@@ -723,7 +724,7 @@ void cper_estatus_print(const char *pfx,
 	printk("%s""event severity: %s\n", pfx, cper_severity_str(severity));
 	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
 
-	apei_estatus_for_each_section(estatus, gdata) {
+	estatus_for_each_section(estatus, gdata) {
 		cper_estatus_print_section(newpfx, gdata, sec_no);
 		sec_no++;
 	}
@@ -755,11 +756,11 @@ int cper_estatus_check(const struct acpi_hest_generic_status *estatus)
 
 	data_len = estatus->data_length;
 
-	apei_estatus_for_each_section(estatus, gdata) {
-		if (acpi_hest_get_size(gdata) > data_len)
+	estatus_for_each_section(estatus, gdata) {
+		if (estatus_get_size(gdata) > data_len)
 			return -EINVAL;
 
-		record_size = acpi_hest_get_record_size(gdata);
+		record_size = estatus_get_record_size(gdata);
 		if (record_size > data_len)
 			return -EINVAL;
 
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index ebd21b05fe6e..022c0325f1e0 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -4,6 +4,7 @@
 
 #include <acpi/apei.h>
 #include <acpi/hed.h>
+#include <linux/estatus.h>
 
 /*
  * One struct ghes is created for each generic hardware error source.
@@ -80,46 +81,8 @@ static inline void ghes_estatus_pool_region_free(unsigned long addr, u32 size) {
 
 int ghes_estatus_pool_init(unsigned int num_ghes);
 
-static inline int acpi_hest_get_version(struct acpi_hest_generic_data *gdata)
-{
-	return gdata->revision >> 8;
-}
-
-static inline void *acpi_hest_get_payload(struct acpi_hest_generic_data *gdata)
-{
-	if (acpi_hest_get_version(gdata) >= 3)
-		return (void *)(((struct acpi_hest_generic_data_v300 *)(gdata)) + 1);
-
-	return gdata + 1;
-}
-
-static inline int acpi_hest_get_error_length(struct acpi_hest_generic_data *gdata)
-{
-	return ((struct acpi_hest_generic_data *)(gdata))->error_data_length;
-}
-
-static inline int acpi_hest_get_size(struct acpi_hest_generic_data *gdata)
-{
-	if (acpi_hest_get_version(gdata) >= 3)
-		return sizeof(struct acpi_hest_generic_data_v300);
-
-	return sizeof(struct acpi_hest_generic_data);
-}
-
-static inline int acpi_hest_get_record_size(struct acpi_hest_generic_data *gdata)
-{
-	return (acpi_hest_get_size(gdata) + acpi_hest_get_error_length(gdata));
-}
-
-static inline void *acpi_hest_get_next(struct acpi_hest_generic_data *gdata)
-{
-	return (void *)(gdata) + acpi_hest_get_record_size(gdata);
-}
-
 #define apei_estatus_for_each_section(estatus, section)			\
-	for (section = (struct acpi_hest_generic_data *)(estatus + 1);	\
-	     (void *)section - (void *)(estatus + 1) < estatus->data_length; \
-	     section = acpi_hest_get_next(section))
+	estatus_for_each_section(estatus, section)
 
 #ifdef CONFIG_ACPI_APEI_SEA
 int ghes_notify_sea(void);
-- 
2.43.0


