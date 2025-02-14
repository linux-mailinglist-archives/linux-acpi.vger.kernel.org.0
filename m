Return-Path: <linux-acpi+bounces-11182-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B152A35344
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 01:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C057916B05D
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 00:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08756FC5;
	Fri, 14 Feb 2025 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg9EFP/s"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C91FC3;
	Fri, 14 Feb 2025 00:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739494395; cv=none; b=HMu7pxka+/YNtfzQo1u2TOLbEpFR4RzrYxk80isS3W8NjeifYE5gNA4j1qmFeByyI1ipQ/2twO6TXwXktk1TgDsDMl9Oe2UFgVGCWAL9smu4W7+xpdQmA5HZ66WgyRcF4N2Uagi1VyTf4+MFehos2uHNwZVyqDZs/VEE45IfJK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739494395; c=relaxed/simple;
	bh=A+jNzOERGrQ6f2WqwUyiK/qmR/R5OgMuBsE/TU0Reeg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W6UTyZKLCdkpmGgtwQPjO5UOvWfNJqYtRXThzUPPnvtH/H4Zxl4HImuwZCtXq51w/M+/v7LWtH351gQUU4Nk7Y6QzLSYQt2A3GjUmG4xZ4nYHN/TMtw3MCildDsve3d5C9mSyvHNoCXKtUEGF4jU+seMirry4dnEsjx1G/NwcTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg9EFP/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84A5C4CED1;
	Fri, 14 Feb 2025 00:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739494394;
	bh=A+jNzOERGrQ6f2WqwUyiK/qmR/R5OgMuBsE/TU0Reeg=;
	h=Date:From:To:Cc:Subject:From;
	b=Cg9EFP/sI62BvTrUUOC8gOekavXVfG2/sP8dSYtj4gBaR7GL9mZnH5u8R5kxY80ZL
	 +vSnvbper5ziJnENsGp22i/CUZmS3a0Sj8Xk83Ov/seuf580/zwkdu5oD4Avzf5n4q
	 LGi6379gF/9dWxKBeI+4ovV8JkbQuEYG3+KnYRjyEEMgDJj2jYgsF9mxk3G+v9OI0U
	 ENXZBvQq9K5mTI/Rgc95AsOGuw1rR0hCRLelMK7ybE5RhU9x9WLBgnHnUa+aLf0Nsd
	 Z2ARR/bjVTdXoblBJUAtfXkLjXfP1v6jjHaJz5x0KIGpp8krsEQECeJ8vdB7c7na+4
	 UnmUlltArw9gA==
Date: Fri, 14 Feb 2025 11:23:06 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, LIBNVDIMM: ;,
	NON-VOLATILE MEMORY DEVICE SUBSYSTEM status: ;,
	SupportedACPI status: 
	"SupportedGustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org;
Subject: [PATCH v2][next] UAPI: ndctl / acpi: intel: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z66T8tSKjVutr6of@kspp>
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
nd_cmd_pkg_hdr` to replace the type of the objects causing trouble:
`pkg` in multiple structs.

Below is the before-and-after changes of the memory layout in `struct
nd_cmd_pkg`. This to illustrate that the use of `__struct_group()`
doesn't alter the layout, ensuring that user space remains unaffected.

Before changes:
struct nd_cmd_pkg {
	__u64                      nd_family;            /*     0     8 */
	__u64                      nd_command;           /*     8     8 */
	__u32                      nd_size_in;           /*    16     4 */
	__u32                      nd_size_out;          /*    20     4 */
	__u32                      nd_reserved2[9];      /*    24    36 */
	__u32                      nd_fw_size;           /*    60     4 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	unsigned char              nd_payload[];         /*    64     0 */

	/* size: 64, cachelines: 1, members: 7 */
};

After changes:
struct nd_cmd_pkg {
	union {
		struct {
			__u64      nd_family;            /*     0     8 */
			__u64      nd_command;           /*     8     8 */
			__u32      nd_size_in;           /*    16     4 */
			__u32      nd_size_out;          /*    20     4 */
			__u32      nd_reserved2[9];      /*    24    36 */
			__u32      nd_fw_size;           /*    60     4 */
		};                                       /*     0    64 */
		struct nd_cmd_pkg_hdr __hdr;             /*     0    64 */
	};                                               /*     0    64 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	unsigned char              nd_payload[];         /*    64     0 */

	/* size: 64, cachelines: 1, members: 2 */
};

It's also worth mentioning that all members of the struct can still be
accessed directly, for example instance->nd_family, instance->nd_command,
and so on.

So, with these changes, fix 12 of the following warnings:

drivers/acpi/nfit/intel.c:692:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Show changes in UAPI first. (Alison)
 - Update changelog text --add more information about _struct_group()
   changes. (Alison)

v1:
 - Link: https://lore.kernel.org/linux-hardening/Z618ILbAR8YAvTkd@kspp/

 include/uapi/linux/ndctl.h | 15 +++++++++------
 drivers/acpi/nfit/intel.c  | 24 ++++++++++++------------
 2 files changed, 21 insertions(+), 18 deletions(-)

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
-- 
2.43.0


