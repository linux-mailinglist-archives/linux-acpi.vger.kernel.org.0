Return-Path: <linux-acpi+bounces-11145-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BDEA3371D
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 05:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53D91889B5B
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 04:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2A8205E17;
	Thu, 13 Feb 2025 04:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmdUGCSJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ACA11CAF;
	Thu, 13 Feb 2025 04:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739422762; cv=none; b=YUqbm3w/fv9k5KFM6PDjXn60MDwGd/HRLconOvLadhMgOgLbxJe9Btw+bhpT0+j5rYhVoq/A3euQtSOfWnnk3t8XtbW6moeql2KtJm+T/r9LGcEjlAyj6uXuZZxg49XmlZjG4bxuz0x6A+4zuZzFML77d+vZYsi209cHI2ofHGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739422762; c=relaxed/simple;
	bh=+nL/t8KJmXr78QWaFZl9COVC+ons7uiJayM6FVQt2mg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KO0KBGFRfrEa+ZD9/RT1R188/p5oahVyi98qInDD6MHU/IHk9MbvkwoBBXVoMJ0vuXbSeTZbG7cpYvJTwwnEXnUiTI3vvNnbEaG8UyNtzNh9DqrL40T4Gz91/S4c36mk3TA+AeZHi/8gdtyO43CQHucG72SlvQilcCtQ3F6MrGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmdUGCSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B16C4CED1;
	Thu, 13 Feb 2025 04:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739422761;
	bh=+nL/t8KJmXr78QWaFZl9COVC+ons7uiJayM6FVQt2mg=;
	h=Date:From:To:Cc:Subject:From;
	b=YmdUGCSJU8lwwiNu0T7UO178FByNZKXqoHct9TNDvHDa4PW4lzI9+vA1qLsgIX/Rr
	 OoRaxXEex1/0CCpYrpwR2ZQ/rLMRfqkydpFCbT1rhe9b/O/fGwglL+9DG/5tyd760w
	 FCiy78K+yYpPsK/XBYwOnM8+A4wLsHsw0u5iP6LDwRGgIfDdBO0b2nA9XCQZInF37N
	 4ZTzmDLqV3bfPZwqcpBR2IxZazUHfVqOi5dpRnwZwr+u8xN8GRxxqXdZI8a34zx0/u
	 eX2PjZUAk7KQjaEqEJczStaAL00xg4muSX10mlUByJjivO9djDRA6VF2IOKNXf8kc3
	 8+UuNvfPZhoAQ==
Date: Thu, 13 Feb 2025 15:29:12 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] UAPI: ndctl / acpi: intel: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z618ILbAR8YAvTkd@kspp>
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

So, in order to avoid ending up with flexible-array members in the
middle of other structs, we use the `__struct_group()` helper to
separate the flexible array from the rest of the members in the
flexible structure. We then use the newly created tagged `struct
nd_cmd_pkg_hdr` to replace the type of the objects causing trouble
(`pkg`) in multiple structs.

So, with these changes, fix the following warnings:

drivers/acpi/nfit/intel.c:692:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/acpi/nfit/intel.c:59:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/acpi/nfit/intel.c:586:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/acpi/nfit/intel.c:522:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/acpi/nfit/intel.c:411:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/acpi/nfit/intel.c:358:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/acpi/nfit/intel.c:322:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/acpi/nfit/intel.c:281:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/acpi/nfit/intel.c:238:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/acpi/nfit/intel.c:199:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/acpi/nfit/intel.c:157:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/acpi/nfit/intel.c:124:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/acpi/nfit/intel.c  | 24 ++++++++++++------------
 include/uapi/linux/ndctl.h | 15 +++++++++------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
index 3902759abcba..fe561ce0ddec 100644
--- a/drivers/acpi/nfit/intel.c
+++ b/drivers/acpi/nfit/intel.c
@@ -56,7 +56,7 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	unsigned long security_flags = 0;
 	struct {
-		struct nd_cmd_pkg pkg;
+		struct nd_cmd_pkg_hdr pkg;
 		struct nd_intel_get_security_state cmd;
 	} nd_cmd = {
 		.pkg = {
@@ -121,7 +121,7 @@ static int intel_security_freeze(struct nvdimm *nvdimm)
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	struct {
-		struct nd_cmd_pkg pkg;
+		struct nd_cmd_pkg_hdr pkg;
 		struct nd_intel_freeze_lock cmd;
 	} nd_cmd = {
 		.pkg = {
@@ -154,7 +154,7 @@ static int intel_security_change_key(struct nvdimm *nvdimm,
 		NVDIMM_INTEL_SET_MASTER_PASSPHRASE :
 		NVDIMM_INTEL_SET_PASSPHRASE;
 	struct {
-		struct nd_cmd_pkg pkg;
+		struct nd_cmd_pkg_hdr pkg;
 		struct nd_intel_set_passphrase cmd;
 	} nd_cmd = {
 		.pkg = {
@@ -196,7 +196,7 @@ static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	struct {
-		struct nd_cmd_pkg pkg;
+		struct nd_cmd_pkg_hdr pkg;
 		struct nd_intel_unlock_unit cmd;
 	} nd_cmd = {
 		.pkg = {
@@ -235,7 +235,7 @@ static int intel_security_disable(struct nvdimm *nvdimm,
 	int rc;
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	struct {
-		struct nd_cmd_pkg pkg;
+		struct nd_cmd_pkg_hdr pkg;
 		struct nd_intel_disable_passphrase cmd;
 	} nd_cmd = {
 		.pkg = {
@@ -278,7 +278,7 @@ static int __maybe_unused intel_security_erase(struct nvdimm *nvdimm,
 	unsigned int cmd = ptype == NVDIMM_MASTER ?
 		NVDIMM_INTEL_MASTER_SECURE_ERASE : NVDIMM_INTEL_SECURE_ERASE;
 	struct {
-		struct nd_cmd_pkg pkg;
+		struct nd_cmd_pkg_hdr pkg;
 		struct nd_intel_secure_erase cmd;
 	} nd_cmd = {
 		.pkg = {
@@ -319,7 +319,7 @@ static int __maybe_unused intel_security_query_overwrite(struct nvdimm *nvdimm)
 	int rc;
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	struct {
-		struct nd_cmd_pkg pkg;
+		struct nd_cmd_pkg_hdr pkg;
 		struct nd_intel_query_overwrite cmd;
 	} nd_cmd = {
 		.pkg = {
@@ -355,7 +355,7 @@ static int __maybe_unused intel_security_overwrite(struct nvdimm *nvdimm,
 	int rc;
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	struct {
-		struct nd_cmd_pkg pkg;
+		struct nd_cmd_pkg_hdr pkg;
 		struct nd_intel_overwrite cmd;
 	} nd_cmd = {
 		.pkg = {
@@ -408,7 +408,7 @@ static int intel_bus_fwa_businfo(struct nvdimm_bus_descriptor *nd_desc,
 		struct nd_intel_bus_fw_activate_businfo *info)
 {
 	struct {
-		struct nd_cmd_pkg pkg;
+		struct nd_cmd_pkg_hdr pkg;
 		struct nd_intel_bus_fw_activate_businfo cmd;
 	} nd_cmd = {
 		.pkg = {
@@ -519,7 +519,7 @@ static int intel_bus_fwa_activate(struct nvdimm_bus_descriptor *nd_desc)
 {
 	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 	struct {
-		struct nd_cmd_pkg pkg;
+		struct nd_cmd_pkg_hdr pkg;
 		struct nd_intel_bus_fw_activate cmd;
 	} nd_cmd = {
 		.pkg = {
@@ -583,7 +583,7 @@ static int intel_fwa_dimminfo(struct nvdimm *nvdimm,
 		struct nd_intel_fw_activate_dimminfo *info)
 {
 	struct {
-		struct nd_cmd_pkg pkg;
+		struct nd_cmd_pkg_hdr pkg;
 		struct nd_intel_fw_activate_dimminfo cmd;
 	} nd_cmd = {
 		.pkg = {
@@ -689,7 +689,7 @@ static int intel_fwa_arm(struct nvdimm *nvdimm, enum nvdimm_fwa_trigger arm)
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	struct acpi_nfit_desc *acpi_desc = nfit_mem->acpi_desc;
 	struct {
-		struct nd_cmd_pkg pkg;
+		struct nd_cmd_pkg_hdr pkg;
 		struct nd_intel_fw_activate_arm cmd;
 	} nd_cmd = {
 		.pkg = {
diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
index 73516e263627..34c11644d5d7 100644
--- a/include/uapi/linux/ndctl.h
+++ b/include/uapi/linux/ndctl.h
@@ -227,12 +227,15 @@ enum ars_masks {
  */
 
 struct nd_cmd_pkg {
-	__u64   nd_family;		/* family of commands */
-	__u64   nd_command;
-	__u32   nd_size_in;		/* INPUT: size of input args */
-	__u32   nd_size_out;		/* INPUT: size of payload */
-	__u32   nd_reserved2[9];	/* reserved must be zero */
-	__u32   nd_fw_size;		/* OUTPUT: size fw wants to return */
+	/* New members MUST be added within the __struct_group() macro below. */
+	__struct_group(nd_cmd_pkg_hdr, __hdr, /* no attrs */,
+		__u64   nd_family;		/* family of commands */
+		__u64   nd_command;
+		__u32   nd_size_in;		/* INPUT: size of input args */
+		__u32   nd_size_out;		/* INPUT: size of payload */
+		__u32   nd_reserved2[9];	/* reserved must be zero */
+		__u32   nd_fw_size;		/* OUTPUT: size fw wants to return */
+	);
 	unsigned char nd_payload[];	/* Contents of call      */
 };
 
-- 
2.43.0


