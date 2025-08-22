Return-Path: <linux-acpi+bounces-15964-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E243AB31F78
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 17:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1011BB608DC
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 15:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C512A34A31C;
	Fri, 22 Aug 2025 15:36:18 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3186F286890;
	Fri, 22 Aug 2025 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876978; cv=none; b=dLaYinxSsdCVTFVsOTKQSGnht5ezCRm7jzCaBpAJYrdpAD4nunacpOAL6lVWXXihUWAqopI3WNWvY3F8duSyG6VXuplw1eKiT1VSzTkzJPWL4mNt3ZlIhbO01HYnqmX4aJba8IEdup4N2zdLUUglY6WM9VLKB/3R+sDnupIkCdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876978; c=relaxed/simple;
	bh=TWVip1TkrPKgYZgIpSL+XlhROAFKrr+IQzPOiLtT210=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=owJWz//XAK+yS7cE783ZVCXNMis8vGb5OioQwa6FubTDj/koOho/d7v8SeKr5pyIcsoq3tRz15eM0Vh2sDjeP8XATosL3pYAenSqNrVdCAM+m978CGLKN9J9bYENE5NzXH+iOpJfqpO68+4O3IuORqVlZg31i2URXLNTSB47at0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85B6C15A1;
	Fri, 22 Aug 2025 08:36:08 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E7C33F63F;
	Fri, 22 Aug 2025 08:36:11 -0700 (PDT)
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
Subject: [PATCH 21/33] arm_mpam: Extend reset logic to allow devices to be reset any time
Date: Fri, 22 Aug 2025 15:30:36 +0000
Message-Id: <20250822153048.2287-56-james.morse@arm.com>
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

cpuhp callbacks aren't the only time the MSC configuration may need to
be reset. Resctrl has an API call to reset a class.
If an MPAM error interrupt arrives it indicates the driver has
misprogrammed an MSC. The safest thing to do is reset all the MSCs
and disable MPAM.

Add a helper to reset RIS via their class. Call this from mpam_disable(),
which can be scheduled from the error interrupt handler.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/resctrl/mpam_devices.c  | 62 +++++++++++++++++++++++++++++++--
 drivers/resctrl/mpam_internal.h |  1 +
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 759244966736..3516cbe8623e 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -915,8 +915,6 @@ static int mpam_reset_ris(void *arg)
 	u16 partid, partid_max;
 	struct mpam_msc_ris *ris = arg;
 
-	mpam_assert_srcu_read_lock_held();
-
 	if (ris->in_reset_state)
 		return 0;
 
@@ -1569,6 +1567,66 @@ static void mpam_enable_once(void)
 	       mpam_partid_max + 1, mpam_pmg_max + 1);
 }
 
+static void mpam_reset_component_locked(struct mpam_component *comp)
+{
+	int idx;
+	struct mpam_msc *msc;
+	struct mpam_vmsc *vmsc;
+	struct mpam_msc_ris *ris;
+
+	might_sleep();
+	lockdep_assert_cpus_held();
+
+	idx = srcu_read_lock(&mpam_srcu);
+	list_for_each_entry_rcu(vmsc, &comp->vmsc, comp_list) {
+		msc = vmsc->msc;
+
+		list_for_each_entry_rcu(ris, &vmsc->ris, vmsc_list) {
+			if (!ris->in_reset_state)
+				mpam_touch_msc(msc, mpam_reset_ris, ris);
+			ris->in_reset_state = true;
+		}
+	}
+	srcu_read_unlock(&mpam_srcu, idx);
+}
+
+static void mpam_reset_class_locked(struct mpam_class *class)
+{
+	int idx;
+	struct mpam_component *comp;
+
+	lockdep_assert_cpus_held();
+
+	idx = srcu_read_lock(&mpam_srcu);
+	list_for_each_entry_rcu(comp, &class->components, class_list)
+		mpam_reset_component_locked(comp);
+	srcu_read_unlock(&mpam_srcu, idx);
+}
+
+static void mpam_reset_class(struct mpam_class *class)
+{
+	cpus_read_lock();
+	mpam_reset_class_locked(class);
+	cpus_read_unlock();
+}
+
+/*
+ * Called in response to an error IRQ.
+ * All of MPAMs errors indicate a software bug, restore any modified
+ * controls to their reset values.
+ */
+void mpam_disable(void)
+{
+	int idx;
+	struct mpam_class *class;
+
+	idx = srcu_read_lock(&mpam_srcu);
+	list_for_each_entry_srcu(class, &mpam_classes, classes_list,
+				 srcu_read_lock_held(&mpam_srcu))
+		mpam_reset_class(class);
+	srcu_read_unlock(&mpam_srcu, idx);
+}
+
 /*
  * Enable mpam once all devices have been probed.
  * Scheduled by mpam_discovery_cpu_online() once all devices have been created.
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 466d670a01eb..b30fee2b7674 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -281,6 +281,7 @@ extern u8 mpam_pmg_max;
 
 /* Scheduled work callback to enable mpam once all MSC have been probed */
 void mpam_enable(struct work_struct *work);
+void mpam_disable(void);
 
 int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
 				   cpumask_t *affinity);
-- 
2.20.1


