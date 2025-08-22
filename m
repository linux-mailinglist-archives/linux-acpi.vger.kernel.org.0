Return-Path: <linux-acpi+bounces-15963-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C269B31F73
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 17:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5363CAC561C
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26695285CA1;
	Fri, 22 Aug 2025 15:36:13 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963F2273D6B;
	Fri, 22 Aug 2025 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876973; cv=none; b=jrcS+RHsi7USVVGrPVqTuejymiOCCQa0DNrqaDVxX9cqZg6ke3eQjzI2TbwXLtA8a/s2xU5B8iW38jCJ8d6CiytORUIF787aLDrMcARzzySxwef3Rwy6/9KjkhV7HuMlO+2+AzbMmougC7GzHk17+aWbrHKLGFzUUQilykYSMuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876973; c=relaxed/simple;
	bh=482lR6qZEXMuwO0xSwqkMMzje9b+l5mSPWDxSUXfvvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bl7TN1y/ioQ6pgJdpkxDkro/Q70+pKxNsRTCjpZfeI5vpHXukFnvm80CUbiGLjVjLC3jNpmmNPdN81xktfLSZclqUQWYvcz9ZWfNooT/z0GkvqiqS4bE9ZyCOESrljtv8bJvlJKfgf3PLPyOagLiHS+OjUJuLCC6fUymLc0KSPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCCD115A1;
	Fri, 22 Aug 2025 08:36:02 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF8E33F63F;
	Fri, 22 Aug 2025 08:36:05 -0700 (PDT)
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
Subject: [PATCH 20/33] arm_mpam: Add a helper to touch an MSC from any CPU
Date: Fri, 22 Aug 2025 15:30:35 +0000
Message-Id: <20250822153048.2287-55-james.morse@arm.com>
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

Resetting RIS entries from the cpuhp callback is easy as the
callback occurs on the correct CPU. This won't be true for any other
caller that wants to reset or configure an MSC.

Add a helper that schedules the provided function if necessary.
Prevent the cpuhp callbacks from changing the MSC state by taking the
cpuhp lock.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/resctrl/mpam_devices.c | 37 +++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index c1f01dd748ad..759244966736 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -906,20 +906,51 @@ static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
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
 
 	mpam_assert_srcu_read_lock_held();
 
 	if (ris->in_reset_state)
-		return;
+		return 0;
 
 	spin_lock(&partid_max_lock);
 	partid_max = mpam_partid_max;
 	spin_unlock(&partid_max_lock);
 	for (partid = 0; partid < partid_max; partid++)
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
+	mpam_assert_srcu_read_lock_held();
+
+	return smp_call_on_cpu(mpam_get_msc_preferred_cpu(msc), fn, arg, true);
 }
 
 static void mpam_reset_msc(struct mpam_msc *msc, bool online)
@@ -932,7 +963,7 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
 	mpam_mon_sel_outer_lock(msc);
 	idx = srcu_read_lock(&mpam_srcu);
 	list_for_each_entry_srcu(ris, &msc->ris, msc_list, srcu_read_lock_held(&mpam_srcu)) {
-		mpam_reset_ris(ris);
+		mpam_touch_msc(msc, &mpam_reset_ris, ris);
 
 		/*
 		 * Set in_reset_state when coming online. The reset state
-- 
2.20.1


