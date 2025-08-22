Return-Path: <linux-acpi+bounces-15931-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AC6B31F09
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 17:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA2D6463AC
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF0C28642C;
	Fri, 22 Aug 2025 15:33:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE3F23BCFF;
	Fri, 22 Aug 2025 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876792; cv=none; b=A+1KteSzZqfY00PUohAAeO92MWv6y/8VdxoOR370wrV6wvLlmMSfDldMk6VYh51ZR4A/QF4pyULkUSj3I04kb1Ol8iKPyBYZUJ+PoAJDPaZQDWb0Pkz9w5hWju5+Yc7IMQ9boTZvgR1QJI96mVjRjIcX8wFyRsyEAoDRBVs1P8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876792; c=relaxed/simple;
	bh=97eqOvDRVNdpalL4cQZkLBZqWKPMfcJSnL2FMWLYgD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cl068a2x95tAOV5AB3c4YG17ka93+ny6pw0TWvKAlqQpCRjoy/eTxtmNJmzyO25tW1uFdpejfPEdzj/EvfqitIP+3WAKYOlVw3+7k3wghAS8YeAdxoxKS/T4HPNUayDl0VSsxj/TIZA2Gfv3lF+yP8Fy5Ey8ziH+jd4CqhRyNig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 513A227DC;
	Fri, 22 Aug 2025 08:33:02 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 453BC3F63F;
	Fri, 22 Aug 2025 08:33:05 -0700 (PDT)
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
Subject: [PATCH 22/33] arm_mpam: Register and enable IRQs
Date: Fri, 22 Aug 2025 15:30:03 +0000
Message-Id: <20250822153048.2287-23-james.morse@arm.com>
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

Register and enable error IRQs. All the MPAM error interrupts indicate a
software bug, e.g. out of range partid. If the error interrupt is ever
signalled, attempt to disable MPAM.

Only the irq handler accesses the ESR register, so no locking is needed.
The work to disable MPAM after an error needs to happen at process
context, use a threaded interrupt.

There is no support for percpu threaded interrupts, for now schedule
the work to be done from the irq handler.

Enabling the IRQs in the MSC may involve cross calling to a CPU that
can access the MSC.

Once the IRQ is requested, the mpam_disable() path can be called
asynchronously, which will walk structures sized by max_partid. Ensure
this size is fixed before the interrupt is requested.

CC: Rohit Mathew <rohit.mathew@arm.com>
Tested-by: Rohit Mathew <rohit.mathew@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since RFC:
 * Use guard marco when walking srcu list.
 * Use INTEN macro for enabling interrupts.
 * Move partid_max_published up earlier in mpam_enable_once().
---
 drivers/resctrl/mpam_devices.c  | 311 +++++++++++++++++++++++++++++++-
 drivers/resctrl/mpam_internal.h |   9 +-
 2 files changed, 312 insertions(+), 8 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 3516cbe8623e..210d64fad0b1 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -14,6 +14,9 @@
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/gfp.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/mutex.h>
@@ -62,6 +65,12 @@ static DEFINE_SPINLOCK(partid_max_lock);
  */
 static DECLARE_WORK(mpam_enable_work, &mpam_enable);
 
+/*
+ * All mpam error interrupts indicate a software bug. On receipt, disable the
+ * driver.
+ */
+static DECLARE_WORK(mpam_broken_work, &mpam_disable);
+
 /*
  * An MSC is a physical container for controls and monitors, each identified by
  * their RIS index. These share a base-address, interrupts and some MMIO
@@ -159,6 +168,24 @@ static u64 mpam_msc_read_idr(struct mpam_msc *msc)
 	return (idr_high << 32) | idr_low;
 }
 
+static void mpam_msc_zero_esr(struct mpam_msc *msc)
+{
+	__mpam_write_reg(msc, MPAMF_ESR, 0);
+	if (msc->has_extd_esr)
+		__mpam_write_reg(msc, MPAMF_ESR + 4, 0);
+}
+
+static u64 mpam_msc_read_esr(struct mpam_msc *msc)
+{
+	u64 esr_high = 0, esr_low;
+
+	esr_low = __mpam_read_reg(msc, MPAMF_ESR);
+	if (msc->has_extd_esr)
+		esr_high = __mpam_read_reg(msc, MPAMF_ESR + 4);
+
+	return (esr_high << 32) | esr_low;
+}
+
 static void __mpam_part_sel_raw(u32 partsel, struct mpam_msc *msc)
 {
 	lockdep_assert_held(&msc->part_sel_lock);
@@ -405,12 +432,12 @@ static void mpam_msc_destroy(struct mpam_msc *msc)
 
 	lockdep_assert_held(&mpam_list_lock);
 
-	list_del_rcu(&msc->glbl_list);
-	platform_set_drvdata(pdev, NULL);
-
 	list_for_each_entry_safe(ris, tmp, &msc->ris, msc_list)
 		mpam_ris_destroy(ris);
 
+	list_del_rcu(&msc->glbl_list);
+	platform_set_drvdata(pdev, NULL);
+
 	add_to_garbage(msc);
 	msc->garbage.pdev = pdev;
 }
@@ -828,6 +855,7 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
 		pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
 		msc->partid_max = min(msc->partid_max, partid_max);
 		msc->pmg_max = min(msc->pmg_max, pmg_max);
+		msc->has_extd_esr = FIELD_GET(MPAMF_IDR_HAS_EXTD_ESR, idr);
 
 		ris = mpam_get_or_create_ris(msc, ris_idx);
 		if (IS_ERR(ris))
@@ -840,6 +868,9 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
 		mutex_unlock(&msc->part_sel_lock);
 	}
 
+	/* Clear any stale errors */
+	mpam_msc_zero_esr(msc);
+
 	spin_lock(&partid_max_lock);
 	mpam_partid_max = min(mpam_partid_max, msc->partid_max);
 	mpam_pmg_max = min(mpam_pmg_max, msc->pmg_max);
@@ -973,6 +1004,13 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
 	mpam_mon_sel_outer_unlock(msc);
 }
 
+static void _enable_percpu_irq(void *_irq)
+{
+	int *irq = _irq;
+
+	enable_percpu_irq(*irq, IRQ_TYPE_NONE);
+}
+
 static int mpam_cpu_online(unsigned int cpu)
 {
 	int idx;
@@ -983,6 +1021,9 @@ static int mpam_cpu_online(unsigned int cpu)
 		if (!cpumask_test_cpu(cpu, &msc->accessibility))
 			continue;
 
+		if (msc->reenable_error_ppi)
+			_enable_percpu_irq(&msc->reenable_error_ppi);
+
 		if (atomic_fetch_inc(&msc->online_refs) == 0)
 			mpam_reset_msc(msc, true);
 	}
@@ -1031,6 +1072,9 @@ static int mpam_cpu_offline(unsigned int cpu)
 		if (!cpumask_test_cpu(cpu, &msc->accessibility))
 			continue;
 
+		if (msc->reenable_error_ppi)
+			disable_percpu_irq(msc->reenable_error_ppi);
+
 		if (atomic_dec_and_test(&msc->online_refs))
 			mpam_reset_msc(msc, false);
 	}
@@ -1057,6 +1101,51 @@ static void mpam_register_cpuhp_callbacks(int (*online)(unsigned int online),
 	mutex_unlock(&mpam_cpuhp_state_lock);
 }
 
+static int __setup_ppi(struct mpam_msc *msc)
+{
+	int cpu;
+
+	msc->error_dev_id = alloc_percpu_gfp(struct mpam_msc *, GFP_KERNEL);
+	if (!msc->error_dev_id)
+		return -ENOMEM;
+
+	for_each_cpu(cpu, &msc->accessibility) {
+		struct mpam_msc *empty = *per_cpu_ptr(msc->error_dev_id, cpu);
+
+		if (empty) {
+			pr_err_once("%s shares PPI with %s!\n",
+				    dev_name(&msc->pdev->dev),
+				    dev_name(&empty->pdev->dev));
+			return -EBUSY;
+		}
+		*per_cpu_ptr(msc->error_dev_id, cpu) = msc;
+	}
+
+	return 0;
+}
+
+static int mpam_msc_setup_error_irq(struct mpam_msc *msc)
+{
+	int irq;
+
+	irq = platform_get_irq_byname_optional(msc->pdev, "error");
+	if (irq <= 0)
+		return 0;
+
+	/* Allocate and initialise the percpu device pointer for PPI */
+	if (irq_is_percpu(irq))
+		return __setup_ppi(msc);
+
+	/* sanity check: shared interrupts can be routed anywhere? */
+	if (!cpumask_equal(&msc->accessibility, cpu_possible_mask)) {
+		pr_err_once("msc:%u is a private resource with a shared error interrupt",
+			    msc->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int mpam_dt_count_msc(void)
 {
 	int count = 0;
@@ -1265,6 +1354,10 @@ static int mpam_msc_drv_probe(struct platform_device *pdev)
 			break;
 		}
 
+		err = mpam_msc_setup_error_irq(msc);
+		if (err)
+			break;
+
 		if (device_property_read_u32(&pdev->dev, "pcc-channel",
 					     &msc->pcc_subspace_id))
 			msc->iface = MPAM_IFACE_MMIO;
@@ -1547,11 +1640,171 @@ static void mpam_enable_merge_features(struct list_head *all_classes_list)
 	}
 }
 
+static char *mpam_errcode_names[16] = {
+	[0] = "No error",
+	[1] = "PARTID_SEL_Range",
+	[2] = "Req_PARTID_Range",
+	[3] = "MSMONCFG_ID_RANGE",
+	[4] = "Req_PMG_Range",
+	[5] = "Monitor_Range",
+	[6] = "intPARTID_Range",
+	[7] = "Unexpected_INTERNAL",
+	[8] = "Undefined_RIS_PART_SEL",
+	[9] = "RIS_No_Control",
+	[10] = "Undefined_RIS_MON_SEL",
+	[11] = "RIS_No_Monitor",
+	[12 ... 15] = "Reserved"
+};
+
+static int mpam_enable_msc_ecr(void *_msc)
+{
+	struct mpam_msc *msc = _msc;
+
+	__mpam_write_reg(msc, MPAMF_ECR, MPAMF_ECR_INTEN);
+
+	return 0;
+}
+
+static int mpam_disable_msc_ecr(void *_msc)
+{
+	struct mpam_msc *msc = _msc;
+
+	__mpam_write_reg(msc, MPAMF_ECR, 0);
+
+	return 0;
+}
+
+static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
+{
+	u64 reg;
+	u16 partid;
+	u8 errcode, pmg, ris;
+
+	if (WARN_ON_ONCE(!msc) ||
+	    WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
+					   &msc->accessibility)))
+		return IRQ_NONE;
+
+	reg = mpam_msc_read_esr(msc);
+
+	errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
+	if (!errcode)
+		return IRQ_NONE;
+
+	/* Clear level triggered irq */
+	mpam_msc_zero_esr(msc);
+
+	partid = FIELD_GET(MPAMF_ESR_PARTID_MON, reg);
+	pmg = FIELD_GET(MPAMF_ESR_PMG, reg);
+	ris = FIELD_GET(MPAMF_ESR_RIS, reg);
+
+	pr_err("error irq from msc:%u '%s', partid:%u, pmg: %u, ris: %u\n",
+	       msc->id, mpam_errcode_names[errcode], partid, pmg, ris);
+
+	if (irq_is_percpu(irq)) {
+		mpam_disable_msc_ecr(msc);
+		schedule_work(&mpam_broken_work);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t mpam_ppi_handler(int irq, void *dev_id)
+{
+	struct mpam_msc *msc = *(struct mpam_msc **)dev_id;
+
+	return __mpam_irq_handler(irq, msc);
+}
+
+static irqreturn_t mpam_spi_handler(int irq, void *dev_id)
+{
+	struct mpam_msc *msc = dev_id;
+
+	return __mpam_irq_handler(irq, msc);
+}
+
+static irqreturn_t mpam_disable_thread(int irq, void *dev_id);
+
+static int mpam_register_irqs(void)
+{
+	int err, irq;
+	struct mpam_msc *msc;
+
+	lockdep_assert_cpus_held();
+
+	guard(srcu)(&mpam_srcu);
+	list_for_each_entry_srcu(msc, &mpam_all_msc, glbl_list, srcu_read_lock_held(&mpam_srcu)) {
+		irq = platform_get_irq_byname_optional(msc->pdev, "error");
+		if (irq <= 0)
+			continue;
+
+		/* The MPAM spec says the interrupt can be SPI, PPI or LPI */
+		/* We anticipate sharing the interrupt with other MSCs */
+		if (irq_is_percpu(irq)) {
+			err = request_percpu_irq(irq, &mpam_ppi_handler,
+						 "mpam:msc:error",
+						 msc->error_dev_id);
+			if (err)
+				return err;
+
+			msc->reenable_error_ppi = irq;
+			smp_call_function_many(&msc->accessibility,
+					       &_enable_percpu_irq, &irq,
+					       true);
+		} else {
+			err = devm_request_threaded_irq(&msc->pdev->dev, irq,
+							&mpam_spi_handler,
+							&mpam_disable_thread,
+							IRQF_SHARED,
+							"mpam:msc:error", msc);
+			if (err)
+				return err;
+		}
+
+		msc->error_irq_requested = true;
+		mpam_touch_msc(msc, mpam_enable_msc_ecr, msc);
+		msc->error_irq_hw_enabled = true;
+	}
+
+	return 0;
+}
+
+static void mpam_unregister_irqs(void)
+{
+	int irq, idx;
+	struct mpam_msc *msc;
+
+	cpus_read_lock();
+	/* take the lock as free_irq() can sleep */
+	idx = srcu_read_lock(&mpam_srcu);
+	list_for_each_entry_srcu(msc, &mpam_all_msc, glbl_list, srcu_read_lock_held(&mpam_srcu)) {
+		irq = platform_get_irq_byname_optional(msc->pdev, "error");
+		if (irq <= 0)
+			continue;
+
+		if (msc->error_irq_hw_enabled) {
+			mpam_touch_msc(msc, mpam_disable_msc_ecr, msc);
+			msc->error_irq_hw_enabled = false;
+		}
+
+		if (msc->error_irq_requested) {
+			if (irq_is_percpu(irq)) {
+				msc->reenable_error_ppi = 0;
+				free_percpu_irq(irq, msc->error_dev_id);
+			} else {
+				devm_free_irq(&msc->pdev->dev, irq, msc);
+			}
+			msc->error_irq_requested = false;
+		}
+	}
+	srcu_read_unlock(&mpam_srcu, idx);
+	cpus_read_unlock();
+}
+
 static void mpam_enable_once(void)
 {
-	mutex_lock(&mpam_list_lock);
-	mpam_enable_merge_features(&mpam_classes);
-	mutex_unlock(&mpam_list_lock);
+	int err;
 
 	/*
 	 * Once the cpuhp callbacks have been changed, mpam_partid_max can no
@@ -1561,6 +1814,27 @@ static void mpam_enable_once(void)
 	partid_max_published = true;
 	spin_unlock(&partid_max_lock);
 
+	/*
+	 * If all the MSC have been probed, enabling the IRQs happens next.
+	 * That involves cross-calling to a CPU that can reach the MSC, and
+	 * the locks must be taken in this order:
+	 */
+	cpus_read_lock();
+	mutex_lock(&mpam_list_lock);
+	mpam_enable_merge_features(&mpam_classes);
+
+	err = mpam_register_irqs();
+	if (err)
+		pr_warn("Failed to register irqs: %d\n", err);
+
+	mutex_unlock(&mpam_list_lock);
+	cpus_read_unlock();
+
+	if (err) {
+		schedule_work(&mpam_broken_work);
+		return;
+	}
+
 	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline);
 
 	printk(KERN_INFO "MPAM enabled with %u partid and %u pmg\n",
@@ -1615,16 +1889,39 @@ static void mpam_reset_class(struct mpam_class *class)
  * All of MPAMs errors indicate a software bug, restore any modified
  * controls to their reset values.
  */
-void mpam_disable(void)
+static irqreturn_t mpam_disable_thread(int irq, void *dev_id)
 {
 	int idx;
 	struct mpam_class *class;
+	struct mpam_msc *msc, *tmp;
+
+	mutex_lock(&mpam_cpuhp_state_lock);
+	if (mpam_cpuhp_state) {
+		cpuhp_remove_state(mpam_cpuhp_state);
+		mpam_cpuhp_state = 0;
+	}
+	mutex_unlock(&mpam_cpuhp_state_lock);
+
+	mpam_unregister_irqs();
 
 	idx = srcu_read_lock(&mpam_srcu);
 	list_for_each_entry_srcu(class, &mpam_classes, classes_list,
 				 srcu_read_lock_held(&mpam_srcu))
 		mpam_reset_class(class);
 	srcu_read_unlock(&mpam_srcu, idx);
+
+	mutex_lock(&mpam_list_lock);
+	list_for_each_entry_safe(msc, tmp, &mpam_all_msc, glbl_list)
+		mpam_msc_destroy(msc);
+	mutex_unlock(&mpam_list_lock);
+	mpam_free_garbage();
+
+	return IRQ_HANDLED;
+}
+
+void mpam_disable(struct work_struct *ignored)
+{
+	mpam_disable_thread(0, NULL);
 }
 
 /*
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index b30fee2b7674..c9418c9cf9f2 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -44,6 +44,11 @@ struct mpam_msc {
 	struct pcc_mbox_chan	*pcc_chan;
 	u32			nrdy_usec;
 	cpumask_t		accessibility;
+	bool			has_extd_esr;
+
+	int				reenable_error_ppi;
+	struct mpam_msc * __percpu	*error_dev_id;
+
 	atomic_t		online_refs;
 
 	/*
@@ -52,6 +57,8 @@ struct mpam_msc {
 	 */
 	struct mutex		probe_lock;
 	bool			probed;
+	bool			error_irq_requested;
+	bool			error_irq_hw_enabled;
 	u16			partid_max;
 	u8			pmg_max;
 	unsigned long		ris_idxs[128 / BITS_PER_LONG];
@@ -281,7 +288,7 @@ extern u8 mpam_pmg_max;
 
 /* Scheduled work callback to enable mpam once all MSC have been probed */
 void mpam_enable(struct work_struct *work);
-void mpam_disable(void);
+void mpam_disable(struct work_struct *work);
 
 int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
 				   cpumask_t *affinity);
-- 
2.20.1


