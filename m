Return-Path: <linux-acpi+bounces-18958-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B67C6559F
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 18:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 201C029C61
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 17:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34993396F1;
	Mon, 17 Nov 2025 17:02:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003DE337BBC;
	Mon, 17 Nov 2025 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398978; cv=none; b=dIMYa4+N+stGOQ7iGdexNNI843LdDkwYXwIWGiRxKpD2ft8uJL+upzmyG6yRO/w3v0zJylSj0YAuA6+r6dYNIcwn654jwe4ZUq0alkgGha1wOJHmk1nXC2txXS3b4RJquLb20kVwoLg/FD6kv6fJ2V2gqI+gIjhulbddj2oQcjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398978; c=relaxed/simple;
	bh=UHh19tlzRRFWiGkJm3UxipB+GsQqOZ2kid5ax/KO0f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFyArKPpNVTGNqfaqN5EINmifq2i0rnCFUTwt9bAnAenTQzaHVwKT7sLebY1GotyJsnpoSOfAVw9MnVSGKCwNezodAoMzkMM32Kln8JctIydQtklTX3PmGw8itwwe5HdOkz9WQP3JpkbQexc+QUFsWzCNyHnlsUBKbdwbOoygWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9D8E1655;
	Mon, 17 Nov 2025 09:02:48 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5AA943F66E;
	Mon, 17 Nov 2025 09:02:51 -0800 (PST)
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
	Zeng Heng <zengheng4@huawei.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Ben Horgan <ben.horgan@arm.com>
Subject: [PATCH v5 27/34] arm_mpam: Track bandwidth counter state for power management
Date: Mon, 17 Nov 2025 17:00:06 +0000
Message-ID: <20251117170014.4113754-28-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117170014.4113754-1-ben.horgan@arm.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Morse <james.morse@arm.com>

Bandwidth counters need to run continuously to correctly reflect the
bandwidth.

Save the counter state when the hardware is reset due to CPU hotplug.
Add struct mbwu_state to track the bandwidth counter. Support for
tracking overflow with the same structure will be added in a
subsequent commit.

Cc: Zeng Heng <zengheng4@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Zeng Heng <zengheng4@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com>
Tested-by: Gavin Shan <gshan@redhat.com>
Tested-by: Zeng Heng <zengheng4@huawei.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
Changes since v3:
Drop tags
Fix correction accounting
Split out overflow checking
---
 drivers/resctrl/mpam_devices.c  | 126 +++++++++++++++++++++++++++++++-
 drivers/resctrl/mpam_internal.h |  21 +++++-
 2 files changed, 145 insertions(+), 2 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index b229e820673c..7983d492ad9a 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -993,6 +993,7 @@ static void __ris_msmon_read(void *arg)
 	struct mon_read *m = arg;
 	struct mon_cfg *ctx = m->ctx;
 	struct mpam_msc_ris *ris = m->ris;
+	struct msmon_mbwu_state *mbwu_state;
 	struct mpam_props *rprops = &ris->props;
 	struct mpam_msc *msc = m->ris->vmsc->msc;
 	u32 mon_sel, ctl_val, flt_val, cur_ctl, cur_flt;
@@ -1023,11 +1024,21 @@ static void __ris_msmon_read(void *arg)
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
+		/* Include bandwidth consumed before the last hardware reset */
+		now += mbwu_state->correction;
 		break;
 	default:
 		m->err = -EINVAL;
@@ -1039,7 +1050,6 @@ static void __ris_msmon_read(void *arg)
 		return;
 	}
 
-	now = FIELD_GET(MSMON___VALUE, now);
 	*m->val += now;
 }
 
@@ -1235,6 +1245,67 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 	mutex_unlock(&msc->part_sel_lock);
 }
 
+/* Call with msc cfg_lock held */
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
+/* Call with MSC cfg_lock held */
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
@@ -1343,6 +1414,9 @@ static void mpam_reprogram_msc(struct mpam_msc *msc)
 			mpam_touch_msc(msc, __write_config, &arg);
 		}
 		ris->in_reset_state = reset;
+
+		if (mpam_has_feature(mpam_feat_msmon_mbwu, &ris->props))
+			mpam_touch_msc(msc, &mpam_restore_mbwu_state, ris);
 	}
 	mutex_unlock(&msc->cfg_lock);
 }
@@ -1436,6 +1510,9 @@ static int mpam_cpu_offline(unsigned int cpu)
 				 * lost while the CPUs are offline.
 				 */
 				ris->in_reset_state = false;
+
+				if (mpam_is_enabled())
+					mpam_touch_msc(msc, &mpam_save_mbwu_state, ris);
 			}
 			mutex_unlock(&msc->cfg_lock);
 		}
@@ -2109,7 +2186,22 @@ static void mpam_unregister_irqs(void)
 
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
@@ -2135,6 +2227,8 @@ static void mpam_reset_component_cfg(struct mpam_component *comp)
 
 static int __allocate_component_cfg(struct mpam_component *comp)
 {
+	struct mpam_vmsc *vmsc;
+
 	mpam_assert_partid_sizes_fixed();
 
 	if (comp->cfg)
@@ -2152,6 +2246,36 @@ static int __allocate_component_cfg(struct mpam_component *comp)
 
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
index d8f8e29987e0..9c140d8b1e0d 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -91,7 +91,10 @@ struct mpam_msc {
 	 */
 	struct mutex		part_sel_lock;
 
-	/* cfg_lock protects the msc configuration. */
+	/*
+	 * cfg_lock protects the msc configuration and guards against mbwu_state
+	 * save and restore racing.
+	 */
 	struct mutex		cfg_lock;
 
 	/*
@@ -200,6 +203,19 @@ struct mon_cfg {
 	enum mon_filter_options opts;
 };
 
+/* Changes to msmon_mbwu_state are protected by the msc's mon_sel_lock. */
+struct msmon_mbwu_state {
+	bool		enabled;
+	struct mon_cfg	cfg;
+
+	/*
+	 * The value to add to the new reading to account for power management.
+	 */
+	u64		correction;
+
+	struct mpam_garbage	garbage;
+};
+
 struct mpam_class {
 	/* mpam_components in this class */
 	struct list_head	components;
@@ -293,6 +309,9 @@ struct mpam_msc_ris {
 	/* parent: */
 	struct mpam_vmsc	*vmsc;
 
+	/* msmon mbwu configuration is preserved over reset */
+	struct msmon_mbwu_state	*mbwu_state;
+
 	struct mpam_garbage	garbage;
 };
 
-- 
2.43.0


