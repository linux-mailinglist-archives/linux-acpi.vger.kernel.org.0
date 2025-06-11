Return-Path: <linux-acpi+bounces-14290-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA715AD5F84
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 21:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B575917EB1D
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 19:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA442BD595;
	Wed, 11 Jun 2025 19:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGR3uUlj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B1D286D57;
	Wed, 11 Jun 2025 19:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671565; cv=none; b=nw3mWX57zPL4Ygc7Dql0PR0EeKdydEp6TSlJDcuXoAJ+IxUpIyGWcZX3kb5pNyj5Q3+HPA16y/9ggCyTiHWSzSZUkov3E+tCCWJffUxatX9SzIiz3DrYeadqsKigouleETYcfjiF3iaJvcxj1mhCLZ2KPfMiBXDqJXAQDhDrCDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671565; c=relaxed/simple;
	bh=nMYxhhhFnGMD3R90Vo4bzJWsKoPXpLrIlEnkfbCZH7I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SAgOnBbb8hPrmv6VQ7B+9HGzy3cdyKF5/jCBPEf9zwF4z6s8XMoxuJ0TIVL54fCdTocX/gM5bqhR9eCfEhIQmb8t/x1MyfUYXrdjwq6fo47J2xzZ9v16Q+O/mDBNtf6XaZsqTA2A7gRaPxImksk6hu9P2xP46r7FI1mL0aleCp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGR3uUlj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C9CC4CEE3;
	Wed, 11 Jun 2025 19:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749671565;
	bh=nMYxhhhFnGMD3R90Vo4bzJWsKoPXpLrIlEnkfbCZH7I=;
	h=Date:From:To:Cc:Subject:From;
	b=kGR3uUlj02j5Do/TNMhY3XgzLEXIYin9QqWXVE0V4k1v5hL50XhTQuaiyep4y4TSE
	 kzXnSoaxibk3Jv/715vYNqQkuciYfIFJ2SYykIxKXnS0+iQCo3pmtVn6e7tR18GM2b
	 iSI3r3ZfbZnk2h5M9tfiMlxNVmqKKuxOOU+QAS9A11VxOLA6BnPwtgXXwFLJaS2p9k
	 qMk7GUXGUDWvtx0YEaGzrm9Ea3LIITqFLkwlc11NjBuz27q9kEbHo6C3trdvPifxe6
	 lcBazw0usVR0dhq1T2qENIm+fVGBxXFZU+V1wGpMXs8GO2LF/n40AO4QFfMtK+dn+s
	 J6IBcr4HKvppg==
Date: Wed, 11 Jun 2025 13:52:41 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: [PATCH v3][next] acpi: nfit: intel: avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <aEneid7gdAZr1_kR@kspp>
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

Refactor multiple structs that contain flexible-array members in the
middle by replacing them with unions.

These changes preserve the memory layout while effectively adjusting
it so that the flexible-array member is always treated as the last
member.

With these changes, fix a dozen instances of the following type of
warning:

drivers/acpi/nfit/intel.c:692:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - Use union instead of DEFINE_RAW_FLEX().

Changes in v2:
 - Use DEFINE_RAW_FLEX() instead of __struct_group().
 - Link: https://lore.kernel.org/linux-hardening/Z-QpUcxFCRByYcTA@kspp/ 

v1:
 - Link: https://lore.kernel.org/linux-hardening/Z618ILbAR8YAvTkd@kspp/

 drivers/acpi/nfit/intel.c | 132 +++++++++++++++++++++++++++++++-------
 1 file changed, 108 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
index 3902759abcba..987d427ec2b6 100644
--- a/drivers/acpi/nfit/intel.c
+++ b/drivers/acpi/nfit/intel.c
@@ -55,9 +55,16 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	unsigned long security_flags = 0;
-	struct {
+	/*
+	 * This effectively creates a union between the flexible-array member
+	 * and any members after _offset_to_fam.
+	 */
+	union {
 		struct nd_cmd_pkg pkg;
-		struct nd_intel_get_security_state cmd;
+		struct {
+			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
+			struct nd_intel_get_security_state cmd;
+		};
 	} nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
@@ -120,9 +127,16 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
 static int intel_security_freeze(struct nvdimm *nvdimm)
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-	struct {
+	/*
+	 * This effectively creates a union between the flexible-array member
+	 * and any members after _offset_to_fam.
+	 */
+	union {
 		struct nd_cmd_pkg pkg;
-		struct nd_intel_freeze_lock cmd;
+		struct {
+			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
+			struct nd_intel_freeze_lock cmd;
+		};
 	} nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_FREEZE_LOCK,
@@ -153,9 +167,16 @@ static int intel_security_change_key(struct nvdimm *nvdimm,
 	unsigned int cmd = ptype == NVDIMM_MASTER ?
 		NVDIMM_INTEL_SET_MASTER_PASSPHRASE :
 		NVDIMM_INTEL_SET_PASSPHRASE;
-	struct {
+	/*
+	 * This effectively creates a union between the flexible-array member
+	 * and any members after _offset_to_fam.
+	 */
+	union {
 		struct nd_cmd_pkg pkg;
-		struct nd_intel_set_passphrase cmd;
+		struct {
+			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
+			struct nd_intel_set_passphrase cmd;
+		};
 	} nd_cmd = {
 		.pkg = {
 			.nd_family = NVDIMM_FAMILY_INTEL,
@@ -195,9 +216,16 @@ static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
 		const struct nvdimm_key_data *key_data)
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-	struct {
+	/*
+	 * This effectively creates a union between the flexible-array member
+	 * and any members after _offset_to_fam.
+	 */
+	union {
 		struct nd_cmd_pkg pkg;
-		struct nd_intel_unlock_unit cmd;
+		struct {
+			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
+			struct nd_intel_unlock_unit cmd;
+		};
 	} nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_UNLOCK_UNIT,
@@ -234,9 +262,16 @@ static int intel_security_disable(struct nvdimm *nvdimm,
 {
 	int rc;
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-	struct {
+	/*
+	 * This effectively creates a union between the flexible-array member
+	 * and any members after _offset_to_fam.
+	 */
+	union {
 		struct nd_cmd_pkg pkg;
-		struct nd_intel_disable_passphrase cmd;
+		struct {
+			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
+			struct nd_intel_disable_passphrase cmd;
+		};
 	} nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_DISABLE_PASSPHRASE,
@@ -277,9 +312,16 @@ static int __maybe_unused intel_security_erase(struct nvdimm *nvdimm,
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	unsigned int cmd = ptype == NVDIMM_MASTER ?
 		NVDIMM_INTEL_MASTER_SECURE_ERASE : NVDIMM_INTEL_SECURE_ERASE;
-	struct {
+	/*
+	 * This effectively creates a union between the flexible-array member
+	 * and any members after _offset_to_fam.
+	 */
+	union {
 		struct nd_cmd_pkg pkg;
-		struct nd_intel_secure_erase cmd;
+		struct {
+			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
+			struct nd_intel_secure_erase cmd;
+		};
 	} nd_cmd = {
 		.pkg = {
 			.nd_family = NVDIMM_FAMILY_INTEL,
@@ -318,9 +360,16 @@ static int __maybe_unused intel_security_query_overwrite(struct nvdimm *nvdimm)
 {
 	int rc;
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-	struct {
+	/*
+	 * This effectively creates a union between the flexible-array member
+	 * and any members after _offset_to_fam.
+	 */
+	union {
 		struct nd_cmd_pkg pkg;
-		struct nd_intel_query_overwrite cmd;
+		struct {
+			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
+			struct nd_intel_query_overwrite cmd;
+		};
 	} nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_QUERY_OVERWRITE,
@@ -354,9 +403,16 @@ static int __maybe_unused intel_security_overwrite(struct nvdimm *nvdimm,
 {
 	int rc;
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-	struct {
+	/*
+	 * This effectively creates a union between the flexible-array member
+	 * and any members after _offset_to_fam.
+	 */
+	union {
 		struct nd_cmd_pkg pkg;
-		struct nd_intel_overwrite cmd;
+		struct {
+			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
+			struct nd_intel_overwrite cmd;
+		};
 	} nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_OVERWRITE,
@@ -407,9 +463,16 @@ const struct nvdimm_security_ops *intel_security_ops = &__intel_security_ops;
 static int intel_bus_fwa_businfo(struct nvdimm_bus_descriptor *nd_desc,
 		struct nd_intel_bus_fw_activate_businfo *info)
 {
-	struct {
+	/*
+	 * This effectively creates a union between the flexible-array member
+	 * and any members after _offset_to_fam.
+	 */
+	union {
 		struct nd_cmd_pkg pkg;
-		struct nd_intel_bus_fw_activate_businfo cmd;
+		struct {
+			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
+			struct nd_intel_bus_fw_activate_businfo cmd;
+		};
 	} nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE_BUSINFO,
@@ -518,9 +581,16 @@ static enum nvdimm_fwa_capability intel_bus_fwa_capability(
 static int intel_bus_fwa_activate(struct nvdimm_bus_descriptor *nd_desc)
 {
 	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
-	struct {
+	/*
+	 * This effectively creates a union between the flexible-array member
+	 * and any members after _offset_to_fam.
+	 */
+	union {
 		struct nd_cmd_pkg pkg;
-		struct nd_intel_bus_fw_activate cmd;
+		struct {
+			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
+			struct nd_intel_bus_fw_activate cmd;
+		};
 	} nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE,
@@ -582,9 +652,16 @@ const struct nvdimm_bus_fw_ops *intel_bus_fw_ops = &__intel_bus_fw_ops;
 static int intel_fwa_dimminfo(struct nvdimm *nvdimm,
 		struct nd_intel_fw_activate_dimminfo *info)
 {
-	struct {
+	/*
+	 * This effectively creates a union between the flexible-array member
+	 * and any members after _offset_to_fam.
+	 */
+	union {
 		struct nd_cmd_pkg pkg;
-		struct nd_intel_fw_activate_dimminfo cmd;
+		struct {
+			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
+			struct nd_intel_fw_activate_dimminfo cmd;
+		};
 	} nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_FW_ACTIVATE_DIMMINFO,
@@ -688,9 +765,16 @@ static int intel_fwa_arm(struct nvdimm *nvdimm, enum nvdimm_fwa_trigger arm)
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	struct acpi_nfit_desc *acpi_desc = nfit_mem->acpi_desc;
-	struct {
+	/*
+	 * This effectively creates a union between the flexible-array member
+	 * and any members after _offset_to_fam.
+	 */
+	union {
 		struct nd_cmd_pkg pkg;
-		struct nd_intel_fw_activate_arm cmd;
+		struct {
+			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
+			struct nd_intel_fw_activate_arm cmd;
+		};
 	} nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_FW_ACTIVATE_ARM,
-- 
2.43.0


