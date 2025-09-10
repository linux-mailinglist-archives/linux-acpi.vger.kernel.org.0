Return-Path: <linux-acpi+bounces-16631-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0534CB522B6
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 22:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A296C1C88150
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 20:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E9130AD04;
	Wed, 10 Sep 2025 20:44:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B809630DEB7;
	Wed, 10 Sep 2025 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537067; cv=none; b=h/OF9kvHtSp0EVgGy8Lrrlu08QG0j7vClb9VIh6tzwGiRqKZrEiLYbUgzx0g2HvwNkrySCtETDQJrrOANKG7NAjrNyO4qx6EJfmWDtgwsjJTiCIJLdA1rm75QoNl98GsB8LMG1vgffDn2nam0mmac/jeG/ZQanYquWgurnCLC4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537067; c=relaxed/simple;
	bh=7navXBxHShagp690G26Rw3K20P7L6z3qPg9baxtqTos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sKpxn8MS5J40Zr9CquthLmrZ1M4/gEaY4JGeKGoBwsCyplAeCycrLWU4R3mP501qiYHWddN0vd0yI3OuamZ6HT+oj6o3/VFucNRfi2vhFEYTP3pJaUZ+sXu/py+k/g9wHM8Y80/Y9DFicXioRmBao0TyK3+9CvLqpCe9+TgAF8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B994F153B;
	Wed, 10 Sep 2025 13:44:16 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71C0D3F63F;
	Wed, 10 Sep 2025 13:44:20 -0700 (PDT)
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
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 11/29] arm_mpam: Probe hardware to find the supported partid/pmg values
Date: Wed, 10 Sep 2025 20:42:51 +0000
Message-Id: <20250910204309.20751-12-james.morse@arm.com>
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

CPUs can generate traffic with a range of PARTID and PMG values,
but each MSC may also have its own maximum size for these fields.
Before MPAM can be used, the driver needs to probe each RIS on
each MSC, to find the system-wide smallest value that can be used.
The limits from requestors (e.g. CPUs) also need taking into account.

While doing this, RIS entries that firmware didn't describe are created
under MPAM_CLASS_UNKNOWN.

While we're here, implement the mpam_register_requestor() call
for the arch code to register the CPU limits. Future callers of this
will tell us about the SMMU and ITS.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * Change to lock ordering now that the list-lock mutex isn't held from
   the cpuhp call.
 * Removed irq-unmaksed assert in requestor register.
 * Changed captialisation in print message.
---
 drivers/resctrl/mpam_devices.c  | 150 +++++++++++++++++++++++++++++++-
 drivers/resctrl/mpam_internal.h |   6 ++
 include/linux/arm_mpam.h        |  14 +++
 3 files changed, 169 insertions(+), 1 deletion(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index c265376d936b..24dc81c15ec8 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -6,6 +6,7 @@
 #include <linux/acpi.h>
 #include <linux/atomic.h>
 #include <linux/arm_mpam.h>
+#include <linux/bitfield.h>
 #include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
@@ -43,6 +44,15 @@ static atomic_t mpam_num_msc;
 static int mpam_cpuhp_state;
 static DEFINE_MUTEX(mpam_cpuhp_state_lock);
 
+/*
+ * The smallest common values for any CPU or MSC in the system.
+ * Generating traffic outside this range will result in screaming interrupts.
+ */
+u16 mpam_partid_max;
+u8 mpam_pmg_max;
+static bool partid_max_init, partid_max_published;
+static DEFINE_SPINLOCK(partid_max_lock);
+
 /*
  * mpam is enabled once all devices have been probed from CPU online callbacks,
  * scheduled via this work_struct. If access to an MSC depends on a CPU that
@@ -113,6 +123,72 @@ static inline u32 _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg)
 
 #define mpam_read_partsel_reg(msc, reg)        _mpam_read_partsel_reg(msc, MPAMF_##reg)
 
+static void __mpam_write_reg(struct mpam_msc *msc, u16 reg, u32 val)
+{
+	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);
+	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
+
+	writel_relaxed(val, msc->mapped_hwpage + reg);
+}
+
+static inline void _mpam_write_partsel_reg(struct mpam_msc *msc, u16 reg, u32 val)
+{
+	lockdep_assert_held_once(&msc->part_sel_lock);
+	__mpam_write_reg(msc, reg, val);
+}
+#define mpam_write_partsel_reg(msc, reg, val)  _mpam_write_partsel_reg(msc, MPAMCFG_##reg, val)
+
+static u64 mpam_msc_read_idr(struct mpam_msc *msc)
+{
+	u64 idr_high = 0, idr_low;
+
+	lockdep_assert_held(&msc->part_sel_lock);
+
+	idr_low = mpam_read_partsel_reg(msc, IDR);
+	if (FIELD_GET(MPAMF_IDR_EXT, idr_low))
+		idr_high = mpam_read_partsel_reg(msc, IDR + 4);
+
+	return (idr_high << 32) | idr_low;
+}
+
+static void __mpam_part_sel_raw(u32 partsel, struct mpam_msc *msc)
+{
+	lockdep_assert_held(&msc->part_sel_lock);
+
+	mpam_write_partsel_reg(msc, PART_SEL, partsel);
+}
+
+static void __mpam_part_sel(u8 ris_idx, u16 partid, struct mpam_msc *msc)
+{
+	u32 partsel = FIELD_PREP(MPAMCFG_PART_SEL_RIS, ris_idx) |
+		      FIELD_PREP(MPAMCFG_PART_SEL_PARTID_SEL, partid);
+
+	__mpam_part_sel_raw(partsel, msc);
+}
+
+int mpam_register_requestor(u16 partid_max, u8 pmg_max)
+{
+	int err = 0;
+
+	spin_lock(&partid_max_lock);
+	if (!partid_max_init) {
+		mpam_partid_max = partid_max;
+		mpam_pmg_max = pmg_max;
+		partid_max_init = true;
+	} else if (!partid_max_published) {
+		mpam_partid_max = min(mpam_partid_max, partid_max);
+		mpam_pmg_max = min(mpam_pmg_max, pmg_max);
+	} else {
+		/* New requestors can't lower the values */
+		if (partid_max < mpam_partid_max || pmg_max < mpam_pmg_max)
+			err = -EBUSY;
+	}
+	spin_unlock(&partid_max_lock);
+
+	return err;
+}
+EXPORT_SYMBOL(mpam_register_requestor);
+
 #define init_garbage(x)	init_llist_node(&(x)->garbage.llist)
 
 static struct mpam_vmsc *
@@ -451,6 +527,7 @@ static int mpam_ris_create_locked(struct mpam_msc *msc, u8 ris_idx,
 	cpumask_or(&comp->affinity, &comp->affinity, &ris->affinity);
 	cpumask_or(&class->affinity, &class->affinity, &ris->affinity);
 	list_add_rcu(&ris->vmsc_list, &vmsc->ris);
+	list_add_rcu(&ris->msc_list, &msc->ris);
 
 	return 0;
 }
@@ -470,9 +547,37 @@ int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
 	return err;
 }
 
+static struct mpam_msc_ris *mpam_get_or_create_ris(struct mpam_msc *msc,
+						   u8 ris_idx)
+{
+	int err;
+	struct mpam_msc_ris *ris, *found = ERR_PTR(-ENOENT);
+
+	lockdep_assert_held(&mpam_list_lock);
+
+	if (!test_bit(ris_idx, &msc->ris_idxs)) {
+		err = mpam_ris_create_locked(msc, ris_idx, MPAM_CLASS_UNKNOWN,
+					     0, 0);
+		if (err)
+			return ERR_PTR(err);
+	}
+
+	list_for_each_entry(ris, &msc->ris, msc_list) {
+		if (ris->ris_idx == ris_idx) {
+			found = ris;
+			break;
+		}
+	}
+
+	return found;
+}
+
 static int mpam_msc_hw_probe(struct mpam_msc *msc)
 {
 	u64 idr;
+	u16 partid_max;
+	u8 ris_idx, pmg_max;
+	struct mpam_msc_ris *ris;
 	struct device *dev = &msc->pdev->dev;
 
 	lockdep_assert_held(&msc->probe_lock);
@@ -483,6 +588,39 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
 		return -EIO;
 	}
 
+	/* Grab an IDR value to find out how many RIS there are */
+	mutex_lock(&msc->part_sel_lock);
+	idr = mpam_msc_read_idr(msc);
+	mutex_unlock(&msc->part_sel_lock);
+	msc->ris_max = FIELD_GET(MPAMF_IDR_RIS_MAX, idr);
+
+	/* Use these values so partid/pmg always starts with a valid value */
+	msc->partid_max = FIELD_GET(MPAMF_IDR_PARTID_MAX, idr);
+	msc->pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
+
+	for (ris_idx = 0; ris_idx <= msc->ris_max; ris_idx++) {
+		mutex_lock(&msc->part_sel_lock);
+		__mpam_part_sel(ris_idx, 0, msc);
+		idr = mpam_msc_read_idr(msc);
+		mutex_unlock(&msc->part_sel_lock);
+
+		partid_max = FIELD_GET(MPAMF_IDR_PARTID_MAX, idr);
+		pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
+		msc->partid_max = min(msc->partid_max, partid_max);
+		msc->pmg_max = min(msc->pmg_max, pmg_max);
+
+		mutex_lock(&mpam_list_lock);
+		ris = mpam_get_or_create_ris(msc, ris_idx);
+		mutex_unlock(&mpam_list_lock);
+		if (IS_ERR(ris))
+			return PTR_ERR(ris);
+	}
+
+	spin_lock(&partid_max_lock);
+	mpam_partid_max = min(mpam_partid_max, msc->partid_max);
+	mpam_pmg_max = min(mpam_pmg_max, msc->pmg_max);
+	spin_unlock(&partid_max_lock);
+
 	msc->probed = true;
 
 	return 0;
@@ -675,9 +813,18 @@ static struct platform_driver mpam_msc_driver = {
 
 static void mpam_enable_once(void)
 {
+	/*
+	 * Once the cpuhp callbacks have been changed, mpam_partid_max can no
+	 * longer change.
+	 */
+	spin_lock(&partid_max_lock);
+	partid_max_published = true;
+	spin_unlock(&partid_max_lock);
+
 	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline);
 
-	pr_info("MPAM enabled\n");
+	printk(KERN_INFO "MPAM enabled with %u PARTIDs and %u PMGs\n",
+	       mpam_partid_max + 1, mpam_pmg_max + 1);
 }
 
 void mpam_disable(struct work_struct *ignored)
@@ -744,4 +891,5 @@ static int __init mpam_msc_driver_init(void)
 
 	return platform_driver_register(&mpam_msc_driver);
 }
+/* Must occur after arm64_mpam_register_cpus() from arch_initcall() */
 subsys_initcall(mpam_msc_driver_init);
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index d4f3febc7a50..828ce93c95d5 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -52,6 +52,8 @@ struct mpam_msc {
 	 */
 	struct mutex		probe_lock;
 	bool			probed;
+	u16			partid_max;
+	u8			pmg_max;
 	unsigned long		ris_idxs;
 	u32			ris_max;
 
@@ -150,6 +152,10 @@ struct mpam_msc_ris {
 extern struct srcu_struct mpam_srcu;
 extern struct list_head mpam_classes;
 
+/* System wide partid/pmg values */
+extern u16 mpam_partid_max;
+extern u8 mpam_pmg_max;
+
 /* Scheduled work callback to enable mpam once all MSC have been probed */
 void mpam_enable(struct work_struct *work);
 void mpam_disable(struct work_struct *work);
diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
index 3206f5ddc147..cb6e6cfbea0b 100644
--- a/include/linux/arm_mpam.h
+++ b/include/linux/arm_mpam.h
@@ -41,4 +41,18 @@ static inline int acpi_mpam_count_msc(void) { return -EINVAL; }
 int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
 		    enum mpam_class_types type, u8 class_id, int component_id);
 
+/**
+ * mpam_register_requestor() - Register a requestor with the MPAM driver
+ * @partid_max:		The maximum PARTID value the requestor can generate.
+ * @pmg_max:		The maximum PMG value the requestor can generate.
+ *
+ * Registers a requestor with the MPAM driver to ensure the chosen system-wide
+ * minimum PARTID and PMG values will allow the requestors features to be used.
+ *
+ * Returns an error if the registration is too late, and a larger PARTID/PMG
+ * value has been advertised to user-space. In this case the requestor should
+ * not use its MPAM features. Returns 0 on success.
+ */
+int mpam_register_requestor(u16 partid_max, u8 pmg_max);
+
 #endif /* __LINUX_ARM_MPAM_H */
-- 
2.39.5


