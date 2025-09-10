Return-Path: <linux-acpi+bounces-16632-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC35B522BA
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 22:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D4BA07A91
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 20:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C6930F524;
	Wed, 10 Sep 2025 20:44:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A789C30F552;
	Wed, 10 Sep 2025 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537072; cv=none; b=O36NFY2WSubSOkJJTjxMKeX7kMbQZj9KHDpviNKFHzA7emlJpJ6A2oCzu2PG3W4RElKnceizgr8pgt+8JfnGoqST2u5q+piQgxcneVSlapqD+usd79CKe2Q+DyJLr0Lws4t2CQKTBIdrIj7kwsLwTIp/vgZvdUQc3TLlE+5z0Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537072; c=relaxed/simple;
	bh=WOR048v1sYnJX4tzPXnoQkCKMQ7y6xK61e6TsW9XslA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UU4MYm8C5e1ZRc9VhI8XKtPrz6ym74UC9v3cZMW31R7GBDjL/NmJ/uu0nRgPQ//J6Wxka+lemlI0eoZsjVnLDRDV+n1XJjZrZc1U4hiXR7H6tGQ9ePDzsdRqG8VEY5EJLTUmte2O2oxtaXBymoY3Vt3hwYOf3p8LqiuVHRMnTH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1D991C0A;
	Wed, 10 Sep 2025 13:44:21 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BB463F63F;
	Wed, 10 Sep 2025 13:44:25 -0700 (PDT)
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
Subject: [PATCH v2 12/29] arm_mpam: Add helpers for managing the locking around the mon_sel registers
Date: Wed, 10 Sep 2025 20:42:52 +0000
Message-Id: <20250910204309.20751-13-james.morse@arm.com>
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

The MSC MON_SEL register needs to be accessed from hardirq for the overflow
interrupt, and when taking an IPI to access these registers on platforms
where MSC are not accesible from every CPU. This makes an irqsave
spinlock the obvious lock to protect these registers. On systems with SCMI
mailboxes it must be able to sleep, meaning a mutex must be used. The
SCMI platforms can't support an overflow interrupt.

Clearly these two can't exist for one MSC at the same time.

Add helpers for the MON_SEL locking. The outer lock must be taken in a
pre-emptible context before the inner lock can be taken. On systems with
SCMI mailboxes where the MON_SEL accesses must sleep - the inner lock
will fail to be 'taken' if the caller is unable to sleep. This will allow
callers to fail without having to explicitly check the interface type of
each MSC.

Signed-off-by: James Morse <james.morse@arm.com>
---
Change since v1:
 * Made accesses to outer_lock_held READ_ONCE() for torn values in the failure
   case.
---
 drivers/resctrl/mpam_devices.c  |  3 +--
 drivers/resctrl/mpam_internal.h | 37 +++++++++++++++++++++++++++++----
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 24dc81c15ec8..a26b012452e2 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -748,8 +748,7 @@ static int mpam_msc_drv_probe(struct platform_device *pdev)
 
 		mutex_init(&msc->probe_lock);
 		mutex_init(&msc->part_sel_lock);
-		mutex_init(&msc->outer_mon_sel_lock);
-		raw_spin_lock_init(&msc->inner_mon_sel_lock);
+		mpam_mon_sel_lock_init(msc);
 		msc->id = pdev->id;
 		msc->pdev = pdev;
 		INIT_LIST_HEAD_RCU(&msc->all_msc_list);
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 828ce93c95d5..4cc44d4e21c4 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -70,12 +70,17 @@ struct mpam_msc {
 
 	/*
 	 * mon_sel_lock protects access to the MSC hardware registers that are
-	 * affected by MPAMCFG_MON_SEL.
+	 * affected by MPAMCFG_MON_SEL, and the mbwu_state.
+	 * Access to mon_sel is needed from both process and interrupt contexts,
+	 * but is complicated by firmware-backed platforms that can't make any
+	 * access unless they can sleep.
+	 * Always use the mpam_mon_sel_lock() helpers.
+	 * Accessed to mon_sel need to be able to fail if they occur in the wrong
+	 * context.
 	 * If needed, take msc->probe_lock first.
 	 */
-	struct mutex		outer_mon_sel_lock;
-	raw_spinlock_t		inner_mon_sel_lock;
-	unsigned long		inner_mon_sel_flags;
+	raw_spinlock_t		_mon_sel_lock;
+	unsigned long		_mon_sel_flags;
 
 	void __iomem		*mapped_hwpage;
 	size_t			mapped_hwpage_sz;
@@ -83,6 +88,30 @@ struct mpam_msc {
 	struct mpam_garbage	garbage;
 };
 
+/* Returning false here means accesses to mon_sel must fail and report an error. */
+static inline bool __must_check mpam_mon_sel_lock(struct mpam_msc *msc)
+{
+	WARN_ON_ONCE(msc->iface != MPAM_IFACE_MMIO);
+
+	raw_spin_lock_irqsave(&msc->_mon_sel_lock, msc->_mon_sel_flags);
+	return true;
+}
+
+static inline void mpam_mon_sel_unlock(struct mpam_msc *msc)
+{
+	raw_spin_unlock_irqrestore(&msc->_mon_sel_lock, msc->_mon_sel_flags);
+}
+
+static inline void mpam_mon_sel_lock_held(struct mpam_msc *msc)
+{
+	lockdep_assert_held_once(&msc->_mon_sel_lock);
+}
+
+static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
+{
+	raw_spin_lock_init(&msc->_mon_sel_lock);
+}
+
 struct mpam_class {
 	/* mpam_components in this class */
 	struct list_head	components;
-- 
2.39.5


