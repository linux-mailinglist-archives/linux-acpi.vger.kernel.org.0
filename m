Return-Path: <linux-acpi+bounces-18944-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE222C65539
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 18:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id E46F7293C1
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 17:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A01932937E;
	Mon, 17 Nov 2025 17:01:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DAF31577B;
	Mon, 17 Nov 2025 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398901; cv=none; b=m62lN6WGbXNzLK3klyZbKWZMKrSCZvLwZVjBDoazNCvcmSUf6ACZP915IOfanfYk3iSxQ5CtZRf9kW65OP7upUUCGd1huWnjyL8iZWG24ysPwud+zoBvNLCwzfauUkG6JKXy+f/Esuk/vglJZapqtxvU+kX2Vt6EAK0XYsiVmEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398901; c=relaxed/simple;
	bh=QqThtEr1yDr/aUTeL79NsqDLBW1SuboZEqPGIDtqP1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGhDtevjHRmXifNbKrO9c8pRW06JCGJnPHdQuh/L5AoDhMh1ZLN/i9ynDRS8moSewCgBQdlRKYXeFEgLmjNxgehfOnJlAziVWlQMKwVMukMOdX0T4c1ONhVlGhQN1y79qsRSDnN1GAt3EVpW/Uw9exYgZ0uReAXo5Qm/z3E7nvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 828E81655;
	Mon, 17 Nov 2025 09:01:31 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E8C643F66E;
	Mon, 17 Nov 2025 09:01:33 -0800 (PST)
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
	Lecopzer Chen <lecopzerc@nvidia.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Zeng Heng <zengheng4@huawei.com>
Subject: [PATCH v5 13/34] arm_mpam: Add cpuhp callbacks to probe MSC hardware
Date: Mon, 17 Nov 2025 16:59:52 +0000
Message-ID: <20251117170014.4113754-14-ben.horgan@arm.com>
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

Because an MSC can only by accessed from the CPUs in its cpu-affinity
set we need to be running on one of those CPUs to probe the MSC
hardware.

Do this work in the cpuhp callback. Probing the hardware will only
happen before MPAM is enabled, walk all the MSCs and probe those we can
reach that haven't already been probed as each CPU's online call is made.

This adds the low-level MSC register read accessors.

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
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
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
Add a tag - thanks!
Include tidying
---
 drivers/resctrl/mpam_devices.c  | 176 +++++++++++++++++++++++++++++++-
 drivers/resctrl/mpam_internal.h |   5 +
 2 files changed, 180 insertions(+), 1 deletion(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index f1dcf9bb14f2..51284f55ae9b 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -4,8 +4,10 @@
 #define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
 
 #include <linux/acpi.h>
+#include <linux/atomic.h>
 #include <linux/arm_mpam.h>
 #include <linux/cacheinfo.h>
+#include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -17,6 +19,7 @@
 #include <linux/printk.h>
 #include <linux/srcu.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
 #include "mpam_internal.h"
 
@@ -36,6 +39,25 @@ struct srcu_struct mpam_srcu;
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
+/* When mpam is disabled, the printed reason to aid debugging */
+static char *mpam_disable_reason;
+
 /*
  * An MSC is a physical container for controls and monitors, each identified by
  * their RIS index. These share a base-address, interrupts and some MMIO
@@ -106,6 +128,21 @@ static void mpam_free_garbage(void)
 	}
 }
 
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
+#define mpam_read_partsel_reg(msc, reg) _mpam_read_partsel_reg(msc, MPAMF_##reg)
+
 static struct mpam_class *
 mpam_class_alloc(u8 level_idx, enum mpam_class_types type)
 {
@@ -413,6 +450,86 @@ int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
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
+		if (err)
+			break;
+		new_device_probed = true;
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
+					  int (*offline)(unsigned int offline),
+					  char *name)
+{
+	mutex_lock(&mpam_cpuhp_state_lock);
+	if (mpam_cpuhp_state) {
+		cpuhp_remove_state(mpam_cpuhp_state);
+		mpam_cpuhp_state = 0;
+	}
+
+	mpam_cpuhp_state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, name, online,
+					     offline);
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
@@ -549,7 +666,8 @@ static int mpam_msc_drv_probe(struct platform_device *pdev)
 	}
 
 	if (atomic_add_return(1, &mpam_num_msc) == fw_num_msc)
-		pr_info("Discovered all MSCs\n");
+		mpam_register_cpuhp_callbacks(mpam_discovery_cpu_online, NULL,
+					      "mpam:drv_probe");
 
 	return 0;
 }
@@ -562,6 +680,62 @@ static struct platform_driver mpam_msc_driver = {
 	.remove = mpam_msc_drv_remove,
 };
 
+static void mpam_enable_once(void)
+{
+	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline,
+				      "mpam:online");
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
index 51f791cc207b..4e1538d29783 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -48,6 +48,7 @@ struct mpam_msc {
 	 * properties become read-only and the lists are protected by SRCU.
 	 */
 	struct mutex		probe_lock;
+	bool			probed;
 	unsigned long		ris_idxs;
 	u32			ris_max;
 
@@ -137,6 +138,10 @@ struct mpam_msc_ris {
 extern struct srcu_struct mpam_srcu;
 extern struct list_head mpam_classes;
 
+/* Scheduled work callback to enable mpam once all MSC have been probed */
+void mpam_enable(struct work_struct *work);
+void mpam_disable(struct work_struct *work);
+
 int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
 				   cpumask_t *affinity);
 
-- 
2.43.0


