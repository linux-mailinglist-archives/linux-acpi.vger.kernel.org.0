Return-Path: <linux-acpi+bounces-16630-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C6CB522B5
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 22:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2585850BD
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 20:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624EF30AAD4;
	Wed, 10 Sep 2025 20:44:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBE130AACC;
	Wed, 10 Sep 2025 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537062; cv=none; b=iLdVue9J5MirBmSRLcYq55A7T+vbqagk2AfInyNp8ZQO9MqCQYq1sCpLLYTdWCRbVcGHbTq+DTbUhXHMg17F4ob884Y9iil89X5ENKxSPEwwGp1Mh9eXO497s0Xxm4ntJdr5HnkFWStn5veQIprfTOD/fI5pEpZw4pEf01iPia0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537062; c=relaxed/simple;
	bh=1DaYWnI5xlh9G7vTYH9KyIFwMZBmSH2lxHYTiQgI/1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q0+LdisxWeu5HKDahBvjWRqsuL6wnP1JmoM5NUwE15o0qh+dMDulTMMeTfJcDkRCt6e7V8s0TZLobrbckhsufw7oqPqA7cTCotvmf4gXp9XBaBzXqSyLFKMmx2AEEzCAlZdoOlvzqX2aAuwQB5korHJRpPt7qMKtIKLz7B7358Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6201153B;
	Wed, 10 Sep 2025 13:44:11 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6019A3F63F;
	Wed, 10 Sep 2025 13:44:15 -0700 (PDT)
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
	Lecopzer Chen <lecopzerc@nvidia.com>
Subject: [PATCH v2 10/29] arm_mpam: Add cpuhp callbacks to probe MSC hardware
Date: Wed, 10 Sep 2025 20:42:50 +0000
Message-Id: <20250910204309.20751-11-james.morse@arm.com>
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

Because an MSC can only by accessed from the CPUs in its cpu-affinity
set we need to be running on one of those CPUs to probe the MSC
hardware.

Do this work in the cpuhp callback. Probing the hardware will only
happen before MPAM is enabled, walk all the MSCs and probe those we can
reach that haven't already been probed as each CPU's online call is made.

This adds the low-level MSC register accessors.

Once all MSCs reported by the firmware have been probed from a CPU in
their respective cpu-affinity set, the probe-time cpuhp callbacks are
replaced.  The replacement callbacks will ultimately need to handle
save/restore of the runtime MSC state across power transitions, but for
now there is nothing to do in them: so do nothing.

The architecture's context switch code will be enabled by a static-key,
this can be set by mpam_enable(), but must be done from process context,
not a cpuhp callback because both take the cpuhp lock.
Whenever a new MSC has been probed, the mpam_enable() work is scheduled
to test if all the MSCs have been probed. If probing fails, mpam_disable()
is scheduled to unregister the cpuhp callbacks and free memory.

CC: Lecopzer Chen <lecopzerc@nvidia.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * Removed register bounds check. If the firmware tables are wrong the
   resulting translation fault should be enough to debug this.
 * Removed '&' in front of a function pointer.
 * Pulled mpam_disable() into this patch.
 * Disable mpam when probing fails to avoid extra work on broken platforms.
 * Added mpam_disbale_reason as there are now two non-debug reasons for this
   to happen.
---
 drivers/resctrl/mpam_devices.c  | 173 +++++++++++++++++++++++++++++++-
 drivers/resctrl/mpam_internal.h |   5 +
 2 files changed, 177 insertions(+), 1 deletion(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index c7f4981b3545..c265376d936b 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -4,6 +4,7 @@
 #define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
 
 #include <linux/acpi.h>
+#include <linux/atomic.h>
 #include <linux/arm_mpam.h>
 #include <linux/cacheinfo.h>
 #include <linux/cpu.h>
@@ -19,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
 #include "mpam_internal.h"
 
@@ -38,6 +40,22 @@ struct srcu_struct mpam_srcu;
  */
 static atomic_t mpam_num_msc;
 
+static int mpam_cpuhp_state;
+static DEFINE_MUTEX(mpam_cpuhp_state_lock);
+
+/*
+ * mpam is enabled once all devices have been probed from CPU online callbacks,
+ * scheduled via this work_struct. If access to an MSC depends on a CPU that
+ * was not brought online at boot, this can happen surprisingly late.
+ */
+static DECLARE_WORK(mpam_enable_work, &mpam_enable);
+
+/*
+ * All mpam error interrupts indicate a software bug. On receipt, disable the
+ * driver.
+ */
+static DECLARE_WORK(mpam_broken_work, &mpam_disable);
+
 /*
  * An MSC is a physical container for controls and monitors, each identified by
  * their RIS index. These share a base-address, interrupts and some MMIO
@@ -77,6 +95,24 @@ LIST_HEAD(mpam_classes);
 /* List of all objects that can be free()d after synchronise_srcu() */
 static LLIST_HEAD(mpam_garbage);
 
+/* When mpam is disabled, the printed reason to aid debugging */
+static char *mpam_disable_reason;
+
+static u32 __mpam_read_reg(struct mpam_msc *msc, u16 reg)
+{
+	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
+
+	return readl_relaxed(msc->mapped_hwpage + reg);
+}
+
+static inline u32 _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg)
+{
+	lockdep_assert_held_once(&msc->part_sel_lock);
+	return __mpam_read_reg(msc, reg);
+}
+
+#define mpam_read_partsel_reg(msc, reg)        _mpam_read_partsel_reg(msc, MPAMF_##reg)
+
 #define init_garbage(x)	init_llist_node(&(x)->garbage.llist)
 
 static struct mpam_vmsc *
@@ -434,6 +470,86 @@ int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
 	return err;
 }
 
+static int mpam_msc_hw_probe(struct mpam_msc *msc)
+{
+	u64 idr;
+	struct device *dev = &msc->pdev->dev;
+
+	lockdep_assert_held(&msc->probe_lock);
+
+	idr = __mpam_read_reg(msc, MPAMF_AIDR);
+	if ((idr & MPAMF_AIDR_ARCH_MAJOR_REV) != MPAM_ARCHITECTURE_V1) {
+		dev_err_once(dev, "MSC does not match MPAM architecture v1.x\n");
+		return -EIO;
+	}
+
+	msc->probed = true;
+
+	return 0;
+}
+
+static int mpam_cpu_online(unsigned int cpu)
+{
+	return 0;
+}
+
+/* Before mpam is enabled, try to probe new MSC */
+static int mpam_discovery_cpu_online(unsigned int cpu)
+{
+	int err = 0;
+	struct mpam_msc *msc;
+	bool new_device_probed = false;
+
+	guard(srcu)(&mpam_srcu);
+	list_for_each_entry_srcu(msc, &mpam_all_msc, all_msc_list,
+				 srcu_read_lock_held(&mpam_srcu)) {
+		if (!cpumask_test_cpu(cpu, &msc->accessibility))
+			continue;
+
+		mutex_lock(&msc->probe_lock);
+		if (!msc->probed)
+			err = mpam_msc_hw_probe(msc);
+		mutex_unlock(&msc->probe_lock);
+
+		if (!err)
+			new_device_probed = true;
+		else
+			break;
+	}
+
+	if (new_device_probed && !err)
+		schedule_work(&mpam_enable_work);
+	if (err) {
+		mpam_disable_reason = "error during probing";
+		schedule_work(&mpam_broken_work);
+	}
+
+	return err;
+}
+
+static int mpam_cpu_offline(unsigned int cpu)
+{
+	return 0;
+}
+
+static void mpam_register_cpuhp_callbacks(int (*online)(unsigned int online),
+					  int (*offline)(unsigned int offline))
+{
+	mutex_lock(&mpam_cpuhp_state_lock);
+	if (mpam_cpuhp_state) {
+		cpuhp_remove_state(mpam_cpuhp_state);
+		mpam_cpuhp_state = 0;
+	}
+
+	mpam_cpuhp_state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mpam:online",
+					     online, offline);
+	if (mpam_cpuhp_state <= 0) {
+		pr_err("Failed to register cpuhp callbacks");
+		mpam_cpuhp_state = 0;
+	}
+	mutex_unlock(&mpam_cpuhp_state_lock);
+}
+
 /*
  * An MSC can control traffic from a set of CPUs, but may only be accessible
  * from a (hopefully wider) set of CPUs. The common reason for this is power
@@ -544,7 +660,7 @@ static int mpam_msc_drv_probe(struct platform_device *pdev)
 		mpam_msc_drv_remove(pdev);
 
 	if (!err && atomic_add_return(1, &mpam_num_msc) == fw_num_msc)
-		pr_info("Discovered all MSC\n");
+		mpam_register_cpuhp_callbacks(mpam_discovery_cpu_online, NULL);
 
 	return err;
 }
@@ -557,6 +673,61 @@ static struct platform_driver mpam_msc_driver = {
 	.remove = mpam_msc_drv_remove,
 };
 
+static void mpam_enable_once(void)
+{
+	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline);
+
+	pr_info("MPAM enabled\n");
+}
+
+void mpam_disable(struct work_struct *ignored)
+{
+	struct mpam_msc *msc, *tmp;
+
+	mutex_lock(&mpam_cpuhp_state_lock);
+	if (mpam_cpuhp_state) {
+		cpuhp_remove_state(mpam_cpuhp_state);
+		mpam_cpuhp_state = 0;
+	}
+	mutex_unlock(&mpam_cpuhp_state_lock);
+
+	mutex_lock(&mpam_list_lock);
+	list_for_each_entry_safe(msc, tmp, &mpam_all_msc, all_msc_list)
+		mpam_msc_destroy(msc);
+	mutex_unlock(&mpam_list_lock);
+	mpam_free_garbage();
+
+	pr_err_once("MPAM disabled due to %s\n", mpam_disable_reason);
+}
+
+/*
+ * Enable mpam once all devices have been probed.
+ * Scheduled by mpam_discovery_cpu_online() once all devices have been created.
+ * Also scheduled when new devices are probed when new CPUs come online.
+ */
+void mpam_enable(struct work_struct *work)
+{
+	static atomic_t once;
+	struct mpam_msc *msc;
+	bool all_devices_probed = true;
+
+	/* Have we probed all the hw devices? */
+	guard(srcu)(&mpam_srcu);
+	list_for_each_entry_srcu(msc, &mpam_all_msc, all_msc_list,
+				 srcu_read_lock_held(&mpam_srcu)) {
+		mutex_lock(&msc->probe_lock);
+		if (!msc->probed)
+			all_devices_probed = false;
+		mutex_unlock(&msc->probe_lock);
+
+		if (!all_devices_probed)
+			break;
+	}
+
+	if (all_devices_probed && !atomic_fetch_inc(&once))
+		mpam_enable_once();
+}
+
 static int __init mpam_msc_driver_init(void)
 {
 	if (!system_supports_mpam())
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 109f03df46c2..d4f3febc7a50 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -51,6 +51,7 @@ struct mpam_msc {
 	 * properties become read-only and the lists are protected by SRCU.
 	 */
 	struct mutex		probe_lock;
+	bool			probed;
 	unsigned long		ris_idxs;
 	u32			ris_max;
 
@@ -149,6 +150,10 @@ struct mpam_msc_ris {
 extern struct srcu_struct mpam_srcu;
 extern struct list_head mpam_classes;
 
+/* Scheduled work callback to enable mpam once all MSC have been probed */
+void mpam_enable(struct work_struct *work);
+void mpam_disable(struct work_struct *work);
+
 int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
 				   cpumask_t *affinity);
 
-- 
2.39.5


