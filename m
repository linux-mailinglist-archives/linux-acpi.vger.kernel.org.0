Return-Path: <linux-acpi+bounces-17921-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CA2BEB500
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 21:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB2AF507F9D
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 18:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC2A33B94F;
	Fri, 17 Oct 2025 18:59:18 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223BB393DF6;
	Fri, 17 Oct 2025 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727558; cv=none; b=m52r92Gg560g9f45skl73++BP6u4i/HrqWvNPfbKoZ2TfzLFdFjha58+XE47awstWCwS5JJebu4Px9SKJsObJKwKYA9IhYLHNe69sO5AiFJPdmJAUOafDz8Qb3buDp+jdQ7eGlDN+4xkN1UqTt9z4ry31gMxcIxqgCkG+BmjFKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727558; c=relaxed/simple;
	bh=Mt//lxzU+FtYQIS0DX0CI4b7c/OTyvJYIYTPZljuGz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cigbz3Grf4mP1JYYJaXdxU5ClVcSXo4K2Optl/oj2fQpiP0/wMjBTMHSI4IGlYdRS34q7voTx1mhQW5P4Ro6arkdIaVaJc6P5D6bVSOQ48p8u+mKcgtr0GzoAEBI5gg6O+SfEPOcjJD83AA6HLGvlLt7w8Cc0IiyvfsvEgX8bLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97C5A1515;
	Fri, 17 Oct 2025 11:59:06 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84B0B3F66E;
	Fri, 17 Oct 2025 11:59:09 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Gavin Shan <gshan@redhat.com>
Subject: [PATCH v3 24/29] arm_mpam: Track bandwidth counter state for overflow and power management
Date: Fri, 17 Oct 2025 18:56:40 +0000
Message-Id: <20251017185645.26604-25-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251017185645.26604-1-james.morse@arm.com>
References: <20251017185645.26604-1-james.morse@arm.com>
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

Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v2:
 * Removed bogus 'if (!mbwu_state)' checks.
 * Fixed __allocate_component_cfg() losing error return values.
 * Moved variable definitions into the loop.
 * Removed spurious lockdep assert from mpam_reset_component_cfg().

Changes since v1:
 * Fixed lock/unlock typo.
---
 drivers/resctrl/mpam_devices.c  | 146 +++++++++++++++++++++++++++++++-
 drivers/resctrl/mpam_internal.h |  23 +++++
 2 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index fb5414c6b3eb..deb1dcc6f6b1 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -955,6 +955,7 @@ static void clean_msmon_ctl_val(u32 *cur_ctl)
 static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
 				     u32 flt_val)
 {
+	struct msmon_mbwu_state *mbwu_state;
 	struct mpam_msc *msc = m->ris->vmsc->msc;
 
 	/*
@@ -973,20 +974,31 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
 		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
 		mpam_write_monsel_reg(msc, MBWU, 0);
 		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
+
+		mbwu_state = &m->ris->mbwu_state[m->ctx->mon];
+		mbwu_state->prev_val = 0;
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
@@ -1014,11 +1026,28 @@ static void __ris_msmon_read(void *arg)
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
@@ -1031,7 +1060,6 @@ static void __ris_msmon_read(void *arg)
 		return;
 	}
 
-	now = FIELD_GET(MSMON___VALUE, now);
 	*m->val += now;
 }
 
@@ -1250,6 +1278,67 @@ static int mpam_reprogram_ris(void *_arg)
 	return 0;
 }
 
+/* Call with MSC lock held */
+static int mpam_restore_mbwu_state(void *_ris)
+{
+	int i;
+	struct mon_read mwbu_arg;
+	struct mpam_msc_ris *ris = _ris;
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
+	return 0;
+}
+
+/* Call with MSC lock and held */
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
+		if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
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
+		cfg->pmg = FIELD_GET(MSMON_CFG_x_FLT_PMG, cur_flt);
+		cfg->match_pmg = FIELD_GET(MSMON_CFG_x_CTL_MATCH_PMG, cur_ctl);
+		cfg->partid = FIELD_GET(MSMON_CFG_x_FLT_PARTID, cur_flt);
+		mbwu_state->correction += val;
+		mbwu_state->enabled = FIELD_GET(MSMON_CFG_x_CTL_EN, cur_ctl);
+		mpam_mon_sel_unlock(msc);
+	}
+
+	return 0;
+}
+
 static void mpam_init_reset_cfg(struct mpam_config *reset_cfg)
 {
 	*reset_cfg = (struct mpam_config) {
@@ -1322,6 +1411,9 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
 		 * for non-zero partid may be lost while the CPUs are offline.
 		 */
 		ris->in_reset_state = online;
+
+		if (mpam_is_enabled() && !online)
+			mpam_touch_msc(msc, &mpam_save_mbwu_state, ris);
 	}
 }
 
@@ -1355,6 +1447,9 @@ static void mpam_reprogram_msc(struct mpam_msc *msc)
 			mpam_reprogram_ris_partid(ris, partid, cfg);
 		}
 		ris->in_reset_state = reset;
+
+		if (mpam_has_feature(mpam_feat_msmon_mbwu, &ris->props))
+			mpam_touch_msc(msc, &mpam_restore_mbwu_state, ris);
 	}
 }
 
@@ -2096,7 +2191,22 @@ static void mpam_unregister_irqs(void)
 
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
+		if (mpam_mon_sel_lock(msc)) {
+			list_for_each_entry(ris, &vmsc->ris, vmsc_list)
+				add_to_garbage(ris->mbwu_state);
+			mpam_mon_sel_unlock(msc);
+		}
+	}
 }
 
 static void mpam_reset_component_cfg(struct mpam_component *comp)
@@ -2114,6 +2224,8 @@ static void mpam_reset_component_cfg(struct mpam_component *comp)
 
 static int __allocate_component_cfg(struct mpam_component *comp)
 {
+	struct mpam_vmsc *vmsc;
+
 	mpam_assert_partid_sizes_fixed();
 
 	if (comp->cfg)
@@ -2131,6 +2243,36 @@ static int __allocate_component_cfg(struct mpam_component *comp)
 
 	mpam_reset_component_cfg(comp);
 
+	list_for_each_entry(vmsc, &comp->vmsc, comp_list) {
+		struct mpam_msc *msc;
+		struct mpam_msc_ris *ris;
+		struct msmon_mbwu_state *mbwu_state;
+
+		if (!vmsc->props.num_mbwu_mon)
+			continue;
+
+		msc = vmsc->msc;
+		list_for_each_entry(ris, &vmsc->ris, vmsc_list) {
+			if (!ris->props.num_mbwu_mon)
+				continue;
+
+			mbwu_state = kcalloc(ris->props.num_mbwu_mon,
+					     sizeof(*ris->mbwu_state),
+					     GFP_KERNEL);
+			if (!mbwu_state) {
+				__destroy_component_cfg(comp);
+				return -ENOMEM;
+			}
+
+			init_garbage(&mbwu_state[0].garbage);
+
+			if (mpam_mon_sel_lock(msc)) {
+				ris->mbwu_state = mbwu_state;
+				mpam_mon_sel_unlock(msc);
+			}
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 0c84e945c891..28c475d18d86 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -199,6 +199,26 @@ struct mon_cfg {
 	enum mon_filter_options opts;
 };
 
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
 struct mpam_class {
 	/* mpam_components in this class */
 	struct list_head	components;
@@ -291,6 +311,9 @@ struct mpam_msc_ris {
 	/* parent: */
 	struct mpam_vmsc	*vmsc;
 
+	/* msmon mbwu configuration is preserved over reset */
+	struct msmon_mbwu_state	*mbwu_state;
+
 	struct mpam_garbage	garbage;
 };
 
-- 
2.39.5


