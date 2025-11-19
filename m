Return-Path: <linux-acpi+bounces-19105-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 336E0C6E773
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 13:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 109412ED88
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 12:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B51835A95B;
	Wed, 19 Nov 2025 12:26:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC35F363C70;
	Wed, 19 Nov 2025 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555181; cv=none; b=EDtQa2zV6QVXuR+vZtUzV0DfkCZ313JCq0FWDzAVMQGu9S9bBGT0zu1H3sX0IsLuWAHaZ1Zm1Jyzpm6IbnQSPDhi+G/jAFQbORU6r3hCMEOVtXVX0jUQ9AywoKT+aD8a++tU3NBKmUGOR97Ecd3rMBhzsd9LJFG0n+p97qsFMGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555181; c=relaxed/simple;
	bh=kluSk65iCAzmUqXvUy7ZKe9XGDi2vxCnLbtDu6f2dQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwN2wFITD56oQX7nFp/0iSU/yn79P9fOSxj06mANejviM+sKCFwCgwhDGhume0vK6wyaz87B/fq9xAkBToEFFm4JGTEyeWowjW42PZCn1CgxB2GRvyis9UUXxeTc/76bCWZP/HMYn+jVbYjGkWpoQjbI8PUM4NENH9DHs3YiY8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D7031480;
	Wed, 19 Nov 2025 04:26:11 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB0CE3F740;
	Wed, 19 Nov 2025 04:26:13 -0800 (PST)
From: Ben Horgan <ben.horgan@arm.com>
To: james.morse@arm.com
Cc: amitsinght@marvell.com,
	baisheng.gao@unisoc.com,
	baolin.wang@linux.alibaba.com,
	bobo.shaobowang@huawei.com,
	carl@os.amperecomputing.com,
	catalin.marinas@arm.com,
	dakr@kernel.org,
	dave.martin@arm.com,
	david@redhat.com,
	dfustini@baylibre.com,
	fenghuay@nvidia.com,
	gregkh@linuxfoundation.org,
	gshan@redhat.com,
	guohanjun@huawei.com,
	jeremy.linton@arm.com,
	jonathan.cameron@huawei.com,
	kobak@nvidia.com,
	lcherian@marvell.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org,
	peternewman@google.com,
	quic_jiles@quicinc.com,
	rafael@kernel.org,
	robh@kernel.org,
	rohit.mathew@arm.com,
	scott@os.amperecomputing.com,
	sdonthineni@nvidia.com,
	sudeep.holla@arm.com,
	tan.shaopeng@fujitsu.com,
	will@kernel.org,
	xhao@linux.alibaba.com,
	reinette.chatre@intel.com,
	Fenghua Yu <fenghuay@nvdia.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Zeng Heng <zengheng4@huawei.com>,
	Ben Horgan <ben.horgan@arm.com>
Subject: [PATCH v6 31/34] arm_mpam: Add helper to reset saved mbwu state
Date: Wed, 19 Nov 2025 12:23:01 +0000
Message-ID: <20251119122305.302149-32-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119122305.302149-1-ben.horgan@arm.com>
References: <20251119122305.302149-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Morse <james.morse@arm.com>

resctrl expects to reset the bandwidth counters when the filesystem
is mounted.

To allow this, add a helper that clears the saved mbwu state. Instead
of cross calling to each CPU that can access the component MSC to
write to the counter, set a flag that causes it to be zero'd on the
the next read. This is easily done by forcing a configuration update.

Signed-off-by: James Morse <james.morse@arm.com>
Cc: Peter Newman <peternewman@google.com>
Reviewed-by: Fenghua Yu <fenghuay@nvdia.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com>
Tested-by: Gavin Shan <gshan@redhat.com>
Tested-by: Zeng Heng <zengheng4@huawei.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
Changes since v3:
Correct type checking, use mpam_feat_msmon_mbwu_<n>counter
---
 drivers/resctrl/mpam_devices.c  | 48 ++++++++++++++++++++++++++++++++-
 drivers/resctrl/mpam_internal.h |  2 ++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 0fb08222b91d..b4aa81799429 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1075,6 +1075,7 @@ static void __ris_msmon_read(void *arg)
 	bool overflow;
 	struct mon_read *m = arg;
 	struct mon_cfg *ctx = m->ctx;
+	bool reset_on_next_read = false;
 	struct mpam_msc_ris *ris = m->ris;
 	struct msmon_mbwu_state *mbwu_state;
 	struct mpam_props *rprops = &ris->props;
@@ -1089,6 +1090,20 @@ static void __ris_msmon_read(void *arg)
 		  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
 	mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
 
+	switch (m->type) {
+	case mpam_feat_msmon_mbwu_31counter:
+	case mpam_feat_msmon_mbwu_44counter:
+	case mpam_feat_msmon_mbwu_63counter:
+		mbwu_state = &ris->mbwu_state[ctx->mon];
+		if (mbwu_state) {
+			reset_on_next_read = mbwu_state->reset_on_next_read;
+			mbwu_state->reset_on_next_read = false;
+		}
+		break;
+	default:
+		break;
+	}
+
 	/*
 	 * Read the existing configuration to avoid re-writing the same values.
 	 * This saves waiting for 'nrdy' on subsequent reads.
@@ -1106,7 +1121,7 @@ static void __ris_msmon_read(void *arg)
 	config_mismatch = cur_flt != flt_val ||
 			  cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);
 
-	if (config_mismatch) {
+	if (config_mismatch || reset_on_next_read) {
 		write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
 		overflow = false;
 	} else if (overflow) {
@@ -1263,6 +1278,37 @@ int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
 	return err;
 }
 
+void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct mon_cfg *ctx)
+{
+	struct mpam_msc *msc;
+	struct mpam_vmsc *vmsc;
+	struct mpam_msc_ris *ris;
+
+	if (!mpam_is_enabled())
+		return;
+
+	guard(srcu)(&mpam_srcu);
+	list_for_each_entry_srcu(vmsc, &comp->vmsc, comp_list,
+				 srcu_read_lock_held(&mpam_srcu)) {
+		if (!mpam_has_feature(mpam_feat_msmon_mbwu, &vmsc->props))
+			continue;
+
+		msc = vmsc->msc;
+		list_for_each_entry_srcu(ris, &vmsc->ris, vmsc_list,
+					 srcu_read_lock_held(&mpam_srcu)) {
+			if (!mpam_has_feature(mpam_feat_msmon_mbwu, &ris->props))
+				continue;
+
+			if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
+				continue;
+
+			ris->mbwu_state[ctx->mon].correction = 0;
+			ris->mbwu_state[ctx->mon].reset_on_next_read = true;
+			mpam_mon_sel_unlock(msc);
+		}
+	}
+}
+
 static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
 {
 	u32 num_words, msb;
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 693a315c4710..18d53c07b3d7 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -211,6 +211,7 @@ struct mon_cfg {
 /* Changes to msmon_mbwu_state are protected by the msc's mon_sel_lock. */
 struct msmon_mbwu_state {
 	bool		enabled;
+	bool		reset_on_next_read;
 	struct mon_cfg	cfg;
 
 	/*
@@ -370,6 +371,7 @@ int mpam_apply_config(struct mpam_component *comp, u16 partid,
 
 int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
 		    enum mpam_device_features, u64 *val);
+void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct mon_cfg *ctx);
 
 int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
 				   cpumask_t *affinity);
-- 
2.43.0


