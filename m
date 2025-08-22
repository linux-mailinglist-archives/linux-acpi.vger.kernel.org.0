Return-Path: <linux-acpi+bounces-15923-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA712B31ED0
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 17:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE1BBBA7606
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 15:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C571246779;
	Fri, 22 Aug 2025 15:32:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95DC230BC5;
	Fri, 22 Aug 2025 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876747; cv=none; b=fBycG6n3KmqsZTBRDO0z30nU0FJu6p12zvz30Lgoj3pYV6Aa4uxU2mQdOqfGDW4a+Uj2ehilqCMsSuu+N4EB2ElUutP3wWNjePtBg+JTv/M5cQWO+RGCQe9LmMPizH8ALtqYt61YcUQg6VygojE2WNmJyY/c/XkyOZgq7TVTpTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876747; c=relaxed/simple;
	bh=D8sn23uyVZKXjYi56qnnrhhb+TIoQOI3fZWQOUGpl+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AI7vcnyt3bAgQko5hefrGXS3YZxNHlSLQnUyHnBxoOAAylSvecz2gKlL38a6XOz0hj/TilDj9u/tAn8uwScffDNJF9HvJEMJvew6OWFFgPAkCPG421Cqj5HKh4MB+vLIvYB7yJ9Etif/8KdguG9le/7SDqsE0KWC8hyenW2bfEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 434D32880;
	Fri, 22 Aug 2025 08:32:17 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 139773F63F;
	Fri, 22 Aug 2025 08:32:19 -0700 (PDT)
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
	Lecopzer Chen <lecopzerc@nvidia.com>
Subject: [PATCH 14/33] arm_mpam: Add cpuhp callbacks to probe MSC hardware
Date: Fri, 22 Aug 2025 15:29:55 +0000
Message-Id: <20250822153048.2287-15-james.morse@arm.com>
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

Because an MSC can only by accessed from the CPUs in its cpu-affinity
set we need to be running on one of those CPUs to probe the MSC
hardware.

Do this work in the cpuhp callback. Probing the hardware will only
happen before MPAM is enabled, walk all the MSCs and probe those we can
reach that haven't already been probed.

Later once MPAM is enabled, this cpuhp callback will be replaced by
one that avoids the global list.

Enabling a static key will also take the cpuhp lock, so can't be done
from the cpuhp callback. Whenever a new MSC has been probed schedule
work to test if all the MSCs have now been probed.

CC: Lecopzer Chen <lecopzerc@nvidia.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/resctrl/mpam_devices.c  | 144 +++++++++++++++++++++++++++++++-
 drivers/resctrl/mpam_internal.h |   8 +-
 2 files changed, 147 insertions(+), 5 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 5baf2a8786fb..9d6516f98acf 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -4,6 +4,7 @@
 #define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
 
 #include <linux/acpi.h>
+#include <linux/atomic.h>
 #include <linux/arm_mpam.h>
 #include <linux/cacheinfo.h>
 #include <linux/cpu.h>
@@ -21,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
 #include <acpi/pcc.h>
 
@@ -39,6 +41,16 @@ struct srcu_struct mpam_srcu;
 /* MPAM isn't available until all the MSC have been probed. */
 static u32 mpam_num_msc;
 
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
 /*
  * An MSC is a physical container for controls and monitors, each identified by
  * their RIS index. These share a base-address, interrupts and some MMIO
@@ -78,6 +90,22 @@ LIST_HEAD(mpam_classes);
 /* List of all objects that can be free()d after synchronise_srcu() */
 static LLIST_HEAD(mpam_garbage);
 
+static u32 __mpam_read_reg(struct mpam_msc *msc, u16 reg)
+{
+	WARN_ON_ONCE(reg > msc->mapped_hwpage_sz);
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
@@ -511,9 +539,84 @@ int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
 	return err;
 }
 
-static void mpam_discovery_complete(void)
+static int mpam_msc_hw_probe(struct mpam_msc *msc)
+{
+	u64 idr;
+	int err;
+
+	lockdep_assert_held(&msc->probe_lock);
+
+	mutex_lock(&msc->part_sel_lock);
+	idr = mpam_read_partsel_reg(msc, AIDR);
+	if ((idr & MPAMF_AIDR_ARCH_MAJOR_REV) != MPAM_ARCHITECTURE_V1) {
+		pr_err_once("%s does not match MPAM architecture v1.x\n",
+			    dev_name(&msc->pdev->dev));
+		err = -EIO;
+	} else {
+		msc->probed = true;
+		err = 0;
+	}
+	mutex_unlock(&msc->part_sel_lock);
+
+	return err;
+}
+
+static int mpam_cpu_online(unsigned int cpu)
 {
-	pr_err("Discovered all MSC\n");
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
+	mutex_lock(&mpam_list_lock);
+	list_for_each_entry(msc, &mpam_all_msc, glbl_list) {
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
+			break; // mpam_broken
+	}
+	mutex_unlock(&mpam_list_lock);
+
+	if (new_device_probed && !err)
+		schedule_work(&mpam_enable_work);
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
 }
 
 static int mpam_dt_count_msc(void)
@@ -772,7 +875,7 @@ static int mpam_msc_drv_probe(struct platform_device *pdev)
 	}
 
 	if (!err && fw_num_msc == mpam_num_msc)
-		mpam_discovery_complete();
+		mpam_register_cpuhp_callbacks(&mpam_discovery_cpu_online, NULL);
 
 	if (err && msc)
 		mpam_msc_drv_remove(pdev);
@@ -795,6 +898,41 @@ static struct platform_driver mpam_msc_driver = {
 	.remove = mpam_msc_drv_remove,
 };
 
+static void mpam_enable_once(void)
+{
+	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline);
+
+	pr_info("MPAM enabled\n");
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
+	mutex_lock(&mpam_list_lock);
+	list_for_each_entry(msc, &mpam_all_msc, glbl_list) {
+		mutex_lock(&msc->probe_lock);
+		if (!msc->probed)
+			all_devices_probed = false;
+		mutex_unlock(&msc->probe_lock);
+
+		if (!all_devices_probed)
+			break;
+	}
+	mutex_unlock(&mpam_list_lock);
+
+	if (all_devices_probed && !atomic_fetch_inc(&once))
+		mpam_enable_once();
+}
+
 /*
  * MSC that are hidden under caches are not created as platform devices
  * as there is no cache driver. Caches are also special-cased in
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 6e0982a1a9ac..a98cca08a2ef 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -49,6 +49,7 @@ struct mpam_msc {
 	 * properties become read-only and the lists are protected by SRCU.
 	 */
 	struct mutex		probe_lock;
+	bool			probed;
 	unsigned long		ris_idxs[128 / BITS_PER_LONG];
 	u32			ris_max;
 
@@ -59,14 +60,14 @@ struct mpam_msc {
 	 * part_sel_lock protects access to the MSC hardware registers that are
 	 * affected by MPAMCFG_PART_SEL. (including the ID registers that vary
 	 * by RIS).
-	 * If needed, take msc->lock first.
+	 * If needed, take msc->probe_lock first.
 	 */
 	struct mutex		part_sel_lock;
 
 	/*
 	 * mon_sel_lock protects access to the MSC hardware registers that are
 	 * affeted by MPAMCFG_MON_SEL.
-	 * If needed, take msc->lock first.
+	 * If needed, take msc->probe_lock first.
 	 */
 	struct mutex		outer_mon_sel_lock;
 	raw_spinlock_t		inner_mon_sel_lock;
@@ -147,6 +148,9 @@ struct mpam_msc_ris {
 extern struct srcu_struct mpam_srcu;
 extern struct list_head mpam_classes;
 
+/* Scheduled work callback to enable mpam once all MSC have been probed */
+void mpam_enable(struct work_struct *work);
+
 int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
 				   cpumask_t *affinity);
 
-- 
2.20.1


