Return-Path: <linux-acpi+bounces-15921-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1411B31EEA
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 17:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E251624C8
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 15:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47C124BD03;
	Fri, 22 Aug 2025 15:32:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C614823F26B;
	Fri, 22 Aug 2025 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876736; cv=none; b=RCpX6s+vh7hSJZyxrPbc2yWU8us+isHE0d6CHeX5mccGPjLYw29xwArTcA9dDEELEIweg0+fxnHIwwlPDzRE2a1mCTc28D1lUx+9NrbyTZ3seh28HDdVlRpIAldY/Zj9cmzmKkQhT8UDGz1EDdf6D1S9rBPzsP8e8uWUpDV0Ue4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876736; c=relaxed/simple;
	bh=rO1UJzDV98/vppIKoHqddqmx3hapljNfVW/hUFGiJY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y/b/eeDja3LsLQ6vfR/67/clyR2XlB0+CnnYbZLWCfTODHxoXQEwwiG6yx8yv7+y6ztqvlgjKSn9SzzBol4wWDkh5tAk573FC4ZRM6MbO3dsvvoDY2jJ0A+CQVs5jY/9PF44VaLoZeo45ZnMkgFt8D+kiBSeCiNzrbDnhV2AoSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBDEB15A1;
	Fri, 22 Aug 2025 08:32:05 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCA903F63F;
	Fri, 22 Aug 2025 08:32:08 -0700 (PDT)
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
	Danilo Krummrich <dakr@kernel.org>,
	Ben Horgan <ben.horgan@arm.com>
Subject: [PATCH 12/33] arm_mpam: Add the class and component structures for ris firmware described
Date: Fri, 22 Aug 2025 15:29:53 +0000
Message-Id: <20250822153048.2287-13-james.morse@arm.com>
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

An MSC is a container of resources, each identified by their RIS index.
Some RIS are described by firmware to provide their position in the system.
Others are discovered when the driver probes the hardware.

To configure a resource it needs to be found by its class, e.g. 'L2'.
There are two kinds of grouping, a class is a set of components, which
are visible to user-space as there are likely to be multiple instances
of the L2 cache. (e.g. one per cluster or package)

struct mpam_components are a set of struct mpam_vmsc. A vMSC groups the
RIS in an MSC that control the same logical piece of hardware. (e.g. L2).
This is to allow hardware implementations where two controls are presented
as different RIS. Re-combining these RIS allows their feature bits to
be or-ed. This structure is not visible outside mpam_devices.c

struct mpam_vmsc are then a set of struct mpam_msc_ris, which are not
visible as each L2 cache may be composed of individual slices which need
to be configured the same as the hardware is not able to distribute the
configuration.

Add support for creating and destroying these structures.

A gfp is passed as the structures may need creating when a new RIS entry
is discovered when probing the MSC.

CC: Ben Horgan <ben.horgan@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since RFC:
 * removed a pr_err() debug message that crept in.
---
 drivers/resctrl/mpam_devices.c  | 488 +++++++++++++++++++++++++++++++-
 drivers/resctrl/mpam_internal.h |  91 ++++++
 include/linux/arm_mpam.h        |   8 +-
 3 files changed, 574 insertions(+), 13 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 71a1fb1a9c75..5baf2a8786fb 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -20,7 +20,6 @@
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/srcu.h>
 #include <linux/types.h>
 
 #include <acpi/pcc.h>
@@ -35,11 +34,483 @@
 static DEFINE_MUTEX(mpam_list_lock);
 static LIST_HEAD(mpam_all_msc);
 
-static struct srcu_struct mpam_srcu;
+struct srcu_struct mpam_srcu;
 
 /* MPAM isn't available until all the MSC have been probed. */
 static u32 mpam_num_msc;
 
+/*
+ * An MSC is a physical container for controls and monitors, each identified by
+ * their RIS index. These share a base-address, interrupts and some MMIO
+ * registers. A vMSC is a virtual container for RIS in an MSC that control or
+ * monitor the same thing. Members of a vMSC are all RIS in the same MSC, but
+ * not all RIS in an MSC share a vMSC.
+ * Components are a group of vMSC that control or monitor the same thing but
+ * are from different MSC, so have different base-address, interrupts etc.
+ * Classes are the set components of the same type.
+ *
+ * The features of a vMSC is the union of the RIS it contains.
+ * The features of a Class and Component are the common subset of the vMSC
+ * they contain.
+ *
+ * e.g. The system cache may have bandwidth controls on multiple interfaces,
+ * for regulating traffic from devices independently of traffic from CPUs.
+ * If these are two RIS in one MSC, they will be treated as controlling
+ * different things, and will not share a vMSC/component/class.
+ *
+ * e.g. The L2 may have one MSC and two RIS, one for cache-controls another
+ * for bandwidth. These two RIS are members of the same vMSC.
+ *
+ * e.g. The set of RIS that make up the L2 are grouped as a component. These
+ * are sometimes termed slices. They should be configured the same, as if there
+ * were only one.
+ *
+ * e.g. The SoC probably has more than one L2, each attached to a distinct set
+ * of CPUs. All the L2 components are grouped as a class.
+ *
+ * When creating an MSC, struct mpam_msc is added to the all mpam_all_msc list,
+ * then linked via struct mpam_ris to a vmsc, component and class.
+ * The same MSC may exist under different class->component->vmsc paths, but the
+ * RIS index will be unique.
+ */
+LIST_HEAD(mpam_classes);
+
+/* List of all objects that can be free()d after synchronise_srcu() */
+static LLIST_HEAD(mpam_garbage);
+
+#define init_garbage(x)	init_llist_node(&(x)->garbage.llist)
+
+static struct mpam_vmsc *
+mpam_vmsc_alloc(struct mpam_component *comp, struct mpam_msc *msc, gfp_t gfp)
+{
+	struct mpam_vmsc *vmsc;
+
+	lockdep_assert_held(&mpam_list_lock);
+
+	vmsc = kzalloc(sizeof(*vmsc), gfp);
+	if (!comp)
+		return ERR_PTR(-ENOMEM);
+	init_garbage(vmsc);
+
+	INIT_LIST_HEAD_RCU(&vmsc->ris);
+	INIT_LIST_HEAD_RCU(&vmsc->comp_list);
+	vmsc->comp = comp;
+	vmsc->msc = msc;
+
+	list_add_rcu(&vmsc->comp_list, &comp->vmsc);
+
+	return vmsc;
+}
+
+static struct mpam_vmsc *mpam_vmsc_get(struct mpam_component *comp,
+				       struct mpam_msc *msc, bool alloc,
+				       gfp_t gfp)
+{
+	struct mpam_vmsc *vmsc;
+
+	lockdep_assert_held(&mpam_list_lock);
+
+	list_for_each_entry(vmsc, &comp->vmsc, comp_list) {
+		if (vmsc->msc->id == msc->id)
+			return vmsc;
+	}
+
+	if (!alloc)
+		return ERR_PTR(-ENOENT);
+
+	return mpam_vmsc_alloc(comp, msc, gfp);
+}
+
+static struct mpam_component *
+mpam_component_alloc(struct mpam_class *class, int id, gfp_t gfp)
+{
+	struct mpam_component *comp;
+
+	lockdep_assert_held(&mpam_list_lock);
+
+	comp = kzalloc(sizeof(*comp), gfp);
+	if (!comp)
+		return ERR_PTR(-ENOMEM);
+	init_garbage(comp);
+
+	comp->comp_id = id;
+	INIT_LIST_HEAD_RCU(&comp->vmsc);
+	/* affinity is updated when ris are added */
+	INIT_LIST_HEAD_RCU(&comp->class_list);
+	comp->class = class;
+
+	list_add_rcu(&comp->class_list, &class->components);
+
+	return comp;
+}
+
+static struct mpam_component *
+mpam_component_get(struct mpam_class *class, int id, bool alloc, gfp_t gfp)
+{
+	struct mpam_component *comp;
+
+	lockdep_assert_held(&mpam_list_lock);
+
+	list_for_each_entry(comp, &class->components, class_list) {
+		if (comp->comp_id == id)
+			return comp;
+	}
+
+	if (!alloc)
+		return ERR_PTR(-ENOENT);
+
+	return mpam_component_alloc(class, id, gfp);
+}
+
+static struct mpam_class *
+mpam_class_alloc(u8 level_idx, enum mpam_class_types type, gfp_t gfp)
+{
+	struct mpam_class *class;
+
+	lockdep_assert_held(&mpam_list_lock);
+
+	class = kzalloc(sizeof(*class), gfp);
+	if (!class)
+		return ERR_PTR(-ENOMEM);
+	init_garbage(class);
+
+	INIT_LIST_HEAD_RCU(&class->components);
+	/* affinity is updated when ris are added */
+	class->level = level_idx;
+	class->type = type;
+	INIT_LIST_HEAD_RCU(&class->classes_list);
+
+	list_add_rcu(&class->classes_list, &mpam_classes);
+
+	return class;
+}
+
+static struct mpam_class *
+mpam_class_get(u8 level_idx, enum mpam_class_types type, bool alloc, gfp_t gfp)
+{
+	bool found = false;
+	struct mpam_class *class;
+
+	lockdep_assert_held(&mpam_list_lock);
+
+	list_for_each_entry(class, &mpam_classes, classes_list) {
+		if (class->type == type && class->level == level_idx) {
+			found = true;
+			break;
+		}
+	}
+
+	if (found)
+		return class;
+
+	if (!alloc)
+		return ERR_PTR(-ENOENT);
+
+	return mpam_class_alloc(level_idx, type, gfp);
+}
+
+#define add_to_garbage(x)				\
+do {							\
+	__typeof__(x) _x = x;				\
+	(_x)->garbage.to_free = (_x);			\
+	llist_add(&(_x)->garbage.llist, &mpam_garbage);	\
+} while (0)
+
+static void mpam_class_destroy(struct mpam_class *class)
+{
+	lockdep_assert_held(&mpam_list_lock);
+
+	list_del_rcu(&class->classes_list);
+	add_to_garbage(class);
+}
+
+static void mpam_comp_destroy(struct mpam_component *comp)
+{
+	struct mpam_class *class = comp->class;
+
+	lockdep_assert_held(&mpam_list_lock);
+
+	list_del_rcu(&comp->class_list);
+	add_to_garbage(comp);
+
+	if (list_empty(&class->components))
+		mpam_class_destroy(class);
+}
+
+static void mpam_vmsc_destroy(struct mpam_vmsc *vmsc)
+{
+	struct mpam_component *comp = vmsc->comp;
+
+	lockdep_assert_held(&mpam_list_lock);
+
+	list_del_rcu(&vmsc->comp_list);
+	add_to_garbage(vmsc);
+
+	if (list_empty(&comp->vmsc))
+		mpam_comp_destroy(comp);
+}
+
+static void mpam_ris_destroy(struct mpam_msc_ris *ris)
+{
+	struct mpam_vmsc *vmsc = ris->vmsc;
+	struct mpam_msc *msc = vmsc->msc;
+	struct platform_device *pdev = msc->pdev;
+	struct mpam_component *comp = vmsc->comp;
+	struct mpam_class *class = comp->class;
+
+	lockdep_assert_held(&mpam_list_lock);
+
+	cpumask_andnot(&comp->affinity, &comp->affinity, &ris->affinity);
+	cpumask_andnot(&class->affinity, &class->affinity, &ris->affinity);
+	clear_bit(ris->ris_idx, msc->ris_idxs);
+	list_del_rcu(&ris->vmsc_list);
+	list_del_rcu(&ris->msc_list);
+	add_to_garbage(ris);
+	ris->garbage.pdev = pdev;
+
+	if (list_empty(&vmsc->ris))
+		mpam_vmsc_destroy(vmsc);
+}
+
+/*
+ * There are two ways of reaching a struct mpam_msc_ris. Via the
+ * class->component->vmsc->ris, or via the msc.
+ * When destroying the msc, the other side needs unlinking and cleaning up too.
+ */
+static void mpam_msc_destroy(struct mpam_msc *msc)
+{
+	struct platform_device *pdev = msc->pdev;
+	struct mpam_msc_ris *ris, *tmp;
+
+	lockdep_assert_held(&mpam_list_lock);
+
+	list_del_rcu(&msc->glbl_list);
+	platform_set_drvdata(pdev, NULL);
+
+	list_for_each_entry_safe(ris, tmp, &msc->ris, msc_list)
+		mpam_ris_destroy(ris);
+
+	add_to_garbage(msc);
+	msc->garbage.pdev = pdev;
+}
+
+static void mpam_free_garbage(void)
+{
+	struct mpam_garbage *iter, *tmp;
+	struct llist_node *to_free = llist_del_all(&mpam_garbage);
+
+	if (!to_free)
+		return;
+
+	synchronize_srcu(&mpam_srcu);
+
+	llist_for_each_entry_safe(iter, tmp, to_free, llist) {
+		if (iter->pdev)
+			devm_kfree(&iter->pdev->dev, iter->to_free);
+		else
+			kfree(iter->to_free);
+	}
+}
+
+/* Called recursively to walk the list of caches from a particular CPU */
+static void __mpam_get_cpumask_from_cache_id(int cpu, struct device_node *cache_node,
+					     unsigned long cache_id,
+					     u32 cache_level,
+					     cpumask_t *affinity)
+{
+	int err;
+	u32 iter_level;
+	unsigned long iter_cache_id;
+	struct device_node *iter_node __free(device_node) = of_find_next_cache_node(cache_node);
+
+	if (!iter_node)
+		return;
+
+	err = of_property_read_u32(iter_node, "cache-level", &iter_level);
+	if (err)
+		return;
+
+	/*
+	 * get_cpu_cacheinfo_id() isn't ready until sometime
+	 * during device_initcall(). Use cache_of_calculate_id().
+	 */
+	iter_cache_id = cache_of_calculate_id(iter_node);
+	if (cache_id == ~0UL)
+		return;
+
+	if (iter_level == cache_level && iter_cache_id == cache_id)
+		cpumask_set_cpu(cpu, affinity);
+
+	__mpam_get_cpumask_from_cache_id(cpu, iter_node, cache_id, cache_level,
+					 affinity);
+}
+
+/*
+ * The cacheinfo structures are only populated when CPUs are online.
+ * This helper walks the device tree to include offline CPUs too.
+ */
+int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
+				   cpumask_t *affinity)
+{
+	int cpu;
+
+	if (!acpi_disabled)
+		return acpi_pptt_get_cpumask_from_cache_id(cache_id, affinity);
+
+	for_each_possible_cpu(cpu) {
+		struct device_node *cpu_node __free(device_node) = of_get_cpu_node(cpu, NULL);
+		if (!cpu_node) {
+			pr_err("Failed to find cpu%d device node\n", cpu);
+			return -ENOENT;
+		}
+
+		__mpam_get_cpumask_from_cache_id(cpu, cpu_node, cache_id,
+						 cache_level, affinity);
+			continue;
+	}
+
+	return 0;
+}
+
+/*
+ * cpumask_of_node() only knows about online CPUs. This can't tell us whether
+ * a class is represented on all possible CPUs.
+ */
+static void get_cpumask_from_node_id(u32 node_id, cpumask_t *affinity)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		if (node_id == cpu_to_node(cpu))
+			cpumask_set_cpu(cpu, affinity);
+	}
+}
+
+static int get_cpumask_from_cache(struct device_node *cache,
+				  cpumask_t *affinity)
+{
+	int err;
+	u32 cache_level;
+	unsigned long cache_id;
+
+	err = of_property_read_u32(cache, "cache-level", &cache_level);
+	if (err) {
+		pr_err("Failed to read cache-level from cache node\n");
+		return -ENOENT;
+	}
+
+	cache_id = cache_of_calculate_id(cache);
+	if (cache_id == ~0UL) {
+		pr_err("Failed to calculate cache-id from cache node\n");
+		return -ENOENT;
+	}
+
+	return mpam_get_cpumask_from_cache_id(cache_id, cache_level, affinity);
+}
+
+static int mpam_ris_get_affinity(struct mpam_msc *msc, cpumask_t *affinity,
+				 enum mpam_class_types type,
+				 struct mpam_class *class,
+				 struct mpam_component *comp)
+{
+	int err;
+
+	switch (type) {
+	case MPAM_CLASS_CACHE:
+		err = mpam_get_cpumask_from_cache_id(comp->comp_id, class->level,
+						     affinity);
+		if (err)
+			return err;
+
+		if (cpumask_empty(affinity))
+			pr_warn_once("%s no CPUs associated with cache node",
+				     dev_name(&msc->pdev->dev));
+
+		break;
+	case MPAM_CLASS_MEMORY:
+		get_cpumask_from_node_id(comp->comp_id, affinity);
+		/* affinity may be empty for CPU-less memory nodes */
+		break;
+	case MPAM_CLASS_UNKNOWN:
+		return 0;
+	}
+
+	cpumask_and(affinity, affinity, &msc->accessibility);
+
+	return 0;
+}
+
+static int mpam_ris_create_locked(struct mpam_msc *msc, u8 ris_idx,
+				  enum mpam_class_types type, u8 class_id,
+				  int component_id, gfp_t gfp)
+{
+	int err;
+	struct mpam_vmsc *vmsc;
+	struct mpam_msc_ris *ris;
+	struct mpam_class *class;
+	struct mpam_component *comp;
+
+	lockdep_assert_held(&mpam_list_lock);
+
+	if (test_and_set_bit(ris_idx, msc->ris_idxs))
+		return -EBUSY;
+
+	ris = devm_kzalloc(&msc->pdev->dev, sizeof(*ris), gfp);
+	if (!ris)
+		return -ENOMEM;
+	init_garbage(ris);
+
+	class = mpam_class_get(class_id, type, true, gfp);
+	if (IS_ERR(class))
+		return PTR_ERR(class);
+
+	comp = mpam_component_get(class, component_id, true, gfp);
+	if (IS_ERR(comp)) {
+		if (list_empty(&class->components))
+			mpam_class_destroy(class);
+		return PTR_ERR(comp);
+	}
+
+	vmsc = mpam_vmsc_get(comp, msc, true, gfp);
+	if (IS_ERR(vmsc)) {
+		if (list_empty(&comp->vmsc))
+			mpam_comp_destroy(comp);
+		return PTR_ERR(vmsc);
+	}
+
+	err = mpam_ris_get_affinity(msc, &ris->affinity, type, class, comp);
+	if (err) {
+		if (list_empty(&vmsc->ris))
+			mpam_vmsc_destroy(vmsc);
+		return err;
+	}
+
+	ris->ris_idx = ris_idx;
+	INIT_LIST_HEAD_RCU(&ris->vmsc_list);
+	ris->vmsc = vmsc;
+
+	cpumask_or(&comp->affinity, &comp->affinity, &ris->affinity);
+	cpumask_or(&class->affinity, &class->affinity, &ris->affinity);
+	list_add_rcu(&ris->vmsc_list, &vmsc->ris);
+
+	return 0;
+}
+
+int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
+		    enum mpam_class_types type, u8 class_id, int component_id)
+{
+	int err;
+
+	mutex_lock(&mpam_list_lock);
+	err = mpam_ris_create_locked(msc, ris_idx, type, class_id,
+				     component_id, GFP_KERNEL);
+	mutex_unlock(&mpam_list_lock);
+	if (err)
+		mpam_free_garbage();
+
+	return err;
+}
+
 static void mpam_discovery_complete(void)
 {
 	pr_err("Discovered all MSC\n");
@@ -179,7 +650,10 @@ static int update_msc_accessibility(struct mpam_msc *msc)
 		cpumask_copy(&msc->accessibility, cpu_possible_mask);
 		err = 0;
 	} else {
-		if (of_device_is_compatible(parent, "memory")) {
+		if (of_device_is_compatible(parent, "cache")) {
+			err = get_cpumask_from_cache(parent,
+						     &msc->accessibility);
+		} else if (of_device_is_compatible(parent, "memory")) {
 			cpumask_copy(&msc->accessibility, cpu_possible_mask);
 			err = 0;
 		} else {
@@ -209,11 +683,10 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
 
 	mutex_lock(&mpam_list_lock);
 	mpam_num_msc--;
-	platform_set_drvdata(pdev, NULL);
-	list_del_rcu(&msc->glbl_list);
-	synchronize_srcu(&mpam_srcu);
-	devm_kfree(&pdev->dev, msc);
+	mpam_msc_destroy(msc);
 	mutex_unlock(&mpam_list_lock);
+
+	mpam_free_garbage();
 }
 
 static int mpam_msc_drv_probe(struct platform_device *pdev)
@@ -230,6 +703,7 @@ static int mpam_msc_drv_probe(struct platform_device *pdev)
 			err = -ENOMEM;
 			break;
 		}
+		init_garbage(msc);
 
 		mutex_init(&msc->probe_lock);
 		mutex_init(&msc->part_sel_lock);
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 07e0f240eaca..d49bb884b433 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -7,10 +7,27 @@
 #include <linux/arm_mpam.h>
 #include <linux/cpumask.h>
 #include <linux/io.h>
+#include <linux/llist.h>
 #include <linux/mailbox_client.h>
 #include <linux/mutex.h>
 #include <linux/resctrl.h>
 #include <linux/sizes.h>
+#include <linux/srcu.h>
+
+/*
+ * Structures protected by SRCU may not be freed for a surprising amount of
+ * time (especially if perf is running). To ensure the MPAM error interrupt can
+ * tear down all the structures, build a list of objects that can be gargbage
+ * collected once synchronize_srcu() has returned.
+ * If pdev is non-NULL, use devm_kfree().
+ */
+struct mpam_garbage {
+	/* member of mpam_garbage */
+	struct llist_node	llist;
+
+	void			*to_free;
+	struct platform_device	*pdev;
+};
 
 struct mpam_msc {
 	/* member of mpam_all_msc */
@@ -57,6 +74,80 @@ struct mpam_msc {
 
 	void __iomem		*mapped_hwpage;
 	size_t			mapped_hwpage_sz;
+
+	struct mpam_garbage	garbage;
+};
+
+struct mpam_class {
+	/* mpam_components in this class */
+	struct list_head	components;
+
+	cpumask_t		affinity;
+
+	u8			level;
+	enum mpam_class_types	type;
+
+	/* member of mpam_classes */
+	struct list_head	classes_list;
+
+	struct mpam_garbage	garbage;
+};
+
+struct mpam_component {
+	u32			comp_id;
+
+	/* mpam_vmsc in this component */
+	struct list_head	vmsc;
+
+	cpumask_t		affinity;
+
+	/* member of mpam_class:components */
+	struct list_head	class_list;
+
+	/* parent: */
+	struct mpam_class	*class;
+
+	struct mpam_garbage	garbage;
 };
 
+struct mpam_vmsc {
+	/* member of mpam_component:vmsc_list */
+	struct list_head	comp_list;
+
+	/* mpam_msc_ris in this vmsc */
+	struct list_head	ris;
+
+	/* All RIS in this vMSC are members of this MSC */
+	struct mpam_msc		*msc;
+
+	/* parent: */
+	struct mpam_component	*comp;
+
+	struct mpam_garbage	garbage;
+};
+
+struct mpam_msc_ris {
+	u8			ris_idx;
+
+	cpumask_t		affinity;
+
+	/* member of mpam_vmsc:ris */
+	struct list_head	vmsc_list;
+
+	/* member of mpam_msc:ris */
+	struct list_head	msc_list;
+
+	/* parent: */
+	struct mpam_vmsc	*vmsc;
+
+	struct mpam_garbage	garbage;
+};
+
+/* List of all classes - protected by srcu*/
+extern struct srcu_struct mpam_srcu;
+extern struct list_head mpam_classes;
+
+int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
+				   cpumask_t *affinity);
+
 #endif /* MPAM_INTERNAL_H */
diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
index 0edefa6ba019..406a77be68cb 100644
--- a/include/linux/arm_mpam.h
+++ b/include/linux/arm_mpam.h
@@ -36,11 +36,7 @@ static inline int acpi_mpam_parse_resources(struct mpam_msc *msc,
 static inline int acpi_mpam_count_msc(void) { return -EINVAL; }
 #endif
 
-static inline int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
-				  enum mpam_class_types type, u8 class_id,
-				  int component_id)
-{
-	return -EINVAL;
-}
+int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
+		    enum mpam_class_types type, u8 class_id, int component_id);
 
 #endif /* __LINUX_ARM_MPAM_H */
-- 
2.20.1


