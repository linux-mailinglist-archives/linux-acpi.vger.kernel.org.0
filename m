Return-Path: <linux-acpi+bounces-18950-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8C6C65560
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 18:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id ECDE328F7D
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 17:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9337F2FD1AE;
	Mon, 17 Nov 2025 17:02:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E343321C2;
	Mon, 17 Nov 2025 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398934; cv=none; b=cFtYZud5nD3a9jzR67ov0rVjJazmED+2vNstZJWQo2w7Gw9BQdRoNsLxago897exARKK6OkRLjnFKGZRoC/zX+w2wyNGFeZ2gDD5YXBrzMiu46cfNaM5gQ2w04LV/AJnPO9qPgYH//ynLoMzqgVxNMG1RuecBjs6LBghh4OUxzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398934; c=relaxed/simple;
	bh=p6PuY94xvUXP8xIRWjQJO4ZazIJ94AmQkH9ewhLMuxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqMIVQxHIfplRY916CMuifIXuJVCOnyhfqA5Nhgb4t8gZr6NdosLKzzJhxeultYJzi5SPRVZ1FTCIJTmzhL2fpSOx4fyu2FazXiQvGU5XXhj/J+nGLTByHU16bG6yNk90GjzBj30nQX6T6GoZqe5YiicNUWQQsg7naylvkB+h/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82042FEC;
	Mon, 17 Nov 2025 09:02:04 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AD4393F66E;
	Mon, 17 Nov 2025 09:02:06 -0800 (PST)
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
Subject: [PATCH v5 19/34] arm_mpam: Add a helper to touch an MSC from any CPU
Date: Mon, 17 Nov 2025 16:59:58 +0000
Message-ID: <20251117170014.4113754-20-ben.horgan@arm.com>
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

Resetting RIS entries from the cpuhp callback is easy as the
callback occurs on the correct CPU. This won't be true for any other
caller that wants to reset or configure an MSC.

Add a helper that schedules the provided function if necessary.

Callers should take the cpuhp lock to prevent the cpuhp callbacks from
changing the MSC state.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
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
 drivers/resctrl/mpam_devices.c | 37 +++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index fe6b931be139..8e7a74482fcd 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -806,20 +806,51 @@ static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
 	mutex_unlock(&msc->part_sel_lock);
 }
 
-static void mpam_reset_ris(struct mpam_msc_ris *ris)
+/*
+ * Called via smp_call_on_cpu() to prevent migration, while still being
+ * pre-emptible.
+ */
+static int mpam_reset_ris(void *arg)
 {
 	u16 partid, partid_max;
+	struct mpam_msc_ris *ris = arg;
 
 	WARN_ON_ONCE(!srcu_read_lock_held((&mpam_srcu)));
 
 	if (ris->in_reset_state)
-		return;
+		return 0;
 
 	spin_lock(&partid_max_lock);
 	partid_max = mpam_partid_max;
 	spin_unlock(&partid_max_lock);
 	for (partid = 0; partid <= partid_max; partid++)
 		mpam_reset_ris_partid(ris, partid);
+
+	return 0;
+}
+
+/*
+ * Get the preferred CPU for this MSC. If it is accessible from this CPU,
+ * this CPU is preferred. This can be preempted/migrated, it will only result
+ * in more work.
+ */
+static int mpam_get_msc_preferred_cpu(struct mpam_msc *msc)
+{
+	int cpu = raw_smp_processor_id();
+
+	if (cpumask_test_cpu(cpu, &msc->accessibility))
+		return cpu;
+
+	return cpumask_first_and(&msc->accessibility, cpu_online_mask);
+}
+
+static int mpam_touch_msc(struct mpam_msc *msc, int (*fn)(void *a), void *arg)
+{
+	lockdep_assert_irqs_enabled();
+	lockdep_assert_cpus_held();
+	WARN_ON_ONCE(!srcu_read_lock_held((&mpam_srcu)));
+
+	return smp_call_on_cpu(mpam_get_msc_preferred_cpu(msc), fn, arg, true);
 }
 
 static void mpam_reset_msc(struct mpam_msc *msc, bool online)
@@ -827,7 +858,7 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
 	struct mpam_msc_ris *ris;
 
 	list_for_each_entry_srcu(ris, &msc->ris, msc_list, srcu_read_lock_held(&mpam_srcu)) {
-		mpam_reset_ris(ris);
+		mpam_touch_msc(msc, &mpam_reset_ris, ris);
 
 		/*
 		 * Set in_reset_state when coming online. The reset state
-- 
2.43.0


