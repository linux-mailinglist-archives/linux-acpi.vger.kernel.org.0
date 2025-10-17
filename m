Return-Path: <linux-acpi+bounces-17914-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E2CBEB55F
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 21:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1211895DD3
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 19:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96E936CE06;
	Fri, 17 Oct 2025 18:58:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2524436CE03;
	Fri, 17 Oct 2025 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727518; cv=none; b=uov1eww+e+S91bFsojYjxKH565Xv6n4hadn8stbGqmLTowIH7/kTSSfzu1b6fMgm3KS0+teCaMV7h9V/EMyY24LZYD0CJ+vc2RxJoae7ISES0awOIfxtxaC+5HeOXgqnm0vW5p38irHANTeT32OeAGEWvYkGqXuW1ez57DNblfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727518; c=relaxed/simple;
	bh=ZDnkddHVA67wGKnfxu2HrHojd6o4rL3MbPoUleD7ePY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xmi60hvUnWsvAuyJQkYgnMzL8SvSHUxQIagD1PQOfAMVW6fBJcHi/4/TM9QHdG5GjN7yvlkp0Mr0/VbLfwoyD4ERfRiPHe9U20lh0l/m8jSiia9qkZq9DIlyOik5jW/WvNgMswRUCLh+rTXZ1CTbeiOJS1c/7XPqXaYClPFGWdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC03C1595;
	Fri, 17 Oct 2025 11:58:28 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C9593F66E;
	Fri, 17 Oct 2025 11:58:31 -0700 (PDT)
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
	Gavin Shan <gshan@redhat.com>,
	Ben Horgan <ben.horgan@arm.com>
Subject: [PATCH v3 17/29] arm_mpam: Extend reset logic to allow devices to be reset any time
Date: Fri, 17 Oct 2025 18:56:33 +0000
Message-Id: <20251017185645.26604-18-james.morse@arm.com>
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

cpuhp callbacks aren't the only time the MSC configuration may need to
be reset. Resctrl has an API call to reset a class.
If an MPAM error interrupt arrives it indicates the driver has
misprogrammed an MSC. The safest thing to do is reset all the MSCs
and disable MPAM.

Add a helper to reset RIS via their class. Call this from mpam_disable(),
which can be scheduled from the error interrupt handler.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
---
Changes since v2:
 * Reduced the scop of arguments in mpam_reset_component_locked().

Changes since v1:
 * more complete use of _srcu helpers.
 * Use guard macro for srcu.
 * Dropped a might_sleep() - something else will bark.
---
 drivers/resctrl/mpam_devices.c | 58 ++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index ec089593acad..545482e112b7 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -802,15 +802,13 @@ static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
 
 /*
  * Called via smp_call_on_cpu() to prevent migration, while still being
- * pre-emptible.
+ * pre-emptible. Caller must hold mpam_srcu.
  */
 static int mpam_reset_ris(void *arg)
 {
 	u16 partid, partid_max;
 	struct mpam_msc_ris *ris = arg;
 
-	WARN_ON_ONCE(!srcu_read_lock_held((&mpam_srcu)));
-
 	if (ris->in_reset_state)
 		return 0;
 
@@ -1328,8 +1326,56 @@ static void mpam_enable_once(void)
 	       mpam_partid_max + 1, mpam_pmg_max + 1);
 }
 
+static void mpam_reset_component_locked(struct mpam_component *comp)
+{
+
+	struct mpam_vmsc *vmsc;
+
+	lockdep_assert_cpus_held();
+
+	guard(srcu)(&mpam_srcu);
+	list_for_each_entry_srcu(vmsc, &comp->vmsc, comp_list,
+				 srcu_read_lock_held(&mpam_srcu)) {
+		struct mpam_msc *msc = vmsc->msc;
+		struct mpam_msc_ris *ris;
+
+		list_for_each_entry_srcu(ris, &vmsc->ris, vmsc_list,
+					 srcu_read_lock_held(&mpam_srcu)) {
+			if (!ris->in_reset_state)
+				mpam_touch_msc(msc, mpam_reset_ris, ris);
+			ris->in_reset_state = true;
+		}
+	}
+}
+
+static void mpam_reset_class_locked(struct mpam_class *class)
+{
+	struct mpam_component *comp;
+
+	lockdep_assert_cpus_held();
+
+	guard(srcu)(&mpam_srcu);
+	list_for_each_entry_srcu(comp, &class->components, class_list,
+				 srcu_read_lock_held(&mpam_srcu))
+		mpam_reset_component_locked(comp);
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
 void mpam_disable(struct work_struct *ignored)
 {
+	int idx;
+	struct mpam_class *class;
 	struct mpam_msc *msc, *tmp;
 
 	mutex_lock(&mpam_cpuhp_state_lock);
@@ -1339,6 +1385,12 @@ void mpam_disable(struct work_struct *ignored)
 	}
 	mutex_unlock(&mpam_cpuhp_state_lock);
 
+	idx = srcu_read_lock(&mpam_srcu);
+	list_for_each_entry_srcu(class, &mpam_classes, classes_list,
+				 srcu_read_lock_held(&mpam_srcu))
+		mpam_reset_class(class);
+	srcu_read_unlock(&mpam_srcu, idx);
+
 	mutex_lock(&mpam_list_lock);
 	list_for_each_entry_safe(msc, tmp, &mpam_all_msc, all_msc_list)
 		mpam_msc_destroy(msc);
-- 
2.39.5


