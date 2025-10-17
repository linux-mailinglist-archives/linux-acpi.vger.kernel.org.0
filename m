Return-Path: <linux-acpi+bounces-17911-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6289BEB565
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 21:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 02AEB35EF53
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 19:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07CE342C8D;
	Fri, 17 Oct 2025 18:58:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE4F335070;
	Fri, 17 Oct 2025 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727503; cv=none; b=eaZytYo4/xtCtjupY+ku1ZXbP1FDq7NpLVxWS+xRmejMZ98UdprnK8qvGU82BsYL0/lP5An8IAckMNbmHKlAqt6ErdsWuqoAL3RJYPSOUhO/m54Lw2Nrbxtc+WFL8ePJrLc8EmNbEPjsybRYG2bm/RP5dcf0FfRcVYGeQ7Uqwqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727503; c=relaxed/simple;
	bh=sshFD+WvOWTRooA+GmREDFefgDALSgwyFiOEVp2TfjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uGw85zYEJax8qbZLD9h6P15lOZoCFj7dwZk4HJc5ogoDBW7aMlIIbei3TBg8ezF9mE5N8AQXd+UousMyj7XMbBMdUPQqN/W/IRkOszpivXW2sHHEfn5PYc1RDuYRdk+usCiYPmEy7rk7j7RztrMDMy1mLA87Do4Lfy46uYzK0VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C38F1515;
	Fri, 17 Oct 2025 11:58:12 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57A1A3F66E;
	Fri, 17 Oct 2025 11:58:15 -0700 (PDT)
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
	Ben Horgan <ben.horgan@arm.com>
Subject: [PATCH v3 14/29] arm_mpam: Merge supported features during mpam_enable() into mpam_class
Date: Fri, 17 Oct 2025 18:56:30 +0000
Message-Id: <20251017185645.26604-15-james.morse@arm.com>
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
Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
---
Changes since v2:
 * Removed __func_ from pr_debug messages, pr_fmt has this covered.
 * Made a few debug messages used dev_dvg.
 * Dropped paranoia around empty vmsc/component lists.
 * Reworded comment describing the feature merging to state why the order
   matters and which helpers do what.
---
 drivers/resctrl/mpam_devices.c  | 214 ++++++++++++++++++++++++++++++++
 drivers/resctrl/mpam_internal.h |   3 +
 2 files changed, 217 insertions(+)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 80c27c84dccc..e150f4a0bfcd 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -956,8 +956,222 @@ static struct platform_driver mpam_msc_driver = {
 	.remove = mpam_msc_drv_remove,
 };
 
+/* Any of these features mean the BWA_WD field is valid. */
+static bool mpam_has_bwa_wd_feature(struct mpam_props *props)
+{
+	if (mpam_has_feature(mpam_feat_mbw_min, props))
+		return true;
+	if (mpam_has_feature(mpam_feat_mbw_max, props))
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
+		pr_debug("cleared cpor_part\n");
+		mpam_clear_feature(mpam_feat_cpor_part, parent);
+		parent->cpbm_wd = 0;
+	}
+
+	if (CAN_MERGE_FEAT(parent, child, mpam_feat_mbw_part, alias)) {
+		parent->mbw_pbm_bits = child->mbw_pbm_bits;
+	} else if (MISMATCHED_FEAT(parent, child, mpam_feat_mbw_part,
+				   mbw_pbm_bits, alias)) {
+		pr_debug("cleared mbw_part\n");
+		mpam_clear_feature(mpam_feat_mbw_part, parent);
+		parent->mbw_pbm_bits = 0;
+	}
+
+	/* bwa_wd is a count of bits, fewer bits means less precision */
+	if (alias && !mpam_has_bwa_wd_feature(parent) &&
+	    mpam_has_bwa_wd_feature(child)) {
+		parent->bwa_wd = child->bwa_wd;
+	} else if (MISMATCHED_HELPER(parent, child, mpam_has_bwa_wd_feature,
+				     bwa_wd, alias)) {
+		pr_debug("took the min bwa_wd\n");
+		parent->bwa_wd = min(parent->bwa_wd, child->bwa_wd);
+	}
+
+	/* For num properties, take the minimum */
+	if (CAN_MERGE_FEAT(parent, child, mpam_feat_msmon_csu, alias)) {
+		parent->num_csu_mon = child->num_csu_mon;
+	} else if (MISMATCHED_FEAT(parent, child, mpam_feat_msmon_csu,
+				   num_csu_mon, alias)) {
+		pr_debug("took the min num_csu_mon\n");
+		parent->num_csu_mon = min(parent->num_csu_mon,
+					  child->num_csu_mon);
+	}
+
+	if (CAN_MERGE_FEAT(parent, child, mpam_feat_msmon_mbwu, alias)) {
+		parent->num_mbwu_mon = child->num_mbwu_mon;
+	} else if (MISMATCHED_FEAT(parent, child, mpam_feat_msmon_mbwu,
+				   num_mbwu_mon, alias)) {
+		pr_debug("took the min num_mbwu_mon\n");
+		parent->num_mbwu_mon = min(parent->num_mbwu_mon,
+					   child->num_mbwu_mon);
+	}
+
+	if (alias) {
+		/* Merge features for aliased resources */
+		bitmap_or(parent->features, parent->features, child->features, MPAM_FEATURE_LAST);
+	} else {
+		/* Clear missing features for non aliasing */
+		bitmap_and(parent->features, parent->features, child->features, MPAM_FEATURE_LAST);
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
+	struct device *dev = &vmsc->msc->pdev->dev;
+
+	lockdep_assert_held(&mpam_list_lock); /* we modify class */
+
+	dev_dbg(dev, "Merging features for class:0x%lx &= vmsc:0x%lx\n",
+		(long)cprops->features, (long)vprops->features);
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
+	struct device *dev = &vmsc->msc->pdev->dev;
+
+	lockdep_assert_held(&mpam_list_lock); /* we modify vmsc */
+
+	dev_dbg(dev, "Merging features for vmsc:0x%lx |= ris:0x%lx\n",
+		(long)vprops->features, (long)rprops->features);
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
+	comp = list_first_entry(&class->components,
+				struct mpam_component, class_list);
+	vmsc = list_first_entry(&comp->vmsc,
+				struct mpam_vmsc, comp_list);
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
+ * vmsc features are bitwise-or'd together by mpam_enable_merge_vmsc_features()
+ * as the first step so that mpam_enable_init_class_features() can initialise
+ * the class with a representive set of features.
+ * Next the mpam_enable_merge_class_features() bitwise-and's all the vmsc
+ * features to form the class features.
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
index be9ea0aab6d2..39331d81c481 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -139,6 +139,7 @@ struct mpam_props {
 
 #define mpam_has_feature(_feat, x)	test_bit(_feat, (x)->features)
 #define mpam_set_feature(_feat, x)	set_bit(_feat, (x)->features)
+#define mpam_clear_feature(_feat, x)	clear_bit(_feat, (x)->features)
 
 struct mpam_class {
 	/* mpam_components in this class */
@@ -146,6 +147,8 @@ struct mpam_class {
 
 	cpumask_t		affinity;
 
+	struct mpam_props	props;
+	u32			nrdy_usec;
 	u8			level;
 	enum mpam_class_types	type;
 
-- 
2.39.5


