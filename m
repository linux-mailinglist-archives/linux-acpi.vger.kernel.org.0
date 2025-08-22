Return-Path: <linux-acpi+bounces-15937-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9345B31EE4
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 17:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D3CE4E6C81
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 15:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D8A25B2FE;
	Fri, 22 Aug 2025 15:33:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093411D9663;
	Fri, 22 Aug 2025 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876826; cv=none; b=dV+R5/xypNCJi9s3yTyRHmWy71u2QDYs/OPJu5UJsZTWr0U+jUQzcLZF/gcIjWN4Hkpv/DMOAn54ecRwFmk+VdgWava2ZLhoUjqnGn3rNkaObWvyaxyro/p6AfFDAHP7UUVhgGOdzQi+LbjJfTWYZwQds6UKgdH+lLdOM2j3N1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876826; c=relaxed/simple;
	bh=e/v02KhRV9ZA3YNW1CPUZQu2Vj4wjqyoRUt+Zwhciqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GDJCV/qBppD1fSv25lMxT62wJTdIRekav+igGjbPJeYJXYspF4V8/yxo66SlzcKzo6uWllJ5tZzSJJS5kGaraAW3cl3boSorBIMbSyXezLgBtmhYh86K28iI9rkZgdvnpDYHJP2AO/qvCR5b0u4mVkumjbtsYfk6ICJb0M7oS/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AD3E2880;
	Fri, 22 Aug 2025 08:33:36 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 541EB3F63F;
	Fri, 22 Aug 2025 08:33:39 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	fenghuay@nvidia.com,
	baisheng.gao@unisoc.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rob Herring <robh@kernel.org>,
	Rohit Mathew <rohit.mathew@arm.com>,
	Rafael Wysocki <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 28/33] arm_mpam: Track bandwidth counter state for overflow and power management
Date: Fri, 22 Aug 2025 15:30:09 +0000
Message-Id: <20250822153048.2287-29-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250822153048.2287-1-james.morse@arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bandwidth counters need to run continuously to correctly reflect the
bandwidth.

The value read may be lower than the previous value read in the case
of overflow and when the hardware is reset due to CPU hotplug.

Add struct mbwu_state to track the bandwidth counter to allow overflow
and power management to be handled.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/resctrl/mpam_devices.c  | 163 +++++++++++++++++++++++++++++++-
 drivers/resctrl/mpam_internal.h |  54 ++++++++---
 2 files changed, 200 insertions(+), 17 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 9ce771aaf671..11be34b54643 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1004,6 +1004,7 @@ static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
 	*ctl_val |= MSMON_CFG_x_CTL_MATCH_PARTID;
 
 	*flt_val = FIELD_PREP(MSMON_CFG_MBWU_FLT_PARTID, ctx->partid);
+	*flt_val |= FIELD_PREP(MSMON_CFG_MBWU_FLT_RWBW, ctx->opts);
 	if (m->ctx->match_pmg) {
 		*ctl_val |= MSMON_CFG_x_CTL_MATCH_PMG;
 		*flt_val |= FIELD_PREP(MSMON_CFG_MBWU_FLT_PMG, ctx->pmg);
@@ -1041,6 +1042,7 @@ static void clean_msmon_ctl_val(u32 *cur_ctl)
 static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
 				     u32 flt_val)
 {
+	struct msmon_mbwu_state *mbwu_state;
 	struct mpam_msc *msc = m->ris->vmsc->msc;
 
 	/*
@@ -1059,20 +1061,32 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
 		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
 		mpam_write_monsel_reg(msc, MBWU, 0);
 		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
+
+		mbwu_state = &m->ris->mbwu_state[m->ctx->mon];
+		if (mbwu_state)
+			mbwu_state->prev_val = 0;
+
 		break;
 	default:
 		return;
 	}
 }
 
+static u64 mpam_msmon_overflow_val(struct mpam_msc_ris *ris)
+{
+	/* TODO: scaling, and long counters */
+	return GENMASK_ULL(30, 0);
+}
+
 /* Call with MSC lock held */
 static void __ris_msmon_read(void *arg)
 {
-	u64 now;
 	bool nrdy = false;
 	struct mon_read *m = arg;
+	u64 now, overflow_val = 0;
 	struct mon_cfg *ctx = m->ctx;
 	struct mpam_msc_ris *ris = m->ris;
+	struct msmon_mbwu_state *mbwu_state;
 	struct mpam_props *rprops = &ris->props;
 	struct mpam_msc *msc = m->ris->vmsc->msc;
 	u32 mon_sel, ctl_val, flt_val, cur_ctl, cur_flt;
@@ -1100,11 +1114,30 @@ static void __ris_msmon_read(void *arg)
 		now = mpam_read_monsel_reg(msc, CSU);
 		if (mpam_has_feature(mpam_feat_msmon_csu_hw_nrdy, rprops))
 			nrdy = now & MSMON___NRDY;
+		now = FIELD_GET(MSMON___VALUE, now);
 		break;
 	case mpam_feat_msmon_mbwu:
 		now = mpam_read_monsel_reg(msc, MBWU);
 		if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops))
 			nrdy = now & MSMON___NRDY;
+		now = FIELD_GET(MSMON___VALUE, now);
+
+		if (nrdy)
+			break;
+
+		mbwu_state = &ris->mbwu_state[ctx->mon];
+		if (!mbwu_state)
+			break;
+
+		/* Add any pre-overflow value to the mbwu_state->val */
+		if (mbwu_state->prev_val > now)
+			overflow_val = mpam_msmon_overflow_val(ris) - mbwu_state->prev_val;
+
+		mbwu_state->prev_val = now;
+		mbwu_state->correction += overflow_val;
+
+		/* Include bandwidth consumed before the last hardware reset */
+		now += mbwu_state->correction;
 		break;
 	default:
 		m->err = -EINVAL;
@@ -1117,7 +1150,6 @@ static void __ris_msmon_read(void *arg)
 		return;
 	}
 
-	now = FIELD_GET(MSMON___VALUE, now);
 	*m->val += now;
 }
 
@@ -1329,6 +1361,72 @@ static int mpam_reprogram_ris(void *_arg)
 	return 0;
 }
 
+/* Call with MSC lock and outer mon_sel lock held */
+static int mpam_restore_mbwu_state(void *_ris)
+{
+	int i;
+	struct mon_read mwbu_arg;
+	struct mpam_msc_ris *ris = _ris;
+	struct mpam_msc *msc = ris->vmsc->msc;
+
+	mpam_mon_sel_outer_lock(msc);
+
+	for (i = 0; i < ris->props.num_mbwu_mon; i++) {
+		if (ris->mbwu_state[i].enabled) {
+			mwbu_arg.ris = ris;
+			mwbu_arg.ctx = &ris->mbwu_state[i].cfg;
+			mwbu_arg.type = mpam_feat_msmon_mbwu;
+
+			__ris_msmon_read(&mwbu_arg);
+		}
+	}
+
+	mpam_mon_sel_outer_unlock(msc);
+
+	return 0;
+}
+
+/* Call with MSC lock and outer mon_sel lock held */
+static int mpam_save_mbwu_state(void *arg)
+{
+	int i;
+	u64 val;
+	struct mon_cfg *cfg;
+	u32 cur_flt, cur_ctl, mon_sel;
+	struct mpam_msc_ris *ris = arg;
+	struct msmon_mbwu_state *mbwu_state;
+	struct mpam_msc *msc = ris->vmsc->msc;
+
+	for (i = 0; i < ris->props.num_mbwu_mon; i++) {
+		mbwu_state = &ris->mbwu_state[i];
+		cfg = &mbwu_state->cfg;
+
+		if (WARN_ON_ONCE(!mpam_mon_sel_inner_lock(msc)))
+			return -EIO;
+
+		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
+			  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
+		mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
+
+		cur_flt = mpam_read_monsel_reg(msc, CFG_MBWU_FLT);
+		cur_ctl = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
+		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
+
+		val = mpam_read_monsel_reg(msc, MBWU);
+		mpam_write_monsel_reg(msc, MBWU, 0);
+
+		cfg->mon = i;
+		cfg->pmg = FIELD_GET(MSMON_CFG_MBWU_FLT_PMG, cur_flt);
+		cfg->match_pmg = FIELD_GET(MSMON_CFG_x_CTL_MATCH_PMG, cur_ctl);
+		cfg->partid = FIELD_GET(MSMON_CFG_MBWU_FLT_PARTID, cur_flt);
+		mbwu_state->correction += val;
+		mbwu_state->enabled = FIELD_GET(MSMON_CFG_x_CTL_EN, cur_ctl);
+		mpam_mon_sel_inner_unlock(msc);
+	}
+
+	return 0;
+}
+
 /*
  * Called via smp_call_on_cpu() to prevent migration, while still being
  * pre-emptible.
@@ -1389,6 +1487,9 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
 		 * for non-zero partid may be lost while the CPUs are offline.
 		 */
 		ris->in_reset_state = online;
+
+		if (mpam_is_enabled() && !online)
+			mpam_touch_msc(msc, &mpam_save_mbwu_state, ris);
 	}
 	mpam_mon_sel_outer_unlock(msc);
 }
@@ -1423,6 +1524,9 @@ static void mpam_reprogram_msc(struct mpam_msc *msc)
 			mpam_reprogram_ris_partid(ris, partid, cfg);
 		}
 		ris->in_reset_state = reset;
+
+		if (mpam_has_feature(mpam_feat_msmon_mbwu, &ris->props))
+			mpam_touch_msc(msc, &mpam_restore_mbwu_state, ris);
 	}
 }
 
@@ -2291,11 +2395,35 @@ static void mpam_unregister_irqs(void)
 
 static void __destroy_component_cfg(struct mpam_component *comp)
 {
+	struct mpam_msc *msc;
+	struct mpam_vmsc *vmsc;
+	struct mpam_msc_ris *ris;
+
+	lockdep_assert_held(&mpam_list_lock);
+
 	add_to_garbage(comp->cfg);
+	list_for_each_entry(vmsc, &comp->vmsc, comp_list) {
+		msc = vmsc->msc;
+
+		mpam_mon_sel_outer_lock(msc);
+		if (mpam_mon_sel_inner_lock(msc)) {
+			list_for_each_entry(ris, &vmsc->ris, vmsc_list)
+				add_to_garbage(ris->mbwu_state);
+			mpam_mon_sel_inner_unlock(msc);
+		}
+		mpam_mon_sel_outer_lock(msc);
+	}
 }
 
 static int __allocate_component_cfg(struct mpam_component *comp)
 {
+	int err = 0;
+	struct mpam_msc *msc;
+	struct mpam_vmsc *vmsc;
+	struct mpam_msc_ris *ris;
+	struct msmon_mbwu_state *mbwu_state;
+
+	lockdep_assert_held(&mpam_list_lock);
 	mpam_assert_partid_sizes_fixed();
 
 	if (comp->cfg)
@@ -2306,6 +2434,37 @@ static int __allocate_component_cfg(struct mpam_component *comp)
 		return -ENOMEM;
 	init_garbage(comp->cfg);
 
+	list_for_each_entry(vmsc, &comp->vmsc, comp_list) {
+		if (!vmsc->props.num_mbwu_mon)
+			continue;
+
+		msc = vmsc->msc;
+		mpam_mon_sel_outer_lock(msc);
+		list_for_each_entry(ris, &vmsc->ris, vmsc_list) {
+			if (!ris->props.num_mbwu_mon)
+				continue;
+
+			mbwu_state = kcalloc(ris->props.num_mbwu_mon,
+					     sizeof(*ris->mbwu_state),
+					     GFP_KERNEL);
+			if (!mbwu_state) {
+				__destroy_component_cfg(comp);
+				err = -ENOMEM;
+				break;
+			}
+
+			if (mpam_mon_sel_inner_lock(msc)) {
+				init_garbage(mbwu_state);
+				ris->mbwu_state = mbwu_state;
+				mpam_mon_sel_inner_unlock(msc);
+			}
+		}
+		mpam_mon_sel_outer_unlock(msc);
+
+		if (err)
+			break;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 76e406a2b0d1..9a50a5432f4a 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -271,6 +271,42 @@ struct mpam_component {
 	struct mpam_garbage	garbage;
 };
 
+/* The values for MSMON_CFG_MBWU_FLT.RWBW */
+enum mon_filter_options {
+	COUNT_BOTH	= 0,
+	COUNT_WRITE	= 1,
+	COUNT_READ	= 2,
+};
+
+struct mon_cfg {
+	/* mon is wider than u16 to hold an out of range 'USE_RMID_IDX' */
+	u32                     mon;
+	u8                      pmg;
+	bool                    match_pmg;
+	u32                     partid;
+	enum mon_filter_options opts;
+};
+
+/*
+ * Changes to enabled and cfg are protected by the msc->lock.
+ * Changes to prev_val and correction are protected by the msc's mon_sel_lock.
+ */
+struct msmon_mbwu_state {
+	bool		enabled;
+	struct mon_cfg	cfg;
+
+	/* The value last read from the hardware. Used to detect overflow. */
+	u64		prev_val;
+
+	/*
+	 * The value to add to the new reading to account for power management,
+	 * and shifts to trigger the overflow interrupt.
+	 */
+	u64		correction;
+
+	struct mpam_garbage	garbage;
+};
+
 struct mpam_vmsc {
 	/* member of mpam_component:vmsc_list */
 	struct list_head	comp_list;
@@ -306,22 +342,10 @@ struct mpam_msc_ris {
 	/* parent: */
 	struct mpam_vmsc	*vmsc;
 
-	struct mpam_garbage	garbage;
-};
+	/* msmon mbwu configuration is preserved over reset */
+	struct msmon_mbwu_state	*mbwu_state;
 
-/* The values for MSMON_CFG_MBWU_FLT.RWBW */
-enum mon_filter_options {
-	COUNT_BOTH	= 0,
-	COUNT_WRITE	= 1,
-	COUNT_READ	= 2,
-};
-
-struct mon_cfg {
-	u16                     mon;
-	u8                      pmg;
-	bool                    match_pmg;
-	u32                     partid;
-	enum mon_filter_options opts;
+	struct mpam_garbage	garbage;
 };
 
 static inline int mpam_alloc_csu_mon(struct mpam_class *class)
-- 
2.20.1


