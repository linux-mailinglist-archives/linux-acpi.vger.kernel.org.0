Return-Path: <linux-acpi+bounces-18644-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF059C3FEE8
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 13:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB2394EEEB9
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 12:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77E7328B7C;
	Fri,  7 Nov 2025 12:37:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6A0303CAC;
	Fri,  7 Nov 2025 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762519030; cv=none; b=RXhcL5VPnLXXrYm5yD+DrFmuAwK0wtZL0zH+5mpcoMmPU/O6ZPD/VosRMCn3WNJgRIMF/Q/GBgc0ZaRRZHC6SdnrBInDoVm+Jno7tzlopjzpjsdNVH4LlvN2pERySaTpk5OxkBHcaKifPmPRIrq8M3aMfO58A3B8T1JVZ9PPa0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762519030; c=relaxed/simple;
	bh=gczW6MIzhUo8eQGsf50TB+qQjyHhIT3/rUTQtBs+Nzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBiBmavd5HzulwiyScToIkiHewcRGMwzwop0taZRHe/GDG/cJytCIZyJ0tiXAlIeOAtdNPuUZbyXkzHBmUzOJ4Pw/ierHmiEEwY2pq+VvVFMEpyaWn1KbtJnKz7oMxOKSN2omwGF+88+NCVtWHtxdAUiyxk5ePo5DR1uRc7eVhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF1811515;
	Fri,  7 Nov 2025 04:36:59 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9A4463F66E;
	Fri,  7 Nov 2025 04:37:02 -0800 (PST)
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
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH 19/33] arm_mpam: Add a helper to touch an MSC from any CPU
Date: Fri,  7 Nov 2025 12:34:36 +0000
Message-ID: <20251107123450.664001-20-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107123450.664001-1-ben.horgan@arm.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
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
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
 drivers/resctrl/mpam_devices.c | 37 +++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 6a01247317b7..bcdf4fbc3941 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -807,20 +807,51 @@ static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
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
@@ -828,7 +859,7 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
 	struct mpam_msc_ris *ris;
 
 	list_for_each_entry_srcu(ris, &msc->ris, msc_list, srcu_read_lock_held(&mpam_srcu)) {
-		mpam_reset_ris(ris);
+		mpam_touch_msc(msc, &mpam_reset_ris, ris);
 
 		/*
 		 * Set in_reset_state when coming online. The reset state
-- 
2.43.0


