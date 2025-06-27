Return-Path: <linux-acpi+bounces-14788-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A26CAEBF52
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 20:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4F71738C4
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 18:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F041EA7CF;
	Fri, 27 Jun 2025 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITe48UYA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B498D4502A;
	Fri, 27 Jun 2025 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751050524; cv=none; b=cigf9NTuAy0ETZW92zCP4FDhepTw9k7M7zYqgk6ogAMYOQOBv0gQRwu5Cf4SMjI8JNwLbVRvxcRJY3y70sDgwSurP+EIcXmNtOTDcMhQ9Xz2zFbRdbVWbrEaTcHQGR+beckjOXzBBnyQDG+EC5tqz3X8kkNZ+IF3FD4lqvfcM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751050524; c=relaxed/simple;
	bh=oLWn1hEhrRA2WOirLALuOWE0n+F+Fa0VRES5IX5m308=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HwJtk4cFcr5jeGyLCBHXsTsPZTPAO06NXWcCRIL+dLO/PK7DoR8fIzPkXsDwW9fRzUaVLjtHKYH7Amp1Gz7Rvxd8IqczYDC7cRqeuohzyETK0l5wv2wvRdzqnDkVoMLc/d+yz0ggN7VWgpT9bdw16ZO23G6o/qpY5Cs8mafZQGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITe48UYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06724C4CEE3;
	Fri, 27 Jun 2025 18:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751050524;
	bh=oLWn1hEhrRA2WOirLALuOWE0n+F+Fa0VRES5IX5m308=;
	h=Date:From:To:Cc:Subject:From;
	b=ITe48UYA92zBNkBJfGQsrXBEKkIEHsqlCinbEoCqQJqUmEY7MUUVDFYkcdPZNNFLo
	 8rR4VNd1S66Tubi7HW+m3iVcjP05T28okzL2Fn+COdNDAfsEUrxHblgdlb35wYuBDT
	 6uAexZfNcerv2jEeQMldheuWuut9fq/bgII+rFydoEKLivOpKKCyrCmJDGFPnOuZrw
	 NXspkoZoNUjCSKCD8IdMPZOdIHFiRp32heUTvmgmQr7hZnZZGtKXvdAJY8NvuybAXy
	 MEDEo4AfW/iVClq9tpGS2oT2MehdkDj/sk59GUrRPvIJyRi2YKDURdsUAtInP/EauQ
	 2pwUnkWw3Yk6Q==
Date: Fri, 27 Jun 2025 12:55:19 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, Kees Cook <kees@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v5][for-next/hardening] acpi: nfit: intel: avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <aF7pF4kej8VQapyR@kspp>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the new TRAILING_OVERLAP() helper to fix a dozen instances of
the following type of warning:

drivers/acpi/nfit/intel.c:692:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Acked-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v5:
 - Fix union initialization. (Dan)
 - Leave trailing object indentation unchanged. (Kees)

Changes in v4:
 - Use the new TRAILING_OVERLAP() helper.
 - Link: https://lore.kernel.org/linux-hardening/aFxtOLs6Yv_uzgt4@kspp/

Changes in v3:
 - Use union instead of DEFINE_RAW_FLEX().
 - Link: https://lore.kernel.org/linux-hardening/aEneid7gdAZr1_kR@kspp/

Changes in v2:
 - Use DEFINE_RAW_FLEX() instead of __struct_group().
 - Link: https://lore.kernel.org/linux-hardening/Z-QpUcxFCRByYcTA@kspp/

v1:
 - Link: https://lore.kernel.org/linux-hardening/Z618ILbAR8YAvTkd@kspp/

 drivers/acpi/nfit/intel.c | 119 +++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 67 deletions(-)

diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
index 3902759abcba..bce6f6a18426 100644
--- a/drivers/acpi/nfit/intel.c
+++ b/drivers/acpi/nfit/intel.c
@@ -55,10 +55,9 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	unsigned long security_flags = 0;
-	struct {
-		struct nd_cmd_pkg pkg;
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
 		struct nd_intel_get_security_state cmd;
-	} nd_cmd = {
+	) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
 			.nd_family = NVDIMM_FAMILY_INTEL,
@@ -120,10 +119,9 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
 static int intel_security_freeze(struct nvdimm *nvdimm)
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-	struct {
-		struct nd_cmd_pkg pkg;
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
 		struct nd_intel_freeze_lock cmd;
-	} nd_cmd = {
+	) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_FREEZE_LOCK,
 			.nd_family = NVDIMM_FAMILY_INTEL,
@@ -153,10 +151,9 @@ static int intel_security_change_key(struct nvdimm *nvdimm,
 	unsigned int cmd = ptype == NVDIMM_MASTER ?
 		NVDIMM_INTEL_SET_MASTER_PASSPHRASE :
 		NVDIMM_INTEL_SET_PASSPHRASE;
-	struct {
-		struct nd_cmd_pkg pkg;
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
 		struct nd_intel_set_passphrase cmd;
-	} nd_cmd = {
+	) nd_cmd = {
 		.pkg = {
 			.nd_family = NVDIMM_FAMILY_INTEL,
 			.nd_size_in = ND_INTEL_PASSPHRASE_SIZE * 2,
@@ -195,10 +192,9 @@ static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
 		const struct nvdimm_key_data *key_data)
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-	struct {
-		struct nd_cmd_pkg pkg;
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
 		struct nd_intel_unlock_unit cmd;
-	} nd_cmd = {
+	) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_UNLOCK_UNIT,
 			.nd_family = NVDIMM_FAMILY_INTEL,
@@ -234,10 +230,9 @@ static int intel_security_disable(struct nvdimm *nvdimm,
 {
 	int rc;
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-	struct {
-		struct nd_cmd_pkg pkg;
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
 		struct nd_intel_disable_passphrase cmd;
-	} nd_cmd = {
+	) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_DISABLE_PASSPHRASE,
 			.nd_family = NVDIMM_FAMILY_INTEL,
@@ -277,10 +272,9 @@ static int __maybe_unused intel_security_erase(struct nvdimm *nvdimm,
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	unsigned int cmd = ptype == NVDIMM_MASTER ?
 		NVDIMM_INTEL_MASTER_SECURE_ERASE : NVDIMM_INTEL_SECURE_ERASE;
-	struct {
-		struct nd_cmd_pkg pkg;
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
 		struct nd_intel_secure_erase cmd;
-	} nd_cmd = {
+	) nd_cmd = {
 		.pkg = {
 			.nd_family = NVDIMM_FAMILY_INTEL,
 			.nd_size_in = ND_INTEL_PASSPHRASE_SIZE,
@@ -318,10 +312,9 @@ static int __maybe_unused intel_security_query_overwrite(struct nvdimm *nvdimm)
 {
 	int rc;
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-	struct {
-		struct nd_cmd_pkg pkg;
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
 		struct nd_intel_query_overwrite cmd;
-	} nd_cmd = {
+	) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_QUERY_OVERWRITE,
 			.nd_family = NVDIMM_FAMILY_INTEL,
@@ -354,10 +347,9 @@ static int __maybe_unused intel_security_overwrite(struct nvdimm *nvdimm,
 {
 	int rc;
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-	struct {
-		struct nd_cmd_pkg pkg;
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
 		struct nd_intel_overwrite cmd;
-	} nd_cmd = {
+	) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_OVERWRITE,
 			.nd_family = NVDIMM_FAMILY_INTEL,
@@ -407,10 +399,9 @@ const struct nvdimm_security_ops *intel_security_ops = &__intel_security_ops;
 static int intel_bus_fwa_businfo(struct nvdimm_bus_descriptor *nd_desc,
 		struct nd_intel_bus_fw_activate_businfo *info)
 {
-	struct {
-		struct nd_cmd_pkg pkg;
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
 		struct nd_intel_bus_fw_activate_businfo cmd;
-	} nd_cmd = {
+	) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE_BUSINFO,
 			.nd_family = NVDIMM_BUS_FAMILY_INTEL,
@@ -518,33 +509,31 @@ static enum nvdimm_fwa_capability intel_bus_fwa_capability(
 static int intel_bus_fwa_activate(struct nvdimm_bus_descriptor *nd_desc)
 {
 	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
-	struct {
-		struct nd_cmd_pkg pkg;
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
 		struct nd_intel_bus_fw_activate cmd;
-	} nd_cmd = {
-		.pkg = {
-			.nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE,
-			.nd_family = NVDIMM_BUS_FAMILY_INTEL,
-			.nd_size_in = sizeof(nd_cmd.cmd.iodev_state),
-			.nd_size_out =
-				sizeof(struct nd_intel_bus_fw_activate),
-			.nd_fw_size =
-				sizeof(struct nd_intel_bus_fw_activate),
-		},
+	) nd_cmd;
+	int rc;
+
+	nd_cmd.pkg = (struct nd_cmd_pkg) {
+		.nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE,
+		.nd_family = NVDIMM_BUS_FAMILY_INTEL,
+		.nd_size_in = sizeof(nd_cmd.cmd.iodev_state),
+		.nd_size_out =
+			sizeof(struct nd_intel_bus_fw_activate),
+		.nd_fw_size =
+			sizeof(struct nd_intel_bus_fw_activate),
+	};
+	nd_cmd.cmd = (struct nd_intel_bus_fw_activate) {
 		/*
 		 * Even though activate is run from a suspended context,
 		 * for safety, still ask platform firmware to force
 		 * quiesce devices by default. Let a module
 		 * parameter override that policy.
 		 */
-		.cmd = {
-			.iodev_state = acpi_desc->fwa_noidle
-				? ND_INTEL_BUS_FWA_IODEV_OS_IDLE
-				: ND_INTEL_BUS_FWA_IODEV_FORCE_IDLE,
-		},
+		.iodev_state = acpi_desc->fwa_noidle
+			? ND_INTEL_BUS_FWA_IODEV_OS_IDLE
+			: ND_INTEL_BUS_FWA_IODEV_FORCE_IDLE,
 	};
-	int rc;
-
 	switch (intel_bus_fwa_state(nd_desc)) {
 	case NVDIMM_FWA_ARMED:
 	case NVDIMM_FWA_ARM_OVERFLOW:
@@ -582,10 +571,9 @@ const struct nvdimm_bus_fw_ops *intel_bus_fw_ops = &__intel_bus_fw_ops;
 static int intel_fwa_dimminfo(struct nvdimm *nvdimm,
 		struct nd_intel_fw_activate_dimminfo *info)
 {
-	struct {
-		struct nd_cmd_pkg pkg;
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
 		struct nd_intel_fw_activate_dimminfo cmd;
-	} nd_cmd = {
+	) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_FW_ACTIVATE_DIMMINFO,
 			.nd_family = NVDIMM_FAMILY_INTEL,
@@ -688,27 +676,24 @@ static int intel_fwa_arm(struct nvdimm *nvdimm, enum nvdimm_fwa_trigger arm)
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	struct acpi_nfit_desc *acpi_desc = nfit_mem->acpi_desc;
-	struct {
-		struct nd_cmd_pkg pkg;
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
 		struct nd_intel_fw_activate_arm cmd;
-	} nd_cmd = {
-		.pkg = {
-			.nd_command = NVDIMM_INTEL_FW_ACTIVATE_ARM,
-			.nd_family = NVDIMM_FAMILY_INTEL,
-			.nd_size_in = sizeof(nd_cmd.cmd.activate_arm),
-			.nd_size_out =
-				sizeof(struct nd_intel_fw_activate_arm),
-			.nd_fw_size =
-				sizeof(struct nd_intel_fw_activate_arm),
-		},
-		.cmd = {
-			.activate_arm = arm == NVDIMM_FWA_ARM
-				? ND_INTEL_DIMM_FWA_ARM
-				: ND_INTEL_DIMM_FWA_DISARM,
-		},
-	};
+	) nd_cmd;
 	int rc;
 
+	nd_cmd.pkg = (struct nd_cmd_pkg) {
+		.nd_command = NVDIMM_INTEL_FW_ACTIVATE_ARM,
+		.nd_family = NVDIMM_FAMILY_INTEL,
+		.nd_size_in = sizeof(nd_cmd.cmd.activate_arm),
+		.nd_size_out = sizeof(struct nd_intel_fw_activate_arm),
+		.nd_fw_size = sizeof(struct nd_intel_fw_activate_arm),
+	};
+	nd_cmd.cmd = (struct nd_intel_fw_activate_arm) {
+		.activate_arm = arm == NVDIMM_FWA_ARM ?
+					ND_INTEL_DIMM_FWA_ARM :
+					ND_INTEL_DIMM_FWA_DISARM,
+	};
+
 	switch (intel_fwa_state(nvdimm)) {
 	case NVDIMM_FWA_INVALID:
 		return -ENXIO;
-- 
2.43.0


