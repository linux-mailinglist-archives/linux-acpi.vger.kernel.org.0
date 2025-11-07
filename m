Return-Path: <linux-acpi+bounces-18656-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A3BC3FF3D
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 13:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB98188276C
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 12:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785BF32D444;
	Fri,  7 Nov 2025 12:38:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56323271EC;
	Fri,  7 Nov 2025 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762519092; cv=none; b=kwsPeI6ln7GPWvOznOYnmNwwjqqINR5gFoxiy8sAIqb5Wjahpt+8cXq6vO4ZHT5k49gZsaHnIB6YUvExOdcHq0rgvs5NW4E0pX1B9uBq72VaBFG0kUD2YMOFSXdrClZJMw1TFZvzJlAG22sNSrwVDF1xXXSQwewXNBKfrc36YU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762519092; c=relaxed/simple;
	bh=J05Up4NeCCqMQMzDQ3YdhYaXbu3zXuJAYeXHQysZbdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srP6jBFoqONwY9lQQrWQ5jqguUpx5BQDQ9RCMYxjwyPVTRaAAgFwlHWjoHVdSRERjncjtCl3ixV6CQLIq/c/0pdboKzuGAsBYjqBwTNuZdFHJUv9E9BT0gfJUF1jzcztYh35pGaj9w/bx8oA5pr2YpB73cD+tjPEuUnrsrtDMwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB0471515;
	Fri,  7 Nov 2025 04:38:02 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8640E3F66E;
	Fri,  7 Nov 2025 04:38:05 -0800 (PST)
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
	Fenghua Yu <fenghuay@nvdia.com>,
	Ben Horgan <ben.horgan@arm.com>
Subject: [PATCH 31/33] arm_mpam: Add helper to reset saved mbwu state
Date: Fri,  7 Nov 2025 12:34:48 +0000
Message-ID: <20251107123450.664001-32-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107123450.664001-1-ben.horgan@arm.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
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
Reviewed-by: Fenghua Yu <fenghuay@nvdia.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Cc: Peter Newman <peternewman@google.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
Changes since v3:
Correct type checking, use mpam_feat_msmon_mbwu_<n>counter
---
 drivers/resctrl/mpam_devices.c  | 48 ++++++++++++++++++++++++++++++++-
 drivers/resctrl/mpam_internal.h |  2 ++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 59d12ee1195d..eb6417f57e23 100644
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
@@ -1264,6 +1279,37 @@ int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
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
index f3bf26b7fdaf..0061d355ad3e 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -209,6 +209,7 @@ struct mon_cfg {
 /* Changes to msmon_mbwu_state are protected by the msc's mon_sel_lock. */
 struct msmon_mbwu_state {
 	bool		enabled;
+	bool		reset_on_next_read;
 	struct mon_cfg	cfg;
 
 	/*
@@ -368,6 +369,7 @@ int mpam_apply_config(struct mpam_component *comp, u16 partid,
 
 int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
 		    enum mpam_device_features, u64 *val);
+void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct mon_cfg *ctx);
 
 int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
 				   cpumask_t *affinity);
-- 
2.43.0


