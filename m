Return-Path: <linux-acpi+bounces-19904-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC65CE92E6
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 10:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54D2F3017200
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 09:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CF828A1D5;
	Tue, 30 Dec 2025 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YU5xqCqB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3205277013;
	Tue, 30 Dec 2025 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767086016; cv=none; b=api5GYoDmnSjZOmzZSq+XHEkscvCW+nClLxk43nfbNptMF99S1Fp1pP30BqCwE6xiOFL2J5YiFA8CojVb+g/V6QOwVig+EsRpz0njp9SCDAb89G/NxONT18JZzTHbIjP4qbaA8oFOQIR7F2rZ+r0R5zUu7d0X3nafv/dpp5hc74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767086016; c=relaxed/simple;
	bh=6ucn8f9BDqoSDn7iwYQA3aTzDmGe/48cB++lEHvfZYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SWrgLmM0GViPHexe3by0eDqD91z6pOFoDwDFXLrJOHrUSpY888IjADxrv8TnMipx+8plyoXVyWAQlubitRum4xljNB1KPmy2Cd6BpVX5umbY4CuNIOe/js9sVEvAhCfWOMjsP4a8nG0JXrqdysyqRYLnLFiq+GinPPxdCyBV98k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YU5xqCqB; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767086005; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=nNa/fpvPn0Z1TlWVzlYTuc3CsiURx6FTNkQ2E5NF740=;
	b=YU5xqCqBHlqj+JxKjObByy2ZNb8MHZk/fBY2SQcVFQOXTLaJ5n+BMGSn8F8uOVETT2TZagdORWh/+k9dh7eKDsZ6CL9YJ94kvucWMLEEckLhX4veekXI7lVi6qhEFXjbbZjC3eX3H+YoHgMhRdFyk7XicHfIXktJE96BMxccNQw=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WvzYKvz_1767086003 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Dec 2025 17:13:25 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	lenb@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	yazen.ghannam@amd.com,
	misono.tomohiro@fujitsu.com,
	fengwei_yin@linux.alibaba.com
Cc: tianruidong@linux.alibaba.com
Subject: [PATCH v5 14/17] ras: ATL: Unify ATL interface for ARM64 and AMD
Date: Tue, 30 Dec 2025 17:13:22 +0800
Message-Id: <20251230091322.50015-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20251230090945.43969-1-tianruidong@linux.alibaba.com>
References: <20251230090945.43969-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain components report errors using their internal physical
addresses. For instance, on AMD platforms, the UMC reports
normalized addresses, while on Arm systems, memory controllers
may report logical addresses. These addresses must be translated
into System Physical Addresses (SPA) before the OS can utilize
them effectively.

AMD already provides the amd_atl_umc_na_to_spa interface for
physical address translation. This patch introduces a common
function, atl_ras_la_to_spa, intended for use by both AMD and
Arm64 architectures. The parameters of this function are
architecture-specific data required for the address translation
process.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/edac/amd64_edac.c      |  2 +-
 drivers/ras/aest/aest-core.c   |  3 +++
 drivers/ras/amd/atl/core.c     |  4 ++--
 drivers/ras/amd/atl/internal.h |  2 +-
 drivers/ras/amd/atl/umc.c      |  5 +++--
 drivers/ras/amd/fmpm.c         |  2 +-
 drivers/ras/ras.c              | 24 +++++++++++-------------
 include/linux/ras.h            |  9 ++++-----
 8 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2391f3469961..478cfef37892 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2847,7 +2847,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 	a_err.ipid = m->ipid;
 	a_err.cpu  = m->extcpu;
 
-	sys_addr = amd_convert_umc_mca_addr_to_sys_addr(&a_err);
+	sys_addr = convert_ras_la_to_spa(&a_err);
 	if (IS_ERR_VALUE(sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
 		goto log_error;
diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index a290b482bf8b..052211ca3e2a 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -235,6 +235,9 @@ static void aest_node_pool_process(struct work_struct *work)
 		    (status & (ERR_STATUS_UE | ERR_STATUS_DE))) {
 			if (event->addressing_mode == AEST_ADDREESS_SPA)
 				addr = event->regs.err_addr & PHYS_MASK;
+			else
+				addr = convert_ras_la_to_spa(event);
+
 			aest_handle_memory_failure(addr);
 		}
 
diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
index 0f7cd6dab0b0..4f44c0ce97ec 100644
--- a/drivers/ras/amd/atl/core.c
+++ b/drivers/ras/amd/atl/core.c
@@ -210,7 +210,7 @@ static int __init amd_atl_init(void)
 
 	/* Increment this module's recount so that it can't be easily unloaded. */
 	__module_get(THIS_MODULE);
-	amd_atl_register_decoder(convert_umc_mca_addr_to_sys_addr);
+	atl_register_decoder(convert_umc_mca_addr_to_sys_addr);
 
 	pr_info("AMD Address Translation Library initialized\n");
 	return 0;
@@ -222,7 +222,7 @@ static int __init amd_atl_init(void)
  */
 static void __exit amd_atl_exit(void)
 {
-	amd_atl_unregister_decoder();
+	atl_unregister_decoder();
 }
 
 module_init(amd_atl_init);
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 82a56d9c2be1..423a6193fdc7 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -279,7 +279,7 @@ int denormalize_address(struct addr_ctx *ctx);
 int dehash_address(struct addr_ctx *ctx);
 
 unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsigned long addr);
-unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
+unsigned long convert_umc_mca_addr_to_sys_addr(void *data);
 
 u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr);
 u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr);
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index befc616d5e8a..a688550604bd 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -318,7 +318,7 @@ static void _retire_row_mi300(struct atl_err *a_err)
 		a_err->addr &= ~MI300_UMC_MCA_COL;
 		a_err->addr |= FIELD_PREP(MI300_UMC_MCA_COL, col);
 
-		addr = amd_convert_umc_mca_addr_to_sys_addr(a_err);
+		addr = convert_ras_la_to_spa(a_err);
 		if (IS_ERR_VALUE(addr))
 			continue;
 
@@ -399,8 +399,9 @@ static u8 get_coh_st_inst_id(struct atl_err *err)
 	return FIELD_GET(UMC_CHANNEL_NUM, err->ipid);
 }
 
-unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err)
+unsigned long convert_umc_mca_addr_to_sys_addr(void *data)
 {
+	struct atl_err *err = data;
 	u8 socket_id = topology_physical_package_id(err->cpu);
 	u8 coh_st_inst_id = get_coh_st_inst_id(err);
 	unsigned long addr = get_addr(err->addr);
diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 8877c6ff64c4..d9fdd367644f 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -333,7 +333,7 @@ static void save_spa(struct fru_rec *rec, unsigned int entry,
 	a_err.ipid = id;
 	a_err.cpu  = cpu;
 
-	spa = amd_convert_umc_mca_addr_to_sys_addr(&a_err);
+	spa = convert_ras_la_to_spa(&a_err);
 	if (IS_ERR_VALUE(spa)) {
 		pr_debug("Failed to get system address\n");
 		return;
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 2a5b5a9fdcb3..050b49466a18 100644
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
index 05096f049dac..2270a8eb1038 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -42,14 +42,9 @@ struct atl_err {
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
 
 #if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
@@ -63,6 +58,10 @@ amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err) { return -EINVAL; }
 #define GET_LOGICAL_INDEX(mpidr) -EINVAL
 #endif /* CONFIG_ARM || CONFIG_ARM64 */
 
+void atl_register_decoder(unsigned long (*f)(void *));
+void atl_unregister_decoder(void);
+unsigned long convert_ras_la_to_spa(void *err);
+
 #if IS_ENABLED(CONFIG_AEST)
 void aest_register_decode_chain(struct notifier_block *nb);
 void aest_unregister_decode_chain(struct notifier_block *nb);
-- 
2.47.3


