Return-Path: <linux-acpi+bounces-17909-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A948CBEB580
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 21:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C5B1AE40FB
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 19:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A212133508C;
	Fri, 17 Oct 2025 18:58:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0463370F8;
	Fri, 17 Oct 2025 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727491; cv=none; b=tiizYbZp/LU7vKdWjI+uoThEttd+Yz47ZEBWFsjbRE61uwJcQnAMrRDU4xwLZzV/BbZ3h7PhHuhrc5JD+k1ATRVfJnfbEXg/x8+uEiJsw6VT7cYuOO3nYc00MraONuFLsDkQicWaKfbjQWoFDdpBl2z4nEq0iJcEK3HTW15CKpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727491; c=relaxed/simple;
	bh=G3SsLhxFI8p5Sv28fYljHJwRqTt/yt+C4b75QW23cJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U7mFxogv2tWbkgUSwNIHtjnKDw5fMyE04F+Zc+Oxs9pfui/25Cp5tPYbVXJsw/6eUY5EnzZPC6I6JJXPzbQyq4fa5Kew//2Xz6aHFdPjHyvqIoOy3Z02dk5XtUQvGi6OhoCkKr7NZZ2I1EZpn3xqruKp/bteFuLF+CmUFVjC99I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEEEE1596;
	Fri, 17 Oct 2025 11:58:01 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABA8B3F66E;
	Fri, 17 Oct 2025 11:58:04 -0700 (PDT)
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
Subject: [PATCH v3 12/29] arm_mpam: Add helpers for managing the locking around the mon_sel registers
Date: Fri, 17 Oct 2025 18:56:28 +0000
Message-Id: <20251017185645.26604-13-james.morse@arm.com>
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

The MSC MON_SEL register needs to be accessed from hardirq for the overflow
interrupt, and when taking an IPI to access these registers on platforms
where MSC are not accessible from every CPU. This makes an irqsave
spinlock the obvious lock to protect these registers. On systems with SCMI
or PCC mailboxes it must be able to sleep, meaning a mutex must be used.
The SCMI or PCC platforms can't support an overflow interrupt, and
can't access the registers from hardirq context.

Clearly these two can't exist for one MSC at the same time.

Add helpers for the MON_SEL locking. For now, use a irqsave spinlock and
only support 'real' MMIO platforms.

In the future this lock will be split in two allowing SCMI/PCC platforms
to take a mutex. Because there are contexts where the SCMI/PCC platforms
can't make an access, mpam_mon_sel_lock() needs to be able to fail. Do
this now, so that all the error handling on these paths is present. This
allows the relevant paths to fail if they are needed on a platform where
this isn't possible, instead of having to make explicit checks of the
interface type.

Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Change since v1:
 * Made accesses to outer_lock_held READ_ONCE() for torn values in the failure
   case.
---
 drivers/resctrl/mpam_devices.c  |  3 ++-
 drivers/resctrl/mpam_internal.h | 38 +++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 910bb6cd5e4f..35011d3e8f1e 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -738,6 +738,7 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
 
 	mutex_init(&msc->probe_lock);
 	mutex_init(&msc->part_sel_lock);
+	mpam_mon_sel_lock_init(msc);
 	msc->id = pdev->id;
 	msc->pdev = pdev;
 	INIT_LIST_HEAD_RCU(&msc->all_msc_list);
@@ -822,7 +823,7 @@ static void mpam_enable_once(void)
 				      "mpam:online");
 
 	/* Use printk() to avoid the pr_fmt adding the function name. */
-	printk(KERN_INFO, "MPAM enabled with %u PARTIDs and %u PMGs\n",
+	printk(KERN_INFO "MPAM enabled with %u PARTIDs and %u PMGs\n",
 	       mpam_partid_max + 1, mpam_pmg_max + 1);
 }
 
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 9c08502e9c76..1afc52b36328 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -67,12 +67,50 @@ struct mpam_msc {
 	 */
 	struct mutex		part_sel_lock;
 
+	/*
+	 * mon_sel_lock protects access to the MSC hardware registers that are
+	 * affected by MPAMCFG_MON_SEL, and the mbwu_state.
+	 * Access to mon_sel is needed from both process and interrupt contexts,
+	 * but is complicated by firmware-backed platforms that can't make any
+	 * access unless they can sleep.
+	 * Always use the mpam_mon_sel_lock() helpers.
+	 * Accesses to mon_sel need to be able to fail if they occur in the wrong
+	 * context.
+	 * If needed, take msc->probe_lock first.
+	 */
+	raw_spinlock_t		_mon_sel_lock;
+	unsigned long		_mon_sel_flags;
+
 	void __iomem		*mapped_hwpage;
 	size_t			mapped_hwpage_sz;
 
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


