Return-Path: <linux-acpi+bounces-15959-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2753B31F3F
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 17:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E8BB61CCE
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 15:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBA2285078;
	Fri, 22 Aug 2025 15:35:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAC12472BF;
	Fri, 22 Aug 2025 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876951; cv=none; b=HTO5PZetN2GB2T1+zdjpAakId3avE4Mhb5tUhxd4R/Hlc/d34fIci7cihzx4iJwssfzBFh30aKcE9011j1y2lI3MuPwCmXahbg6HP8bWzRLta7Hujk9FG2vaGXk1JUVWFsbWgxrj+Mok7/7mi3ypd+0nhE1wH1KB4B2JovA1xw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876951; c=relaxed/simple;
	bh=0Ze5L8S2Rtxz2WZnVOh9RQPMiP0i+scwI2LdJBUwSaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wj0f+xbIT5vx0smKnCHnj75Lky7Iy2OvSOQOauOrtTX2FRAoi9+u5Q8DVwQ4zW/1Cd+qWvgE7Q9rLs0YCQRax/kjR5QgFINNnKktgFBq535hddJOM3eCa3D8fEFVx69H/gYs9nKkDK0R53l52sirWZz78x5S3pK22aCPcElyRQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 440B515A1;
	Fri, 22 Aug 2025 08:35:40 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3759E3F63F;
	Fri, 22 Aug 2025 08:35:43 -0700 (PDT)
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
Subject: [PATCH 16/33] arm_mpam: Add helpers for managing the locking around the mon_sel registers
Date: Fri, 22 Aug 2025 15:30:31 +0000
Message-Id: <20250822153048.2287-51-james.morse@arm.com>
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

The MSC MON_SEL register needs to be accessed from hardirq context by the
PMU drivers, making an irqsave spinlock the obvious lock to protect these
registers. On systems with SCMI mailboxes it must be able to sleep, meaning
a mutex must be used.

Clearly these two can't exist at the same time.

Add helpers for the MON_SEL locking. The outer lock must be taken in a
pre-emptible context before the inner lock can be taken. On systems with
SCMI mailboxes where the MON_SEL accesses must sleep - the inner lock
will fail to be 'taken' if the caller is unable to sleep. This will allow
the PMU driver to fail without having to check the interface type of
each MSC.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/resctrl/mpam_internal.h | 57 ++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index a623f405ddd8..c6f087f9fa7d 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -68,10 +68,19 @@ struct mpam_msc {
 
 	/*
 	 * mon_sel_lock protects access to the MSC hardware registers that are
-	 * affeted by MPAMCFG_MON_SEL.
+	 * affected by MPAMCFG_MON_SEL, and the mbwu_state.
+	 * Both the 'inner' and 'outer' must be taken.
+	 * For real MMIO MSC, the outer lock is unnecessary - but keeps the
+	 * code common with:
+	 * Firmware backed MSC need to sleep when accessing the MSC, which
+	 * means some code-paths will always fail. For these MSC the outer
+	 * lock is providing the protection, and the inner lock fails to
+	 * be taken if the task is unable to sleep.
+	 *
 	 * If needed, take msc->probe_lock first.
 	 */
 	struct mutex		outer_mon_sel_lock;
+	bool			outer_lock_held;
 	raw_spinlock_t		inner_mon_sel_lock;
 	unsigned long		inner_mon_sel_flags;
 
@@ -81,6 +90,52 @@ struct mpam_msc {
 	struct mpam_garbage	garbage;
 };
 
+static inline bool __must_check mpam_mon_sel_inner_lock(struct mpam_msc *msc)
+{
+	/*
+	 * The outer lock may be taken by a CPU that then issues an IPI to run
+	 * a helper that takes the inner lock. lockdep can't help us here.
+	 */
+	WARN_ON_ONCE(!msc->outer_lock_held);
+
+	if (msc->iface == MPAM_IFACE_MMIO) {
+		raw_spin_lock_irqsave(&msc->inner_mon_sel_lock, msc->inner_mon_sel_flags);
+		return true;
+	}
+
+	/* Accesses must fail if we are not pre-emptible */
+	return !!preemptible();
+}
+
+static inline void mpam_mon_sel_inner_unlock(struct mpam_msc *msc)
+{
+	WARN_ON_ONCE(!msc->outer_lock_held);
+
+	if (msc->iface == MPAM_IFACE_MMIO)
+		raw_spin_unlock_irqrestore(&msc->inner_mon_sel_lock, msc->inner_mon_sel_flags);
+}
+
+static inline void mpam_mon_sel_outer_lock(struct mpam_msc *msc)
+{
+	mutex_lock(&msc->outer_mon_sel_lock);
+	msc->outer_lock_held = true;
+}
+
+static inline void mpam_mon_sel_outer_unlock(struct mpam_msc *msc)
+{
+	msc->outer_lock_held = false;
+	mutex_unlock(&msc->outer_mon_sel_lock);
+}
+
+static inline void mpam_mon_sel_lock_held(struct mpam_msc *msc)
+{
+	WARN_ON_ONCE(!msc->outer_lock_held);
+	if (msc->iface == MPAM_IFACE_MMIO)
+		lockdep_assert_held_once(&msc->inner_mon_sel_lock);
+	else
+		lockdep_assert_preemption_enabled();
+}
+
 struct mpam_class {
 	/* mpam_components in this class */
 	struct list_head	components;
-- 
2.20.1


