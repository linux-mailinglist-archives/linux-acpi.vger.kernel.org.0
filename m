Return-Path: <linux-acpi+bounces-17904-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA89BEB4D8
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 20:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8035E75BA
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 18:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C58E335066;
	Fri, 17 Oct 2025 18:57:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE0A335083;
	Fri, 17 Oct 2025 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727465; cv=none; b=HcDE2rl1dhy3BXaKHGRAR0hoEuG9ErIhMvjSEKRG1AFK9o2HeOJlsIxTZqBtQTE8gNdljBHii8oYi601Prf++PBqZpT6n0whD7SkrRSDfMyazWHJl+iOyI0Gmop2U72O4/g8OcE9Xn+aFvOLI/vOLq/elzcE/D6mswl94on0UOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727465; c=relaxed/simple;
	bh=wU96tf+v36vtJybg9EohFQfXi6kEb5fH/k6n12cxYKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nql/v3PZ5foMJdIsZOS8MQY2rwCWEDjVlg5mdL8eIM/oPoT5a46MS+wzraBLAgefnU/CvCT4LXhMtso5TtcNzI9mLuL3nCiNxplZaqDMbbHJfHDHMm6IMmWB18gemF6S3zu/CqDFaij3AuAcrJ9s5kldcgM49nkzRQWchO6Ea6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3D911515;
	Fri, 17 Oct 2025 11:57:34 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C137C3F66E;
	Fri, 17 Oct 2025 11:57:37 -0700 (PDT)
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
	Gavin Shan <gshan@redhat.com>
Subject: [PATCH v3 07/29] arm_mpam: Add probe/remove for mpam msc driver and kbuild boiler plate
Date: Fri, 17 Oct 2025 18:56:23 +0000
Message-Id: <20251017185645.26604-8-james.morse@arm.com>
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

Probing MPAM is convoluted. MSCs that are integrated with a CPU may
only be accessible from those CPUs, and they may not be online.
Touching the hardware early is pointless as MPAM can't be used until
the system-wide common values for num_partid and num_pmg have been
discovered.

Start with driver probe/remove and mapping the MSC.

CC: Carl Worth <carl@os.amperecomputing.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v2:
 * Comment in Kconfig about why EXPERT.
 * Dropped duplicate depends.
 * Fixed duplicate return statement.
 * Restructured driver probe to have a do_ function to allow breaks to be
   return instead...
 * Removed resctrl.h include, added spinlock.h
 * Removed stray DT function prototype
 * Removed stray PCC variables in struct mpam_msc.
 * Used ccflags not cflags for debug define.
 * Moved srcu header include to internal.h
 * Moved mpam_msc_destroy() into this patch.

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
 * Change cleanup macro to use IS_ERR_OR_NULL().

Changes since RFC:
 * Check for status=broken DT devices.
 * Moved all the files around.
 * Made Kconfig symbols depend on EXPERT
---
 arch/arm64/Kconfig              |   1 +
 drivers/Kconfig                 |   2 +
 drivers/Makefile                |   1 +
 drivers/acpi/arm64/mpam.c       |   7 ++
 drivers/resctrl/Kconfig         |  13 +++
 drivers/resctrl/Makefile        |   4 +
 drivers/resctrl/mpam_devices.c  | 190 ++++++++++++++++++++++++++++++++
 drivers/resctrl/mpam_internal.h |  52 +++++++++
 include/linux/acpi.h            |   2 +-
 9 files changed, 271 insertions(+), 1 deletion(-)
 create mode 100644 drivers/resctrl/Kconfig
 create mode 100644 drivers/resctrl/Makefile
 create mode 100644 drivers/resctrl/mpam_devices.c
 create mode 100644 drivers/resctrl/mpam_internal.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c5e66d5d72cd..004d58cfbff8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2025,6 +2025,7 @@ config ARM64_TLB_RANGE
 
 config ARM64_MPAM
 	bool "Enable support for MPAM"
+	select ARM64_MPAM_DRIVER if EXPERT	# does nothing yet
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
index 8e1ffa4358d5..20eb17596b89 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -194,6 +194,7 @@ obj-$(CONFIG_HTE)		+= hte/
 obj-$(CONFIG_DRM_ACCEL)		+= accel/
 obj-$(CONFIG_CDX_BUS)		+= cdx/
 obj-$(CONFIG_DPLL)		+= dpll/
+obj-y				+= resctrl/
 
 obj-$(CONFIG_DIBS)		+= dibs/
 obj-$(CONFIG_S390)		+= s390/
diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
index 59712397025d..51c6f5fd4a5e 100644
--- a/drivers/acpi/arm64/mpam.c
+++ b/drivers/acpi/arm64/mpam.c
@@ -337,6 +337,13 @@ static int __init acpi_mpam_parse(void)
 	return 0;
 }
 
+/**
+ * acpi_mpam_count_msc() - Count the number of MSC described by firmware.
+ *
+ * Returns the number of of MSC, or zero for an error.
+ *
+ * This can be called before or in parallel with acpi_mpam_parse().
+ */
 int acpi_mpam_count_msc(void)
 {
 	struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);
diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
new file mode 100644
index 000000000000..58c83b5c8bfd
--- /dev/null
+++ b/drivers/resctrl/Kconfig
@@ -0,0 +1,13 @@
+menuconfig ARM64_MPAM_DRIVER
+	bool "MPAM driver"
+	depends on ARM64 && ARM64_MPAM && EXPERT
+	help
+	  MPAM driver for System IP, e,g. caches and memory controllers.
+
+if ARM64_MPAM_DRIVER
+config ARM64_MPAM_DRIVER_DEBUG
+	bool "Enable debug messages from the MPAM driver"
+	help
+	  Say yes here to enable debug messages from the MPAM driver.
+
+endif
diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
new file mode 100644
index 000000000000..898199dcf80d
--- /dev/null
+++ b/drivers/resctrl/Makefile
@@ -0,0 +1,4 @@
+obj-$(CONFIG_ARM64_MPAM_DRIVER)			+= mpam.o
+mpam-y						+= mpam_devices.o
+
+ccflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)	+= -DDEBUG
diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
new file mode 100644
index 000000000000..d18eeec95f79
--- /dev/null
+++ b/drivers/resctrl/mpam_devices.c
@@ -0,0 +1,190 @@
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
+	return err;
+}
+
+static int fw_num_msc;
+
+static void mpam_msc_destroy(struct mpam_msc *msc)
+{
+	struct platform_device *pdev = msc->pdev;
+
+	lockdep_assert_held(&mpam_list_lock);
+
+	list_del_rcu(&msc->all_msc_list);
+	platform_set_drvdata(pdev, NULL);
+}
+
+static void mpam_msc_drv_remove(struct platform_device *pdev)
+{
+	struct mpam_msc *msc = platform_get_drvdata(pdev);
+
+	if (!msc)
+		return;
+
+	mutex_lock(&mpam_list_lock);
+	mpam_msc_destroy(msc);
+	mutex_unlock(&mpam_list_lock);
+
+	synchronize_srcu(&mpam_srcu);
+}
+
+static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
+{
+	int err;
+	u32 tmp;
+	struct mpam_msc *msc;
+	struct resource *msc_res;
+	struct device *dev = &pdev->dev;
+
+	lockdep_assert_held(&mpam_list_lock);
+
+	msc = devm_kzalloc(&pdev->dev, sizeof(*msc), GFP_KERNEL);
+	if (!msc)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&msc->probe_lock);
+	mutex_init(&msc->part_sel_lock);
+	msc->id = pdev->id;
+	msc->pdev = pdev;
+	INIT_LIST_HEAD_RCU(&msc->all_msc_list);
+	INIT_LIST_HEAD_RCU(&msc->ris);
+
+	err = update_msc_accessibility(msc);
+	if (err)
+		return ERR_PTR(err);
+	if (cpumask_empty(&msc->accessibility)) {
+		dev_err_once(dev, "MSC is not accessible from any CPU!");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (device_property_read_u32(&pdev->dev, "pcc-channel", &tmp))
+		msc->iface = MPAM_IFACE_MMIO;
+	else
+		msc->iface = MPAM_IFACE_PCC;
+
+	if (msc->iface == MPAM_IFACE_MMIO) {
+		void __iomem *io;
+
+		io = devm_platform_get_and_ioremap_resource(pdev, 0,
+							    &msc_res);
+		if (IS_ERR(io)) {
+			dev_err_once(dev, "Failed to map MSC base address\n");
+			return (void *)io;
+		}
+		msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
+		msc->mapped_hwpage = io;
+	}
+
+	list_add_rcu(&msc->all_msc_list, &mpam_all_msc);
+	platform_set_drvdata(pdev, msc);
+
+	return msc;
+}
+
+static int mpam_msc_drv_probe(struct platform_device *pdev)
+{
+	int err;
+	struct mpam_msc *msc = NULL;
+	void *plat_data = pdev->dev.platform_data;
+
+	mutex_lock(&mpam_list_lock);
+	msc = do_mpam_msc_drv_probe(pdev);
+	mutex_unlock(&mpam_list_lock);
+	if (!IS_ERR(msc)) {
+		/* Create RIS entries described by firmware */
+		err = acpi_mpam_parse_resources(msc, plat_data);
+		if (err)
+			mpam_msc_drv_remove(pdev);
+	} else {
+		err = PTR_ERR(msc);
+	}
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
index 000000000000..6ac75f3613c3
--- /dev/null
+++ b/drivers/resctrl/mpam_internal.h
@@ -0,0 +1,52 @@
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
+#include <linux/sizes.h>
+#include <linux/spinlock.h>
+#include <linux/srcu.h>
+
+struct platform_device;
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
+	void __iomem		*mapped_hwpage;
+	size_t			mapped_hwpage_sz;
+};
+#endif /* MPAM_INTERNAL_H */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 9d66421f68ff..70f075b397ce 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -231,7 +231,7 @@ static inline struct acpi_table_header *acpi_get_table_ret(char *signature, u32
 		return ERR_PTR(-ENOENT);
 	return table;
 }
-DEFINE_FREE(acpi_table, struct acpi_table_header *, if (!IS_ERR(_T)) acpi_put_table(_T))
+DEFINE_FREE(acpi_table, struct acpi_table_header *, if (!IS_ERR_OR_NULL(_T)) acpi_put_table(_T))
 
 int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
 int __init_or_acpilib acpi_table_parse_entries(char *id,
-- 
2.39.5


