Return-Path: <linux-acpi+bounces-16627-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 326BDB522AE
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 22:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B87116408A
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 20:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358A0307481;
	Wed, 10 Sep 2025 20:44:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51441306481;
	Wed, 10 Sep 2025 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537047; cv=none; b=UMzT8jOBS3fVOUw2gsFqDFSKotEVugprdJZVSyS863xTJf6EUOwhI5yZ3PtjYraSLOr2eP6uBAqhelhvSE1uHwKowEwwO7X5s7H9MmT0XqPIEyYWfj5kTdax08SlkciCv5KXk+4EB6ewcgGYN5Kt4yhas1F5Dd+etAszkvQItSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537047; c=relaxed/simple;
	bh=ZbfzgCDkV4CyXtCuTkzM3JAf/naBfaV5hmJ8RErclJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PWEMJlvEUuxcb/Ndv2rs2d7eMGVGV7G6X1TpDO0lRYDko3reitkfxrB+E6KNhyAwLhVaWHWXwPCCSRf7yADYQO07PYj/t0W3vqdwvTDImdhuGds0Bs4EVwyMr0a/faWbyryChJrYswUo7NeA900szVG8AxhYJ2Ez1iE0HAxHvWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 507BA22EA;
	Wed, 10 Sep 2025 13:43:56 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF0CA3F63F;
	Wed, 10 Sep 2025 13:43:59 -0700 (PDT)
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
Subject: [PATCH v2 07/29] arm_mpam: Add probe/remove for mpam msc driver and kbuild boiler plate
Date: Wed, 10 Sep 2025 20:42:47 +0000
Message-Id: <20250910204309.20751-8-james.morse@arm.com>
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

Probing MPAM is convoluted. MSCs that are integrated with a CPU may
only be accessible from those CPUs, and they may not be online.
Touching the hardware early is pointless as MPAM can't be used until
the system-wide common values for num_partid and num_pmg have been
discovered.

Start with driver probe/remove and mapping the MSC.

CC: Carl Worth <carl@os.amperecomputing.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * Avoid selecting driver on other architectrues.
 * Removed PCC support stub.
 * Use for_each_available_child_of_node_scoped() and of_property_read_reg()
 * Clarified a comment.
 * Stopped using mpam_num_msc as an id,a and made it atomic.
 * Size of -1 returned from cache_of_calculate_id()
 * Renamed some struct members.
 * Made a bunch of pr_err() dev_err_ocne().
 * Used more cleanup magic.
 * Inlined a print message.
 * Fixed error propagation from mpam_dt_parse_resources().
 * Moved cache accessibility checks earlier.

Changes since RFC:
 * Check for status=broken DT devices.
 * Moved all the files around.
 * Made Kconfig symbols depend on EXPERT
---
 arch/arm64/Kconfig              |   1 +
 drivers/Kconfig                 |   2 +
 drivers/Makefile                |   1 +
 drivers/resctrl/Kconfig         |  14 +++
 drivers/resctrl/Makefile        |   4 +
 drivers/resctrl/mpam_devices.c  | 180 ++++++++++++++++++++++++++++++++
 drivers/resctrl/mpam_internal.h |  65 ++++++++++++
 7 files changed, 267 insertions(+)
 create mode 100644 drivers/resctrl/Kconfig
 create mode 100644 drivers/resctrl/Makefile
 create mode 100644 drivers/resctrl/mpam_devices.c
 create mode 100644 drivers/resctrl/mpam_internal.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6487c511bdc6..93e563e1cce4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2062,6 +2062,7 @@ config ARM64_TLB_RANGE
 
 config ARM64_MPAM
 	bool "Enable support for MPAM"
+	select ARM64_MPAM_DRIVER if EXPERT
 	select ACPI_MPAM if ACPI
 	help
 	  Memory System Resource Partitioning and Monitoring (MPAM) is an
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 4915a63866b0..3054b50a2f4c 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -251,4 +251,6 @@ source "drivers/hte/Kconfig"
 
 source "drivers/cdx/Kconfig"
 
+source "drivers/resctrl/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index b5749cf67044..f41cf4eddeba 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -194,5 +194,6 @@ obj-$(CONFIG_HTE)		+= hte/
 obj-$(CONFIG_DRM_ACCEL)		+= accel/
 obj-$(CONFIG_CDX_BUS)		+= cdx/
 obj-$(CONFIG_DPLL)		+= dpll/
+obj-y				+= resctrl/
 
 obj-$(CONFIG_S390)		+= s390/
diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
new file mode 100644
index 000000000000..c30532a3a3a4
--- /dev/null
+++ b/drivers/resctrl/Kconfig
@@ -0,0 +1,14 @@
+menuconfig ARM64_MPAM_DRIVER
+	bool "MPAM driver"
+	depends on ARM64 && ARM64_MPAM && EXPERT
+	help
+	  MPAM driver for System IP, e,g. caches and memory controllers.
+
+if ARM64_MPAM_DRIVER
+config ARM64_MPAM_DRIVER_DEBUG
+	bool "Enable debug messages from the MPAM driver"
+	depends on ARM64_MPAM_DRIVER
+	help
+	  Say yes here to enable debug messages from the MPAM driver.
+
+endif
diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
new file mode 100644
index 000000000000..92b48fa20108
--- /dev/null
+++ b/drivers/resctrl/Makefile
@@ -0,0 +1,4 @@
+obj-$(CONFIG_ARM64_MPAM_DRIVER)			+= mpam.o
+mpam-y						+= mpam_devices.o
+
+cflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)	+= -DDEBUG
diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
new file mode 100644
index 000000000000..efc4738e3b4d
--- /dev/null
+++ b/drivers/resctrl/mpam_devices.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2025 Arm Ltd.
+
+#define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
+
+#include <linux/acpi.h>
+#include <linux/arm_mpam.h>
+#include <linux/cacheinfo.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/list.h>
+#include <linux/lockdep.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/srcu.h>
+#include <linux/types.h>
+
+#include "mpam_internal.h"
+
+/*
+ * mpam_list_lock protects the SRCU lists when writing. Once the
+ * mpam_enabled key is enabled these lists are read-only,
+ * unless the error interrupt disables the driver.
+ */
+static DEFINE_MUTEX(mpam_list_lock);
+static LIST_HEAD(mpam_all_msc);
+
+static struct srcu_struct mpam_srcu;
+
+/*
+ * Number of MSCs that have been probed. Once all MSC have been probed MPAM
+ * can be enabled.
+ */
+static atomic_t mpam_num_msc;
+
+/*
+ * An MSC can control traffic from a set of CPUs, but may only be accessible
+ * from a (hopefully wider) set of CPUs. The common reason for this is power
+ * management. If all the CPUs in a cluster are in PSCI:CPU_SUSPEND, the
+ * corresponding cache may also be powered off. By making accesses from
+ * one of those CPUs, we ensure this isn't the case.
+ */
+static int update_msc_accessibility(struct mpam_msc *msc)
+{
+	u32 affinity_id;
+	int err;
+
+	err = device_property_read_u32(&msc->pdev->dev, "cpu_affinity",
+				       &affinity_id);
+	if (err)
+		cpumask_copy(&msc->accessibility, cpu_possible_mask);
+	else
+		acpi_pptt_get_cpus_from_container(affinity_id,
+						  &msc->accessibility);
+
+	return 0;
+
+	return err;
+}
+
+static int fw_num_msc;
+
+static void mpam_msc_drv_remove(struct platform_device *pdev)
+{
+	struct mpam_msc *msc = platform_get_drvdata(pdev);
+
+	if (!msc)
+		return;
+
+	mutex_lock(&mpam_list_lock);
+	platform_set_drvdata(pdev, NULL);
+	list_del_rcu(&msc->all_msc_list);
+	synchronize_srcu(&mpam_srcu);
+	mutex_unlock(&mpam_list_lock);
+}
+
+static int mpam_msc_drv_probe(struct platform_device *pdev)
+{
+	int err;
+	struct mpam_msc *msc;
+	struct resource *msc_res;
+	struct device *dev = &pdev->dev;
+	void *plat_data = pdev->dev.platform_data;
+
+	mutex_lock(&mpam_list_lock);
+	do {
+		msc = devm_kzalloc(&pdev->dev, sizeof(*msc), GFP_KERNEL);
+		if (!msc) {
+			err = -ENOMEM;
+			break;
+		}
+
+		mutex_init(&msc->probe_lock);
+		mutex_init(&msc->part_sel_lock);
+		mutex_init(&msc->outer_mon_sel_lock);
+		raw_spin_lock_init(&msc->inner_mon_sel_lock);
+		msc->id = pdev->id;
+		msc->pdev = pdev;
+		INIT_LIST_HEAD_RCU(&msc->all_msc_list);
+		INIT_LIST_HEAD_RCU(&msc->ris);
+
+		err = update_msc_accessibility(msc);
+		if (err)
+			break;
+		if (cpumask_empty(&msc->accessibility)) {
+			dev_err_once(dev, "MSC is not accessible from any CPU!");
+			err = -EINVAL;
+			break;
+		}
+
+		if (device_property_read_u32(&pdev->dev, "pcc-channel",
+					     &msc->pcc_subspace_id))
+			msc->iface = MPAM_IFACE_MMIO;
+		else
+			msc->iface = MPAM_IFACE_PCC;
+
+		if (msc->iface == MPAM_IFACE_MMIO) {
+			void __iomem *io;
+
+			io = devm_platform_get_and_ioremap_resource(pdev, 0,
+								    &msc_res);
+			if (IS_ERR(io)) {
+				dev_err_once(dev, "Failed to map MSC base address\n");
+				err = PTR_ERR(io);
+				break;
+			}
+			msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
+			msc->mapped_hwpage = io;
+		}
+
+		list_add_rcu(&msc->all_msc_list, &mpam_all_msc);
+		platform_set_drvdata(pdev, msc);
+	} while (0);
+	mutex_unlock(&mpam_list_lock);
+
+	if (!err) {
+		/* Create RIS entries described by firmware */
+		err = acpi_mpam_parse_resources(msc, plat_data);
+	}
+
+	if (err && msc)
+		mpam_msc_drv_remove(pdev);
+
+	if (!err && atomic_add_return(1, &mpam_num_msc) == fw_num_msc)
+		pr_info("Discovered all MSC\n");
+
+	return err;
+}
+
+static struct platform_driver mpam_msc_driver = {
+	.driver = {
+		.name = "mpam_msc",
+	},
+	.probe = mpam_msc_drv_probe,
+	.remove = mpam_msc_drv_remove,
+};
+
+static int __init mpam_msc_driver_init(void)
+{
+	if (!system_supports_mpam())
+		return -EOPNOTSUPP;
+
+	init_srcu_struct(&mpam_srcu);
+
+	fw_num_msc = acpi_mpam_count_msc();
+
+	if (fw_num_msc <= 0) {
+		pr_err("No MSC devices found in firmware\n");
+		return -EINVAL;
+	}
+
+	return platform_driver_register(&mpam_msc_driver);
+}
+subsys_initcall(mpam_msc_driver_init);
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
new file mode 100644
index 000000000000..7c63d590fc98
--- /dev/null
+++ b/drivers/resctrl/mpam_internal.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (C) 2025 Arm Ltd.
+
+#ifndef MPAM_INTERNAL_H
+#define MPAM_INTERNAL_H
+
+#include <linux/arm_mpam.h>
+#include <linux/cpumask.h>
+#include <linux/io.h>
+#include <linux/mailbox_client.h>
+#include <linux/mutex.h>
+#include <linux/resctrl.h>
+#include <linux/sizes.h>
+
+struct mpam_msc {
+	/* member of mpam_all_msc */
+	struct list_head        all_msc_list;
+
+	int			id;
+	struct platform_device *pdev;
+
+	/* Not modified after mpam_is_enabled() becomes true */
+	enum mpam_msc_iface	iface;
+	u32			pcc_subspace_id;
+	struct mbox_client	pcc_cl;
+	struct pcc_mbox_chan	*pcc_chan;
+	u32			nrdy_usec;
+	cpumask_t		accessibility;
+
+	/*
+	 * probe_lock is only taken during discovery. After discovery these
+	 * properties become read-only and the lists are protected by SRCU.
+	 */
+	struct mutex		probe_lock;
+	unsigned long		ris_idxs;
+	u32			ris_max;
+
+	/* mpam_msc_ris of this component */
+	struct list_head	ris;
+
+	/*
+	 * part_sel_lock protects access to the MSC hardware registers that are
+	 * affected by MPAMCFG_PART_SEL. (including the ID registers that vary
+	 * by RIS).
+	 * If needed, take msc->probe_lock first.
+	 */
+	struct mutex		part_sel_lock;
+
+	/*
+	 * mon_sel_lock protects access to the MSC hardware registers that are
+	 * affected by MPAMCFG_MON_SEL.
+	 * If needed, take msc->probe_lock first.
+	 */
+	struct mutex		outer_mon_sel_lock;
+	raw_spinlock_t		inner_mon_sel_lock;
+	unsigned long		inner_mon_sel_flags;
+
+	void __iomem		*mapped_hwpage;
+	size_t			mapped_hwpage_sz;
+};
+
+int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
+				   cpumask_t *affinity);
+
+#endif /* MPAM_INTERNAL_H */
-- 
2.39.5


