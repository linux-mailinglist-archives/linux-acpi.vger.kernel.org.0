Return-Path: <linux-acpi+bounces-14653-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8239AE9043
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 23:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3B81C26271
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 21:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5809F2512F1;
	Wed, 25 Jun 2025 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWt1a8HM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283E5248881;
	Wed, 25 Jun 2025 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750887741; cv=none; b=qyyCqESIEebAmUI84x2WTAsuxs4hL+oswDzziyWCTIx7CtcyLY0qV8zNmtj580SzVNfaTDnfxLI1HdyU+s3GXaJJrKa3lYXV8DipCvAlK3SABjeB2kdOxnA+25ukUfKmmX1iDjU5PKKjhFJBSZI7dzztP3UuzEhdtBTlW+RqdmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750887741; c=relaxed/simple;
	bh=pFVcSUUSzGl88Ok2Nmc7XkcXLiJtNBOYTAVGqHxHIBk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cUyGoSNybVjQ0MK1r1oB6nBySD6CXGUNHfTHmuZSlFxhFTUI3wzzc5RHfgfxoqdkZ1ocX7zQatrBG669y7eTWSwolHSQRBShFJHO5O8T1iT1dodSHDwyqp4KffP0lz+K0zF6ew8Gv57s5VVmf3mcyX9KM7l5RkjfqqFHa6eoKOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWt1a8HM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E701C4CEEA;
	Wed, 25 Jun 2025 21:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750887740;
	bh=pFVcSUUSzGl88Ok2Nmc7XkcXLiJtNBOYTAVGqHxHIBk=;
	h=Date:From:To:Cc:Subject:From;
	b=QWt1a8HMUw5HOtvhpEgXj+EP5bDlat1dDWxwbhMBLfpU8wDOscNwk5SkrWLiLmU29
	 fmqn+BfZTq5/93Hqri57wzyEutuuKx+9bvmAXBe2BED77NvgYbWz3RuGcqM6j96Rny
	 vFf6aBo6ZnzcH7nSWXOPlguE1iuJNdTOyIKn97S2wInBty4+VdqUAgH6cRp348AP5a
	 VT509nbcS8cpGcNozPcpVEU2Xq8XtSfGYqUw1UzPI6BkbcpiRRATBjztHuZyJRpXxu
	 m3Nb29NfrJoQ0BNjX5QmNGxGRTwci47uO0lxGNzsbZsNp7lRdTr/1mQDiF/FxmnEoh
	 vRGiUc/klXdlg==
Date: Wed, 25 Jun 2025 15:42:16 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <kees@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v4][for-next/hardening] acpi: nfit: intel: avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <aFxtOLs6Yv_uzgt4@kspp>
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
This patch should go through:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/ (for-next/hardening)

Changes in v4:
 - Use the new TRAILING_OVERLAP() helper.

Changes in v3:
 - Use union instead of DEFINE_RAW_FLEX().
 - Link: https://lore.kernel.org/linux-hardening/aEneid7gdAZr1_kR@kspp/

Changes in v2:
 - Use DEFINE_RAW_FLEX() instead of __struct_group().
 - Link: https://lore.kernel.org/linux-hardening/Z-QpUcxFCRByYcTA@kspp/ 

v1:
 - Link: https://lore.kernel.org/linux-hardening/Z618ILbAR8YAvTkd@kspp/

 drivers/acpi/nfit/intel.c | 84 +++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 48 deletions(-)

diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
index 3902759abcba..d0b72e906428 100644
--- a/drivers/acpi/nfit/intel.c
+++ b/drivers/acpi/nfit/intel.c
@@ -55,10 +55,9 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	unsigned long security_flags = 0;
-	struct {
-		struct nd_cmd_pkg pkg;
-		struct nd_intel_get_security_state cmd;
-	} nd_cmd = {
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+			 struct nd_intel_get_security_state cmd;
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
-		struct nd_intel_freeze_lock cmd;
-	} nd_cmd = {
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+			 struct nd_intel_freeze_lock cmd;
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
-		struct nd_intel_set_passphrase cmd;
-	} nd_cmd = {
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+			 struct nd_intel_set_passphrase cmd;
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
-		struct nd_intel_unlock_unit cmd;
-	} nd_cmd = {
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+			 struct nd_intel_unlock_unit cmd;
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
-		struct nd_intel_disable_passphrase cmd;
-	} nd_cmd = {
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+			 struct nd_intel_disable_passphrase cmd;
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
-		struct nd_intel_secure_erase cmd;
-	} nd_cmd = {
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+			 struct nd_intel_secure_erase cmd;
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
-		struct nd_intel_query_overwrite cmd;
-	} nd_cmd = {
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+			 struct nd_intel_query_overwrite cmd;
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
-		struct nd_intel_overwrite cmd;
-	} nd_cmd = {
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+			 struct nd_intel_overwrite cmd;
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
-		struct nd_intel_bus_fw_activate_businfo cmd;
-	} nd_cmd = {
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+			 struct nd_intel_bus_fw_activate_businfo cmd;
+	) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE_BUSINFO,
 			.nd_family = NVDIMM_BUS_FAMILY_INTEL,
@@ -518,10 +509,9 @@ static enum nvdimm_fwa_capability intel_bus_fwa_capability(
 static int intel_bus_fwa_activate(struct nvdimm_bus_descriptor *nd_desc)
 {
 	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
-	struct {
-		struct nd_cmd_pkg pkg;
-		struct nd_intel_bus_fw_activate cmd;
-	} nd_cmd = {
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+			 struct nd_intel_bus_fw_activate cmd;
+	) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE,
 			.nd_family = NVDIMM_BUS_FAMILY_INTEL,
@@ -582,10 +572,9 @@ const struct nvdimm_bus_fw_ops *intel_bus_fw_ops = &__intel_bus_fw_ops;
 static int intel_fwa_dimminfo(struct nvdimm *nvdimm,
 		struct nd_intel_fw_activate_dimminfo *info)
 {
-	struct {
-		struct nd_cmd_pkg pkg;
-		struct nd_intel_fw_activate_dimminfo cmd;
-	} nd_cmd = {
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+			 struct nd_intel_fw_activate_dimminfo cmd;
+	) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_FW_ACTIVATE_DIMMINFO,
 			.nd_family = NVDIMM_FAMILY_INTEL,
@@ -688,10 +677,9 @@ static int intel_fwa_arm(struct nvdimm *nvdimm, enum nvdimm_fwa_trigger arm)
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	struct acpi_nfit_desc *acpi_desc = nfit_mem->acpi_desc;
-	struct {
-		struct nd_cmd_pkg pkg;
-		struct nd_intel_fw_activate_arm cmd;
-	} nd_cmd = {
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+			 struct nd_intel_fw_activate_arm cmd;
+	) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_FW_ACTIVATE_ARM,
 			.nd_family = NVDIMM_FAMILY_INTEL,
-- 
2.43.0


