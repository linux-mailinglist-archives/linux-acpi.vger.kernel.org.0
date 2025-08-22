Return-Path: <linux-acpi+bounces-15927-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB6EB31EED
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 17:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EB01BA7B1B
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 15:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB5024C07A;
	Fri, 22 Aug 2025 15:32:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979C0285C80;
	Fri, 22 Aug 2025 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876770; cv=none; b=pBoG1FyBA5xEQnF792yQlTqu6yNbHq32ZvkVZG+BryTEiRCCIt1EW/wgrWoqeI2pMCvMZJrIn4rLSBx5Dey6OaYFg80P4SSmyXWLLF5RgVzvAAOUnGJkjrRhyRlZ3XX3THVHc2zXfUQ2ZITL6lm/pYoHTgDzPx0I9M0GQ4vm+Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876770; c=relaxed/simple;
	bh=qLpxKKQRoeowzKRU4A01FJgGIXdUmV1qXXFSySCrG7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ud6kCwBuSZrkVq3R3BolSspzIB+yop6EfHIxsfgcsv6nxFkJsQix6RfkBC91det12h+WtV+PgzJdq570Iue9gpDYpRCJjwXqaLZ+LPvIvL4R3SmhYElYmDNseYCU0lCeaCwGBI26nnyrhLzGd+QmhMI+2kTxHZ2RH9uV4C/d0wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE32D15A1;
	Fri, 22 Aug 2025 08:32:39 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF83C3F63F;
	Fri, 22 Aug 2025 08:32:42 -0700 (PDT)
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
Subject: [PATCH 18/33] arm_mpam: Merge supported features during mpam_enable() into mpam_class
Date: Fri, 22 Aug 2025 15:29:59 +0000
Message-Id: <20250822153048.2287-19-james.morse@arm.com>
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

To make a decision about whether to expose an mpam class as
a resctrl resource we need to know its overall supported
features and properties.

Once we've probed all the resources, we can walk the tree
and produce overall values by merging the bitmaps. This
eliminates features that are only supported by some MSC
that make up a component or class.

If bitmap properties are mismatched within a component we
cannot support the mismatched feature.

Care has to be taken as vMSC may hold mismatched RIS.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/resctrl/mpam_devices.c  | 215 ++++++++++++++++++++++++++++++++
 drivers/resctrl/mpam_internal.h |   8 ++
 2 files changed, 223 insertions(+)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 290a04f8654f..bb62de6d3847 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1186,8 +1186,223 @@ static struct platform_driver mpam_msc_driver = {
 	.remove = mpam_msc_drv_remove,
 };
 
+/* Any of these features mean the BWA_WD field is valid. */
+static bool mpam_has_bwa_wd_feature(struct mpam_props *props)
+{
+	if (mpam_has_feature(mpam_feat_mbw_min, props))
+		return true;
+	if (mpam_has_feature(mpam_feat_mbw_max, props))
+		return true;
+	if (mpam_has_feature(mpam_feat_mbw_prop, props))
+		return true;
+	return false;
+}
+
+#define MISMATCHED_HELPER(parent, child, helper, field, alias)		\
+	helper(parent) &&						\
+	((helper(child) && (parent)->field != (child)->field) ||	\
+	 (!helper(child) && !(alias)))
+
+#define MISMATCHED_FEAT(parent, child, feat, field, alias)		     \
+	mpam_has_feature((feat), (parent)) &&				     \
+	((mpam_has_feature((feat), (child)) && (parent)->field != (child)->field) || \
+	 (!mpam_has_feature((feat), (child)) && !(alias)))
+
+#define CAN_MERGE_FEAT(parent, child, feat, alias)			\
+	(alias) && !mpam_has_feature((feat), (parent)) &&		\
+	mpam_has_feature((feat), (child))
+
+/*
+ * Combine two props fields.
+ * If this is for controls that alias the same resource, it is safe to just
+ * copy the values over. If two aliasing controls implement the same scheme
+ * a safe value must be picked.
+ * For non-aliasing controls, these control different resources, and the
+ * resulting safe value must be compatible with both. When merging values in
+ * the tree, all the aliasing resources must be handled first.
+ * On mismatch, parent is modified.
+ */
+static void __props_mismatch(struct mpam_props *parent,
+			     struct mpam_props *child, bool alias)
+{
+	if (CAN_MERGE_FEAT(parent, child, mpam_feat_cpor_part, alias)) {
+		parent->cpbm_wd = child->cpbm_wd;
+	} else if (MISMATCHED_FEAT(parent, child, mpam_feat_cpor_part,
+				   cpbm_wd, alias)) {
+		pr_debug("%s cleared cpor_part\n", __func__);
+		mpam_clear_feature(mpam_feat_cpor_part, &parent->features);
+		parent->cpbm_wd = 0;
+	}
+
+	if (CAN_MERGE_FEAT(parent, child, mpam_feat_mbw_part, alias)) {
+		parent->mbw_pbm_bits = child->mbw_pbm_bits;
+	} else if (MISMATCHED_FEAT(parent, child, mpam_feat_mbw_part,
+				   mbw_pbm_bits, alias)) {
+		pr_debug("%s cleared mbw_part\n", __func__);
+		mpam_clear_feature(mpam_feat_mbw_part, &parent->features);
+		parent->mbw_pbm_bits = 0;
+	}
+
+	/* bwa_wd is a count of bits, fewer bits means less precision */
+	if (alias && !mpam_has_bwa_wd_feature(parent) && mpam_has_bwa_wd_feature(child)) {
+		parent->bwa_wd = child->bwa_wd;
+	} else if (MISMATCHED_HELPER(parent, child, mpam_has_bwa_wd_feature,
+				     bwa_wd, alias)) {
+		pr_debug("%s took the min bwa_wd\n", __func__);
+		parent->bwa_wd = min(parent->bwa_wd, child->bwa_wd);
+	}
+
+	/* For num properties, take the minimum */
+	if (CAN_MERGE_FEAT(parent, child, mpam_feat_msmon_csu, alias)) {
+		parent->num_csu_mon = child->num_csu_mon;
+	} else if (MISMATCHED_FEAT(parent, child, mpam_feat_msmon_csu,
+				   num_csu_mon, alias)) {
+		pr_debug("%s took the min num_csu_mon\n", __func__);
+		parent->num_csu_mon = min(parent->num_csu_mon, child->num_csu_mon);
+	}
+
+	if (CAN_MERGE_FEAT(parent, child, mpam_feat_msmon_mbwu, alias)) {
+		parent->num_mbwu_mon = child->num_mbwu_mon;
+	} else if (MISMATCHED_FEAT(parent, child, mpam_feat_msmon_mbwu,
+				   num_mbwu_mon, alias)) {
+		pr_debug("%s took the min num_mbwu_mon\n", __func__);
+		parent->num_mbwu_mon = min(parent->num_mbwu_mon, child->num_mbwu_mon);
+	}
+
+	if (alias) {
+		/* Merge features for aliased resources */
+		parent->features |= child->features;
+	} else {
+		/* Clear missing features for non aliasing */
+		parent->features &= child->features;
+	}
+}
+
+/*
+ * If a vmsc doesn't match class feature/configuration, do the right thing(tm).
+ * For 'num' properties we can just take the minimum.
+ * For properties where the mismatched unused bits would make a difference, we
+ * nobble the class feature, as we can't configure all the resources.
+ * e.g. The L3 cache is composed of two resources with 13 and 17 portion
+ * bitmaps respectively.
+ */
+static void
+__class_props_mismatch(struct mpam_class *class, struct mpam_vmsc *vmsc)
+{
+	struct mpam_props *cprops = &class->props;
+	struct mpam_props *vprops = &vmsc->props;
+
+	lockdep_assert_held(&mpam_list_lock); /* we modify class */
+
+	pr_debug("%s: Merging features for class:0x%lx &= vmsc:0x%lx\n",
+		 dev_name(&vmsc->msc->pdev->dev),
+		 (long)cprops->features, (long)vprops->features);
+
+	/* Take the safe value for any common features */
+	__props_mismatch(cprops, vprops, false);
+}
+
+static void
+__vmsc_props_mismatch(struct mpam_vmsc *vmsc, struct mpam_msc_ris *ris)
+{
+	struct mpam_props *rprops = &ris->props;
+	struct mpam_props *vprops = &vmsc->props;
+
+	lockdep_assert_held(&mpam_list_lock); /* we modify vmsc */
+
+	pr_debug("%s: Merging features for vmsc:0x%lx |= ris:0x%lx\n",
+		 dev_name(&vmsc->msc->pdev->dev),
+		 (long)vprops->features, (long)rprops->features);
+
+	/*
+	 * Merge mismatched features - Copy any features that aren't common,
+	 * but take the safe value for any common features.
+	 */
+	__props_mismatch(vprops, rprops, true);
+}
+
+/*
+ * Copy the first component's first vMSC's properties and features to the
+ * class. __class_props_mismatch() will remove conflicts.
+ * It is not possible to have a class with no components, or a component with
+ * no resources. The vMSC properties have already been built.
+ */
+static void mpam_enable_init_class_features(struct mpam_class *class)
+{
+	struct mpam_vmsc *vmsc;
+	struct mpam_component *comp;
+
+	comp = list_first_entry_or_null(&class->components,
+					struct mpam_component, class_list);
+	if (WARN_ON(!comp))
+		return;
+
+	vmsc = list_first_entry_or_null(&comp->vmsc,
+					struct mpam_vmsc, comp_list);
+	if (WARN_ON(!vmsc))
+		return;
+
+	class->props = vmsc->props;
+}
+
+static void mpam_enable_merge_vmsc_features(struct mpam_component *comp)
+{
+	struct mpam_vmsc *vmsc;
+	struct mpam_msc_ris *ris;
+	struct mpam_class *class = comp->class;
+
+	list_for_each_entry(vmsc, &comp->vmsc, comp_list) {
+		list_for_each_entry(ris, &vmsc->ris, vmsc_list) {
+			__vmsc_props_mismatch(vmsc, ris);
+			class->nrdy_usec = max(class->nrdy_usec,
+					       vmsc->msc->nrdy_usec);
+		}
+	}
+}
+
+static void mpam_enable_merge_class_features(struct mpam_component *comp)
+{
+	struct mpam_vmsc *vmsc;
+	struct mpam_class *class = comp->class;
+
+	list_for_each_entry(vmsc, &comp->vmsc, comp_list)
+		__class_props_mismatch(class, vmsc);
+}
+
+/*
+ * Merge all the common resource features into class.
+ * vmsc features are bitwise-or'd together, this must be done first.
+ * Next the class features are the bitwise-and of all the vmsc features.
+ * Other features are the min/max as appropriate.
+ *
+ * To avoid walking the whole tree twice, the class->nrdy_usec property is
+ * updated when working with the vmsc as it is a max(), and doesn't need
+ * initialising first.
+ */
+static void mpam_enable_merge_features(struct list_head *all_classes_list)
+{
+	struct mpam_class *class;
+	struct mpam_component *comp;
+
+	lockdep_assert_held(&mpam_list_lock);
+
+	list_for_each_entry(class, all_classes_list, classes_list) {
+		list_for_each_entry(comp, &class->components, class_list)
+			mpam_enable_merge_vmsc_features(comp);
+
+		mpam_enable_init_class_features(class);
+
+		list_for_each_entry(comp, &class->components, class_list)
+			mpam_enable_merge_class_features(comp);
+	}
+}
+
 static void mpam_enable_once(void)
 {
+	mutex_lock(&mpam_list_lock);
+	mpam_enable_merge_features(&mpam_classes);
+	mutex_unlock(&mpam_list_lock);
+
 	/*
 	 * Once the cpuhp callbacks have been changed, mpam_partid_max can no
 	 * longer change.
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 9f6cd4a68cce..a2b0ff411138 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -186,12 +186,20 @@ static inline void mpam_set_feature(enum mpam_device_features feat,
 	props->features |= (1 << feat);
 }
 
+static inline void mpam_clear_feature(enum mpam_device_features feat,
+				      mpam_features_t *supported)
+{
+	*supported &= ~(1 << feat);
+}
+
 struct mpam_class {
 	/* mpam_components in this class */
 	struct list_head	components;
 
 	cpumask_t		affinity;
 
+	struct mpam_props	props;
+	u32			nrdy_usec;
 	u8			level;
 	enum mpam_class_types	type;
 
-- 
2.20.1


