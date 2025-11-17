Return-Path: <linux-acpi+bounces-18951-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BBCC65563
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 18:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id C4CD629A74
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 17:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726B6334692;
	Mon, 17 Nov 2025 17:02:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4834833439B;
	Mon, 17 Nov 2025 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398940; cv=none; b=iqxjkaCqqnCoCMjveWItxNizlM955D34UukZtiJemu74XMaS5g4hJZe4tt08G1WHi65VtseUVeAVz2uRtl3Gh6ZqKeY+iDg+EQZQphR3T+zXO/mcMxQd9Ar617NxQ6sTCmZPbEQGyJH7bORZFFRjDizRp1C5FeI3VhKyS3LL/S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398940; c=relaxed/simple;
	bh=York43yo1Ip/bFZc4WTYbPzCqMrVO0xXNIWz4RnpBdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtfCkJCCsLZotmSNWMAlvLYn0sKKMM7IBXAuAYID2luLaDN+iHDGpNz/cHbEvEdoCNloJADUYndx+SUNzRPsCQ0AzTAi9eFuXj2barCiTNLgjLRS6DMUsQqgi7PLr4Dn1uUfFTerdB/PqpjAoLqPmD07e8nk1fKwHKKSpKvahL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02BDD168F;
	Mon, 17 Nov 2025 09:02:10 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 66A1F3F66E;
	Mon, 17 Nov 2025 09:02:12 -0800 (PST)
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
Subject: [PATCH v5 20/34] arm_mpam: Extend reset logic to allow devices to be reset any time
Date: Mon, 17 Nov 2025 16:59:59 +0000
Message-ID: <20251117170014.4113754-21-ben.horgan@arm.com>
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
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com>
Tested-by: Gavin Shan <gshan@redhat.com>
Tested-by: Zeng Heng <zengheng4@huawei.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
 drivers/resctrl/mpam_devices.c | 57 ++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 8e7a74482fcd..ff33f6485952 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -808,15 +808,13 @@ static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
 
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
 
@@ -1337,8 +1335,55 @@ static void mpam_enable_once(void)
 	       mpam_partid_max + 1, mpam_pmg_max + 1);
 }
 
+static void mpam_reset_component_locked(struct mpam_component *comp)
+{
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
@@ -1348,6 +1393,12 @@ void mpam_disable(struct work_struct *ignored)
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
2.43.0


