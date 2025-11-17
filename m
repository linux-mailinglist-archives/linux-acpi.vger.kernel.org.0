Return-Path: <linux-acpi+bounces-18945-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5381DC65542
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 18:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A88D9293C6
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0404A32C954;
	Mon, 17 Nov 2025 17:01:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2144531577B;
	Mon, 17 Nov 2025 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398906; cv=none; b=noKQ9FdXiH8dOPpDFZYd+XiNxA7dakiH794B87+Ii7Xdxr+8Np56Wp4XTRU4sZ4dSfZam9qfzoEM05pbAA4fgA/cK/RAouu/BH08aHSQzb2D9M9azGDLKnTA5EYAotYcQUFPJ4xT2QLl6ug2gduDx8pxD4H69/LIIDc8NoyOrd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398906; c=relaxed/simple;
	bh=yEvOYdRLf+O9obDldejkWnfa4aWtQgEJBq0LwL84OZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CN26Coighf0IU1CT9QzeG6mX9iPUxSSmVl1ZZGqfAp2YrfaVJ+rnnPU0PIMu/Or34MSOacNBivIJYo+U0Nvym4YNAbfKGM7uUheylkcrEnpTyyCxf98XZC5C5+KsHxJBWbpSEaufwBujVn1zMI4dPOOB17BwXvmuZiA+TVLx0UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9711FEC;
	Mon, 17 Nov 2025 09:01:36 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B8A03F66E;
	Mon, 17 Nov 2025 09:01:39 -0800 (PST)
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
	Ben Horgan <ben.horgan@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Zeng Heng <zengheng4@huawei.com>
Subject: [PATCH v5 14/34] arm_mpam: Probe hardware to find the supported partid/pmg values
Date: Mon, 17 Nov 2025 16:59:53 +0000
Message-ID: <20251117170014.4113754-15-ben.horgan@arm.com>
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

CPUs can generate traffic with a range of PARTID and PMG values,
but each MSC may also have its own maximum size for these fields.
Before MPAM can be used, the driver needs to probe each RIS on
each MSC, to find the system-wide smallest value that can be used.
The limits from requestors (e.g. CPUs) also need taking into account.

While doing this, RIS entries that firmware didn't describe are created
under MPAM_CLASS_UNKNOWN.

This adds the low level MSC write accessors.

While we're here, implement the mpam_register_requestor() call
for the arch code to register the CPU limits. Future callers of this
will tell us about the SMMU and ITS.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com>
Tested-by: Gavin Shan <gshan@redhat.com>
Tested-by: Zeng Heng <zengheng4@huawei.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
Changes since v3:
From Jonathan:
Stray comma in printk
Unnecessary braces
---
 drivers/resctrl/mpam_devices.c  | 148 +++++++++++++++++++++++++++++++-
 drivers/resctrl/mpam_internal.h |   6 ++
 include/linux/arm_mpam.h        |  14 +++
 3 files changed, 167 insertions(+), 1 deletion(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 51284f55ae9b..ac1c770cea35 100644
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
@@ -42,6 +43,15 @@ static atomic_t mpam_num_msc;
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
@@ -143,6 +153,70 @@ static inline u32 _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg)
 
 #define mpam_read_partsel_reg(msc, reg) _mpam_read_partsel_reg(msc, MPAMF_##reg)
 
+static void __mpam_write_reg(struct mpam_msc *msc, u16 reg, u32 val)
+{
+	WARN_ON_ONCE(reg + sizeof(u32) >= msc->mapped_hwpage_sz);
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
+
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
+	guard(spinlock)(&partid_max_lock);
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
+			return -EBUSY;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(mpam_register_requestor);
+
 static struct mpam_class *
 mpam_class_alloc(u8 level_idx, enum mpam_class_types type)
 {
@@ -450,9 +524,35 @@ int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
 	return err;
 }
 
+static struct mpam_msc_ris *mpam_get_or_create_ris(struct mpam_msc *msc,
+						   u8 ris_idx)
+{
+	int err;
+	struct mpam_msc_ris *ris;
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
+		if (ris->ris_idx == ris_idx)
+			return ris;
+	}
+
+	return ERR_PTR(-ENOENT);
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
@@ -463,6 +563,40 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
 		return -EIO;
 	}
 
+	/* Grab an IDR value to find out how many RIS there are */
+	mutex_lock(&msc->part_sel_lock);
+	idr = mpam_msc_read_idr(msc);
+	mutex_unlock(&msc->part_sel_lock);
+
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
@@ -682,10 +816,20 @@ static struct platform_driver mpam_msc_driver = {
 
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
 	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline,
 				      "mpam:online");
 
-	pr_info("MPAM enabled\n");
+	/* Use printk() to avoid the pr_fmt adding the function name. */
+	printk(KERN_INFO "MPAM enabled with %u PARTIDs and %u PMGs\n",
+	       mpam_partid_max + 1, mpam_pmg_max + 1);
 }
 
 void mpam_disable(struct work_struct *ignored)
@@ -751,4 +895,6 @@ static int __init mpam_msc_driver_init(void)
 
 	return platform_driver_register(&mpam_msc_driver);
 }
+
+/* Must occur after arm64_mpam_register_cpus() from arch_initcall() */
 subsys_initcall(mpam_msc_driver_init);
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 4e1538d29783..768a58a3ab27 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -49,6 +49,8 @@ struct mpam_msc {
 	 */
 	struct mutex		probe_lock;
 	bool			probed;
+	u16			partid_max;
+	u8			pmg_max;
 	unsigned long		ris_idxs;
 	u32			ris_max;
 
@@ -138,6 +140,10 @@ struct mpam_msc_ris {
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
index 13a8ac5c2cbd..7f00c5285a32 100644
--- a/include/linux/arm_mpam.h
+++ b/include/linux/arm_mpam.h
@@ -49,4 +49,18 @@ static inline int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
 }
 #endif
 
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
2.43.0


