Return-Path: <linux-acpi+bounces-18648-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6612C3FF0A
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 13:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5681899638
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 12:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C1C306B00;
	Fri,  7 Nov 2025 12:37:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C304307AF9;
	Fri,  7 Nov 2025 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762519050; cv=none; b=VUteUWayEcqFcZS5MGCm4zwvvjnHyqXhwOEcvQdGVHXWuudAYmf3r/9Q3IacgJ2dp5DUU8qljQQZhTSU110naBHrID7GL53ggLKQHp7gyEFrNeUZsLy61R3hjWxWPM4R7nK22goccC+LC7jjO9lohHtSUhaLexT/Z8FuPqLgFws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762519050; c=relaxed/simple;
	bh=s1Pxr22YRlS198RX7nji91ta5XO6bz61EcgrEMhh1qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKL8W7EImA8D5z97utHxD1jk84p6rf+x9BbLZVS+8HYWaz4yf2JEjZO5HxawTRgS6U6Z+K6kNUH9D7pDZ+7zl9DP3KVElW/SIgyCIEqLqr9BXAtpSYdL5IARJThoCVM6AxJqE8HoI46TPyU7hFNdN7IfIWVjmjaUqwyE2jQymdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A06931515;
	Fri,  7 Nov 2025 04:37:20 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 747E33F66E;
	Fri,  7 Nov 2025 04:37:23 -0800 (PST)
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
	Dave Martin <Dave.Martin@arm.com>,
	Ben Horgan <ben.horgan@arm.com>
Subject: [PATCH 23/33] arm_mpam: Allow configuration to be applied and restored during cpu online
Date: Fri,  7 Nov 2025 12:34:40 +0000
Message-ID: <20251107123450.664001-24-ben.horgan@arm.com>
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

When CPUs come online the MSC's original configuration should be restored.

Add struct mpam_config to hold the configuration. This has a bitmap of
features that were modified. Once the maximum partid is known, allocate
a configuration array for each component, and reprogram each RIS
configuration from this.

CC: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Cc: Shaopeng Tan (Fujitsu) tan.shaopeng@fujitsu.com
Cc: Peter Newman peternewman@google.com
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
Changes since v3:
Drop tags
Fix component reset, otherwise cpbm wrong and controls not set.
Add a cfg_lock to guard configuration of an msc
---
 drivers/resctrl/mpam_devices.c  | 268 ++++++++++++++++++++++++++++++--
 drivers/resctrl/mpam_internal.h |  27 ++++
 2 files changed, 280 insertions(+), 15 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 3a0ad8d93fff..8b0944bdaf28 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -144,6 +144,16 @@ static void mpam_free_garbage(void)
 	}
 }
 
+/*
+ * Once mpam is enabled, new requestors cannot further reduce the available
+ * partid. Assert that the size is fixed, and new requestors will be turned
+ * away.
+ */
+static void mpam_assert_partid_sizes_fixed(void)
+{
+	WARN_ON_ONCE(!partid_max_published);
+}
+
 static u32 __mpam_read_reg(struct mpam_msc *msc, u16 reg)
 {
 	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
@@ -343,6 +353,7 @@ mpam_component_alloc(struct mpam_class *class, int id)
 	return comp;
 }
 
+static void __destroy_component_cfg(struct mpam_component *comp);
 static void mpam_class_destroy(struct mpam_class *class);
 
 static void mpam_component_destroy(struct mpam_component *comp)
@@ -351,6 +362,8 @@ static void mpam_component_destroy(struct mpam_component *comp)
 
 	lockdep_assert_held(&mpam_list_lock);
 
+	__destroy_component_cfg(comp);
+
 	list_del_rcu(&comp->class_list);
 	add_to_garbage(comp);
 
@@ -820,31 +833,59 @@ static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
 	__mpam_write_reg(msc, reg, bm);
 }
 
-static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
+/* Called via IPI. Call while holding an SRCU reference */
+static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
+				      struct mpam_config *cfg)
 {
 	struct mpam_msc *msc = ris->vmsc->msc;
 	struct mpam_props *rprops = &ris->props;
 
-	WARN_ON_ONCE(!srcu_read_lock_held((&mpam_srcu)));
-
 	mutex_lock(&msc->part_sel_lock);
 	__mpam_part_sel(ris->ris_idx, partid, msc);
 
-	if (mpam_has_feature(mpam_feat_cpor_part, rprops))
-		mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM, rprops->cpbm_wd);
+	if (mpam_has_feature(mpam_feat_cpor_part, rprops) &&
+	    mpam_has_feature(mpam_feat_cpor_part, cfg)) {
+		if (cfg->reset_cpbm)
+			mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM,
+					      rprops->cpbm_wd);
+		else
+			mpam_write_partsel_reg(msc, CPBM, cfg->cpbm);
+	}
 
-	if (mpam_has_feature(mpam_feat_mbw_part, rprops))
-		mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM, rprops->mbw_pbm_bits);
+	if (mpam_has_feature(mpam_feat_mbw_part, rprops) &&
+	    mpam_has_feature(mpam_feat_mbw_part, cfg)) {
+		if (cfg->reset_mbw_pbm)
+			mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM,
+					      rprops->mbw_pbm_bits);
+		else
+			mpam_write_partsel_reg(msc, MBW_PBM, cfg->mbw_pbm);
+	}
 
-	if (mpam_has_feature(mpam_feat_mbw_min, rprops))
+	if (mpam_has_feature(mpam_feat_mbw_min, rprops) &&
+	    mpam_has_feature(mpam_feat_mbw_min, cfg))
 		mpam_write_partsel_reg(msc, MBW_MIN, 0);
 
-	if (mpam_has_feature(mpam_feat_mbw_max, rprops))
-		mpam_write_partsel_reg(msc, MBW_MAX, MPAMCFG_MBW_MAX_MAX);
+	if (mpam_has_feature(mpam_feat_mbw_max, rprops) &&
+	    mpam_has_feature(mpam_feat_mbw_max, cfg)) {
+		if (cfg->reset_mbw_max)
+			mpam_write_partsel_reg(msc, MBW_MAX, MPAMCFG_MBW_MAX_MAX);
+		else
+			mpam_write_partsel_reg(msc, MBW_MAX, cfg->mbw_max);
+	}
 
 	mutex_unlock(&msc->part_sel_lock);
 }
 
+static void mpam_init_reset_cfg(struct mpam_config *reset_cfg)
+{
+	*reset_cfg = (struct mpam_config) {
+		.reset_cpbm = true,
+		.reset_mbw_pbm = true,
+		.reset_mbw_max = true,
+	};
+	bitmap_fill(reset_cfg->features, MPAM_FEATURE_LAST);
+}
+
 /*
  * Called via smp_call_on_cpu() to prevent migration, while still being
  * pre-emptible. Caller must hold mpam_srcu.
@@ -852,16 +893,19 @@ static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
 static int mpam_reset_ris(void *arg)
 {
 	u16 partid, partid_max;
+	struct mpam_config reset_cfg;
 	struct mpam_msc_ris *ris = arg;
 
 	if (ris->in_reset_state)
 		return 0;
 
+	mpam_init_reset_cfg(&reset_cfg);
+
 	spin_lock(&partid_max_lock);
 	partid_max = mpam_partid_max;
 	spin_unlock(&partid_max_lock);
 	for (partid = 0; partid <= partid_max; partid++)
-		mpam_reset_ris_partid(ris, partid);
+		mpam_reprogram_ris_partid(ris, partid, &reset_cfg);
 
 	return 0;
 }
@@ -894,6 +938,7 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
 {
 	struct mpam_msc_ris *ris;
 
+	mutex_lock(&msc->cfg_lock);
 	list_for_each_entry_srcu(ris, &msc->ris, msc_list, srcu_read_lock_held(&mpam_srcu)) {
 		mpam_touch_msc(msc, &mpam_reset_ris, ris);
 
@@ -903,6 +948,61 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
 		 */
 		ris->in_reset_state = online;
 	}
+	mutex_unlock(&msc->cfg_lock);
+}
+
+struct mpam_write_config_arg {
+	struct mpam_msc_ris *ris;
+	struct mpam_component *comp;
+	u16 partid;
+};
+
+static int __write_config(void *arg)
+{
+	struct mpam_write_config_arg *c = arg;
+
+	mpam_reprogram_ris_partid(c->ris, c->partid, &c->comp->cfg[c->partid]);
+
+	return 0;
+}
+
+static void mpam_reprogram_msc(struct mpam_msc *msc)
+{
+	u16 partid;
+	bool reset;
+	struct mpam_config *cfg;
+	struct mpam_msc_ris *ris;
+	struct mpam_write_config_arg arg;
+
+	/*
+	 * No lock for mpam_partid_max as partid_max_published has been
+	 * set by mpam_enabled(), so the values can no longer change.
+	 */
+	mpam_assert_partid_sizes_fixed();
+
+	mutex_lock(&msc->cfg_lock);
+	list_for_each_entry_srcu(ris, &msc->ris, msc_list,
+				 srcu_read_lock_held(&mpam_srcu)) {
+		if (!mpam_is_enabled() && !ris->in_reset_state) {
+			mpam_touch_msc(msc, &mpam_reset_ris, ris);
+			ris->in_reset_state = true;
+			continue;
+		}
+
+		arg.comp = ris->vmsc->comp;
+		arg.ris = ris;
+		reset = true;
+		for (partid = 0; partid <= mpam_partid_max; partid++) {
+			cfg = &ris->vmsc->comp->cfg[partid];
+			if (!bitmap_empty(cfg->features, MPAM_FEATURE_LAST))
+				reset = false;
+
+			arg.partid = partid;
+			mpam_touch_msc(msc, __write_config, &arg);
+		}
+		ris->in_reset_state = reset;
+	}
+	mutex_unlock(&msc->cfg_lock);
 }
 
 static void _enable_percpu_irq(void *_irq)
@@ -926,7 +1026,7 @@ static int mpam_cpu_online(unsigned int cpu)
 			_enable_percpu_irq(&msc->reenable_error_ppi);
 
 		if (atomic_fetch_inc(&msc->online_refs) == 0)
-			mpam_reset_msc(msc, true);
+			mpam_reprogram_msc(msc);
 	}
 
 	return 0;
@@ -1125,6 +1225,9 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
 	if (err)
 		return ERR_PTR(err);
 	err = devm_mutex_init(dev, &msc->error_irq_lock);
+	if (err)
+		return ERR_PTR(err);
+	err = devm_mutex_init(dev, &msc->cfg_lock);
 	if (err)
 		return ERR_PTR(err);
 	mpam_mon_sel_lock_init(msc);
@@ -1585,6 +1688,70 @@ static void mpam_unregister_irqs(void)
 	}
 }
 
+static void __destroy_component_cfg(struct mpam_component *comp)
+{
+	add_to_garbage(comp->cfg);
+}
+
+static void mpam_reset_component_cfg(struct mpam_component *comp)
+{
+	int i;
+	struct mpam_props *cprops = &comp->class->props;
+
+	mpam_assert_partid_sizes_fixed();
+
+	if (!comp->cfg)
+		return;
+
+	for (i = 0; i <= mpam_partid_max; i++) {
+		comp->cfg[i] = (struct mpam_config) {};
+		bitmap_fill(comp->cfg[i].features, MPAM_FEATURE_LAST);
+		bitmap_set((unsigned long *)&comp->cfg[i].cpbm, 0, cprops->cpbm_wd);
+		bitmap_set((unsigned long *)&comp->cfg[i].mbw_pbm, 0, cprops->mbw_pbm_bits);
+		bitmap_set((unsigned long *)&comp->cfg[i].mbw_max, 16 - cprops->bwa_wd, cprops->bwa_wd);
+	}
+}
+
+static int __allocate_component_cfg(struct mpam_component *comp)
+{
+	mpam_assert_partid_sizes_fixed();
+
+	if (comp->cfg)
+		return 0;
+
+	comp->cfg = kcalloc(mpam_partid_max + 1, sizeof(*comp->cfg), GFP_KERNEL);
+	if (!comp->cfg)
+		return -ENOMEM;
+
+	/*
+	 * The array is free()d in one go, so only cfg[0]'s structure needs
+	 * to be initialised.
+	 */
+	init_garbage(&comp->cfg[0].garbage);
+
+	mpam_reset_component_cfg(comp);
+
+	return 0;
+}
+
+static int mpam_allocate_config(void)
+{
+	struct mpam_class *class;
+	struct mpam_component *comp;
+
+	lockdep_assert_held(&mpam_list_lock);
+
+	list_for_each_entry(class, &mpam_classes, classes_list) {
+		list_for_each_entry(comp, &class->components, class_list) {
+			int err = __allocate_component_cfg(comp);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 static void mpam_enable_once(void)
 {
 	int err;
@@ -1604,15 +1771,25 @@ static void mpam_enable_once(void)
 	 */
 	cpus_read_lock();
 	mutex_lock(&mpam_list_lock);
-	mpam_enable_merge_features(&mpam_classes);
+	do {
+		mpam_enable_merge_features(&mpam_classes);
 
-	err = mpam_register_irqs();
+		err = mpam_register_irqs();
+		if (err) {
+			pr_warn("Failed to register irqs: %d\n", err);
+			break;
+		}
 
+		err = mpam_allocate_config();
+		if (err) {
+			pr_err("Failed to allocate configuration arrays.\n");
+			break;
+		}
+	} while (0);
 	mutex_unlock(&mpam_list_lock);
 	cpus_read_unlock();
 
 	if (err) {
-		pr_warn("Failed to register irqs: %d\n", err);
 		mpam_disable_reason = "Failed to enable.";
 		schedule_work(&mpam_broken_work);
 		return;
@@ -1632,6 +1809,9 @@ static void mpam_reset_component_locked(struct mpam_component *comp)
 	struct mpam_vmsc *vmsc;
 
 	lockdep_assert_cpus_held();
+	mpam_assert_partid_sizes_fixed();
+
+	mpam_reset_component_cfg(comp);
 
 	guard(srcu)(&mpam_srcu);
 	list_for_each_entry_srcu(vmsc, &comp->vmsc, comp_list,
@@ -1732,6 +1912,64 @@ void mpam_enable(struct work_struct *work)
 		mpam_enable_once();
 }
 
+#define maybe_update_config(cfg, feature, newcfg, member, changes) do { \
+	if (mpam_has_feature(feature, newcfg) &&			\
+	    (newcfg)->member != (cfg)->member) {			\
+		(cfg)->member = (newcfg)->member;			\
+		mpam_set_feature(feature, cfg);				\
+									\
+		(changes) = true;					\
+	}								\
+} while (0)
+
+static bool mpam_update_config(struct mpam_config *cfg,
+			       const struct mpam_config *newcfg)
+{
+	bool has_changes = false;
+
+	maybe_update_config(cfg, mpam_feat_cpor_part, newcfg, cpbm, has_changes);
+	maybe_update_config(cfg, mpam_feat_mbw_part, newcfg, mbw_pbm, has_changes);
+	maybe_update_config(cfg, mpam_feat_mbw_max, newcfg, mbw_max, has_changes);
+
+	return has_changes;
+}
+
+int mpam_apply_config(struct mpam_component *comp, u16 partid,
+		      struct mpam_config *cfg)
+{
+	struct mpam_write_config_arg arg;
+	struct mpam_msc_ris *ris;
+	struct mpam_vmsc *vmsc;
+	struct mpam_msc *msc;
+
+	lockdep_assert_cpus_held();
+
+	/* Don't pass in the current config! */
+	WARN_ON_ONCE(&comp->cfg[partid] == cfg);
+
+	if (!mpam_update_config(&comp->cfg[partid], cfg))
+		return 0;
+
+	arg.comp = comp;
+	arg.partid = partid;
+
+	guard(srcu)(&mpam_srcu);
+	list_for_each_entry_srcu(vmsc, &comp->vmsc, comp_list,
+				 srcu_read_lock_held(&mpam_srcu)) {
+		msc = vmsc->msc;
+
+		mutex_lock(&msc->cfg_lock);
+		list_for_each_entry_srcu(ris, &vmsc->ris, vmsc_list,
+					 srcu_read_lock_held(&mpam_srcu)) {
+			arg.ris = ris;
+			mpam_touch_msc(msc, __write_config, &arg);
+		}
+		mutex_unlock(&msc->cfg_lock);
+	}
+
+	return 0;
+}
+
 static int __init mpam_msc_driver_init(void)
 {
 	if (!system_supports_mpam())
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index c6937161877a..842d32f148b5 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -91,6 +91,9 @@ struct mpam_msc {
 	 */
 	struct mutex		part_sel_lock;
 
+	/* cfg_lock protects the msc configuration. */
+	struct mutex		cfg_lock;
+
 	/*
 	 * mon_sel_lock protects access to the MSC hardware registers that are
 	 * affected by MPAMCFG_MON_SEL, and the mbwu_state.
@@ -180,6 +183,21 @@ struct mpam_class {
 	struct mpam_garbage	garbage;
 };
 
+struct mpam_config {
+	/* Which configuration values are valid. */
+	DECLARE_BITMAP(features, MPAM_FEATURE_LAST);
+
+	u32	cpbm;
+	u32	mbw_pbm;
+	u16	mbw_max;
+
+	bool	reset_cpbm;
+	bool	reset_mbw_pbm;
+	bool	reset_mbw_max;
+
+	struct mpam_garbage	garbage;
+};
+
 struct mpam_component {
 	u32			comp_id;
 
@@ -188,6 +206,12 @@ struct mpam_component {
 
 	cpumask_t		affinity;
 
+	/*
+	 * Array of configuration values, indexed by partid.
+	 * Read from cpuhp callbacks, hold the cpuhp lock when writing.
+	 */
+	struct mpam_config	*cfg;
+
 	/* member of mpam_class:components */
 	struct list_head	class_list;
 
@@ -247,6 +271,9 @@ extern u8 mpam_pmg_max;
 void mpam_enable(struct work_struct *work);
 void mpam_disable(struct work_struct *work);
 
+int mpam_apply_config(struct mpam_component *comp, u16 partid,
+		      struct mpam_config *cfg);
+
 int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
 				   cpumask_t *affinity);
 
-- 
2.43.0


