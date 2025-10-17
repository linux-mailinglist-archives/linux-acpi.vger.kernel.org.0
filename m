Return-Path: <linux-acpi+bounces-17917-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41496BEB505
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 21:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB706E60A5
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 18:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BAB337B94;
	Fri, 17 Oct 2025 18:58:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A653DABE3;
	Fri, 17 Oct 2025 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727536; cv=none; b=nLcwL0UQL4CV3pMTePde/pw3rn1ZNP52CVZd04XAt1aWfbZy1D85kzfcMHx0g2MsWU40rbi9zkVXV7V8qC2cQNjsKcEqCVCXA9Hmzfqvci9ppjLxGVnmhD3aUnDBB2EbeEHcrPOIn3hU9F3KZ54FtvLjmg898j/R5H0S7K+kfaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727536; c=relaxed/simple;
	bh=LENoJScp5FxujcIEwYSfW3q0cau2CBRbr8+joE3TXro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ck/4jARZhlTkzVyOmnM4MOiI/AZHTCV3sEOMV21rqkzAbMOYYEFbmB7pHQJNXflfOpLeMLQv7hnrYJ5to12zh+TV8iNSLVaIQ0a5BWQozGpAz62GMWdAAGAsyTjLZiWgD5DryTeFdWwNpDPHiJ96jKtUW9ycSL7DMDT8jSaz2sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECD281595;
	Fri, 17 Oct 2025 11:58:44 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1AD93F66E;
	Fri, 17 Oct 2025 11:58:47 -0700 (PDT)
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
	Gavin Shan <gshan@redhat.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Ben Horgan <ben.horgan@arm.com>
Subject: [PATCH v3 20/29] arm_mpam: Allow configuration to be applied and restored during cpu online
Date: Fri, 17 Oct 2025 18:56:36 +0000
Message-Id: <20251017185645.26604-21-james.morse@arm.com>
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

When CPUs come online the MSC's original configuration should be restored.

Add struct mpam_config to hold the configuration. This has a bitmap of
features that were modified. Once the maximum partid is known, allocate
a configuration array for each component, and reprogram each RIS
configuration from this.

CC: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
---
Changes since v2:
 * Call mpam_init_reset_cfg() on alloated config as 0 is not longer correct.
 * init_garbage() on each config - the array has to be freed in one go, but
   otherwise this looks weird.
 * Use struct initialiser in mpam_init_reset_cfg(),
 * Moved int err definition.
 * Removed srcu lock taking based on squinting at the only caller.
 * Moved config reset to mpam_reset_component_cfg() for re-use in
   mpam_reset_component_locked(), previous memset() was not enough since zero
   no longer means reset.

Changes since v1:
 * Switched entry_rcu to srcu versions.

Changes since RFC:
 * Added a comment about the ordering around max_partid.
 * Allocate configurations after interrupts are registered to reduce churn.
 * Added mpam_assert_partid_sizes_fixed();
 * Make reset use an all-ones instead of zero config.
---
 drivers/resctrl/mpam_devices.c  | 284 +++++++++++++++++++++++++++++---
 drivers/resctrl/mpam_internal.h |  23 +++
 2 files changed, 287 insertions(+), 20 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index ab37ed1fb5de..e990ef67df5b 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -118,6 +118,17 @@ static inline void init_garbage(struct mpam_garbage *garbage)
 {
 	init_llist_node(&garbage->llist);
 }
+
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
@@ -366,12 +377,16 @@ static void mpam_class_destroy(struct mpam_class *class)
 	add_to_garbage(class);
 }
 
+static void __destroy_component_cfg(struct mpam_component *comp);
+
 static void mpam_comp_destroy(struct mpam_component *comp)
 {
 	struct mpam_class *class = comp->class;
 
 	lockdep_assert_held(&mpam_list_lock);
 
+	__destroy_component_cfg(comp);
+
 	list_del_rcu(&comp->class_list);
 	add_to_garbage(comp);
 
@@ -812,48 +827,102 @@ static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
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
+	    mpam_has_feature(mpam_feat_mbw_max, cfg))
+		mpam_write_partsel_reg(msc, MBW_MAX, cfg->mbw_max);
 
 	mutex_unlock(&msc->part_sel_lock);
 }
 
+struct reprogram_ris {
+	struct mpam_msc_ris *ris;
+	struct mpam_config *cfg;
+};
+
+/* Call with MSC lock held */
+static int mpam_reprogram_ris(void *_arg)
+{
+	u16 partid, partid_max;
+	struct reprogram_ris *arg = _arg;
+	struct mpam_msc_ris *ris = arg->ris;
+	struct mpam_config *cfg = arg->cfg;
+
+	if (ris->in_reset_state)
+		return 0;
+
+	spin_lock(&partid_max_lock);
+	partid_max = mpam_partid_max;
+	spin_unlock(&partid_max_lock);
+	for (partid = 0; partid <= partid_max + 1; partid++)
+		mpam_reprogram_ris_partid(ris, partid, cfg);
+
+	return 0;
+}
+
+static void mpam_init_reset_cfg(struct mpam_config *reset_cfg)
+{
+	*reset_cfg = (struct mpam_config) {
+		.cpbm = ~0,
+		.mbw_pbm = ~0,
+		.mbw_max = MPAMCFG_MBW_MAX_MAX,
+
+		.reset_cpbm = true,
+		.reset_mbw_pbm = true,
+	};
+	bitmap_fill(reset_cfg->features, MPAM_FEATURE_LAST);
+}
+
 /*
  * Called via smp_call_on_cpu() to prevent migration, while still being
  * pre-emptible. Caller must hold mpam_srcu.
  */
 static int mpam_reset_ris(void *arg)
 {
-	u16 partid, partid_max;
+	struct mpam_config reset_cfg;
 	struct mpam_msc_ris *ris = arg;
+	struct reprogram_ris reprogram_arg;
 
 	if (ris->in_reset_state)
 		return 0;
 
-	spin_lock(&partid_max_lock);
-	partid_max = mpam_partid_max;
-	spin_unlock(&partid_max_lock);
-	for (partid = 0; partid < partid_max + 1; partid++)
-		mpam_reset_ris_partid(ris, partid);
+	mpam_init_reset_cfg(&reset_cfg);
+
+	reprogram_arg.ris = ris;
+	reprogram_arg.cfg = &reset_cfg;
+
+	mpam_reprogram_ris(&reprogram_arg);
 
 	return 0;
 }
@@ -897,6 +966,39 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
 	}
 }
 
+static void mpam_reprogram_msc(struct mpam_msc *msc)
+{
+	u16 partid;
+	bool reset;
+	struct mpam_config *cfg;
+	struct mpam_msc_ris *ris;
+
+	/*
+	 * No lock for mpam_partid_max as partid_max_published has been
+	 * set by mpam_enabled(), so the values can no longer change.
+	 */
+	mpam_assert_partid_sizes_fixed();
+
+	list_for_each_entry_srcu(ris, &msc->ris, msc_list,
+				 srcu_read_lock_held(&mpam_srcu)) {
+		if (!mpam_is_enabled() && !ris->in_reset_state) {
+			mpam_touch_msc(msc, &mpam_reset_ris, ris);
+			ris->in_reset_state = true;
+			continue;
+		}
+
+		reset = true;
+		for (partid = 0; partid <= mpam_partid_max; partid++) {
+			cfg = &ris->vmsc->comp->cfg[partid];
+			if (!bitmap_empty(cfg->features, MPAM_FEATURE_LAST))
+				reset = false;
+
+			mpam_reprogram_ris_partid(ris, partid, cfg);
+		}
+		ris->in_reset_state = reset;
+	}
+}
+
 static void _enable_percpu_irq(void *_irq)
 {
 	int *irq = _irq;
@@ -918,7 +1020,7 @@ static int mpam_cpu_online(unsigned int cpu)
 			_enable_percpu_irq(&msc->reenable_error_ppi);
 
 		if (atomic_fetch_inc(&msc->online_refs) == 0)
-			mpam_reset_msc(msc, true);
+			mpam_reprogram_msc(msc);
 	}
 
 	return 0;
@@ -1569,6 +1671,64 @@ static void mpam_unregister_irqs(void)
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
+
+	mpam_assert_partid_sizes_fixed();
+
+	if (!comp->cfg)
+		return;
+
+	for (i = 0; i < mpam_partid_max + 1; i++)
+		mpam_init_reset_cfg(&comp->cfg[i]);
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
+	 * The array is free()d in one go, so only cfg[0]'s struture needs
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
@@ -1588,15 +1748,25 @@ static void mpam_enable_once(void)
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
@@ -1617,6 +1787,9 @@ static void mpam_reset_component_locked(struct mpam_component *comp)
 	struct mpam_vmsc *vmsc;
 
 	lockdep_assert_cpus_held();
+	mpam_assert_partid_sizes_fixed();
+
+	mpam_reset_component_cfg(comp);
 
 	guard(srcu)(&mpam_srcu);
 	list_for_each_entry_srcu(vmsc, &comp->vmsc, comp_list,
@@ -1717,6 +1890,77 @@ void mpam_enable(struct work_struct *work)
 		mpam_enable_once();
 }
 
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
+		list_for_each_entry_srcu(ris, &vmsc->ris, vmsc_list,
+					 srcu_read_lock_held(&mpam_srcu)) {
+			arg.ris = ris;
+			mpam_touch_msc(msc, __write_config, &arg);
+		}
+	}
+
+	return 0;
+}
+
 static int __init mpam_msc_driver_init(void)
 {
 	if (!system_supports_mpam())
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index d492df9a1735..2f2a7369107b 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -182,6 +182,20 @@ struct mpam_class {
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
+
+	struct mpam_garbage	garbage;
+};
+
 struct mpam_component {
 	u32			comp_id;
 
@@ -190,6 +204,12 @@ struct mpam_component {
 
 	cpumask_t		affinity;
 
+	/*
+	 * Array of configuration values, indexed by partid.
+	 * Read from cpuhp callbacks, hold the cpuhp lock when writing.
+	 */
+	struct mpam_config	*cfg;
+
 	/* member of mpam_class:components */
 	struct list_head	class_list;
 
@@ -249,6 +269,9 @@ extern u8 mpam_pmg_max;
 void mpam_enable(struct work_struct *work);
 void mpam_disable(struct work_struct *work);
 
+int mpam_apply_config(struct mpam_component *comp, u16 partid,
+		      struct mpam_config *cfg);
+
 int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
 				   cpumask_t *affinity);
 
-- 
2.39.5


