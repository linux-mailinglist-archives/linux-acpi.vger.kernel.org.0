Return-Path: <linux-acpi+bounces-16640-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FD1B522DC
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 22:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD4418957DE
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 20:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BC02FE04F;
	Wed, 10 Sep 2025 20:45:13 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D3E34166F;
	Wed, 10 Sep 2025 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537113; cv=none; b=i1TT/2Xbedhusn2QlwJEEaFKYcpkjmMqkdMemUyVti+FDPoCeSrLwvf09oY0LScEB0xbzPela5yMvV2/nJnyBg4uE3zx5RDCqfHJM7k382MMN5aut4lQCUTSjlO/eKIhKTE9AjASkY08OGFix7eP13Hybs8pCQuqJMChdSQnnHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537113; c=relaxed/simple;
	bh=o+xFkpUfgOG9TcCM2SUXqYxVokWP+lHkm3PeLjE2MzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BYpJ7/wmdkejaqZwPNg/cABwuMM3hrau7OsNPn0hZBN2IVUnkcDhw5478fAg8iej8u+c7UjB6ojArnjWNeGsRANPkfqCvEAjyXiqOBDQqRm8pCT2/MjZ26GyqjM2DIQZZZPbVRbJEoSjxhKU1ZLfgpFDuAXgsANql16UZ/5ClJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71DC4244C;
	Wed, 10 Sep 2025 13:45:02 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 099733F63F;
	Wed, 10 Sep 2025 13:45:05 -0700 (PDT)
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
	Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v2 20/29] arm_mpam: Allow configuration to be applied and restored during cpu online
Date: Wed, 10 Sep 2025 20:43:00 +0000
Message-Id: <20250910204309.20751-21-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250910204309.20751-1-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
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
---
Changes since v1:
 * Switched entry_rcu to srcu versions.

Changes since RFC:
 * Added a comment about the ordering around max_partid.
 * Allocate configurations after interrupts are registered to reduce churn.
 * Added mpam_assert_partid_sizes_fixed();
 * Make reset use an all-ones instead of zero config.
---
 drivers/resctrl/mpam_devices.c  | 269 +++++++++++++++++++++++++++++---
 drivers/resctrl/mpam_internal.h |  29 +++-
 2 files changed, 271 insertions(+), 27 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index ec1db5f8b05c..7fd149109c75 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -114,6 +114,16 @@ static LLIST_HEAD(mpam_garbage);
 /* When mpam is disabled, the printed reason to aid debugging */
 static char *mpam_disable_reason;
 
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
@@ -363,12 +373,16 @@ static void mpam_class_destroy(struct mpam_class *class)
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
 
@@ -833,50 +847,105 @@ static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
 	__mpam_write_reg(msc, reg, bm);
 }
 
-static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
+/* Called via IPI. Call while holding an SRCU reference */
+static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
+				      struct mpam_config *cfg)
 {
 	struct mpam_msc *msc = ris->vmsc->msc;
 	struct mpam_props *rprops = &ris->props;
 
-	mpam_assert_srcu_read_lock_held();
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
 
-	if (mpam_has_feature(mpam_feat_mbw_prop, rprops))
+	if (mpam_has_feature(mpam_feat_mbw_prop, rprops) &&
+	    mpam_has_feature(mpam_feat_mbw_prop, cfg))
 		mpam_write_partsel_reg(msc, MBW_PROP, 0);
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
+	for (partid = 0; partid <= partid_max; partid++)
+		mpam_reprogram_ris_partid(ris, partid, cfg);
+
+	return 0;
+}
+
+static void mpam_init_reset_cfg(struct mpam_config *reset_cfg)
+{
+	memset(reset_cfg, 0, sizeof(*reset_cfg));
+
+	reset_cfg->features = ~0;
+	reset_cfg->cpbm = ~0;
+	reset_cfg->mbw_pbm = ~0;
+	reset_cfg->mbw_max = MPAMCFG_MBW_MAX_MAX;
+
+	reset_cfg->reset_cpbm = true;
+	reset_cfg->reset_mbw_pbm = true;
+}
+
 /*
  * Called via smp_call_on_cpu() to prevent migration, while still being
  * pre-emptible.
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
-	for (partid = 0; partid < partid_max; partid++)
-		mpam_reset_ris_partid(ris, partid);
+	mpam_init_reset_cfg(&reset_cfg);
+
+	reprogram_arg.ris = ris;
+	reprogram_arg.cfg = &reset_cfg;
+
+	mpam_reprogram_ris(&reprogram_arg);
 
 	return 0;
 }
@@ -922,6 +991,40 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
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
+	guard(srcu)(&mpam_srcu);
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
+			if (cfg->features)
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
@@ -944,7 +1047,7 @@ static int mpam_cpu_online(unsigned int cpu)
 			_enable_percpu_irq(&msc->reenable_error_ppi);
 
 		if (atomic_fetch_inc(&msc->online_refs) == 0)
-			mpam_reset_msc(msc, true);
+			mpam_reprogram_msc(msc);
 	}
 	srcu_read_unlock(&mpam_srcu, idx);
 
@@ -1577,6 +1680,45 @@ static void mpam_unregister_irqs(void)
 	cpus_read_unlock();
 }
 
+static void __destroy_component_cfg(struct mpam_component *comp)
+{
+	add_to_garbage(comp->cfg);
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
+	init_garbage(comp->cfg);
+
+	return 0;
+}
+
+static int mpam_allocate_config(void)
+{
+	int err = 0;
+	struct mpam_class *class;
+	struct mpam_component *comp;
+
+	lockdep_assert_held(&mpam_list_lock);
+
+	list_for_each_entry(class, &mpam_classes, classes_list) {
+		list_for_each_entry(comp, &class->components, class_list) {
+			err = __allocate_component_cfg(comp);
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
@@ -1596,12 +1738,21 @@ static void mpam_enable_once(void)
 	 */
 	cpus_read_lock();
 	mutex_lock(&mpam_list_lock);
-	mpam_enable_merge_features(&mpam_classes);
+	do {
+		mpam_enable_merge_features(&mpam_classes);
 
-	err = mpam_register_irqs();
-	if (err)
-		pr_warn("Failed to register irqs: %d\n", err);
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
 
@@ -1624,6 +1775,9 @@ static void mpam_reset_component_locked(struct mpam_component *comp)
 	struct mpam_msc_ris *ris;
 
 	lockdep_assert_cpus_held();
+	mpam_assert_partid_sizes_fixed();
+
+	memset(comp->cfg, 0, (mpam_partid_max * sizeof(*comp->cfg)));
 
 	guard(srcu)(&mpam_srcu);
 	list_for_each_entry_srcu(vmsc, &comp->vmsc, comp_list,
@@ -1723,6 +1877,77 @@ void mpam_enable(struct work_struct *work)
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
+		cfg->features |= (1 << feature);			\
+									\
+		(changes) |= (1 << feature);				\
+	}								\
+} while (0)
+
+static mpam_features_t mpam_update_config(struct mpam_config *cfg,
+					  const struct mpam_config *newcfg)
+{
+	mpam_features_t changes = 0;
+
+	maybe_update_config(cfg, mpam_feat_cpor_part, newcfg, cpbm, changes);
+	maybe_update_config(cfg, mpam_feat_mbw_part, newcfg, mbw_pbm, changes);
+	maybe_update_config(cfg, mpam_feat_mbw_max, newcfg, mbw_max, changes);
+
+	return changes;
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
index b69fa9199cb4..17570d9aae9b 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -169,11 +169,7 @@ struct mpam_props {
 	u16			num_mbwu_mon;
 };
 
-static inline bool mpam_has_feature(enum mpam_device_features feat,
-				    struct mpam_props *props)
-{
-	return (1 << feat) & props->features;
-}
+#define mpam_has_feature(_feat, x)	((1 << (_feat)) & (x)->features)
 
 static inline void mpam_set_feature(enum mpam_device_features feat,
 				    struct mpam_props *props)
@@ -204,6 +200,20 @@ struct mpam_class {
 	struct mpam_garbage	garbage;
 };
 
+struct mpam_config {
+	/* Which configuration values are valid. */
+	mpam_features_t		features;
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
 
@@ -212,6 +222,12 @@ struct mpam_component {
 
 	cpumask_t		affinity;
 
+	/*
+	 * Array of configuration values, indexed by partid.
+	 * Read from cpuhp callbacks, hold the cpuhp lock when writing.
+	 */
+	struct mpam_config	*cfg;
+
 	/* member of mpam_class:components */
 	struct list_head	class_list;
 
@@ -276,6 +292,9 @@ extern u8 mpam_pmg_max;
 void mpam_enable(struct work_struct *work);
 void mpam_disable(struct work_struct *work);
 
+int mpam_apply_config(struct mpam_component *comp, u16 partid,
+		      struct mpam_config *cfg);
+
 int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
 				   cpumask_t *affinity);
 
-- 
2.39.5


