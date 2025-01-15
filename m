Return-Path: <linux-acpi+bounces-10675-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F45A11C49
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 09:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB331188ACDB
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89861EEA55;
	Wed, 15 Jan 2025 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CYPZ0DYl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6AE1E7C0F;
	Wed, 15 Jan 2025 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930575; cv=none; b=giN9diaVEqRSdSJeqPhyeHJdxaxdYmxe00X9xB3NRS0ZeGliotB+lyVWJqisioi3YsCzxZeVwKDaXws8QfgR7TbX8goF4LqIBdi1rvlKrCQ8dJa5VZTVRWldoePvlvyMkERjnSs9CAE/cMdVSA8dG/+CXotbT0ejP7n6xJHTuXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930575; c=relaxed/simple;
	bh=OZ99pcrfx2iqDBltRHeR8gHXuNXtUIUFN2TWSoqf6BA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nLPVHelCj0zSNmk9CNzXL3DKm7eQ4AHK7Xaib6dUJXrTJEW4KoA610pApLpBoU1sAuwY6jRbrnNb2q+sI0qwJqR3KUHOL1L9OCzpjYIXZeK4gjwYWSG8ChVsB9gHBEkfA6S3oTvC3JZ4nvWuU0IkmSX0whndBdmCS2fKeqhMqq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CYPZ0DYl; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736930564; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=HsWp3M42+F04T5O8bZhRK9JAw+edoq0ObaIcimjdwxU=;
	b=CYPZ0DYlby62tbPncR/mNKv8wi4Di5KDNFrvHPmY+owqyndHOgBuk0j/j7MAKadjJ/bZI/erF+XPHapj8Gze6sWCBwbpU7DhJCLv9omupG3wMvSdGb05amprTG2aZpsmIB4qrdG9w0Q5jzVbFiCsyfRYt9q7Xt3CGJbAHu3HXhA=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WNi.6jE_1736930562 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jan 2025 16:42:44 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	lenb@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	yazen.ghannam@amd.com
Cc: tianruidong@linux.alibaba.com
Subject: [PATCH v3 4/5] RAS/ATL: Unified ATL interface for ARM64 and AMD
Date: Wed, 15 Jan 2025 16:42:27 +0800
Message-Id: <20250115084228.107573-5-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20250115084228.107573-1-tianruidong@linux.alibaba.com>
References: <20250115084228.107573-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Translate device normalize address in AMD, also named logical address,
to system physical address is a common interface in RAS. Provides common
interface both for AMD and ARM.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/edac/amd64_edac.c      |  2 +-
 drivers/ras/aest/aest-core.c   | 12 ++++++------
 drivers/ras/amd/atl/core.c     |  4 ++--
 drivers/ras/amd/atl/internal.h |  2 +-
 drivers/ras/amd/atl/umc.c      |  3 ++-
 drivers/ras/ras.c              | 24 +++++++++++-------------
 include/linux/ras.h            |  9 ++++-----
 7 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index ddfbdb66b794..1e9c96e4daa8 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2832,7 +2832,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 	a_err.ipid = m->ipid;
 	a_err.cpu  = m->extcpu;
 
-	sys_addr = amd_convert_umc_mca_addr_to_sys_addr(&a_err);
+	sys_addr = convert_ras_la_to_spa(&a_err);
 	if (IS_ERR_VALUE(sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
 		goto log_error;
diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index 12d0a32ecda9..0530880ded3e 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -228,16 +228,16 @@ static void aest_node_pool_process(struct work_struct *work)
 	llist_for_each_entry(event, head, llnode) {
 		aest_print(event);
 
-		/* TODO: translate Logical Addresses to System Physical Addresses */
+		addr = event->regs.err_addr & (1UL << CONFIG_ARM64_PA_BITS);
+
 		if (event->addressing_mode == AEST_ADDREESS_LA ||
-			(event->regs.err_addr & ERR_ADDR_AI)) {
-			pr_notice("Can not translate LA to SPA\n");
-			addr = 0;
-		} else
+			(event->regs.err_addr & ERR_ADDR_AI))
+			addr = convert_ras_la_to_spa(event);
+		else
 			addr = event->regs.err_addr & (1UL << CONFIG_ARM64_PA_BITS);
 
 		status = event->regs.err_status;
-		if (addr && ((status & ERR_STATUS_UE) || (status & ERR_STATUS_DE)))
+		if (addr > 0 && ((status & ERR_STATUS_UE) || (status & ERR_STATUS_DE)))
 			aest_handle_memory_failure(addr);
 
 		blocking_notifier_call_chain(&aest_decoder_chain, 0, event);
diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
index 4197e10993ac..6b5f0f65bf8e 100644
--- a/drivers/ras/amd/atl/core.c
+++ b/drivers/ras/amd/atl/core.c
@@ -207,7 +207,7 @@ static int __init amd_atl_init(void)
 
 	/* Increment this module's recount so that it can't be easily unloaded. */
 	__module_get(THIS_MODULE);
-	amd_atl_register_decoder(convert_umc_mca_addr_to_sys_addr);
+	atl_register_decoder(convert_umc_mca_addr_to_sys_addr);
 
 	pr_info("AMD Address Translation Library initialized\n");
 	return 0;
@@ -219,7 +219,7 @@ static int __init amd_atl_init(void)
  */
 static void __exit amd_atl_exit(void)
 {
-	amd_atl_unregister_decoder();
+	atl_unregister_decoder();
 }
 
 module_init(amd_atl_init);
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 143d04c779a8..42686189decb 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -277,7 +277,7 @@ int denormalize_address(struct addr_ctx *ctx);
 int dehash_address(struct addr_ctx *ctx);
 
 unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsigned long addr);
-unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
+unsigned long convert_umc_mca_addr_to_sys_addr(void *data);
 
 u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr);
 u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr);
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index dc8aa12f63c8..aa13f7fd7ba4 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -395,8 +395,9 @@ static u8 get_coh_st_inst_id(struct atl_err *err)
 	return FIELD_GET(UMC_CHANNEL_NUM, err->ipid);
 }
 
-unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err)
+unsigned long convert_umc_mca_addr_to_sys_addr(void *data)
 {
+	struct atl_err *err = data;
 	u8 socket_id = topology_physical_package_id(err->cpu);
 	u8 coh_st_inst_id = get_coh_st_inst_id(err);
 	unsigned long addr = get_addr(err->addr);
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index a6e4792a1b2e..e5f23a8279c2 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -10,36 +10,34 @@
 #include <linux/ras.h>
 #include <linux/uuid.h>
 
-#if IS_ENABLED(CONFIG_AMD_ATL)
 /*
  * Once set, this function pointer should never be unset.
  *
  * The library module will set this pointer if it successfully loads. The module
  * should not be unloaded except for testing and debug purposes.
  */
-static unsigned long (*amd_atl_umc_na_to_spa)(struct atl_err *err);
+static unsigned long (*atl_ras_la_to_spa)(void *err);
 
-void amd_atl_register_decoder(unsigned long (*f)(struct atl_err *))
+void atl_register_decoder(unsigned long (*f)(void *))
 {
-	amd_atl_umc_na_to_spa = f;
+	atl_ras_la_to_spa = f;
 }
-EXPORT_SYMBOL_GPL(amd_atl_register_decoder);
+EXPORT_SYMBOL_GPL(atl_register_decoder);
 
-void amd_atl_unregister_decoder(void)
+void atl_unregister_decoder(void)
 {
-	amd_atl_umc_na_to_spa = NULL;
+	atl_ras_la_to_spa = NULL;
 }
-EXPORT_SYMBOL_GPL(amd_atl_unregister_decoder);
+EXPORT_SYMBOL_GPL(atl_unregister_decoder);
 
-unsigned long amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err)
+unsigned long convert_ras_la_to_spa(void *err)
 {
-	if (!amd_atl_umc_na_to_spa)
+	if (!atl_ras_la_to_spa)
 		return -EINVAL;
 
-	return amd_atl_umc_na_to_spa(err);
+	return atl_ras_la_to_spa(err);
 }
-EXPORT_SYMBOL_GPL(amd_convert_umc_mca_addr_to_sys_addr);
-#endif /* CONFIG_AMD_ATL */
+EXPORT_SYMBOL_GPL(convert_ras_la_to_spa);
 
 #define CREATE_TRACE_POINTS
 #define TRACE_INCLUDE_PATH ../../include/ras
diff --git a/include/linux/ras.h b/include/linux/ras.h
index 1c777af6a1af..2e90556779d2 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -43,16 +43,15 @@ struct atl_err {
 };
 
 #if IS_ENABLED(CONFIG_AMD_ATL)
-void amd_atl_register_decoder(unsigned long (*f)(struct atl_err *));
-void amd_atl_unregister_decoder(void);
 void amd_retire_dram_row(struct atl_err *err);
-unsigned long amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
 #else
 static inline void amd_retire_dram_row(struct atl_err *err) { }
-static inline unsigned long
-amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err) { return -EINVAL; }
 #endif /* CONFIG_AMD_ATL */
 
+void atl_register_decoder(unsigned long (*f)(void *));
+void atl_unregister_decoder(void);
+unsigned long convert_ras_la_to_spa(void *err);
+
 #if IS_ENABLED(CONFIG_AEST)
 void aest_register_decode_chain(struct notifier_block *nb);
 void aest_unregister_decode_chain(struct notifier_block *nb);
-- 
2.33.1


