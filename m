Return-Path: <linux-acpi+bounces-6201-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E088FCF8B
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 15:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87181C21B91
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 13:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5BB18F2CD;
	Wed,  5 Jun 2024 13:15:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ED71953AA
	for <linux-acpi@vger.kernel.org>; Wed,  5 Jun 2024 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593308; cv=none; b=RvIfVPaRA+s6pYVnaB4jSa+tYTEKCFq1oh9sj8hza7TyjUyxPUqBzOJ78bNF0/pk0HAxtekRGBvlgHYvKPBrTBrpoBEcypHwxPk2ib0GTjA05G3TmwT6nkedvK64u7qO0ndLfpYD8y+oOUN/nmsLoWecviS/fJAmG9rJ7obm7+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593308; c=relaxed/simple;
	bh=joMoORbPGZ+FE478qXZj7EbaFTY/+D0XxUw2m5hgyu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXx71uI1SMbawniHa5L1aXu5c+Rnrnfm0NXmlAUMQL4zuib0Jq7xXRGMVK1akA5Xh/uduh/ZQX9QrLbpLyByODZA5Is3ku9IsTJOduelLlzezAGnlMxcfulThtc0q1EkPkv9ypAjpTLJikRHeTCnOrv9QbXpZQKjZKvyiJcaixI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16E701474;
	Wed,  5 Jun 2024 06:15:30 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BA82C3F792;
	Wed,  5 Jun 2024 06:15:04 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 3/3] arm64: FFH: Move ACPI specific code into drivers/acpi/arm64/
Date: Wed,  5 Jun 2024 14:14:58 +0100
Message-ID: <20240605131458.3341095-4-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605131458.3341095-1-sudeep.holla@arm.com>
References: <20240605131458.3341095-1-sudeep.holla@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI FFH Opregion code can be moved out of arm64 arch code as
it just uses SMCCC. Move all the ACPI FFH Opregion code into
drivers/acpi/arm64/ffh.c

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kernel/acpi.c    | 105 -----------------------------------
 drivers/acpi/arm64/Makefile |   1 +
 drivers/acpi/arm64/ffh.c    | 107 ++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 105 deletions(-)
 create mode 100644 drivers/acpi/arm64/ffh.c

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index e0e7b93c16cc..fd1917336d3a 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -422,108 +422,3 @@ void arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 {
 	memblock_mark_nomap(addr, size);
 }
-
-#ifdef CONFIG_ACPI_FFH
-/*
- * Implements ARM64 specific callbacks to support ACPI FFH Operation Region as
- * specified in https://developer.arm.com/docs/den0048/latest
- */
-struct acpi_ffh_data {
-	struct acpi_ffh_info info;
-	void (*invoke_ffh_fn)(unsigned long a0, unsigned long a1,
-			      unsigned long a2, unsigned long a3,
-			      unsigned long a4, unsigned long a5,
-			      unsigned long a6, unsigned long a7,
-			      struct arm_smccc_res *args,
-			      struct arm_smccc_quirk *res);
-	void (*invoke_ffh64_fn)(const struct arm_smccc_1_2_regs *args,
-				struct arm_smccc_1_2_regs *res);
-};
-
-int acpi_ffh_address_space_arch_setup(void *handler_ctxt, void **region_ctxt)
-{
-	enum arm_smccc_conduit conduit;
-	struct acpi_ffh_data *ffh_ctxt;
-
-	if (arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2)
-		return -EOPNOTSUPP;
-
-	conduit = arm_smccc_1_1_get_conduit();
-	if (conduit == SMCCC_CONDUIT_NONE) {
-		pr_err("%s: invalid SMCCC conduit\n", __func__);
-		return -EOPNOTSUPP;
-	}
-
-	ffh_ctxt = kzalloc(sizeof(*ffh_ctxt), GFP_KERNEL);
-	if (!ffh_ctxt)
-		return -ENOMEM;
-
-	if (conduit == SMCCC_CONDUIT_SMC) {
-		ffh_ctxt->invoke_ffh_fn = __arm_smccc_smc;
-		ffh_ctxt->invoke_ffh64_fn = arm_smccc_1_2_smc;
-	} else {
-		ffh_ctxt->invoke_ffh_fn = __arm_smccc_hvc;
-		ffh_ctxt->invoke_ffh64_fn = arm_smccc_1_2_hvc;
-	}
-
-	memcpy(ffh_ctxt, handler_ctxt, sizeof(ffh_ctxt->info));
-
-	*region_ctxt = ffh_ctxt;
-	return AE_OK;
-}
-
-static bool acpi_ffh_smccc_owner_allowed(u32 fid)
-{
-	int owner = ARM_SMCCC_OWNER_NUM(fid);
-
-	if (owner == ARM_SMCCC_OWNER_STANDARD ||
-	    owner == ARM_SMCCC_OWNER_SIP || owner == ARM_SMCCC_OWNER_OEM)
-		return true;
-
-	return false;
-}
-
-int acpi_ffh_address_space_arch_handler(acpi_integer *value, void *region_context)
-{
-	int ret = 0;
-	struct acpi_ffh_data *ffh_ctxt = region_context;
-
-	if (ffh_ctxt->info.offset == 0) {
-		/* SMC/HVC 32bit call */
-		struct arm_smccc_res res;
-		u32 a[8] = { 0 }, *ptr = (u32 *)value;
-
-		if (!ARM_SMCCC_IS_FAST_CALL(*ptr) || ARM_SMCCC_IS_64(*ptr) ||
-		    !acpi_ffh_smccc_owner_allowed(*ptr) ||
-		    ffh_ctxt->info.length > 32) {
-			ret = AE_ERROR;
-		} else {
-			int idx, len = ffh_ctxt->info.length >> 2;
-
-			for (idx = 0; idx < len; idx++)
-				a[idx] = *(ptr + idx);
-
-			ffh_ctxt->invoke_ffh_fn(a[0], a[1], a[2], a[3], a[4],
-						a[5], a[6], a[7], &res, NULL);
-			memcpy(value, &res, sizeof(res));
-		}
-
-	} else if (ffh_ctxt->info.offset == 1) {
-		/* SMC/HVC 64bit call */
-		struct arm_smccc_1_2_regs *r = (struct arm_smccc_1_2_regs *)value;
-
-		if (!ARM_SMCCC_IS_FAST_CALL(r->a0) || !ARM_SMCCC_IS_64(r->a0) ||
-		    !acpi_ffh_smccc_owner_allowed(r->a0) ||
-		    ffh_ctxt->info.length > sizeof(*r)) {
-			ret = AE_ERROR;
-		} else {
-			ffh_ctxt->invoke_ffh64_fn(r, r);
-			memcpy(value, r, ffh_ctxt->info.length);
-		}
-	} else {
-		ret = AE_ERROR;
-	}
-
-	return ret;
-}
-#endif /* CONFIG_ACPI_FFH */
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 2efee23f00b4..05ecde9eaabe 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_ACPI_AGDI) 	+= agdi.o
 obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
+obj-$(CONFIG_ACPI_FFH)		+= ffh.o
 obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
 obj-$(CONFIG_ACPI_IORT) 	+= iort.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE) += cpuidle.o
diff --git a/drivers/acpi/arm64/ffh.c b/drivers/acpi/arm64/ffh.c
new file mode 100644
index 000000000000..877edc6557e9
--- /dev/null
+++ b/drivers/acpi/arm64/ffh.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/acpi.h>
+#include <linux/arm-smccc.h>
+#include <linux/slab.h>
+
+/*
+ * Implements ARM64 specific callbacks to support ACPI FFH Operation Region as
+ * specified in https://developer.arm.com/docs/den0048/latest
+ */
+struct acpi_ffh_data {
+	struct acpi_ffh_info info;
+	void (*invoke_ffh_fn)(unsigned long a0, unsigned long a1,
+			      unsigned long a2, unsigned long a3,
+			      unsigned long a4, unsigned long a5,
+			      unsigned long a6, unsigned long a7,
+			      struct arm_smccc_res *args,
+			      struct arm_smccc_quirk *res);
+	void (*invoke_ffh64_fn)(const struct arm_smccc_1_2_regs *args,
+				struct arm_smccc_1_2_regs *res);
+};
+
+int acpi_ffh_address_space_arch_setup(void *handler_ctxt, void **region_ctxt)
+{
+	enum arm_smccc_conduit conduit;
+	struct acpi_ffh_data *ffh_ctxt;
+
+	if (arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2)
+		return -EOPNOTSUPP;
+
+	conduit = arm_smccc_1_1_get_conduit();
+	if (conduit == SMCCC_CONDUIT_NONE) {
+		pr_err("%s: invalid SMCCC conduit\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	ffh_ctxt = kzalloc(sizeof(*ffh_ctxt), GFP_KERNEL);
+	if (!ffh_ctxt)
+		return -ENOMEM;
+
+	if (conduit == SMCCC_CONDUIT_SMC) {
+		ffh_ctxt->invoke_ffh_fn = __arm_smccc_smc;
+		ffh_ctxt->invoke_ffh64_fn = arm_smccc_1_2_smc;
+	} else {
+		ffh_ctxt->invoke_ffh_fn = __arm_smccc_hvc;
+		ffh_ctxt->invoke_ffh64_fn = arm_smccc_1_2_hvc;
+	}
+
+	memcpy(ffh_ctxt, handler_ctxt, sizeof(ffh_ctxt->info));
+
+	*region_ctxt = ffh_ctxt;
+	return AE_OK;
+}
+
+static bool acpi_ffh_smccc_owner_allowed(u32 fid)
+{
+	int owner = ARM_SMCCC_OWNER_NUM(fid);
+
+	if (owner == ARM_SMCCC_OWNER_STANDARD ||
+	    owner == ARM_SMCCC_OWNER_SIP || owner == ARM_SMCCC_OWNER_OEM)
+		return true;
+
+	return false;
+}
+
+int acpi_ffh_address_space_arch_handler(acpi_integer *value, void *region_context)
+{
+	int ret = 0;
+	struct acpi_ffh_data *ffh_ctxt = region_context;
+
+	if (ffh_ctxt->info.offset == 0) {
+		/* SMC/HVC 32bit call */
+		struct arm_smccc_res res;
+		u32 a[8] = { 0 }, *ptr = (u32 *)value;
+
+		if (!ARM_SMCCC_IS_FAST_CALL(*ptr) || ARM_SMCCC_IS_64(*ptr) ||
+		    !acpi_ffh_smccc_owner_allowed(*ptr) ||
+		    ffh_ctxt->info.length > 32) {
+			ret = AE_ERROR;
+		} else {
+			int idx, len = ffh_ctxt->info.length >> 2;
+
+			for (idx = 0; idx < len; idx++)
+				a[idx] = *(ptr + idx);
+
+			ffh_ctxt->invoke_ffh_fn(a[0], a[1], a[2], a[3], a[4],
+						a[5], a[6], a[7], &res, NULL);
+			memcpy(value, &res, sizeof(res));
+		}
+
+	} else if (ffh_ctxt->info.offset == 1) {
+		/* SMC/HVC 64bit call */
+		struct arm_smccc_1_2_regs *r = (struct arm_smccc_1_2_regs *)value;
+
+		if (!ARM_SMCCC_IS_FAST_CALL(r->a0) || !ARM_SMCCC_IS_64(r->a0) ||
+		    !acpi_ffh_smccc_owner_allowed(r->a0) ||
+		    ffh_ctxt->info.length > sizeof(*r)) {
+			ret = AE_ERROR;
+		} else {
+			ffh_ctxt->invoke_ffh64_fn(r, r);
+			memcpy(value, r, ffh_ctxt->info.length);
+		}
+	} else {
+		ret = AE_ERROR;
+	}
+
+	return ret;
+}
-- 
2.45.2


